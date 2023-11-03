Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A10C4167D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Nov 2023 18:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbjKCSWI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Nov 2023 14:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbjKCSWH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Nov 2023 14:22:07 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204C6CF
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Nov 2023 11:22:05 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4SMTbt0xmXz9t0M;
        Fri,  3 Nov 2023 19:22:02 +0100 (CET)
From:   =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To:     linux-bluetooth@vger.kernel.org
Cc:     zbrown@gnome.org, =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
Subject: [PATCH BlueZ 3/4] lib/sdp: Use correct string length in sdp_copy_seq()
Date:   Fri,  3 Nov 2023 19:21:49 +0100
Message-ID: <20231103182150.60088-4-verdre@v0yd.nl>
In-Reply-To: <20231103182150.60088-1-verdre@v0yd.nl>
References: <20231103182150.60088-1-verdre@v0yd.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

sdp_data_t->unitSize for strings in the SDP record is
`sizeof(uint8_t) + strlen(str)`.

The "length" argument of sdp_data_alloc_with_length() is expected to be
only the length of the string (so `sdp_data_t->unitSize - sizeof(uint8_t)`).

Since the last commit, in sdp_copy_seq() we're allocating one byte too much
for strings now, because the `sizeof(uint8_t)` is not subtracted from unitSize
there.

Fix this by making use of the length returned by sdp_data_value() and pass
that on to sdp_data_alloc_with_length().

Co-developed-by: Zander Brown <zbrown@gnome.org>
---
 lib/sdp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 006ab057a..4b10d8f67 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -1527,10 +1527,10 @@ static sdp_data_t *sdp_copy_seq(sdp_data_t *data)
 	for (tmp = data; tmp; tmp = tmp->next) {
 		sdp_data_t *datatmp;
 		void *value;
+		uint32_t len = 0;
 
-		value = sdp_data_value(tmp, NULL);
-		datatmp = sdp_data_alloc_with_length(tmp->dtd, value,
-								tmp->unitSize);
+		value = sdp_data_value(tmp, &len);
+		datatmp = sdp_data_alloc_with_length(tmp->dtd, value, len);
 
 		if (cur)
 			cur->next = datatmp;
-- 
2.41.0

