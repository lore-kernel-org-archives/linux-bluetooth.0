Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3] android/hal-audio: Fix memory leak
Date: Fri,  6 Jun 2014 10:19:48 +0300
Message-Id: <1402039188-8441-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1402038374-8264-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402038374-8264-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes clang warning:
...
android/hal-audio.c:484:3: warning: Potential leak of memory pointed to
by 'preset'
...
---
 android/hal-audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 439b583..7a40682 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -482,7 +482,7 @@ static bool open_endpoint(struct audio_endpoint **epp,
 
 	if (!ep) {
 		error("Cound not find opened endpoint");
-		return false;
+		goto failed;
 	}
 
 	*epp = ep;
-- 
1.8.3.2

