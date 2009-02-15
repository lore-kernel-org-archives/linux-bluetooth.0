Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] Remove unnecessary attribution
Date: Sun, 15 Feb 2009 16:47:25 -0300
Message-Id: <1234727246-21064-5-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1234727246-21064-4-git-send-email-gustavo@las.ic.unicamp.br>
References: <1234727246-21064-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1234727246-21064-2-git-send-email-gustavo@las.ic.unicamp.br>
 <1234727246-21064-3-git-send-email-gustavo@las.ic.unicamp.br>
 <1234727246-21064-4-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/main.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/main.c b/src/main.c
index d5d45c0..c86ae96 100644
--- a/src/main.c
+++ b/src/main.c
@@ -220,7 +220,6 @@ static void update_service_classes(const bdaddr_t *bdaddr, uint8_t value)
 	dl = g_malloc0(HCI_MAX_DEV * sizeof(*dr) + sizeof(*dl));
 
 	dl->dev_num = HCI_MAX_DEV;
-	dr = dl->dev_req;
 
 	if (ioctl(sk, HCIGETDEVLIST, dl) < 0) {
 		close(sk);
-- 
1.6.0.6

