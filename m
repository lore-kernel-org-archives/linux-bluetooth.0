Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9745C432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 21:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85E37610D1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 21:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhHYVPH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Aug 2021 17:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhHYVPE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Aug 2021 17:15:04 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEC1C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Aug 2021 14:14:17 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id v123so755516pfb.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Aug 2021 14:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mirO0AklfbG5OtoYKr/6Rz/8d6LNFSXQdJz3U0lCAEA=;
        b=UNdXi5/nMm0pUqAjctxe55Hxh+iN2Z7kx2/5axa2pZmxy8bxSPjDPcStKyhm6xHRd2
         GKsXSInQf+aGIBcMQwj9HqkTSWXZE14LGEUOFosBfnM+K8yLWKuJva5HaQUaEVlHSNv2
         iazftRG07YCIsqXzttRfzKR3XNXxRfMgZxAjBxlfGET6BGoV2ZJqDUm+5sqfo5IV4ZQj
         8LCYHnRBn2SlQxiweSmtRC3lfKVMz6MszmlaXIavXAsf3Q89GKYmDlj2vyEOwWBJO+ko
         fd3613VGy0FaSPGZxx+7EDl0uSO6HGkaq+D7h8Z8pBBU8nlIx4KQviD/HQ9h6F6fu5m1
         g1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mirO0AklfbG5OtoYKr/6Rz/8d6LNFSXQdJz3U0lCAEA=;
        b=H1bhXg40qPeH1cy/gf/WvoQmqajFhfeZAmeaCz/aHM63g8azSFxPnrlZCNDiEcmz70
         sBy2tAky5z0YXdu2s73zEqRn6nAfEEpmXzy30+JRBjKvCZhwyHCJ5aplPcYW5qyrNZA9
         ETh16v6OHpnjsk9P0Jjc6X5xfOKxON3bhwaamaIJguFD+6m4dF6Gc5gdDpqySQUuJMQc
         dGVWbu0jLbNGJeLTb+i5j4/7TRdxVB4OoEmf1572CIE8ATnRlwOhvA74vQcHT3Ud+6nB
         fGhw02vGuthVIUeHSgnkZMhR9hmdfbXU/NpggvkO57BA9bBi+QlIsQJOTSY4V4AHqPzm
         dKkw==
X-Gm-Message-State: AOAM532HFG8PEmkxm9r/y31tngIfqMHepBPBShTKZ5MM1HhTKYfA6B7E
        Pb+9Zl15scrb3FPQNjuiyoVv/ztf8H0=
X-Google-Smtp-Source: ABdhPJwZ+bxhOIkKbUteID5k7lsV2uuCjHGEYObohCt89cd5VgPHjJrGxco/cHHojJDEzOU3AVzItA==
X-Received: by 2002:a63:e74b:: with SMTP id j11mr173551pgk.322.1629926056687;
        Wed, 25 Aug 2021 14:14:16 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o15sm921812pgr.64.2021.08.25.14.14.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 14:14:16 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] shared/att: Fix accepting Exchange MTU on EATT bearer
Date:   Wed, 25 Aug 2021 14:14:13 -0700
Message-Id: <20210825211415.1057804-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If remote send Exchange MTU it shall fail as the MTU negotiation shall
happen over L2CAP signalling not ATT for those channels.
---
 src/shared/att.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index ccc753c4e..665d7f4b8 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -962,7 +962,8 @@ static void handle_notify(struct bt_att_chan *chan, uint8_t *pdu,
 		 * link since the MTU size is negotiated using L2CAP channel
 		 * configuration procedures.
 		 */
-		if (bt_att_get_link_type(att) == BT_ATT_BREDR) {
+		if (bt_att_get_link_type(att) == BT_ATT_BREDR ||
+				chan->type == BT_ATT_EATT) {
 			switch (opcode) {
 			case BT_ATT_OP_MTU_REQ:
 				goto not_supported;
-- 
2.31.1

