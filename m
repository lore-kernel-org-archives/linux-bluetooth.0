Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211C9C433B4
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 May 2021 00:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFAF26142A
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 May 2021 00:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhEAAiN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Apr 2021 20:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhEAAiL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Apr 2021 20:38:11 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACE6C06174A
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Apr 2021 17:37:22 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id j7so41091042pgi.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Apr 2021 17:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SJD/aHIRm27dT+kmAOuV3UfGlGvasL9/+X29i/Lf90k=;
        b=A8sIayllgkmKH+Y0Jv1OaTrZ0KI+eEbD7Wp+bSJ2v3Noi+OiwsJ4wgH6Nzsqg27wRp
         dr9t5JPBATpTatGkmkY4r9/VNF1gJa4GnC7wPkWBvxzuSscqsg13kUhtrQ5gGH2NwYdk
         QgoP4PLAUlzTIQ6gGs+rrDTzIVJJG3yUjhggh/eFgKMNl5UlaZbK8kNkzhpoNjxJCyZV
         CSff5e2QTCA4P5RidzIeK6neYW/ky/8EhnpHaWBlTxoWK6lqBioajbSZyTv5NRpkm/dq
         vpffOkuUtA+Xf1cjVRNFO8hg/T5Mf8ZetOT/NgaEYRxn2InDNC8l2X1wShANSM8UFSdr
         84eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SJD/aHIRm27dT+kmAOuV3UfGlGvasL9/+X29i/Lf90k=;
        b=kXt2GODy0hiQedrgdz0OWbQ0ElHJEJzWQ9xXmezGHJzG1ZfLyoyjzwyItE/wPHtPNz
         XqxfGfa58tCufcOx+sgKLD+UKr8w5N9jPLazus67behsKqoFs7YPNepHxYuxWXo0N1zX
         vzTIdBj1oR4wPv6UusHB0qLsHBraMcSq57C7SgGXgXgN4kiagtN6x6Jj3i85qiqiuwK3
         Mdw7d64eBoFPXO1kKRtclo+/mvl2PZPCKdte3T1gTIG9GJefLxwZspK6jdxi7u7Bdol/
         mNU3KOq5dHXnzbVp0rrRQE5QkFz5ZF8L6dcyVrt+jPs3PAyi+Zhex173jCNxM86yiAJB
         GhEQ==
X-Gm-Message-State: AOAM530CcKF6j+cRUgiOJrGqJDbstKGPh33NnuuD72m/Iy2ar+Wvyhtp
        nr34kgaYSENwV1UHD+Tf+ybhgo9rDrPmDg==
X-Google-Smtp-Source: ABdhPJw0Zegduicbl/LuIbrVStJbd2KV3xnsGy3WVx1W48bL6ZXnvglfZc3uVr2JIKXo7urbDFLqVA==
X-Received: by 2002:aa7:9696:0:b029:259:efef:e1e0 with SMTP id f22-20020aa796960000b0290259efefe1e0mr7647153pfk.0.1619829441648;
        Fri, 30 Apr 2021 17:37:21 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h76sm2198410pfe.161.2021.04.30.17.37.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 17:37:21 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] avrcp: Fix not checking if params_len match number of received bytes
Date:   Fri, 30 Apr 2021 17:37:16 -0700
Message-Id: <20210501003717.7553-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210501003717.7553-1-luiz.dentz@gmail.com>
References: <20210501003717.7553-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes sure the number of bytes in the params_len matches the
remaining bytes received so the code don't end up accessing invalid
memory.
---
 profiles/audio/avrcp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 05dd791de..c6a342ee3 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1914,6 +1914,14 @@ static size_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
 		goto err_metadata;
 	}
 
+	operands += sizeof(*pdu);
+	operand_count -= sizeof(*pdu);
+
+	if (pdu->params_len != operand_count) {
+		DBG("AVRCP PDU parameters length don't match");
+		pdu->params_len = operand_count;
+	}
+
 	for (handler = session->control_handlers; handler->pdu_id; handler++) {
 		if (handler->pdu_id == pdu->pdu_id)
 			break;
-- 
2.30.2

