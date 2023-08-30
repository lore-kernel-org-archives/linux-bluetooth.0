Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C11C6FA8F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Aug 2023 20:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240478AbjH3Ux1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Aug 2023 16:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238745AbjH3Ux1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Aug 2023 16:53:27 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE359E52
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 13:52:53 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-34bae82b2ffso651115ab.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 13:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693428711; x=1694033511; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rRR+CuOr40pfkWv2FLUPaihN76hpD2DhbqPkjrvrgWU=;
        b=c0FJgA311Gu4oYQxpC0P6F+rTokiC2Z8Di/I7kXBSe1dBkB+asbYfddKEiwUJS1lRd
         o1N8lnKw/oPAvTkRHw8hiPzongmXun1wMnrMlV6CNA7Nf6Zj3swt1iWbzpIqahu8lc57
         7ypM7A+59lZ8W4GH7pjSe9s4FKAUlqJ9R/AFFUGBhwqvBZ+yIcUq+Nw96m3jFBXfseI8
         A0km2mvqRBoZBgV3e+bhpfSKb0DDy/1/NMC9VtVH/f2zgCzdBNk2c5tyKl+Nbbe1VwHX
         iCPBWGIOiHI+31IjIaAUSODuFkKhWN2TI1Vk4n5SZ6r7ujj2xR4DbO0HnifJMU6lZOT2
         5YVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693428711; x=1694033511;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRR+CuOr40pfkWv2FLUPaihN76hpD2DhbqPkjrvrgWU=;
        b=Vne0tYS/s5MXyX0rNmO14NsAn/Ym3SKciq96skoIaccR0uvY0Ywyq3AsRboCCwXygX
         EiuIScr/0BMgtaIWqJ5nhZzr7QLkg4d3kW9/LM5HF2nDspKOCn2l4kwaS9bfngxCx+8O
         +9UuLPItkmHA00HV8+9ZT6HdIHvcE7MxykTM4+a1LmCkL9QCEnJRleCFL0uGzJTEGjJw
         VrrGtIP+hLSuusm5vL5aoM99Vzuy/S+wLewRGYtblU2Os62it+HsxKdb+5dpmXUD3vkF
         fkJO+qnpKd+Te2ARs2yzX2+FyfAYZ0ZpcTn+WjzcqO4KcL0/BTVb/VgTwIM+fwtZMOve
         EKeg==
X-Gm-Message-State: AOJu0Yxq/ylrDNj8ssqqAwP3hW7/Xl6ARQSLnfQvuo/m72aIw4VG/2w7
        nFg/xvOu6G5K0gliO6/T9LDOC0Wgg68=
X-Google-Smtp-Source: AGHT+IEhyM7apDL91ipPluLmyzunAdSrLGFfka1tp3OZI6Aczjtn/gmxUAH+ggkgSPTx68FWb80l0w==
X-Received: by 2002:a05:6e02:1bcf:b0:348:ddcb:137 with SMTP id x15-20020a056e021bcf00b00348ddcb0137mr4715901ilv.16.1693428711343;
        Wed, 30 Aug 2023 13:51:51 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.43.50])
        by smtp.gmail.com with ESMTPSA id y16-20020a92d0d0000000b0034ac4ccd097sm17023ila.33.2023.08.30.13.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 13:51:51 -0700 (PDT)
Message-ID: <64efabe7.920a0220.924c5.005f@mx.google.com>
Date:   Wed, 30 Aug 2023 13:51:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2020430420449451462=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Set device non temp when synchronized with bcast source
In-Reply-To: <20230830132915.72153-2-silviu.barbulescu@nxp.com>
References: <20230830132915.72153-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2020430420449451462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=780614

---Test result---

Test Summary:
CheckPatch                    PASS      1.02 seconds
GitLint                       PASS      0.67 seconds
BuildEll                      PASS      34.92 seconds
BluezMake                     PASS      1229.43 seconds
MakeCheck                     PASS      13.21 seconds
MakeDistcheck                 PASS      203.48 seconds
CheckValgrind                 PASS      330.33 seconds
CheckSmatch                   PASS      457.77 seconds
bluezmakeextell               PASS      136.69 seconds
IncrementalBuild              PASS      2114.09 seconds
ScanBuild                     PASS      1458.08 seconds



---
Regards,
Linux Bluetooth


--===============2020430420449451462==--
