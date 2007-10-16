Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d5d240eb0710152342i35564c90jaf62cd38db68d36@mail.gmail.com>
Date: Tue, 16 Oct 2007 12:12:27 +0530
From: "rohit puri" <rohitpuri.rohit@gmail.com>
To: Bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] problem with two adapters in extracting the record of
	the discovered devices.
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1064507619=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1064507619==
Content-Type: multipart/alternative;
	boundary="----=_Part_38943_7535856.1192516947408"

------=_Part_38943_7535856.1192516947408
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all

I want to accomplish the following tasks using the Dbus interface.

   1.

   I am using the two bluetooth adapters
   the first adapter is searching for the near by devices.
   2.

   The second adapter is used to find out the SDP records of the
   discoverd devices.


 Here In my code I am using theDBusGProxy HCI0 object to search for the near
by bluetooth devices, secondly HCI1 object is used to extract the channel
number of the discoverd devices.

In summary
first adapter (HCI0) is continuously searching for the near by devices.
And second adapter (HCI1)is used to find out the Records of the discovered
devices.
In my code it discovers the near by devices ,gives there channel number but
crashes.

Here I am attaching the relevant and minimal code.
I  want to know whether is this the right way to proceed or there exists any
other alternative.

   /*function for device discovery attached with signal*/

   static void remote_device_found(DBusGProxy *object, const char
   *address, const unsigned int class, const int rssi, gpointer user_data)

{

GError *error = NULL;

/*function to extract the channel*/

 int channel = get_remote_service_channel ( object,address,"OPP" );

g_print ("Channel returned is %d\n",channel);

}

 static void discovery_started(DBusGProxy *object, gpointer user_data)

{

g_print("Signal: DiscoveryStarted()\n");

}

/* Function Defination  for extracting the channel */

gint

get_remote_service_channel (DBusGProxy *obj, const gchar *address, const
gchar *uuid)

