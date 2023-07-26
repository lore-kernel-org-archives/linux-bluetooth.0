Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A779C0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 16:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjGZQTq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 12:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjGZQTp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 12:19:45 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EBA2704
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 09:19:35 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1bb74752ddbso27767fac.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690388375; x=1690993175;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5lL/kQikztMs8Cn8f+6C2BZVYlml8hsfQzt97f+eYBw=;
        b=p2QG2aFEV022hFKS6FWbpC4qZ1QEy8TSD2uncNYuUK0GoF1nuYNxB/FkwRrNiqY6KP
         JAFOgJCPJJSPjP0+ICkEYAmfR34T2ffB0vnUffut/h8VrT7ZVUOybZ0VwugJqTtMw5nd
         nnZ5dtXHzgr90z4mF/2Z+pMS6YIPw8NnBjutLrn6K6f24es4hagpJDhgUg765NVYp+Nu
         i8XCNRdcmvnG3Xvc6F+JDAJySQo6LMfrrIF4Iu7Vi4QNfkm2Zema11rE8y0PMzXh5t3n
         CRWgdL6jWlKZkChtfPH3Dba8FLtnbRN68XXHx/FDLxeSFioSZmgq//9g/Vbo7sBU/7Ve
         yAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690388375; x=1690993175;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5lL/kQikztMs8Cn8f+6C2BZVYlml8hsfQzt97f+eYBw=;
        b=WYb2n3rEh5RcYx2DkN7vMkX8OC+Y0qy2gAw+Lu9GAUk5qEhWN++0tTJ2Y1FxdRjdB+
         Q5p5+HrP2PISWPBAkPCgZmXdFwqrqTG7N0OCK4tiwX9MPuorV6vaAA2dLcAj7IOKJ9mz
         W7qhLaE7wqR0A33qtAIAgnf/3jN4KgRLsb18jscWhKu7Him2VD1bt4yz4mMwj5eglg9E
         7n7RDtoyVYJRFVBDwYH3NW8bENr4XXc+enAZN3Ihe7tHqqUcBJ1sCuEEsXnFZHT1dkdp
         qQMxSAm1KKgVG9rvjEnVkp+6pU07O/0oq5ir48NQV7tbjzb/lEqJl+H3lcQEUW69BF1J
         I/Gg==
X-Gm-Message-State: ABy/qLZ2AE2M7u+REGHCMtLfeMxMjoXrxT+XpkMunEMUBgW5fyo1rJ8l
        Oi1jetJSMPP8aSJWYS2vbvLtybUyZh4=
X-Google-Smtp-Source: APBJJlESVkKPIg3Dv/cksE6iADuWLW7MkY8Ottc4H48b887zSx+A/d99xV/Qs9qyEzHCzGDjOMoTtQ==
X-Received: by 2002:a05:6870:a446:b0:1ba:8307:9a17 with SMTP id n6-20020a056870a44600b001ba83079a17mr12999oal.10.1690388374855;
        Wed, 26 Jul 2023 09:19:34 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.171.126])
        by smtp.gmail.com with ESMTPSA id v1-20020a05683018c100b006b89596bc61sm5971440ote.61.2023.07.26.09.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 09:19:33 -0700 (PDT)
Message-ID: <64c14795.050a0220.e1e0f.41ae@mx.google.com>
Date:   Wed, 26 Jul 2023 09:19:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6846479088677373646=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Rename BAA_SERVICE to BCAST_AA_SERVICE add BASIC_AA_SERVICE
In-Reply-To: <20230726145303.137597-2-silviu.barbulescu@nxp.com>
References: <20230726145303.137597-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6846479088677373646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=769755

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      27.99 seconds
BluezMake                     PASS      1019.84 seconds
MakeCheck                     PASS      13.03 seconds
MakeDistcheck                 PASS      161.25 seconds
CheckValgrind                 PASS      261.36 seconds
CheckSmatch                   PASS      350.77 seconds
bluezmakeextell               PASS      106.68 seconds
IncrementalBuild              PASS      882.03 seconds
ScanBuild                     PASS      1098.76 seconds



---
Regards,
Linux Bluetooth


--===============6846479088677373646==--
