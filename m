Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A748C432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CBD6610CF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240479AbhHMMWI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240473AbhHMMWI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:22:08 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AEEC061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:41 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id r13-20020ac85c8d0000b029028efef0404cso6244809qta.14
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XZFWy9TOkPrvVn11dZ4GTupHAWciKtSoivOHsfSA9io=;
        b=hxuuKd0KfZDHayUrThdlCy47rTC9wYxGvaou+6YoumJ3tljCkQz4EU+DBm6Cw7PSzU
         XkM20qcbNIfnBhoP6/+nAeWlFlTSLmaIgosqLPjzH+LlMZydMsQX/FHGJzd8jHhXKM6N
         1vbivO6MDEKiRNd/Tv9T0CdULsiaG6KPCBJsYKleV0svRv3CbQhAh/f2b7wMNRFK8kqt
         I/0dT2/BRyh34zOz0Gwv9rDrV521zxAXOy5fQB/KQuRLd6ozwdFh2mBGHovMNAoA6ZVp
         GSOCrVHW3M904TRps0+r2gRjjqkjfc7fBt49s3wuFMyVlhQ1j/G7AkLlbTnGIv+5bSq5
         lWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XZFWy9TOkPrvVn11dZ4GTupHAWciKtSoivOHsfSA9io=;
        b=riGd+mQWtqBc7fFF19qMPIuk5Kx2nWKepiv1j9yka6BeDWFp7gfFuCpcXRNfxNcFeF
         wtGu9beNRPpw9a/GJZuIFF4AbI05HYcQZ5FJ2/G98O5/I46jFAqNbHcDdaaSxSKrUMPd
         XWIE9911gMqIh+/vPZMQ/zX4YaCHb/XoJaBQif6YfALeWByzs1Va6aGZ/KoPkcnsVBiz
         MwMgRODx+8Xk0UtAxJKbji320DzVG4bxx6elDwO/Y/Be8axQVi0bXCysewNAEgWTqgtr
         mFFZStKddQjAle9Mcbfz2DfU4b2lyl6LCI+/FgV++wMtTckKREf5uK22JG+dN2qxk1aG
         RHUw==
X-Gm-Message-State: AOAM530q6eLAxA7Tx54WN13SHOvSNPSHVFPqeL6vkd8YXbl1NmrOeR6G
        eFJY1TkO3Y2DmIC0N+M4xldiMuUTMwt2opr9MurMVzgnF/Ee4WsZTTjEOU079x+H2mxjxPOV31C
        jzUybpHLPWpIpYp7HrIQHtj/qUouL8TuicmDWjS/ChBYtmTq0OfnuRHOcJDYp7HZAHQAje8i6tu
        lv
X-Google-Smtp-Source: ABdhPJz2+ao4IEF6IGK4hCoayt43EsP3axlso/ievdP3kZZZ4bg/bTYMNsOAzu6vzJJRnxZrp84/QCif7vx6
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a0c:ecc4:: with SMTP id
 o4mr2390240qvq.18.1628857300245; Fri, 13 Aug 2021 05:21:40 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:19 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.34.I591bcabb26f8262dbc8f3607d457a2e2a9ad844d@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 34/62] tools/parser/lmp: Inclusive language changes
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"central" and "peripheral" are the preferred terms, as reflected in
the BT core spec 5.3.
---

 tools/parser/lmp.c | 110 ++++++++++++++++++++++-----------------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/tools/parser/lmp.c b/tools/parser/lmp.c
