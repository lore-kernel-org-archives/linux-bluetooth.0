Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 21/21] audio/control: Enable initiate connection to CT role
Date: Tue,  9 Jul 2013 17:39:18 +0300
Message-Id: <1373380758-16489-25-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1373380758-16489-1-git-send-email-luiz.dentz@gmail.com>
References: <1373380758-16489-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Since the policy uses service API to initiate the connections this needs
to be enabled for both CT and TG roles.
---
 profiles/audio/control.c |  3 ---
 profiles/audio/manager.c | 11 +++++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index 35f1c35..912ca73 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -108,9 +108,6 @@ int control_connect(struct btd_service *service)
 	if (control->session)
 		return -EALREADY;
 
-	if (!control->target)
-		return -ENOTSUP;
-
 	control->session = avctp_connect(control->dev);
 	if (!control->session)
 		return -EIO;
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index cb40583..b7522e1 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -167,7 +167,7 @@ static int a2dp_sink_disconnect(struct btd_service *service)
 	return sink_disconnect(service, FALSE);
 }
 
-static int avrcp_target_connect(struct btd_service *service)
+static int avrcp_control_connect(struct btd_service *service)
 {
 	struct btd_device *dev = btd_service_get_device(service);
 	const char *path = device_get_path(dev);
@@ -177,7 +177,7 @@ static int avrcp_target_connect(struct btd_service *service)
 	return control_connect(service);
 }
 
-static int avrcp_target_disconnect(struct btd_service *service)
+static int avrcp_control_disconnect(struct btd_service *service)
 {
 	struct btd_device *dev = btd_service_get_device(service);
 	const char *path = device_get_path(dev);
@@ -304,8 +304,8 @@ static struct btd_profile avrcp_target_profile = {
 	.device_probe	= avrcp_target_probe,
 	.device_remove	= avrcp_target_remove,
 
-	.connect	= avrcp_target_connect,
-	.disconnect	= avrcp_target_disconnect,
+	.connect	= avrcp_control_connect,
+	.disconnect	= avrcp_control_disconnect,
 
 	.adapter_probe	= avrcp_target_server_probe,
 	.adapter_remove = avrcp_target_server_remove,
@@ -318,6 +318,9 @@ static struct btd_profile avrcp_remote_profile = {
 	.device_probe	= avrcp_remote_probe,
 	.device_remove	= avrcp_remote_remove,
 
+	.connect	= avrcp_control_connect,
+	.disconnect	= avrcp_control_disconnect,
+
 	.adapter_probe	= avrcp_remote_server_probe,
 	.adapter_remove = avrcp_remote_server_remove,
 };
-- 
1.8.1.4

