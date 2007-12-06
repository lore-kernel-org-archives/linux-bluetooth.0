Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4757DD54.20607@access-company.com>
Date: Thu, 06 Dec 2007 12:30:28 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?= <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4757DCBD.40602@access-company.com>
In-Reply-To: <4757DCBD.40602@access-company.com>
Content-Type: multipart/mixed; boundary="------------040106070204070906030905"
Subject: Re: [Bluez-devel] [Patch] org.bluez.audio.headset.Connect() to
	handsfree
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
--------------040106070204070906030905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Here is the patch. :/

Frederic

Frédéric Dalleau wrote:
> Hello,
>
> As of today, when calling org.bluez.audio.headset.Connect(), the hfp 
> profile is searched only if the headset->hfp_handle is initialized.
> This member variable is initialized upon CreateDevice the first time the 
> device is created (during resolve_services).
> The variable is not initialized when the audio service is restarted, so 
> after restarting audio service, it is no longer possible to connect to hfp.
>
> The attached patch fix the problem as follow : first search the hfp 
> profile handle, then search an hsp profile handle, by getting rfcomm 
> channel to connect to.
>
> It is based against latest git tree.
>
> Frederic.
>
>
> -------------------------------------------------------------------------
> SF.Net email is sponsored by: The Future of Linux Business White Paper
> from Novell.  From the desktop to the data center, Linux is going
> mainstream.  Let it simplify your IT future.
> http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>   


--------------040106070204070906030905
Content-Type: text/x-patch;
 name="handsfreeconnect.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="handsfreeconnect.patch"

diff --git a/audio/headset.c b/audio/headset.c
index 6cb5406..b32b61b 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -111,6 +111,7 @@ struct headset {
 };
 
 static int rfcomm_connect(struct device *device, struct pending_connect *c);
+static int get_handles(struct device *device, struct pending_connect *c);
 
 static void pending_connect_free(struct pending_connect *c)
 {
@@ -640,11 +641,21 @@ static void get_record_reply(DBusPendingCall *call, void *data)
 		goto failed_not_supported;
 	}
 
-	if ((uuid.type == SDP_UUID32 &&
+	if (hs->type == SVC_HEADSET &&
+			((uuid.type == SDP_UUID32 &&
 			uuid.value.uuid32 != HEADSET_SVCLASS_ID) ||
 			(uuid.type == SDP_UUID16 &&
-			 uuid.value.uuid16 != HEADSET_SVCLASS_ID)) {
-		error("Service classes did not contain the expected UUID");
+			 uuid.value.uuid16 != HEADSET_SVCLASS_ID))) {
+		error("Service classes did not contain the expected UUID for hsp");
+		goto failed_not_supported;
+	}
+
+	if (hs->type == SVC_HANDSFREE &&
+			((uuid.type == SDP_UUID32 &&
+			uuid.value.uuid32 != HANDSFREE_SVCLASS_ID) ||
+			(uuid.type == SDP_UUID16 &&
+			 uuid.value.uuid16 != HANDSFREE_SVCLASS_ID))) {
+		error("Service classes did not contain the expected UUID for hfp");
 		goto failed_not_supported;
 	}
 
@@ -750,7 +761,17 @@ static void get_handles_reply(DBusPendingCall *call, void *data)
 	}
 
 	if (array_len < 1) {
-		debug("No record handles found");
+
+		if(hs->type == SVC_HANDSFREE) {
+			debug("No record handles found for hfp");
+			hs->type = SVC_HEADSET;
+			get_handles(device, c);
+			dbus_message_unref(reply);
+			return;
+		}
+
+		debug("No record handles found for hsp");
+
 		if (c->msg)
 			error_not_supported(device->conn, c->msg);
 		goto failed;
@@ -785,6 +806,7 @@ static void get_handles_reply(DBusPendingCall *call, void *data)
 	}
 
 	dbus_pending_call_set_notify(pending, get_record_reply, device, NULL);
+
 	dbus_pending_call_unref(pending);
 	dbus_message_unref(msg);
 	dbus_message_unref(reply);
@@ -862,7 +884,7 @@ static int rfcomm_connect(struct device *device, struct pending_connect *c)
 		if (!g_slist_find(hs->pending, c))
 			hs->pending = g_slist_append(hs->pending, c);
 
-		hs->type = hs->hfp_handle ? SVC_HANDSFREE : SVC_HEADSET;
+		hs->type = SVC_HANDSFREE;
 
 		if (hs->state == HEADSET_STATE_DISCONNECTED)
 			return get_handles(device, c);

--------------040106070204070906030905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
--------------040106070204070906030905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------040106070204070906030905--
