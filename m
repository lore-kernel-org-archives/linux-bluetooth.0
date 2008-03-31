Return-Path: <cyrus@holtmann.org>
Message-ID: <47F0A6A1.3020704@access-company.com>
Date: Mon, 31 Mar 2008 10:53:53 +0200
From: Frederic Danis <frederic.danis@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <47EA7502.0@access-company.com>	<D1F8014E-5892-4B2A-9219-99670FC1EA60@holtmann.org>	<47EB7AC4.30700@access-company.com>	<70BC25E2-2162-4792-938B-4FE91F0A6032@holtmann.org>
	<47EBC684.5030209@access-company.com>
In-Reply-To: <47EBC684.5030209@access-company.com>
Content-Type: multipart/mixed; boundary="------------010907040704000805060706"
Subject: Re: [Bluez-devel] HID certification using PTS
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010907040704000805060706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

>>>>> - currently, when performing a CreateDevice, input service connects
>>>>> then
>>>>> disconnects from remote device. This makes some tests failed.
>>>>> What do you think if this does not disconnect (and create classic
>>>>> device
>>>>> connection) ?
>>>> does using CreateSecureDevice helps? Can you verify with bluez-
>>>> utils-3.29 and see if it is still a problem?
>>> I tried with CreateSecureDevice and latest 3.29 version but PTS  
>>> tests failed.
>>> I think this is related to the disconnection in Create*Device process.
>>> What do you think if disconnection is removed from this process ? Or  
>>> add a new API, something like CreateAndConnectSecureDevice ?
>>
>> can you please check the service records of the PTS. Does it set the  
>> reconnect value to TRUE. Please check hcidump and see if CreateDevice  
>> actually connects the control and interrupt PSM.
> 
> If I do not make any mistake it seems to me that reconnect is set to 
> false (see attached record - PTS_HID_record.txt).
> Create Device connects control and interrupt PSMs (see 
> PTS_HID_createdevice_dump.txt), but not HID kernel part.
> 
>> Does it help if you call CreateDevice() and then Connect() to pass 
>> the  test.
> 
> Yes, for most of the tests. But for one test (TC_EXT_HOS_CON_BV_0201_I) 
> that check if pairing and connection are available, this makes it failed 
> (CreateSecureDevice then Connect).

I create a patch that allows to create a device and keep it connected (non-secure and secure version) in input manager hierarchy.
It also add a method in device hierarchy to unplug virtual cable without removing device from registered input device list.
This patch allows to pass PTS tests.
Is it OK ?

>>>>> - when kernel (2.6.22) receives a VIRTUAL_CABLE_UNPLUG from PTS  
>>>>> (tests
>>>>> TC_HOS_HCR_BV_02_I and TC_HOS_HCR_BV_04_I) it does not close the  
>>>>> L2CAP
>>>>> channels as PTS waits for.
>>>>> I take a look in 2.6.22 sources, and it seems to me this  
>>>>> disconnection
>>>>> should happen, am I right ?
>>>>> Is it fixed in later kernel ?
>>>> I recall that there was a fix for this.
>>> Do you remember if this has been integrated in kernel ?
>>> I take a look to latest kernel (2.6.24) and do not see any change  
>>> that seems to be related to this problem.
>>
>> Please include the hcidump -X -V output for this case.
> 
> See PTS_HID_virtualcableunplug_dump.txt.
> I also add some traces in kernel (see 
> PTS_HID_virtualcableunplug_kernel.patch) and attached results (see 
> PTS_HID_virtualcableunplug_kernellog.txt).

Did traces help ?
Is it possible that hidp code in kernel send data on the control socket when it receives a Virtual Cable Unplug, so input service can be informed of this and 
perform the l2cap sockets disconnection ?
What is your opinion about that ?

Regards

Fred

-- 
-----------------------------------------------
It is not by improving the oil lamp that one invents the electric bulb!
-----------------------------------------------
Danis Frederic                   Access Company
Software engineer
Mail : mailto:frederic.danis@access-company.com
-----------------------------------------------

--------------010907040704000805060706
Content-Type: text/x-patch;
 name="input-pts.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="input-pts.patch"

Index: device.c
===================================================================
RCS file: /cvsroot/bluez/utils/input/device.c,v
retrieving revision 1.71
diff -a -u -r1.71 device.c
--- device.c	14 Mar 2008 18:44:00 -0000	1.71
+++ device.c	31 Mar 2008 08:36:28 -0000
@@ -1039,6 +1039,19 @@
 	return send_message_and_unref(conn, reply);
 }
 
+static DBusHandlerResult device_unplug(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct device *idev = data;
+
+	if (disconnect(idev, (1 << HIDP_VIRTUAL_CABLE_UNPLUG)) < 0)
+		return error_failed_errno(conn, msg, errno);
+
+	/* Replying to the requestor */
+	return send_message_and_unref(conn,
+			dbus_message_new_method_return(msg));
+}
+
 static void device_unregister(DBusConnection *conn, void *data)
 {
 	struct device *idev = data;
@@ -1057,6 +1070,7 @@
 	{ "GetName",		device_get_name,	"",	"s"	},
 	{ "GetProductId",	device_get_product_id,	"",	"q"	},
 	{ "GetVendorId",	device_get_vendor_id,	"",	"q"	},
+	{ "Unplug",			device_unplug,		"",	"" 	},
 	{ NULL, NULL, NULL, NULL }
 };
 
