Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8830C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Apr 2022 20:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiDLUaw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Apr 2022 16:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiDLUaV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Apr 2022 16:30:21 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0603CE6C45
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Apr 2022 13:27:58 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id y16so14343682ilc.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Apr 2022 13:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mtWgSbdruveJrUu4BEEfTpIcZsOOG4f5Z6iyZGNvjTs=;
        b=k8IghNDL9y2NiS75EzSrdDO7SZhF7jWIvOu9suR8Lgq6xuLFw039/ONgyFZiIZAQ2n
         YO1PSblgTQjmtP9zls9CGMw1OtLRYP1OXsBqb+r6UGCoebQcsJtmPmYXMLqxKiEb+MV1
         /Zal36mKfVkEzEzLNezz6+dGAaHdZhFIT7kfaSB6GxEg2tvYKgSA1FDGrgolQ6IyVtE/
         ePLfWFMMyR1/ZeXFcRigPidSmQd87Pbw46NKrA16SPz7V0orgUK08O/X3YxtlyzeePun
         uzoHdzYdzJNto8chKVFpZ5GgjWEnGOoYD3eW803GUZyPQ7XeWTNRjOcDBAHsoPp3efnK
         iWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mtWgSbdruveJrUu4BEEfTpIcZsOOG4f5Z6iyZGNvjTs=;
        b=fE1rR91HfPWU3EbCyNe/WkJ0z6xBboDFAMh5ORdWiw+yW2pHePeLEAMF9o80IxSS/F
         pgZMgp24FTD+ar27mI/ELf5egFoPFeFVDtnZdi+ivQoZf67lZnu6ju1EhUiyHf8pY84f
         q/kI8njfVUZiqR8ZXhxlHQUSMJlcFRTy7I3kIY0MdopfOe4y2xyvL8ka0S2VYNw8hAJY
         ZMUPqnXEOVUNvlu7lgkGdqQjKLToOYAxWnigQ+AFMgnYSHmIbw84lOs5ApELTKHjc5G7
         Jnm9IFU1gTDehG3408LbsGqPqqT+kUGWTJLViLl/8DKandZB1GGrOOnPhE6WJ0gFf4VI
         2Kjw==
X-Gm-Message-State: AOAM530aV/JWxZWD5Rlgn/NW1YtlNPeJqPW4Gy/EC4TAnNLeND4owAVh
        /GXCXBaDDYNO2uwkWIQgqjYLDhl6i6s=
X-Google-Smtp-Source: ABdhPJzLzTfx5wDnCiXFlI+Bdsx4alD0u+dw0VhAEYz4o3tziEnwZ1IjQq85YlF7XttaCDFzsU9mLg==
X-Received: by 2002:a05:6e02:1a23:b0:2ca:bf14:62e with SMTP id g3-20020a056e021a2300b002cabf14062emr4092422ile.137.1649794790857;
        Tue, 12 Apr 2022 13:19:50 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s12-20020a92cbcc000000b002bd04428740sm20690328ilq.80.2022.04.12.13.19.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 13:19:50 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] build: Make use of StateDirectory and ConfigurationDirectory
Date:   Tue, 12 Apr 2022 13:19:49 -0700
Message-Id: <20220412201949.4011833-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of StateDirectory[1] and ConfigurationDirectory[1] to
inform systemd what those paths are used for instead of using
ReadWritePaths and ReadOnlyPaths which can lead to issues.

Fixes: https://github.com/bluez/bluez/issues/329

[1] https://www.freedesktop.org/software/systemd/man/systemd.exec.html
---
 src/bluetooth.service.in | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index f18801866..912c4ac53 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -19,8 +19,8 @@ ProtectSystem=full
 PrivateTmp=true
 ProtectKernelTunables=true
 ProtectControlGroups=true
-ReadWritePaths=@statedir@
-ReadOnlyPaths=@confdir@
+StateDirectory=@statedir@
+ConfigurationDirectory=@confdir@
 
 # Execute Mappings
 MemoryDenyWriteExecute=true
-- 
2.35.1

