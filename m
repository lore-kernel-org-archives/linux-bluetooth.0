Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 3/3] input: Remove leftover fields in input struct
Date: Mon,  3 Dec 2012 13:41:20 -0300
Message-Id: <1354552880-31864-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1354552880-31864-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1354552880-31864-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/input/device.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 1a33337..d713ebe 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -60,7 +60,6 @@ struct pending_connect {
 
 struct input_device {
 	struct btd_device	*device;
-	DBusConnection		*conn;
 	struct pending_connect	*pending;
 	char			*path;
 	char			*uuid;
@@ -74,7 +73,6 @@ struct input_device {
 	guint			sec_watch;
 	int			timeout;
 	struct hidp_connadd_req *req;
-	struct input_device	*idev;
 	guint			dc_id;
 	gboolean		disable_sdp;
 	char			*name;
-- 
1.7.11.7

