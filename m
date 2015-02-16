Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 5/8] unit/avdtp: Add check for too many SEP creation
Date: Mon, 16 Feb 2015 15:02:27 +0200
Message-Id: <1424091750-29487-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1424091750-29487-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424091750-29487-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test checks that maximum numbers of SEPs registered is MAX_SEID.
---
 unit/test-avdtp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index f2ef767..34820d1 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -578,6 +578,13 @@ static void test_server_seid(gconstpointer data)
 		lseps = g_slist_append(lseps, sep);
 	}
 
+	/* Now add (MAX_SEID + 1) SEP -> it shall fail */
+	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK,
+						AVDTP_MEDIA_TYPE_AUDIO,
+						0x00, TRUE, &sep_ind, NULL,
+						context);
+	g_assert(!sep);
+
 	/* Remove all SEPs */
 	g_slist_free_full(lseps, unregister_sep);
 	lseps = NULL;
-- 
2.1.0

