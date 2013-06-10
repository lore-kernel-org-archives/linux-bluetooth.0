Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/15] AVRCP: Fix crash when connecting role without a record
Date: Mon, 10 Jun 2013 13:37:04 +0300
Message-Id: <1370860630-30359-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
References: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Invalid read of size 4
   at 0x469310: btd_service_connecting_complete (service.c:315)
   by 0x41B29F: session_ct_init_control (avrcp.c:3208)
   by 0x41AD70: state_changed (avrcp.c:3356)
   by 0x417B84: avctp_set_state (avctp.c:550)
   by 0x419E04: avctp_connect_cb (avctp.c:1222)
   by 0x450869: accept_cb (btio.c:202)
   by 0x3F31A47A54: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x3F31A47D87: ??? (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x3F31A48181: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x40A335: main (main.c:595)
 Address 0x20 is not stack'd, malloc'd or (recently) free'd
---
 profiles/audio/avrcp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 78d0fa2..06bffca 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2931,12 +2931,17 @@ static struct avrcp *session_create(struct avrcp_server *server,
 		session->init_control = session_tg_init_control;
 		session->init_browsing = session_tg_init_browsing;
 		session->destroy = session_tg_destroy;
+
 		rec = btd_device_get_record(dev->btd_dev, AVRCP_REMOTE_UUID);
+		if (rec == NULL)
+			btd_device_add_uuid(dev->btd_dev, AVRCP_REMOTE_UUID);
 	} else {
 		session->init_control = session_ct_init_control;
 		session->init_browsing = session_ct_init_browsing;
 		session->destroy = session_ct_destroy;
 		rec = btd_device_get_record(dev->btd_dev, AVRCP_TARGET_UUID);
+		if (rec == NULL)
+			btd_device_add_uuid(dev->btd_dev, AVRCP_TARGET_UUID);
 	}
 
 	if (rec == NULL)
-- 
1.8.1.4

