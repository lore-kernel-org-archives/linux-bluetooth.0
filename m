Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24CFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Nov 2021 02:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92A2861057
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Nov 2021 02:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbhKMCiy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Nov 2021 21:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbhKMCix (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Nov 2021 21:38:53 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1885CC061766
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Nov 2021 18:36:02 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c126so10036979pfb.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Nov 2021 18:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QVLnziUGxzmQ8ZRD+mJLVHBAZV2oPwOBZwmqQicfOMM=;
        b=Cgm3+3Wcltsxb/iTLOo/v0QmJt2MrXieFnafv77Y+SKuecJaMMFXdQ1CCpDVlpSnDg
         JuVxlVrzOFD6W255jagvq2WofBizCMU99kTVu4CeQTE5oZUDgZia2/lZdqQBd81rmRA5
         SBvNt1Y1Mz7CuJDXYwTO85S2MsvROisGuYdEu2cJWbbBg+MlROiJaNTrhVAKh7Hw4mA9
         vaf63b4b6Ja7XgfXq2exuU05TI5Wpgx2QrBuaVIdYDyh7tNJRP2GgxOBKl+hwdt4wU7n
         LxV/fS4k1nz673FwwAEg30neylhNFayvlRDW3qO/8PXR76rzHGG6wmt/9oa3lvvA8mY+
         wzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QVLnziUGxzmQ8ZRD+mJLVHBAZV2oPwOBZwmqQicfOMM=;
        b=j718XMKgetlFfMnruybd4hzdWXRbTjuChugsB3EBvAARKH/Z2wGUBwXBUXLreQJmPA
         q1lKM4TA9WX8PBOYjBR37n+37swILLCgWEwDfAbWu6rIr9H8yif3cVAdw3Mudr9yjcSX
         X55+dN8wki2bAXMqjt94gVbmrdkcHPl0OTZ4TSICv1QWAWhtTJXydJiz/DbZ+3ciu4mC
         5P3Ywda000p/OuNVJDWOguf4jl24wFmR8r7l32U/CPvy1yT0KTEjGix5s1cgcRx8+by6
         fzoaPGuSDnsxlWJwI4/UakI+Lbbri3Xs7DzvNQmKn10j40kkD2Mm+WTmZClq3HIy5XlI
         Ny6A==
X-Gm-Message-State: AOAM530eubZYJaylNa13kfBFyejeUIp/2WsZ224Xg4/PMYzojj7QR5IG
        Ut15BJnMy+EaCRb2TIjr0GZ9PEp1/3s=
X-Google-Smtp-Source: ABdhPJxadXzCAfVRGxnFHS/EHLoQbTVCaBr1+yiYYo0Nm/cSCr8V16SkcpYWwp4qI4pMCWHxqcvOcA==
X-Received: by 2002:a63:790d:: with SMTP id u13mr12553857pgc.150.1636770961337;
        Fri, 12 Nov 2021 18:36:01 -0800 (PST)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:5c5a:3570:def6:e3d5])
        by smtp.gmail.com with ESMTPSA id co4sm12006768pjb.2.2021.11.12.18.36.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 18:36:00 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 2/3] monitor: Fix uninitiailzed scalar variable
Date:   Fri, 12 Nov 2021 18:35:58 -0800
Message-Id: <20211113023559.212793-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211113023559.212793-1-hj.tedd.an@gmail.com>
References: <20211113023559.212793-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the uninitiailzed varialble(CWE-457) reported by
the Coverity scan.
---
 monitor/rfcomm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index 41533b158..02300a8b5 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -437,6 +437,7 @@ void rfcomm_packet(const struct l2cap_frame *frame)
 	if (frame->size < 4)
 		goto fail;
 
+	memset(&hdr, 0, sizeof(hdr));
 	if (!l2cap_frame_get_u8(l2cap_frame, &hdr.address) ||
 			!l2cap_frame_get_u8(l2cap_frame, &hdr.control) ||
 			!l2cap_frame_get_u8(l2cap_frame, &length))
-- 
2.25.1

