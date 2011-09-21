Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/3] Remove empty line before declaration
Date: Tue, 20 Sep 2011 22:49:09 -0400
Message-Id: <1316573351-30884-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1316573351-30884-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1316573351-30884-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index 1ce0f7b..1b95c45 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -857,7 +857,6 @@ uint16_t enc_indication(struct attribute *a, uint8_t *pdu, int len)
 struct attribute *dec_indication(const uint8_t *pdu, int len)
 {
 	const uint16_t min_len = sizeof(pdu[0]) + sizeof(uint16_t);
-
 	struct attribute *a;
 
 	if (pdu == NULL)
-- 
1.7.0.4