index 8c5a228c03..94b6428967 100644
--- a/tools/parser/lmp.c
+++ b/tools/parser/lmp.c
@@ -28,22 +28,22 @@
 
 static enum {
 	IN_RAND,
-	COMB_KEY_M,
-	COMB_KEY_S,
-	AU_RAND_M,
-	AU_RAND_S,
-	SRES_M,
-	SRES_S,
+	COMB_KEY_C,
+	COMB_KEY_P,
+	AU_RAND_C,
+	AU_RAND_P,
+	SRES_C,
+	SRES_P,
 } pairing_state = IN_RAND;
 
 static struct {
 	uint8_t in_rand[16];
-	uint8_t comb_key_m[16];
-	uint8_t comb_key_s[16];
-	uint8_t au_rand_m[16];
-	uint8_t au_rand_s[16];
-	uint8_t sres_m[4];
-	uint8_t sres_s[4];
+	uint8_t comb_key_c[16];
+	uint8_t comb_key_p[16];
+	uint8_t au_rand_c[16];
+	uint8_t au_rand_p[16];
+	uint8_t sres_c[4];
+	uint8_t sres_p[4];
 } pairing_data;
 
 static inline void pairing_data_dump(void)
@@ -59,31 +59,31 @@ static inline void pairing_data_dump(void)
 	p_indent(6, NULL);
 	printf("COMB_KEY ");
 	for (i = 0; i < 16; i++)
-		printf("%2.2x", pairing_data.comb_key_m[i]);
+		printf("%2.2x", pairing_data.comb_key_c[i]);
 	printf(" (M)\n");
 
 	p_indent(6, NULL);
 	printf("COMB_KEY ");
 	for (i = 0; i < 16; i++)
-		printf("%2.2x", pairing_data.comb_key_s[i]);
+		printf("%2.2x", pairing_data.comb_key_p[i]);
 	printf(" (S)\n");
 
 	p_indent(6, NULL);
 	printf("AU_RAND  ");
 	for (i = 0; i < 16; i++)
-		printf("%2.2x", pairing_data.au_rand_m[i]);
+		printf("%2.2x", pairing_data.au_rand_c[i]);
 	printf(" SRES ");
 	for (i = 0; i < 4; i++)
-		printf("%2.2x", pairing_data.sres_m[i]);
+		printf("%2.2x", pairing_data.sres_c[i]);
 	printf(" (M)\n");
 
 	p_indent(6, NULL);
 	printf("AU_RAND  ");
 	for (i = 0; i < 16; i++)
-		printf("%2.2x", pairing_data.au_rand_s[i]);
+		printf("%2.2x", pairing_data.au_rand_p[i]);
 	printf(" SRES ");
 	for (i = 0; i < 4; i++)
-		printf("%2.2x", pairing_data.sres_s[i]);
+		printf("%2.2x", pairing_data.sres_p[i]);
 	printf(" (S)\n");
 }
 
@@ -92,7 +92,7 @@ static inline void in_rand(struct frame *frm)
 	uint8_t *val = frm->ptr;
 
 	memcpy(pairing_data.in_rand, val, 16);
-	pairing_state = COMB_KEY_M;
+	pairing_state = COMB_KEY_C;
 }
 
 static inline void comb_key(struct frame *frm)
