Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D11C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Oct 2022 19:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiJZTTt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Oct 2022 15:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbiJZTTs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Oct 2022 15:19:48 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CB512D2F
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Oct 2022 12:19:45 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id r12so14540174lfp.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Oct 2022 12:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UKt5D0VeGh8TwWIsasBQIP8qLwFh76tzqHwK8jC7Thc=;
        b=VYbD07rYbirgRK+n3zue87uKIPTB/YmTdloQ0C8LO6PC02g7tmMPQMUX2kF/bDXI8c
         aK8QFKDmZrqmA+/nbu4u6FvRus9Dl8X5afpD0+9iJrYbgLvKt0CPei2KbfbgijjrnwdQ
         f2tC8xUjrtQWFRqmnXkMFPkR1C3UhmwEZweokYb/aQ1tRrmh+/yMQmaC5VrWuRChCuy8
         pQCQa5KJR+hRpeQ3Ok52iFpRAF0aMNz2W3F5NP/WtznvyfZn7Nm9Thef7e/f2lcXJXS5
         dTCG4W8BQEE2RWSmJNDEvKfTcehVvIGTGNy0TnjRou2M+NzfqxBU5Q6Un/YhiZBLDXMU
         WSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UKt5D0VeGh8TwWIsasBQIP8qLwFh76tzqHwK8jC7Thc=;
        b=CPJCerZjBj7mSahiS6iSeFkjj1QV2ah39jOHZGWB2r+tPtZBcBFj9w42Wa+WYPt9eo
         QCWcwMzsiirayZUbH6hWKVAknY3WikOiSknQrqY+VsCHeRDo8qCvfMsxrBucCNF/xiyH
         R7aPvGlbD6L4RKEsgvFkZKGTB+SCS6GJSwBUbVx8wgz0ocP4quRJW6mTCSNLsoInG+G9
         b3Cu/N1nqFa2yxQLmarwUBKFOEDdmW5GPpqe/Gq6XPpSZKQbC/TZn+ehAtqOLNbq6/yK
         aPtbhagWswo2Zly4vF7BzaQ6AOE2ptQ4CE88/n+tVUcZOAKUWzN0OlrfccIH3DW9MpHO
         Iw+g==
X-Gm-Message-State: ACrzQf0I5uvfF96nVlDMewMbeBdIIcDk9qMLl1YFole0RBDmVLYgMxaa
        M8JAZxTaER5yBLoPwjrrnFOGj6PNE6xNT8EugBqfE+dB+TB0cyjG
X-Google-Smtp-Source: AMsMyM5eCpu8+UCVvdlFKljHdstYfixBBz+0Qa19xmju3MxuasizwEuVQZaHm1hg7vJuZTyffG783ywPdW75fUUOd/0=
X-Received: by 2002:a05:6512:3b13:b0:4a2:564e:6cea with SMTP id
 f19-20020a0565123b1300b004a2564e6ceamr16276073lfv.242.1666811983553; Wed, 26
 Oct 2022 12:19:43 -0700 (PDT)
MIME-Version: 1.0
From:   Gabriel Mula <mula.gabriel.fr@gmail.com>
Date:   Wed, 26 Oct 2022 21:19:07 +0200
Message-ID: <CADrTX9-1CrAqmjFmsVTGOmutBnzMZ-PRwpwrepnoJzHPu1X5+Q@mail.gmail.com>
Subject: IMC Networks Bluetooth Radio (13d3:3571 ) Issue
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear all,
I am writing to report an issue with USB IMC Networks Bluetooth Radio
(13d3:3571 )
It is a bluetooth module that can be found inside ASus prime x670-P
wifi motherboard.

On this motherboard there is a Wifi/ble combined card :
0a:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd.
Device [10ec:b852]
Subsystem: AzureWave Device [1a3b:5471]
Kernel driver in use: rtw89_8852be
Kernel modules: rtw_8852be

I am using the driver found here on github :
https://github.com/lwfinger/rtw89-BT
I am using archlinux.

The wifi works fine, but the bluetooth can't see any device. (i have
opened an issue here https://github.com/lwfinger/rtw89-BT/issues/10)
< lwfinger > have try to add 10ec:b852 to btusb.c device table, i have
recompile/re-install the driver, but it doesn't help.

If anyone works on that subject, please feel free to contact me,
I am not aware of kernel development but i will be more than happy to
help if I can.

Regards,

-- 
Gabriel Mula
