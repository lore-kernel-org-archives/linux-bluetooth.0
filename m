Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/5] android/avdtptest: Verify data before processing rtp header
Date: Wed,  3 Sep 2014 15:13:44 +0200
Message-Id: <1409750027-20992-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1409750027-20992-1-git-send-email-szymon.janc@tieto.com>
References: <1409750027-20992-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/avdtptest.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/android/avdtptest.c b/android/avdtptest.c
index d520bc0..92312fa 100644
--- a/android/avdtptest.c
+++ b/android/avdtptest.c
@@ -244,16 +244,22 @@ static gboolean media_reader(GIOChannel *source, GIOCondition condition,
 	struct rtp_header *rtp = (void *) buf;
 	static bool decode = false;
 	uint16_t imtu;
-	int fd;
+	int fd, ret;
 
 	if (!avdtp_stream_get_transport(avdtp_stream, &fd, &imtu, NULL, NULL))
 		return TRUE;
 
-	if (read(fd, buf, imtu) < 0) {
+	ret = read(fd, buf, imtu);
+	if (ret < 0) {
 		printf("Reading failed (%s)\n", strerror(errno));
 		return TRUE;
 	}
 
+	if (ret < (int) sizeof(*rtp)) {
+		printf("Not enough media data received (%u bytes)", ret);
+		return TRUE;
+	}
+
 	if (!decode) {
 		printf("V=%u P=%u X=%u CC=%u M=%u PT=%u SeqNr=%d\n",
 			rtp->v, rtp->p, rtp->x, rtp->cc, rtp->m, rtp->pt,
-- 
1.9.1

