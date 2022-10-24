Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564E7C38A2D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Oct 2022 22:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiJXWyt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Oct 2022 18:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiJXWy2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Oct 2022 18:54:28 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D351BFBAE
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Oct 2022 14:16:04 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id z8so6406924qtv.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Oct 2022 14:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uvu3ZmNS98EQenPqE5bE3iuj2W4Sgf+U7b+wuw7Q2t0=;
        b=Fu6D5Keo3s5qtCumqCww7U7JI4XUDag1FzvHPJAkRfCuCzzpHR9M4ezlQCF8sEq0uI
         bwmz5U3ARpyI1YygDh5FwuziFggNpohx4GPd+Zn2DR5/fTgVzHUsggA5mK3MgZ99U3R5
         sSZ4j5zNygtROQSSv9u4/ETry/fDyBqyyj2Sy4Ggnu+RSn06Xe3e7Q0JaOVxqbSAM7yc
         VmKtoJRNkqbeLHOChjMoVrcCj3EL2ZcKwOGUQp2fUmUwOXJ+CbxiCh9jsXXGX4V6ecIy
         QVkIJPpGHhgzh7T8QJAu6gCqG8DALH8cklaNbhIzZ14XHnLBj3rt2MTeRn0LHr+invxR
         MU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvu3ZmNS98EQenPqE5bE3iuj2W4Sgf+U7b+wuw7Q2t0=;
        b=ssCQHycHBHtD90g/tX+xEGavQtEZvJ90714bwbOFj8Td4qo9+IZdqtF6sJmM5rOFP3
         e4tWkRBSkgZ6Q+5XCbVNDJaFzsQUD+xR1haQOc9l0peDD8RQepKC8UpPvpkk1KhzSEdC
         VHUjoPeiQpQ6rvWxfQCs12gTstWPPqXPhxedQ3E8GULpQETcUrWU8StayaLfPT69wsPT
         GXUFCtzn9WEiC0opNo3Ia31ppZlUc1kjoW0J9vzSeW1F6FmvYHzs4vJ3914mkz6w8oy1
         na4JwN/33ZxFl2lOrUE8CoD1l9V7c0cds5QoeugQTTfk8yupl2gQksxWPrQ+1L3qKH6n
         PeBg==
X-Gm-Message-State: ACrzQf35uIB4L2/Pyw59dCtbDfxsmZ1rL8G3/KmEeJBu1aYxg9EIkwCK
        StpTsMOWwwG+en3ACvoq53+chdGDLEt4/A==
X-Google-Smtp-Source: AMsMyM4Z+hp06O7zv6lUsGYRmQDlByvvf1OO0HwfyNvV8w1xantplJe0FicKkStjemD0D+g3GBR8Ow==
X-Received: by 2002:ac8:5f12:0:b0:39c:d2ff:13aa with SMTP id x18-20020ac85f12000000b0039cd2ff13aamr27781057qta.193.1666646109565;
        Mon, 24 Oct 2022 14:15:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.124.147])
        by smtp.gmail.com with ESMTPSA id u13-20020a05620a454d00b006a6ebde4799sm690563qkp.90.2022.10.24.14.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 14:15:09 -0700 (PDT)
Message-ID: <6357005d.050a0220.caba2.2500@mx.google.com>
Date:   Mon, 24 Oct 2022 14:15:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7768344550679736043=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, igor.skalkin@opensynergy.com
Subject: RE: [v4,1/1] virtio_bt: Fix alignment in configuration struct
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221024134033.30142-2-Igor.Skalkin@opensynergy.com>
References: <20221024134033.30142-2-Igor.Skalkin@opensynergy.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7768344550679736043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=688397

---Test result---

Test Summary:
CheckPatch                    PASS      1.80 seconds
GitLint                       PASS      1.02 seconds
SubjectPrefix                 FAIL      0.90 seconds
BuildKernel                   PASS      34.59 seconds
BuildKernel32                 PASS      31.04 seconds
Incremental Build with patchesPASS      45.75 seconds
TestRunner: Setup             PASS      515.95 seconds
TestRunner: l2cap-tester      PASS      17.43 seconds
TestRunner: iso-tester        PASS      16.58 seconds
TestRunner: bnep-tester       PASS      6.65 seconds
TestRunner: mgmt-tester       PASS      106.36 seconds
TestRunner: rfcomm-tester     PASS      10.56 seconds
TestRunner: sco-tester        PASS      10.04 seconds
TestRunner: ioctl-tester      PASS      11.22 seconds
TestRunner: mesh-tester       PASS      8.12 seconds
TestRunner: smp-tester        PASS      9.89 seconds
TestRunner: userchan-tester   PASS      6.90 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.90 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============7768344550679736043==--
