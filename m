Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Fix memset of sco_opt
Date: Tue, 31 Mar 2009 23:30:45 -0300
Message-Id: <1238553045-23938-3-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1238553045-23938-2-git-send-email-gustavo@las.ic.unicamp.br>
References: <1238553045-23938-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1238553045-23938-2-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now len has the correct value: sizeof(sco_opt)
---
 common/btio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/common/btio.c b/common/btio.c
index 9ff407f..030feda 100644
--- a/common/btio.c
+++ b/common/btio.c
@@ -573,8 +573,8 @@ static gboolean sco_set(int sock, uint16_t mtu, GError **err)
 	if (!mtu)
 		return TRUE;
 
-	memset(&sco_opt, 0, len);
 	len = sizeof(sco_opt);
+	memset(&sco_opt, 0, len);
 	if (getsockopt(sock, SOL_SCO, SCO_OPTIONS, &sco_opt, &len) < 0) {
 		ERROR_FAILED(err, "getsockopt(SCO_OPTIONS)", errno);
 		return FALSE;
-- 
1.6.0.6

