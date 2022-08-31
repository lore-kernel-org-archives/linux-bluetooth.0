Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCD0ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 06:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiHaGNG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 02:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiHaGNA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 02:13:00 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4DBBCC1F
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 23:12:59 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id u3-20020a4ab5c3000000b0044b125e5d9eso2350014ooo.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 23:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc;
        bh=Qj2p8YrgXBK6a9h06fDoxUP9OHd1auAzlEwx1dlbG30=;
        b=gzcco3BTueaFAWB5uBF1q9t5+5rDOltRRR2yq4pYqfkacOxgZikYHMbrOL292DhsHF
         8cR/P0lxBFSf+HOb3kwgYjx6EDvIa+g8ves1fXed5d8RVskuR/5wE7GwGeO8UJ+5IFrE
         rjPM7+eRMk9iuu/F6f9MBjg/qy3uBawfNffv0dW1NE6KpWVbqCcA1nI1Mcl6FdyubEf4
         Y1/KCHPjOr4GIG637TynhhddgnLwkKF8JOuZ8jam631kmQh3Eu1KiAJinqQhNasa1EPR
         LmqxqGvwQaubWq3iTPa76hC7ruDlSbuXA2Lbn79/wUKm/2T7Ua7wAnBEdUFo828wXYBo
         Ff0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Qj2p8YrgXBK6a9h06fDoxUP9OHd1auAzlEwx1dlbG30=;
        b=t4w4gITdkbMNeCFsn57fKJSNjeM4zknM8X+NY12ikLnEY9IQ1q+SHsXcZX9FzL1mae
         KJQvrifEeWsTNwWD0rYW7md403PUNCL39wISpzXPI//iVIey1I5xzO7QG5hxz10A33aw
         H5BZxbUnEfqtKgxlIfqSskyIRhGTWdIGD38r8alXn/CI74JoD7q7IxFTTTMcANqmdKJV
         huFqSQfxI8UjLrEYXCySaH/uCKGWpFo2jWeVsC2agDJn3rUT6twNCMOhitSp4dUU6WQ8
         YcT6IttF1STUSOY55if8YvcFZ8zJtzKLl69766Op6jGca4V4Ofw2JMJTjmz5YiReD1cs
         GGDw==
X-Gm-Message-State: ACgBeo0Fki2fVgpECn/1CK3Du3ynA0MenI///Uxm0X6+Gn9ufyE4Es/5
        /G1CTKDwQx7JR2BTva6U+7cm4tz/kgQ=
X-Google-Smtp-Source: AA6agR42y/xUSrLzXWM8hfp6qY1Vo19dC0f8re51faOsAsDb0jAEZFrLx43COvi7KYCi19dLQlOY0g==
X-Received: by 2002:a4a:b6c8:0:b0:44b:4bfe:426d with SMTP id w8-20020a4ab6c8000000b0044b4bfe426dmr8390371ooo.12.1661926378652;
        Tue, 30 Aug 2022 23:12:58 -0700 (PDT)
Received: from [172.17.0.2] ([13.66.23.166])
        by smtp.gmail.com with ESMTPSA id k8-20020a056820016800b0042859bebfebsm7895437ood.45.2022.08.30.23.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 23:12:58 -0700 (PDT)
Message-ID: <630efbea.050a0220.1789a.52ac@mx.google.com>
Date:   Tue, 30 Aug 2022 23:12:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3934828119140359476=="
MIME-Version: 1.0
Subject: RE: Bluetooth: btusb: Add a new PID/VID 13d3/3583 for MT7921
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
In-Reply-To: <cec2ae0d86aa633f3a6666e3812c1c05ab9a0d03.1661921257.git.objelf@gmail.com>
References: <cec2ae0d86aa633f3a6666e3812c1c05ab9a0d03.1661921257.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3934828119140359476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: drivers/bluetooth/btusb.c:484
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3934828119140359476==--
