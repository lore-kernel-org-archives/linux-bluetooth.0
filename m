Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE06C4332E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Mar 2021 18:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B011165100
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Mar 2021 18:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhCISjQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Mar 2021 13:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhCISjN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Mar 2021 13:39:13 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5A7C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Mar 2021 10:39:13 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id t9so1333219pjl.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Mar 2021 10:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ePi5MC25QxxgKrTmbVK5rbwegcbfhbj+u16H6VOeUr8=;
        b=ndxKkFBF4ouCpSQw96fgvIs0y2IPBmiJ79Wa5SD9rXAKAZcnkGoFUgCfJ7LS9YS+bu
         nc954qSBixnnKwvCNAQ/paapwbqAXseCyWohPtOpA5hQeAM7cGL+Uiq0NyrRNSO8mFbr
         qIfoHW1UiiJ0wefm4Lslrz1zKOgvhllxqJbUSdrvMOWXa8io1R8q73BQwy4m1nLcaEoK
         cSPuxh3CLpFlHVPE9Jlq2lqOLlYTZHbBS9wConXo9obVrWAFM9rvBcTmTO3VeoeBaC4i
         wLyohrWhQkpT1Rcm2OuEcL+5nH4bGifilV5nd1IwCotxxYTmbkiDFm+rp7nxzjGhzgnl
         AL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ePi5MC25QxxgKrTmbVK5rbwegcbfhbj+u16H6VOeUr8=;
        b=euXmVz1IBYEQ2UKyFvgS2sKSCMJJ1vRWUfp6ipB4yNApCMD2Al1Tfn+PeQCYCvDZP2
         r8N09YRiCCO9xlT40tLpf5wkr9zQzvmYgwmZGTM6IxNh5bTKCRNMm9aSS14s29D6TqYf
         IN0eKfLlmacfrPX5GZWIEKQnG9oo3V+gjK1q6rt9jvr8ZgfltZqMVuIfgtk7Ra71XABb
         A9eL4QJiyNWwHh4xJ9wxtP1x5S8HGWJ9DL/BUBNBvb+dZPtcCFnrKWQo8CaPQM7S3RCS
         T4jnxNQqCvKm0nkO3K9d188ELamlLWo4w6OfhNKUlVEKZSpUeYH76YeAl9gc+EJRwyAI
         c7Cw==
X-Gm-Message-State: AOAM533lgpx4dPN8urVho5nlT9qQiDXv70G8+PbdQdbJ5Ho8/PjY5HAO
        m8570u8Ip/dRMaofaToRBA9JLvxVdl4JJA==
X-Google-Smtp-Source: ABdhPJwmC+L/ZJQXD4NZH0yRLlf3HU0H3BOh3wbT5sz82IYIo+Q05MyC6c6f4DHBNTTShES84D0qgw==
X-Received: by 2002:a17:902:7597:b029:e3:f7e2:eb36 with SMTP id j23-20020a1709027597b02900e3f7e2eb36mr5151647pll.42.1615315152304;
        Tue, 09 Mar 2021 10:39:12 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 186sm13159074pfb.143.2021.03.09.10.39.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 10:39:11 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: SMP: Fail if remote and local public keys are identical
Date:   Tue,  9 Mar 2021 10:39:11 -0800
Message-Id: <20210309183911.514959-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fails the pairing procedure when both remote and local non-debug
public keys are identical.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/smp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b0c1ee110eff..9e7e3655e4ec 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2732,6 +2732,15 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*key))
 		return SMP_INVALID_PARAMS;
 
+	/* Check if remote and local public keys are the same and debug key is
+	 * not in use.
+	 */
+	if (!test_bit(SMP_FLAG_DEBUG_KEY, &smp->flags) &&
+	    !memcmp(key, smp->local_pk, 64)) {
+		BT_ERR("Remote and local public keys are identical");
+		return SMP_UNSPECIFIED;
+	}
+
 	memcpy(smp->remote_pk, key, 64);
 
 	if (test_bit(SMP_FLAG_REMOTE_OOB, &smp->flags)) {
-- 
2.29.2

