Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 1/2] control: Add a way to identify the role of a avrcp connection
Date: Fri, 10 May 2013 21:29:08 -0300
Message-Id: <1368232149-9974-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/control.c | 8 ++++++++
 profiles/audio/control.h | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index cdba385..480e6b2 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -328,3 +328,11 @@ gboolean control_is_active(struct audio_device *dev)
 
 	return FALSE;
 }
+
+enum control_role_t control_get_role(struct control *control)
+{
+	if (control->remote)
+		return CONTROL_ROLE_REMOTE;
+	else
+		return CONTROL_ROLE_TARGET;
+}
diff --git a/profiles/audio/control.h b/profiles/audio/control.h
index 0a0f208..6f08b0b 100644
--- a/profiles/audio/control.h
+++ b/profiles/audio/control.h
@@ -26,12 +26,19 @@
 
 struct btd_service;
 
+enum control_role_t {
+	CONTROL_ROLE_REMOTE,
+	CONTROL_ROLE_TARGET,
+};
+
 struct control *control_init(struct audio_device *dev,
 						struct btd_service *service);
 void control_update(struct control *control, struct btd_service *service);
 void control_unregister(struct audio_device *dev);
 gboolean control_is_active(struct audio_device *dev);
 
+enum control_role_t control_get_role(struct control *control);
+
 int control_connect(struct audio_device *dev);
 int control_disconnect(struct audio_device *dev);
 
-- 
1.8.2.2

