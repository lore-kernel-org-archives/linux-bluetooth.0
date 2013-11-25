Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] sdptool: Fix memory leaks creating PBAP record
Date: Mon, 25 Nov 2013 15:14:44 +0200
Message-Id: <1385385285-30592-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385385285-30592-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385385285-30592-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 tools/sdptool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index 78dc281..6682612 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -1888,7 +1888,10 @@ end:
 	sdp_list_free(proto[1], 0);
 	sdp_list_free(proto[2], 0);
 	sdp_list_free(apseq, 0);
+	sdp_list_free(pfseq, 0);
 	sdp_list_free(aproto, 0);
+	sdp_list_free(root, 0);
+	sdp_list_free(svclass_id, 0);
 
 	return ret;
 }
-- 
1.8.3.2