Index: input-api.txt
===================================================================
RCS file: /cvsroot/bluez/utils/input/input-api.txt,v
retrieving revision 1.12
diff -a -u -r1.12 input-api.txt
--- input-api.txt	26 Nov 2007 13:41:38 -0000	1.12
+++ input-api.txt	31 Mar 2008 08:36:28 -0000
@@ -39,6 +39,32 @@
 			                 org.bluez.Error.ConnectionAttemptFailed
 			                 org.bluez.Error.Failed
 
+		string CreateAndConnectDevice(string address)
+
+			Create an input device object.
+
+			On success it will return the path of the
+			newly created device object.
+
+			Possible errors: org.bluez.Error.AlreadyExists
+			                 org.bluez.Error.NotSupported
+			                 org.bluez.Error.ConnectionAttemptFailed
+			                 org.bluez.Error.Failed
+
+		string CreateAndConnectSecureDevice(string address)
+
+			Create an input device object. Pairing will
+			be initiated if needed(keyboard/combo devices).
+
+			On success it will return the path of the
+			newly created device object.
+
+			Possible errors: org.bluez.Error.AlreadyExists
+			                 org.bluez.Error.NotSupported
+			                 org.bluez.Error.ConnectionAttemptFailed
+			                 org.bluez.Error.AuthenticationFailed
+			                 org.bluez.Error.Failed
+
 		void RemoveDevice(string path)
 
 			Remove the input device object for a given path.
@@ -98,6 +124,12 @@
 
 			Possible errors: org.bluez.Error.Failed
 
+		void Unplug()
+
+			Unplug virtual cable of the input device.
+
+			Possible errors: org.bluez.Error.Failed
+
 Signals		void Connected()
 
 		void Disconnected()
Index: manager.c
===================================================================
RCS file: /cvsroot/bluez/utils/input/manager.c,v
retrieving revision 1.39
diff -a -u -r1.39 manager.c
--- manager.c	27 Mar 2008 14:05:55 -0000	1.39
+++ manager.c	31 Mar 2008 08:36:28 -0000
@@ -337,6 +337,33 @@
 
 	device_paths = g_slist_append(device_paths, g_strdup(path));
 
+	if ((strcmp("CreateAndConnectDevice", dbus_message_get_member(pr->msg)) == 0) ||
+		(strcmp("CreateAndConnectSecureDevice", dbus_message_get_member(pr->msg)) == 0)) {
+		if ((err = input_device_set_channel(&pr->src, &pr->dst, L2CAP_PSM_HIDP_CTRL, pr->ctrl_sock)) < 0) {
+			/* Send unplug virtual cable to unknown devices */
+			unsigned char unplug[] = { 0x15 };
+			write(pr->ctrl_sock, unplug, sizeof(unplug));
+
+			goto failed;
+		}
+
+		pr->ctrl_sock = -1;
+
+		if ((err = input_device_set_channel(&pr->src, &pr->dst, L2CAP_PSM_HIDP_INTR, isk)) < 0) {
+			input_device_close_channels(&pr->src, &pr->dst);
+
+			goto failed;
+		}
+
+		isk = -1;
+
+		if ((err = input_device_connadd(&pr->src, &pr->dst)) < 0) {
+			input_device_close_channels(&pr->src, &pr->dst);
+
+			goto failed;
+		}
+	}
+
 	/* Replying to the requestor */
 	reply = dbus_message_new_method_return(pr->msg);
 
@@ -354,7 +381,8 @@
 	if (isk >= 0)
 		close(isk);
 
-	close(pr->ctrl_sock);
+	if (pr->ctrl_sock >= 0)
+		close(pr->ctrl_sock);
 	pending_req_free(pr);
 
 	if (hidp.rd_data)
@@ -544,7 +572,8 @@
 
 	dbus_message_unref(reply);
 
-	if (strcmp("CreateSecureDevice", dbus_message_get_member(pr->msg)) == 0) {
+	if ((strcmp("CreateSecureDevice", dbus_message_get_member(pr->msg)) == 0) ||
+		(strcmp("CreateAndConnectSecureDevice", dbus_message_get_member(pr->msg)) == 0)) {
 		sdp_data_t *d;
 
 		/* Pairing mandatory for keyboard and combo */
@@ -1136,6 +1165,8 @@
 	{ "ListDevices",		list_devices,	"",	"as"	},
 	{ "CreateDevice",		create_device,	"s",	"s"	},
 	{ "CreateSecureDevice",		create_device,	"s",	"s"	},
+	{ "CreateAndConnectDevice",	create_device,	"s",	"s"	},
+	{ "CreateAndConnectSecureDevice",		create_device,	"s",	"s"	},
 	{ "RemoveDevice",		remove_device,	"s",	""	},
 	{ NULL, NULL, NULL, NULL },
 };

--------------010907040704000805060706
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--------------010907040704000805060706
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------010907040704000805060706--