@@ -100,19 +100,19 @@ static inline void comb_key(struct frame *frm)
 	uint8_t *val = frm->ptr;
 
 	switch (pairing_state) {
-	case COMB_KEY_M:
-		memcpy(pairing_data.comb_key_m, val, 16);
-		pairing_state = COMB_KEY_S;
+	case COMB_KEY_C:
+		memcpy(pairing_data.comb_key_c, val, 16);
+		pairing_state = COMB_KEY_P;
 		break;
-	case COMB_KEY_S:
-		memcpy(pairing_data.comb_key_s, val, 16);
-		pairing_state = AU_RAND_M;
+	case COMB_KEY_P:
+		memcpy(pairing_data.comb_key_p, val, 16);
+		pairing_state = AU_RAND_C;
 		break;
 	case IN_RAND:
-	case AU_RAND_M:
-	case AU_RAND_S:
-	case SRES_M:
-	case SRES_S:
+	case AU_RAND_C:
+	case AU_RAND_P:
+	case SRES_C:
+	case SRES_P:
 	default:
 		pairing_state = IN_RAND;
 		break;
@@ -124,19 +124,19 @@ static inline void au_rand(struct frame *frm)
 	uint8_t *val = frm->ptr;
 
 	switch (pairing_state) {
-	case AU_RAND_M:
-		memcpy(pairing_data.au_rand_m, val, 16);
-		pairing_state = SRES_M;
+	case AU_RAND_C:
+		memcpy(pairing_data.au_rand_c, val, 16);
+		pairing_state = SRES_C;
 		break;
-	case AU_RAND_S:
-		memcpy(pairing_data.au_rand_s, val, 16);
-		pairing_state = SRES_S;
+	case AU_RAND_P:
+		memcpy(pairing_data.au_rand_p, val, 16);
+		pairing_state = SRES_P;
 		break;
-	case COMB_KEY_M:
-	case COMB_KEY_S:
+	case COMB_KEY_C:
+	case COMB_KEY_P:
 	case IN_RAND:
-	case SRES_M:
-	case SRES_S:
+	case SRES_C:
+	case SRES_P:
 	default:
 		pairing_state = IN_RAND;
 		break;
@@ -148,20 +148,20 @@ static inline void sres(struct frame *frm)
 	uint8_t *val = frm->ptr;
 
 	switch (pairing_state) {
-	case SRES_M:
-		memcpy(pairing_data.sres_m, val, 4);
-		pairing_state = AU_RAND_S;
+	case SRES_C:
+		memcpy(pairing_data.sres_c, val, 4);
+		pairing_state = AU_RAND_P;
 		break;
-	case SRES_S:
-		memcpy(pairing_data.sres_s, val, 4);
+	case SRES_P:
+		memcpy(pairing_data.sres_p, val, 4);
 		pairing_state = IN_RAND;
 		pairing_data_dump();
 		break;
-	case COMB_KEY_M:
-	case COMB_KEY_S:
+	case COMB_KEY_C:
+	case COMB_KEY_P:
 	case IN_RAND:
-	case AU_RAND_M:
-	case AU_RAND_S:
+	case AU_RAND_C:
+	case AU_RAND_P:
 	default:
 		pairing_state = IN_RAND;
 		break;
@@ -1016,10 +1016,10 @@ static inline void esco_link_req_dump(int level, struct frame *frm)
 	uint8_t desco = LMP_U8(frm);
 	uint8_t tesco = LMP_U8(frm);
 	uint8_t wesco = LMP_U8(frm);
-	uint8_t mspkt = LMP_U8(frm);
-	uint8_t smpkt = LMP_U8(frm);
-	uint16_t mslen = LMP_U16(frm);
-	uint16_t smlen = LMP_U16(frm);
+	uint8_t cppkt = LMP_U8(frm);
+	uint8_t pcpkt = LMP_U8(frm);
+	uint16_t cplen = LMP_U16(frm);
+	uint16_t pclen = LMP_U16(frm);
 	uint8_t airmode = LMP_U8(frm);
 	uint8_t negstate = LMP_U8(frm);
 
@@ -1036,10 +1036,10 @@ static inline void esco_link_req_dump(int level, struct frame *frm)
 	printf("D_eSCO %d T_eSCO %d W_eSCO %d\n", desco, tesco, wesco);
 
 	p_indent(level, frm);
-	printf("eSCO M->S packet type 0x%2.2x length %d\n", mspkt, mslen);
+	printf("eSCO C->P packet type 0x%2.2x length %d\n", cppkt, cplen);
 
 	p_indent(level, frm);
-	printf("eSCO S->M packet type 0x%2.2x length %d\n", smpkt, smlen);
+	printf("eSCO P->C packet type 0x%2.2x length %d\n", pcpkt, pclen);
 
 	p_indent(level, frm);
 	printf("air mode 0x%2.2x\n", airmode);
@@ -1142,7 +1142,7 @@ void lmp_dump(int level, struct frame *frm)
 	}
 
 	printf("LMP(%c): %s(%c): ", frm->central ? 's' : 'r',
-				opcode2str(opcode), tid ? 's' : 'm');
+				opcode2str(opcode), tid ? 'p' : 'c');
 
 	if (opcode > 123)
 		printf("op code %d/%d", opcode & 0x7f, opcode >> 7);
-- 
2.33.0.rc1.237.g0d66db33f3-goog

