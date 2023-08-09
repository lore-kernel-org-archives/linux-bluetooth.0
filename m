Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4801BC0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 20:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjHIU17 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjHIU16 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 16:27:58 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B381FF7
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 13:27:58 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9f48b6796so3318591fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Aug 2023 13:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691612876; x=1692217676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FM8uG86RClQlTl2IJIsSwyAwp4fQSw9zCLfKLqDpW3g=;
        b=S7E99dZouiS4HBtMUx8RHHjzC7hdL36rkDOrCJp3Wlv3dQwV1EAampHTbMAdq1xgRI
         +MuqO2PXh+lgX7+Q/UR8Kl4PvohLa1c9UbD5bChjQeuYNJF+9CTR/k6wLhAaePe2pguB
         z8KpYV+pDifPQVqNiKEjyze1bKTTwOCI6Kbi9TV5lhpIKlieF3wIHarkb25l+xhSW8bx
         /NvkLGCh+W38SHMLg8Pt8gz/+m4A/CsX7lapkbyjWPyaY3z9pcKBg9Tu6nXIdk9VEFL+
         zL7PYqryFfnRy4e/EFbnVi+aIJ5CH7fVibRJF+9mtU38Zz2UGqekkhhfMFMOQUCExpp2
         +p2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691612876; x=1692217676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FM8uG86RClQlTl2IJIsSwyAwp4fQSw9zCLfKLqDpW3g=;
        b=Pd32tn7b6dNOQfCbzVfKpwevOtswTlpHEwW8gU1k9G0jfXlAAWTVSzIDgUTXuOgUOV
         EKIKBq2sgxLj6G+H+MnCBuPeGEFi6OBnarzfVXQG+xRdN+8mHC3nuW2ESUCls/CcyvoT
         ikgAiJTik8TwvQPJwehD6yM4geEDYG1ResrbsAkiZ6WLlPbucFphuA+fsWi/ONMCjXrM
         uVETKN+vu6AQ4TPUBcIhqrDMCOY4y5hwCqkpfolf4AGbx0XSFCku6edkSwivL0qKP1/C
         8TiwaI7a53i01SZWLAgtN/gLyvmTEl/mdRO5t689eLqiewB3bXo1VPMxjZuqQXacZSs/
         9dGQ==
X-Gm-Message-State: AOJu0Yxplc/VKTPQG6KwuWZfvvHUXVvHFje9HqMrEJ+Ggw/0SS3ijE6h
        udFUAuKlAYE3BTsXH5JjrSP90C6IoHk=
X-Google-Smtp-Source: AGHT+IGxhhz/+g7iybQHVWp1cxeXss/z70wqFb0NYhCrkyYOWKkFklf73JLda91t0ms4a8BHAXyF7w==
X-Received: by 2002:a2e:7806:0:b0:2b9:48f1:b195 with SMTP id t6-20020a2e7806000000b002b948f1b195mr196802ljc.44.1691612875499;
        Wed, 09 Aug 2023 13:27:55 -0700 (PDT)
Received: from localhost.localdomain (77-169-139-185.fixed.kpn.net. [77.169.139.185])
        by smtp.gmail.com with ESMTPSA id h15-20020a1709066d8f00b00997e52cb30bsm8350819ejt.121.2023.08.09.13.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:27:54 -0700 (PDT)
From:   Bart Philips <bartphilips1@gmail.com>
X-Google-Original-From: Bart Philips <bart.philips@inspiro.nl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Bart Philips <bart.philips@inspiro.nl>
Subject: [PATCH BlueZ 0/1] fix writes to attributes of size 512 
Date:   Wed,  9 Aug 2023 22:27:22 +0200
Message-Id: <20230809202724.15429-1-bart.philips@inspiro.nl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

writing attributes of length 512 fails, although the Bluetooth spec (Vol 4, Part F, 3.2.9) states that attributes sizes up to 512 are allowed. The check_length calls in write_cb and prep_write_cb in gatt-server.c currently pass the length parameter that include the handle/offset length and therefore fail for attributes of length 512. This patch subtracts the handle/offset length before passing it to the check_length function, allowing writes to attributes up to 512 in size. 

Bart Philips (1):
  fix writing attributes of length 512

 src/shared/gatt-server.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1

