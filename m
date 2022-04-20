Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23957C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Apr 2022 23:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356568AbiDTXtA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Apr 2022 19:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiDTXs7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Apr 2022 19:48:59 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF91B3B2AC
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Apr 2022 16:46:11 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id n134so3592732iod.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Apr 2022 16:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gHWZSaJeb0kclIH+CxG9bdtPS5ELkz0JHxRRl/XiVHA=;
        b=ai6KXWtdtJh0XzbbEImgFQgbhoYJIYuH1m3BRsrr+BPZHivO+Z5WfAE2iCRJJeorgM
         +0s0pCO9aedaKjRilDEHg6b91AluDOkaStuM0MtLhX0HaKUzSTPBMjkMZXLQCBc4Br2r
         Iz1EHAHGUuVZrjj479i1MXYVcL0M/YebefSHjcco5MtV+wCnN6bfzSx2hQP2lCoq1h0I
         DqosVgjYm7BCCGO+61v2U6A1527Z0QyyWa5Pr2DXtcng5B6aTScvTlTZphtG5eD8sa9Z
         dYJzt0a25yvcUjrbdvx6Qzr9mWZbTCf5TefBXwiwfDWO+x5M6JxXkISKug37p9scKdwS
         XLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gHWZSaJeb0kclIH+CxG9bdtPS5ELkz0JHxRRl/XiVHA=;
        b=qfskhy6Ujz20li9tUPsZfxpH5pHrAcWaEi95aCnODfebI/d6Bswt3iWH/hwX1+6Ot2
         jYrXEeVWXYofPiTFvGOyk2hbMyCbwd3tsSfW9Mtoz/mBaAiaH6XdUlm81n6+M5kveZTB
         JvHSQoHthfK1GvdOApwD3YFyY3JdMrVcXCsAB+kqRmhnoGoiw+yihuWMFHjGvFLqkayC
         Z+vB3IlcA+yWsA367ef8lzhagiod5XiYms870hqckd969h8nACoKGCdDxHwKrk7eYC3D
         A2OiG+twvrHKIKqPF03u226+rgabbW1cneDRjCPUm7NM5HZgjeE6dmilE8YLYaZyyPV1
         neGw==
X-Gm-Message-State: AOAM532muHn0xUj5ARWFrqT1QsLGElACQ04FDuomdsDmXv9ASjRYfBYl
        Md2pCO5oaOkUprTioHAXZ6NgU7FcGzc=
X-Google-Smtp-Source: ABdhPJxIFr6CuphPSg7RMaG05cwkPX+KbTaSjdpUcg74Sh1hYGGEVRhF7D/FXGkl2wRSyrnv3orIXA==
X-Received: by 2002:a05:6638:3283:b0:32a:75a3:3925 with SMTP id f3-20020a056638328300b0032a75a33925mr4987866jav.248.1650498371051;
        Wed, 20 Apr 2022 16:46:11 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b19-20020a5d8553000000b00649f02b1b0csm12291013ios.39.2022.04.20.16.46.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 16:46:10 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] btmon: Fix decoding of Enhanced Credit Connection Request
Date:   Wed, 20 Apr 2022 16:46:09 -0700
Message-Id: <20220420234609.2968138-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the decoding of Enhanced Credit Connection Request which was
not accounting the fields correctly causing 2 extra Source CID to be
printed.
---
 monitor/l2cap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 4e449854a..01825ce0a 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -1331,7 +1331,7 @@ static void sig_ecred_conn_req(const struct l2cap_frame *frame)
 	const struct bt_l2cap_pdu_ecred_conn_req *pdu = frame->data;
 	uint16_t scid;
 
-	l2cap_frame_pull((void *)frame, frame, sizeof(pdu));
+	l2cap_frame_pull((void *)frame, frame, sizeof(*pdu));
 
 	print_psm(pdu->psm);
 	print_field("MTU: %u", le16_to_cpu(pdu->mtu));
-- 
2.35.1

