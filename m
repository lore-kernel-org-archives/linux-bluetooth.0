Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84649C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 04:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F7D0650E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 04:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhCPENI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 00:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbhCPEMo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 00:12:44 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F9BC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 21:12:44 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id j3so24498652qvo.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 21:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+iU6VSFQcLTVc5WjHb4fBmlFNIJ61juXGJJZHhIddzs=;
        b=grc375LzX+5CK92Cr0cvNaXmMvajwsRWaSfpdkK7nwcFF5FY6ZrV3krOY2PPAQM/C/
         Pvbner/bfEPY2R/p2QXk8a7QHAmWKnGEDRFjzfsaTngZq1ZNuCJuOWvMBR7lrwecZZya
         GAqGt14XBh3Fhx3J2HdkG11HksRJx8wM1X7LctkHyJ74Ig8/bsnk9+EA+6Hy4juKa3d/
         I6LmGJGPp8DX3YkJ2A9acOkJIYNC1IKIiCM8dTITUavdG/R+4G7QvR+/NP0UYE38Vjtf
         TA1R4GbvCvuLvdjbCA15iA+X63IDeHQT8khslLO5xS7VGEoFbidkCQ+xv5KGXeBIO6Ay
         Y/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+iU6VSFQcLTVc5WjHb4fBmlFNIJ61juXGJJZHhIddzs=;
        b=A0G2rPaqp2fkzgYNjRujfVdRl9MgS36RtBasHiu8exrCVfrC5QU5Hf/aXxmsRQPeWX
         tm8Bp1c9WBqqTpBiHatm9BpPS8M62aTKQIhNEAcJoeXIAQlTijnhSL/anD2/WKxoQxtM
         t08W7cuOBhbRdwJbtspfHgncrfZyl8xGC851hOAENvIKHAJZd2nM7Zv7YxCa3vcmZqyb
         bFey4LPKlNs5QA2WNMy3VshDY2MOsuZ9YHSM72P2/QccHvLieSLnkkTwjcbk5bkD+oTN
         Jwe3Pj2MfH10AMT04saaCvLGW/KDRhLS+rLuIrPf49UCqYOVP45f6c/srsx01HclDlHq
         DY5w==
X-Gm-Message-State: AOAM533y4Bttk/trtKqFMDqAteuNX9AK7Yz/ugVJQN9WycTA50fHUPe7
        ttzro+TB5YajJNeMilAKWSRVD7eHwUzX2Yr3t6dhFngzRcFxsdTjHMEk6GoqR17fv2ianIucOM2
        GTCHWt0c4mWDJan/yxrK3P2jHlcJ36a+nLcL+4wNmtsCKKbORC6mu8gIDDUrfdgDePfEQYVdu7y
        aj
X-Google-Smtp-Source: ABdhPJyBPO0OWQ3ITv6tRBPBVIftfVJnzWS/2rmxi2/uqc0uNGPx5ZrOHHVyiAr/y5jMUG2rmUZUXCQCrLLY
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:4c75:df3:58b0:921])
 (user=apusaka job=sendgmr) by 2002:ad4:4b6c:: with SMTP id
 m12mr13731860qvx.21.1615867963216; Mon, 15 Mar 2021 21:12:43 -0700 (PDT)
Date:   Tue, 16 Mar 2021 12:12:37 +0800
Message-Id: <20210316121212.Bluez.1.I92177a7c526b6d3e04c59f95d846ddfa79977b51@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [Bluez PATCH] shared/gatt-client: fix BT_ATT_OP_HANDLE_NFY_MULT parsing
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

We need to advance the pdu pointer after parsing each block of
notification data.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

 src/shared/gatt-client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 8becf1c6cd..4e10f244d8 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2179,6 +2179,7 @@ static void notify_cb(struct bt_att_chan *chan, uint8_t opcode,
 								&data);
 
 			length -= data.len;
+			pdu += data.len;
 		}
 	} else {
 		data.handle = get_le16(pdu);
-- 
2.31.0.rc2.261.g7f71774620-goog

