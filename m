Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] android/hal-audio: Fix memory leak
Date: Fri,  6 Jun 2014 10:06:14 +0300
Message-Id: <1402038374-8264-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes clang warning:
...
android/hal-audio.c:484:3: warning: Potential leak of memory pointed to
by 'preset'
...
---
 android/hal-audio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 439b583..83ea739 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -482,7 +482,7 @@ static bool open_endpoint(struct audio_endpoint **epp,
 
 	if (!ep) {
 		error("Cound not find opened endpoint");
-		return false;
+		goto failed;
 	}
 
 	*epp = ep;
@@ -516,7 +516,8 @@ static bool open_endpoint(struct audio_endpoint **epp,
 	return true;
 
 failed:
-	close(fd);
+	if (fd >= 0)
+		close(fd);
 	free(preset);
 
 	return false;
-- 
1.8.3.2