{

GError *error = NULL;

GArray *handle_array = NULL;

GArray *record_array = NULL;

sdp_record_t *sdp_record = NULL;

gint scanned;

sdp_list_t *protos = NULL;

gint channel = -1;

 g_print ("hi i am here\n");

/* find services that match our UUID */

DBusGConnection * bus = NULL;

bus = dbus_g_bus_get(DBUS_BUS_SYSTEM, &error);

/*another HCI1 adapter used to extract the SDP Records*/

DBusGProxy* obj1 = dbus_g_proxy_new_for_name(bus, "org.bluez",
"/org/bluez/hci1", "org.bluez.Adapter");

if (!dbus_g_proxy_call (obj1,

"GetRemoteServiceHandles", &error,

G_TYPE_STRING, address,

G_TYPE_STRING, uuid,

G_TYPE_INVALID,

DBUS_TYPE_G_UINT_ARRAY, &handle_array,

G_TYPE_INVALID)) {

g_warning (error->message);

g_error_free (error);

goto out;

}

if (!handle_array) {

goto out;

}

 /* get service record for the first service handle */

if (!handle_array->data)

goto out;


 if (!dbus_g_proxy_call (obj1,

"GetRemoteServiceRecord", &error, G_TYPE_STRING, address,

G_TYPE_UINT, *((guint32 *)handle_array->data), G_TYPE_INVALID,

DBUS_TYPE_G_UINT_ARRAY, &record_array, G_TYPE_INVALID)) {

g_warning (error->message);

g_error_free (error);

goto out;

}


Any help is appreciated.

Regards,

Rohit

------=_Part_38943_7535856.1192516947408
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline




	<meta http-equiv="CONTENT-TYPE" content="text/html; charset=utf-8"><title></title><meta name="GENERATOR" content="OpenOffice.org 2.2  (Linux)"><meta name="AUTHOR" content="root"><meta name="CREATED" content="20071015;23405900">
<meta name="CHANGEDBY" content="root"><meta name="CHANGED" content="20071016;82800">
	
	
	
	
	
	
	<style type="text/css">
	&lt;!--
		@page { size: 8.5in 11in; margin: 0.79in }
		P { margin-bottom: 0.08in }
		P.hanging-indent { margin-left: 0.39in; text-indent: -0.2in }
		P.text-body-indent { margin-left: 0.2in }
	--&gt;
	</style>

<p>Hi  all</p>
<p>I want to accomplish the following tasks using the Dbus interface.</p>
<ol><li>
	<p style="margin-bottom: 0in;"> I am using the two bluetooth
	adapters<br>the first adapter is  searching for
	the near by devices.</p>
	</li><li><p style="margin-bottom: 0in;">The second adapter is used to find
	out the SDP records of the discoverd devices.</p>
</li></ol>
<p style="margin-bottom: 0in;"><br>
</p>
<p>Here In my code I am using theDBusGProxy HCI0 object to search for
the near by bluetooth devices, secondly HCI1 object is used to
extract the channel number of the discoverd devices.</p>




<p>In summary<br>first adapter (HCI0) is continuously searching for the near by devices.<br>And second adapter (HCI1)is used to find out the Records of the
discovered devices.<br>In my code it discovers the near  by devices ,gives there channel
number but crashes.</p>


<p>Here I am attaching the relevant and minimal code.<br>I&nbsp; want to know whether is this the right way to proceed or
there exists any other alternative.</p>
<ul><p style="margin-bottom: 0in;"></p><p style="margin-bottom: 0in;">/*function for device discovery attached with signal*/<br></p><p style="margin-bottom: 0in;">static void
	remote_device_found(DBusGProxy *object, const char *address, const
	unsigned int class, const int rssi, gpointer user_data)
</p></ul>
<p style="margin-bottom: 0in;">{
</p>
<p style="margin-bottom: 0in;">        GError                  *error
= NULL;</p><p style="margin-bottom: 0in;">/*function to extract the channel*/<br>
</p>

<p style="margin-bottom: 0in;">
</p>
<p style="margin-bottom: 0in;">  int channel =
get_remote_service_channel ( object,address,&quot;OPP&quot;  );
</p>
<p style="margin-bottom: 0in;"> g_print (&quot;Channel returned is
%d\n&quot;,channel);
</p>
<p style="margin-bottom: 0in;">}
</p>
<p style="margin-bottom: 0in;">
</p>
<p style="margin-bottom: 0in;">static void
discovery_started(DBusGProxy *object, gpointer user_data)
</p>
<p style="margin-bottom: 0in;">{
</p>
<p style="margin-bottom: 0in;">        g_print(&quot;Signal:
DiscoveryStarted()\n&quot;);
</p>
<p style="margin-bottom: 0in;">}
</p>
<p style="margin-bottom: 0in;">/* Function Defination&nbsp; for extracting the channel */<br></p><p style="margin-bottom: 0in;">gint
</p>
<p style="margin-bottom: 0in;">get_remote_service_channel (DBusGProxy
*obj, const gchar *address, const gchar *uuid)
</p>
<p style="margin-bottom: 0in;">{
</p>
<p style="margin-bottom: 0in;">        GError                  *error
= NULL;
</p>
<p style="margin-bottom: 0in;">        GArray                 
*handle_array = NULL;
</p>
<p style="margin-bottom: 0in;">        GArray                 
*record_array = NULL;
</p>
<p style="margin-bottom: 0in;">        sdp_record_t           
*sdp_record = NULL;
</p>
<p style="margin-bottom: 0in;">        gint                   
scanned;
</p>
<p style="margin-bottom: 0in;">        sdp_list_t              *protos
= NULL;
</p>
<p style="margin-bottom: 0in;">        gint                    channel
= -1;
</p>
<p style="margin-bottom: 0in;">
</p>
<p style="margin-bottom: 0in;">        g_print (&quot;hi i am
here\n&quot;);
</p>
<p style="margin-bottom: 0in;">        /* find services that match our
UUID */
</p>
<p style="margin-bottom: 0in;">        DBusGConnection * bus = NULL;
</p>
<p style="margin-bottom: 0in;">        bus =
dbus_g_bus_get(DBUS_BUS_SYSTEM, &amp;error);
</p>
<p style="margin-bottom: 0in;">/*another HCI1 adapter used to extract the SDP Records*/<br></p><p style="margin-bottom: 0in;">        DBusGProxy* obj1 =
dbus_g_proxy_new_for_name(bus, &quot;org.bluez&quot;,
&quot;/org/bluez/hci1&quot;, &quot;org.bluez.Adapter&quot;);
</p>
<p style="margin-bottom: 0in;">        if (!dbus_g_proxy_call (obj1,
</p>
<p style="margin-bottom: 0in;">                               
&quot;GetRemoteServiceHandles&quot;, &amp;error,
</p>
<p style="margin-bottom: 0in;">                               
G_TYPE_STRING, address,
</p>
<p style="margin-bottom: 0in;">                               
G_TYPE_STRING, uuid,
</p>
<p style="margin-bottom: 0in;">                               
G_TYPE_INVALID,
</p>
<p style="margin-bottom: 0in;">                               
DBUS_TYPE_G_UINT_ARRAY, &amp;handle_array,
</p>
<p style="margin-bottom: 0in;">                               
G_TYPE_INVALID)) {
</p>
<p style="margin-bottom: 0in;">                g_warning
(error-&gt;message);
</p>
<p style="margin-bottom: 0in;">                g_error_free (error);
</p>
<p style="margin-bottom: 0in;">                goto out;
</p>
<p style="margin-bottom: 0in;">        }
</p>
<p style="margin-bottom: 0in;">        if (!handle_array) {
</p>
<p style="margin-bottom: 0in;">                goto out;
</p>
<p style="margin-bottom: 0in;">        }
</p>
<p style="margin-bottom: 0in;">
</p>
<p style="margin-bottom: 0in;">        /* get service record for the
first service handle */
</p>
<p style="margin-bottom: 0in;">        if (!handle_array-&gt;data)
</p>
<p style="margin-bottom: 0in;">                goto out;
</p>
<p style="margin-bottom: 0in;"><br>
</p>
<p class="hanging-indent">if (!dbus_g_proxy_call (obj1,
</p>
<p class="text-body-indent">"GetRemoteServiceRecord", &amp;error,
G_TYPE_STRING, address,
</p>
<p class="text-body-indent">G_TYPE_UINT, *((guint32
*)handle_array-&gt;data),
 G_TYPE_INVALID,
</p>
<p class="text-body-indent">DBUS_TYPE_G_UINT_ARRAY, &amp;record_array,
G_TYPE_INVALID)) {
</p>
<p class="text-body-indent">g_warning (error-&gt;message);
</p>
<p class="text-body-indent">g_error_free (error);
</p>
<p class="text-body-indent">goto out;
</p>
<p style="margin-bottom: 0in;">        }</p><br><p style="margin-bottom: 0in;"><br></p><p style="margin-bottom: 0in;">Any help is appreciated.</p><p style="margin-bottom: 0in;">Regards,</p><p style="margin-bottom: 0in;">
Rohit<br></p><p style="margin-bottom: 0in;"><br>
</p>

------=_Part_38943_7535856.1192516947408--


--===============1064507619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1064507619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1064507619==--
