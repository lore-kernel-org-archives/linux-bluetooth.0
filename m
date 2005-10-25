Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3013cac80510251130v5127dedbi3ceaa453a87216cd@mail.gmail.com>
From: Eduardo Rocha <folhabranca@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Device Configuration D-Bus services
In-Reply-To: <20051025120646.GA26339@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_3010_17635.1130265021284"
References: <e1effdeb0510190606x50364b25y52a5092847000105@mail.gmail.com>
	 <3013cac80510241400k2b71125ao7b8b4dfe5077a300@mail.gmail.com>
	 <1130189692.7840.21.camel@blade>
	 <3013cac80510250452j702622acw98ed9abef758bca1@mail.gmail.com>
	 <20051025120646.GA26339@localhost.localdomain>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 25 Oct 2005 15:30:21 -0300

------=_Part_3010_17635.1130265021284
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

here is some code cleanup. This patch should be applied after the
dbus_device.patch.

BR,
Eduardo.

--
Eduardo Rocha
Instituto Nokia de Tecnologia - INdT

On 10/25/05, Johan Hedberg <johan.hedberg@nokia.com> wrote:
> On Tue, Oct 25, 2005, Eduardo Rocha wrote:
> > The point is, as we have merged the main operations in two functions (s=
et
> > and get), so we have to identify the operation by an integer or by a st=
ring
> > constant. It seems that a string is better for python binding (can anyo=
ne
> > confirm that?).
>
> At least by using strings it would be much easier to understand what the
> client code is doing, e.g. if you compare
> SetProperty("page-timeout", 10)
> vs.
> SetProperty(3, 10)
>
> So, I vote for using strings instead of integers.
>
> Johan
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.
> Get Certified Today * Register for a JBoss Training Course
> Free Certification Exam for All Training Attendees Through End of 2005
> Visit http://www.jboss.com/services/certification for more information
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_3010_17635.1130265021284
Content-Type: text/x-patch; name=dbus_cleanup.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dbus_cleanup.patch"

--- bluez-cvs-25102005/utils/hcid/dbus.c	2005-10-25 08:23:03.191337608 -0300
+++ bluez-cvs-new/utils/hcid/dbus.c	2005-10-25 15:19:53.656169024 -0300
@@ -1215,11 +1215,12 @@
 	uint8_t length;
 	uint8_t max_period;
 	uint8_t min_period;
