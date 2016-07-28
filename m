Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/6] audio/a2dp: Fix always setting -EAGAIN for all errors
Date: Thu, 28 Jul 2016 17:27:50 +0300
Message-Id: <1469716070-16506-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1469716070-16506-1-git-send-email-luiz.dentz@gmail.com>
References: <1469716070-16506-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

avdtp_error_posix_errno always return the posix errno not the negative
one which is then assigned to perror negative and then again as negative
in the switch statement making it assume the original value which is the
positive errno which don't match with the expected values which are
negative causing -EAGAIN to always be returned.
---
 profiles/audio/a2dp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index b391fc2..db0736d 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -235,11 +235,11 @@ static int error_to_errno(struct avdtp_error *err)
 	if (avdtp_error_category(err) != AVDTP_ERRNO)
 		return -EIO;
 
-	perr = -avdtp_error_posix_errno(err);
-	switch (-perr) {
-	case -EHOSTDOWN:
-	case -ECONNABORTED:
-		return perr;
+	perr = avdtp_error_posix_errno(err);
+	switch (perr) {
+	case EHOSTDOWN:
+	case ECONNABORTED:
+		return -perr;
 	default:
 		/*
 		 * An unexpect error has occurred setup may be attempted again.
-- 
2.7.4

