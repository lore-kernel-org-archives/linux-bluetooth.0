Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH obexd 3/4] Code clean-up: Remove magic number indicating size of buffer
Date: Thu, 22 Sep 2011 09:52:47 +0200
Message-Id: <1316677968-3494-3-git-send-email-michalski.raf@gmail.com>
In-Reply-To: <1316677968-3494-2-git-send-email-michalski.raf@gmail.com>
References: <1316677968-3494-1-git-send-email-michalski.raf@gmail.com>
 <1316677968-3494-2-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes "magic number" indicating buffer's size
in "vcard_printf_number" function and replace it by value defined under
LEN_MAX. Now it would be consistent with the rest of code, since all
functions from vcard_prinf_* family use LEN_MAX to indicate size
of buffer which may store some vCard's field content.
---
 plugins/vcard.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index ca3a052..901a2ac 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -406,7 +406,7 @@ static void vcard_printf_number(GString *vcards, uint8_t format,
 					enum phonebook_number_type category)
 {
 	const char *intl = "", *category_string = "";
-	char buf[128], field[LEN_MAX];
+	char buf[LEN_MAX], field[LEN_MAX];
 
 	/* TEL is a mandatory field, include even if empty */
 	if (!number || !strlen(number) || !type) {
-- 
1.6.3.3

