Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/2] profiles/audio: Fix propagation of EHOSTDOWN error
Date: Wed, 4 Jun 2014 17:14:45 +0200
Message-ID: <1401894885-7444-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401894885-7444-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401894885-7444-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

EHOSTDOWN error is now overwritten by EIO and once it's passed to
device_profile_connected it triggers connection of another profiles
while it should actually stop connecting them.
---
 profiles/audio/sink.c   | 13 ++++++++-----
 profiles/audio/source.c | 13 ++++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index d16af23..da8992e 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -229,11 +229,14 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 	if (err) {
 		avdtp_unref(sink->session);
 		sink->session = NULL;
-		if (avdtp_error_category(err) == AVDTP_ERRNO
-				&& avdtp_error_posix_errno(err) != EHOSTDOWN) {
-			perr = -EAGAIN;
-		} else
-			perr = -EIO;
+
+		perr = -avdtp_error_posix_errno(err);
+		if (perr != -EHOSTDOWN) {
+			if (avdtp_error_category(err) == AVDTP_ERRNO)
+				perr = -EAGAIN;
+			else
+				perr = -EIO;
+		}
 		goto failed;
 	}
 
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 843b3e8..b0abaa3 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -229,11 +229,14 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 	if (err) {
 		avdtp_unref(source->session);
 		source->session = NULL;
-		if (avdtp_error_category(err) == AVDTP_ERRNO
-				&& avdtp_error_posix_errno(err) != EHOSTDOWN) {
-			perr = -EAGAIN;
-		} else
-			perr = -EIO;
+
+		perr = -avdtp_error_posix_errno(err);
+		if (perr != -EHOSTDOWN) {
+			if (avdtp_error_category(err) == AVDTP_ERRNO)
+				perr = -EAGAIN;
+			else
+				perr = -EIO;
+		}
 		goto failed;
 	}
 
-- 
1.9.3

