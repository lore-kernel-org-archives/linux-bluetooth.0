Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] HDP: Set error message on error condition
Date: Tue, 10 Jun 2014 14:11:35 +0300
Message-Id: <1402398695-10975-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes clang warning:
...
  CC       profiles/health/bluetoothd-hdp.o
profiles/health/hdp.c:1778:13: warning: Access to field 'message'
results in a dereference of a null pointer (loaded from variable 'gerr')
                                                "%s", gerr->message);
                                                      ^~~~~~~~~~~~~
...
---
 profiles/health/hdp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 48dad52..e803943 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -747,8 +747,11 @@ static struct hdp_channel *create_channel(struct hdp_device *dev,
 {
 	struct hdp_channel *hdp_chann;
 
-	if (dev == NULL)
+	if (dev == NULL) {
+		g_set_error(err, HDP_ERROR, HDP_UNSPECIFIED_ERROR,
+					"HDP device uninitialized");
 		return NULL;
+	}
 
 	hdp_chann = g_new0(struct hdp_channel, 1);
 	hdp_chann->config = config;
-- 
1.8.3.2