-	int sock = -1;
+	int dd = -1;
 	int dev_id = -1;
 
 	if (dbus_data->id == DEFAULT_DEVICE_PATH_ID) {
-		if ((dev_id = hci_get_route(NULL)) < 0) {
+		dev_id = hci_get_route(NULL);
+		if (dev_id < 0) {
 			syslog(LOG_ERR, "Bluetooth device is not available");
 			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
 			goto failed;
@@ -1228,8 +1229,8 @@
 	} else
 		dev_id =  dbus_data->id;
 
-	sock = hci_open_dev(dev_id);
-	if (sock < 0) {
+	dd = hci_open_dev(dev_id);
+	if (dd < 0) {
 		syslog(LOG_ERR, "HCI device open failed");
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
 		goto failed;
@@ -1260,14 +1261,14 @@
 
 	inq_mode.mode = 1; //INQUIRY_WITH_RSSI;
 
-	if (hci_send_cmd(sock, OGF_HOST_CTL, OCF_WRITE_INQUIRY_MODE,
+	if (hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_INQUIRY_MODE,
 				WRITE_INQUIRY_MODE_CP_SIZE, &inq_mode) < 0) {
 		syslog(LOG_ERR, "Can't set inquiry mode:%s.", strerror(errno));
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
 	}
 
-	if (hci_send_cmd(sock, OGF_LINK_CTL, OCF_PERIODIC_INQUIRY,
+	if (hci_send_cmd(dd, OGF_LINK_CTL, OCF_PERIODIC_INQUIRY,
 				PERIODIC_INQUIRY_CP_SIZE, &inq_param) < 0) {
 		syslog(LOG_ERR, "Can't send HCI commands:%s.", strerror(errno));
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
@@ -1281,8 +1282,8 @@
 	}
 
 failed:
-	if (sock > 0)
-		close(sock);
+	if (dd >= 0)
+		close(dd);
 
 	return reply;
 }
@@ -1292,11 +1293,12 @@
 	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
 	struct hci_dbus_data *dbus_data = data;
-	int sock = -1;
+	int dd = -1;
 	int dev_id = -1;
 
 	if (dbus_data->id == DEFAULT_DEVICE_PATH_ID) {
-		if ((dev_id = hci_get_route(NULL)) < 0) {
+		dev_id = hci_get_route(NULL);
+		if (dev_id < 0) {
 			syslog(LOG_ERR, "Bluetooth device is not available");
 			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
 			goto failed;
@@ -1304,13 +1306,14 @@
 	} else
 		dev_id = dbus_data->id;
 
-	if ((sock = hci_open_dev(dev_id)) < 0) {
+	dd = hci_open_dev(dev_id);
+	if (dd < 0) {
 		syslog(LOG_ERR, "HCI device open failed");
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
 		goto failed;
 	}
 
-	if (hci_send_cmd(sock, OGF_LINK_CTL, OCF_EXIT_PERIODIC_INQUIRY, 0 , NULL) < 0) {
+	if (hci_send_cmd(dd, OGF_LINK_CTL, OCF_EXIT_PERIODIC_INQUIRY, 0 , NULL) < 0) {
 		syslog(LOG_ERR, "Send hci command failed.");
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 	} else {
@@ -1322,8 +1325,8 @@
 	}
 
 failed:
-	if (sock >= 0)
-		close(sock);
+	if (dd >= 0)
+		close(dd);
 
 	return reply;
 }
@@ -1447,7 +1450,7 @@
 	bdaddr_t bdaddr;
 	uint8_t role;
 	int dev_id = -1;
-	int sock = -1;
+	int dd = -1;
 
 	dbus_message_iter_init(msg, &iter);
 	dbus_message_iter_get_basic(&iter, &str_bdaddr);
@@ -1470,14 +1473,14 @@
 		goto failed;
 	}
 
-	sock = hci_open_dev(dev_id);
-	if (sock < 0) {
+	dd = hci_open_dev(dev_id);
+	if (dd < 0) {
 		syslog(LOG_ERR, "HCI device open failed\n");
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
 		goto failed;
 	}
 
-	if (hci_switch_role(sock, &bdaddr, role, 10000) < 0) {
+	if (hci_switch_role(dd, &bdaddr, role, 10000) < 0) {
 		syslog(LOG_ERR, "Switch role request failed\n");
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 	} else {
@@ -1511,7 +1514,8 @@
 	str2ba(str_bdaddr, &bdaddr);
 
 	if (dbus_data->id == DEFAULT_DEVICE_PATH_ID) {
-		if ((dev_id = hci_get_route(&bdaddr)) < 0) {
+		dev_id = hci_get_route(&bdaddr);
+		if (dev_id  < 0) {
 			syslog(LOG_ERR, "Bluetooth device is not available");
 			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
 			goto failed;
@@ -1571,7 +1575,8 @@
 	int sk = -1;
 
 	if (dbus_data->id == DEFAULT_DEVICE_PATH_ID) {
-		if ((dev_id = hci_get_route(NULL)) < 0) {
+		dev_id = hci_get_route(NULL);
+		if (dev_id < 0) {
 			syslog(LOG_ERR, "Bluetooth device is not available");
 			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
 			goto failed;
@@ -1621,7 +1626,7 @@
 	dbus_message_iter_close_container(&iter, &array_iter);
 
 failed:
-	if (sk >= 0)
+	if (sk > 0)
 		close(sk);
 
 	if (cl)
@@ -1642,7 +1647,7 @@
 	struct hci_conn_info_req *cr = NULL;
 	bdaddr_t bdaddr;
 	int dev_id = -1;
-	int sock = -1;
+	int dd = -1;
 
 	dbus_message_iter_init(msg, &iter);
 	dbus_message_iter_get_basic(&iter, &str_bdaddr);
@@ -1660,8 +1665,8 @@
 		goto failed;
 	}
 
-	sock = hci_open_dev(dev_id);
-	if (sock < 0) {
+	dd = hci_open_dev(dev_id);
+	if (dd < 0) {
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
 		goto failed;
 	}
@@ -1675,7 +1680,7 @@
 	bacpy(&cr->bdaddr, &bdaddr);
 	cr->type = ACL_LINK;
 
-	if (ioctl(sock, HCIGETCONNINFO, (unsigned long) cr) < 0) {
+	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
 	}
@@ -1692,15 +1697,15 @@
 	rq.rlen = EVT_CMD_STATUS_SIZE;
 	rq.event = EVT_CMD_STATUS;
 
-	if (hci_send_req(sock, &rq, 25000) < 0) {
+	if (hci_send_req(dd, &rq, 25000) < 0) {
 		syslog(LOG_ERR, "Unable to send authentication request: %s", strerror(errno));
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
 	}
 
 failed:
-	if (sock >= 0)
-		close(sock);
+	if (dd >= 0)
+		close(dd);
 
 	if (cr)
 		free(cr);
@@ -1725,7 +1730,7 @@
 	struct hci_dev_req *dr      = NULL;
 	struct hci_dev_info di;
 	int i;
-	int sock = -1;
+	int sk = -1;
 
 	char aname[BLUETOOTH_DEVICE_NAME_LEN];
 	char aaddr[BLUETOOTH_DEVICE_ADDR_LEN];
@@ -1734,8 +1739,8 @@
 	const char array_sig[] = HCI_DEVICE_STRUCT_SIGNATURE;
 
 	/* Create and bind HCI socket */
-	sock = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
-	if (sock < 0) {
+	sk = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
+	if (sk < 0) {
 		syslog(LOG_ERR, "Can't open HCI socket: %s (%d)", strerror(errno), errno);
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
@@ -1751,7 +1756,7 @@
 	dl->dev_num = HCI_MAX_DEV;
 	dr = dl->dev_req;
 
-	if (ioctl(sock, HCIGETDEVLIST, dl) < 0) {
+	if (ioctl(sk, HCIGETDEVLIST, dl) < 0) {
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
 	}
@@ -1769,7 +1774,7 @@
 		memset(&di, 0 , sizeof(struct hci_dev_info));
 		di.dev_id = dr->dev_id;
 
-		if (ioctl(sock, HCIGETDEVINFO, &di) < 0)
+		if (ioctl(sk, HCIGETDEVINFO, &di) < 0)
 			continue;
 
 		strcpy(aname, di.name);
@@ -1787,8 +1792,8 @@
 	dbus_message_iter_close_container(&iter, &array_iter);
 
 failed:
-	if (sock >= 0)
-		close(sock);
+	if (sk > 0)
+		close(sk);
 
 	if (dl)
 		free(dl);

------=_Part_3010_17635.1130265021284--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
