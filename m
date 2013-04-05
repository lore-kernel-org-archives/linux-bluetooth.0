Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, keybuk@chromium.org,
	vinicius.gomes@openbossa.org, Alex Deymo <deymo@chromium.org>
Subject: [PATCH v5 3/3] input: Convert gboolean to bool
Date: Fri,  5 Apr 2013 16:20:33 -0700
Message-Id: <1365204033-30540-3-git-send-email-deymo@chromium.org>
In-Reply-To: <1365204033-30540-1-git-send-email-deymo@chromium.org>
References: <1365204033-30540-1-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove some usage of gboolean in favor of bool.
---
 profiles/input/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index f78163b..bcb3947 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -78,7 +78,7 @@ struct input_device {
 	int			timeout;
 	struct hidp_connadd_req *req;
 	guint			dc_id;
-	gboolean		disable_sdp;
+	bool			disable_sdp;
 	char			*name;
 	enum reconnect_mode_t	reconnect_mode;
 };
@@ -686,7 +686,7 @@ int input_device_disconnect(struct btd_device *dev, struct btd_profile *profile)
 
 static struct input_device *input_device_new(struct btd_device *device,
 				const char *path, const uint32_t handle,
-				bool disable_sdp)
+				gboolean disable_sdp)
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
 	struct input_device *idev;
@@ -707,7 +707,7 @@ static struct input_device *input_device_new(struct btd_device *device,
 	return idev;
 }
 
-static gboolean is_device_sdp_disable(const sdp_record_t *rec)
+static bool is_device_sdp_disable(const sdp_record_t *rec)
 {
 	sdp_data_t *data;
 
-- 
1.8.1.3

