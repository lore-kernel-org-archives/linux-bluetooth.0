Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Daniel Gollub <dgollub@suse.de>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 31 Jul 2006 15:18:56 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ANgzEuxdOvMgVl1"
Message-Id: <200607311518.57014.dgollub@suse.de>
Subject: [Bluez-devel] Addition for hcid passkey dbus request
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--Boundary-00=_ANgzEuxdOvMgVl1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi list,

i am started working for the bluez dbus integration for kdebluetooth. The 
kdebluetooth pin dialog for pairing has a pin generation feature for outgoing 
pairing requests. This requires that hcid also provides connection 
information about the pairing. A hcid patch is attached, which sends a 
enhanced passkey request with the connection direction. This requires changes 
on all application which handle as passkey agents. Is there a better solution 
expect dropping the pin generation feature?

Looking forward for some feedback.

best regards,
Daniel

--Boundary-00=_ANgzEuxdOvMgVl1
Content-Type: text/x-diff; charset="us-ascii";
	name="bluez-hcid-dbus-pairing-ci.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluez-hcid-dbus-pairing-ci.diff"

diff -rup bluez-utils/hcid/dbus.c bluez-utils.patched/hcid/dbus.c
--- bluez-utils/hcid/dbus.c	2006-07-31 12:47:40.000000000 +0200
+++ bluez-utils.patched/hcid/dbus.c	2006-07-31 15:14:47.000000000 +0200
@@ -631,7 +631,7 @@ void hcid_dbus_request_pin(int dev, bdad
 
 	snprintf(path, sizeof(path), "%s/hci%d", BASE_PATH, hci_devid(addr));
 
-	handle_passkey_request(connection, dev, path, sba, &ci->bdaddr);
+	handle_passkey_request(connection, dev, path, sba, &ci->bdaddr, ci->out);
 }
 
 void hcid_dbus_bonding_process_complete(bdaddr_t *local, bdaddr_t *peer, const uint8_t status)
diff -rup bluez-utils/hcid/dbus.h bluez-utils.patched/hcid/dbus.h
--- bluez-utils/hcid/dbus.h	2006-07-31 12:47:40.000000000 +0200
+++ bluez-utils.patched/hcid/dbus.h	2006-07-31 15:14:47.000000000 +0200
@@ -178,7 +178,7 @@ DBusHandlerResult simple_introspect(DBus
 
 service_handler_func_t find_service_handler(struct service_data *services, DBusMessage *msg);
 
-int handle_passkey_request(DBusConnection *conn, int dev, const char *path, bdaddr_t *sba, bdaddr_t *dba);
+int handle_passkey_request(DBusConnection *conn, int dev, const char *path, bdaddr_t *sba, bdaddr_t *dba, uint8_t dirout);
 
 static inline DBusHandlerResult send_reply_and_unref(DBusConnection *conn, DBusMessage *reply)
 {
diff -rup bluez-utils/hcid/dbus-security.c bluez-utils.patched/hcid/dbus-security.c
--- bluez-utils/hcid/dbus-security.c	2006-07-31 12:47:40.000000000 +0200
+++ bluez-utils.patched/hcid/dbus-security.c	2006-07-31 15:14:47.000000000 +0200
@@ -398,10 +398,11 @@ done:
 }
 
 static int call_passkey_agent(DBusConnection *conn, struct passkey_agent *agent,
-		int dev, const char *path, bdaddr_t *sba, bdaddr_t *dba)
+		int dev, const char *path, bdaddr_t *sba, bdaddr_t *dba, uint8_t dirout)
 {
 	DBusMessage *message = NULL;
 	DBusPendingCall *pending = NULL;
+	dbus_bool_t dbusdirout = dirout;
 	struct pin_request *req;
 	char bda[18];
 	char *ptr = bda;
@@ -413,6 +414,7 @@ static int call_passkey_agent(DBusConnec
 		goto failed;
 	}
 
+
 	debug("Calling PasskeyAgent.Request: name=%s, path=%s",
 						agent->name, agent->path);
 
@@ -433,6 +435,7 @@ static int call_passkey_agent(DBusConnec
 	dbus_message_append_args(message,
 					DBUS_TYPE_STRING, &path,
 					DBUS_TYPE_STRING, &ptr,
+					DBUS_TYPE_BOOLEAN, &dbusdirout,
 					DBUS_TYPE_INVALID);
 
 	if (dbus_connection_send_with_reply(conn, message,
@@ -468,7 +471,7 @@ DBusHandlerResult handle_security_method
 	return error_unknown_method(conn, msg);
 }
 
-int handle_passkey_request(DBusConnection *conn, int dev, const char *path, bdaddr_t *sba, bdaddr_t *dba)
+int handle_passkey_request(DBusConnection *conn, int dev, const char *path, bdaddr_t *sba, bdaddr_t *dba, uint8_t dirout)
 {
 	struct passkey_agent *agent = default_agent;
 	struct hci_dbus_data *adapter = NULL;
@@ -494,5 +497,5 @@ int handle_passkey_request(DBusConnectio
 	}
 
 done:
-	return call_passkey_agent(conn, agent, dev, path, sba, dba);
+	return call_passkey_agent(conn, agent, dev, path, sba, dba, dirout);
 }
diff -rup bluez-utils/hcid/passkey-agent.c bluez-utils.patched/hcid/passkey-agent.c
--- bluez-utils/hcid/passkey-agent.c	2006-07-31 12:47:40.000000000 +0200
+++ bluez-utils.patched/hcid/passkey-agent.c	2006-07-31 15:15:02.000000000 +0200
@@ -76,12 +76,13 @@ static DBusHandlerResult request_message
 {
 	DBusMessage *reply;
 	const char *path, *address;
+	dbus_bool_t ciout;
 
 	if (!passkey)
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &path,
-			DBUS_TYPE_STRING, &address, DBUS_TYPE_INVALID)) {
+			DBUS_TYPE_STRING, &address, DBUS_TYPE_BOOLEAN, &ciout, DBUS_TYPE_INVALID)) {
 		fprintf(stderr, "Invalid arguments for passkey Request method");
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 	}

--Boundary-00=_ANgzEuxdOvMgVl1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_ANgzEuxdOvMgVl1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_ANgzEuxdOvMgVl1--
