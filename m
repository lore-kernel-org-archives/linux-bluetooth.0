Return-Path: <cyrus@holtmann.org>
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, marcel@hotmann.org, hadess@hadess.net,
	Scott James Remnant <scott@netsplit.com>
Subject: [PATCHv3 1/8] Rename AUTH_TYPE_NOTIFY to AUTH_TYPE_NOTIFY_PASSKEY
Date: Thu,  5 Apr 2012 15:29:33 -0700
Message-Id: <1333664980-29165-2-git-send-email-scott@netsplit.com>
In-Reply-To: <1333664980-29165-1-git-send-email-scott@netsplit.com>
References: <1333664980-29165-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes room for additional notification types to be added.
---
 src/device.c |    8 ++++----
 src/device.h |    2 +-
 src/event.c  |    4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/device.c b/src/device.c
index df3fbac..0ae52ce 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2525,7 +2525,7 @@ void device_simple_pairing_complete(struct btd_device *device, uint8_t status)
 {
 	struct authentication_req *auth = device->authr;
 
-	if (auth && auth->type == AUTH_TYPE_NOTIFY && auth->agent)
+	if (auth && auth->type == AUTH_TYPE_NOTIFY_PASSKEY && auth->agent)
 		agent_cancel(auth->agent);
 }
 
@@ -2542,7 +2542,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t status)
 
 	DBG("bonding %p status 0x%02x", bonding, status);
 
-	if (auth && auth->type == AUTH_TYPE_NOTIFY && auth->agent)
+	if (auth && auth->type == AUTH_TYPE_NOTIFY_PASSKEY && auth->agent)
 		agent_cancel(auth->agent);
 
 	if (status) {
@@ -2796,7 +2796,7 @@ int device_request_authentication(struct btd_device *device, auth_type_t type,
 		err = agent_request_confirmation(agent, device, passkey,
 						confirm_cb, auth, NULL);
 		break;
-	case AUTH_TYPE_NOTIFY:
+	case AUTH_TYPE_NOTIFY_PASSKEY:
 		err = agent_display_passkey(agent, device, passkey);
 		break;
 	default:
@@ -2836,7 +2836,7 @@ static void cancel_authentication(struct authentication_req *auth)
 	case AUTH_TYPE_PASSKEY:
 		((agent_passkey_cb) auth->cb)(agent, &err, 0, device);
 		break;
-	case AUTH_TYPE_NOTIFY:
+	case AUTH_TYPE_NOTIFY_PASSKEY:
 		/* User Notify doesn't require any reply */
 		break;
 	}
diff --git a/src/device.h b/src/device.h
index f3d6c70..d5fdf45 100644
--- a/src/device.h
+++ b/src/device.h
@@ -30,7 +30,7 @@ typedef enum {
 	AUTH_TYPE_PINCODE,
 	AUTH_TYPE_PASSKEY,
 	AUTH_TYPE_CONFIRM,
-	AUTH_TYPE_NOTIFY,
+	AUTH_TYPE_NOTIFY_PASSKEY,
 } auth_type_t;
 
 struct btd_device *device_create(DBusConnection *conn,
diff --git a/src/event.c b/src/event.c
index 78d2757..3259e7d 100644
--- a/src/event.c
+++ b/src/event.c
@@ -202,8 +202,8 @@ int btd_event_user_notify(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey)
 	if (!get_adapter_and_device(sba, dba, &adapter, &device, TRUE))
 		return -ENODEV;
 
-	return device_request_authentication(device, AUTH_TYPE_NOTIFY, passkey,
-								FALSE, NULL);
+	return device_request_authentication(device, AUTH_TYPE_NOTIFY_PASSKEY,
+							passkey, FALSE, NULL);
 }
 
 void btd_event_simple_pairing_complete(bdaddr_t *local, bdaddr_t *peer,
-- 
1.7.7.3

