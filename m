Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/2] android/pts: Update IOPT test results
Date: Thu, 14 Aug 2014 14:58:53 +0200
Message-Id: <1408021133-31714-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1408021133-31714-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1408021133-31714-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-iopt.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/pts-iopt.txt b/android/pts-iopt.txt
index 20962af..3065836 100644
--- a/android/pts-iopt.txt
+++ b/android/pts-iopt.txt
@@ -19,5 +19,7 @@ TC_COD_BV_02_I	N/A	Under PTS 5.1 test shall be disabled as there is
 			PICS settings for HFP shall be disabled for IOPT
 TC_SDSS_BV_02_I	PASS
 TC_SDSA_BV_03_I	FAIL	JIRA #BA-92
-TC_SDR_BV_04_I	FAIL	JIRA #BA-95
+TC_SDR_BV_04_I	PASS	for every PTS bt profile:
+			haltest: bluetooth get_remote_service_record <addr>
+							<requred 128 sdp uuid>
 -------------------------------------------------------------------------------
-- 
1.9.3

