Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832A2C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Dec 2022 19:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiLITMU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Dec 2022 14:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLITMS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Dec 2022 14:12:18 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE2E2AF5
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Dec 2022 11:12:17 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id f24so2600314vkl.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Dec 2022 11:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kZmqbtQGoBWYTZCCMzQTB+yc1cpBLbwoYVYgVPdCLuY=;
        b=Q44i4h6YYzBYG2eAnr2RJlN3KW8vXhW4hawNZW3HIet1uXWhfWmStzuFWYbdl5+tN5
         B9qFCXGVWNGrNBzWafRvCrtiRku0uXiuZfM68EByqXcjoPNaAfRDp5WhBPSeqLwfmvo0
         LliTm7H1EnTQN7WOrBxq70wJtCcS092ugvWN6IgPe4Dd49+YQ4s1w3s0/fQ+upwpJ4Y2
         U0LQa4HsOkCtcHGUfff8/+jS4KcjQaVO5M++p5TbFdMlg/wNWbPh7xAu3MBr4F0C4iDN
         S+duiH4HJG5ONEA8eoTQnSzVtKjcqperkQC3Rkw8MLWngs1cMo8sYv7f8V28wA4qiUDG
         VDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZmqbtQGoBWYTZCCMzQTB+yc1cpBLbwoYVYgVPdCLuY=;
        b=xgjsucA5GDwByahMSjChRGlJqY5Ma6HXp14ihTYgCU9cmpM33IcuQ3PDomMYEqKxPg
         haOCyX1woH4dbWcxkdVCHJrl6m8t39V8hQcFMqkwwNbW5YscKCcOG5crD4MZSGf9YmzG
         H51jx3ldCi/KYQDD/qC8/DtGAIAdw5seKzIuQhT6drN/n2qDylzNmqEQ0C3AOiycZj+D
         vpK+xEAXgbY1OvYlSmpQDZE/k1cMkJZk8vVeN1XehQ755vYoY46GVCzbY7BZQedArydz
         nmqRumeKWAJTFWin46U4W7BXAE+cglrWLqDDM5882zjc/VijhAJNlASko2zCP8DVJCKy
         Gc4Q==
X-Gm-Message-State: ANoB5plNdv/xEfZ/TgtKMcmLY+LlErFoXfxl7dR4zxIHQudvzoegC92p
        30RbPv9xsyHna9s6zGBcnrOC4mFkJt9wrg==
X-Google-Smtp-Source: AA0mqf4bpcn0JeTUK80WJflfC88t6H+MQLiBi/KipPxWI4RkiMueJIs3gFfqbQavBg0idc6V+4WL4Q==
X-Received: by 2002:a1f:5c46:0:b0:3bd:f6b7:411f with SMTP id q67-20020a1f5c46000000b003bdf6b7411fmr3886105vkb.10.1670613136305;
        Fri, 09 Dec 2022 11:12:16 -0800 (PST)
Received: from [172.17.0.2] ([4.236.135.20])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a254a00b006fa43e139b5sm449420qko.59.2022.12.09.11.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 11:12:15 -0800 (PST)
Message-ID: <6393888f.050a0220.dda99.2cc3@mx.google.com>
Date:   Fri, 09 Dec 2022 11:12:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4076630514340726190=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] client/player: Fix not calculating time to wait
In-Reply-To: <20221209180312.938166-1-luiz.dentz@gmail.com>
References: <20221209180312.938166-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4076630514340726190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=703472

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      27.75 seconds
BluezMake                     PASS      902.16 seconds
MakeCheck                     PASS      11.54 seconds
MakeDistcheck                 PASS      152.81 seconds
CheckValgrind                 PASS      250.55 seconds
bluezmakeextell               PASS      96.53 seconds
IncrementalBuild              PASS      733.12 seconds
ScanBuild                     PASS      1040.94 seconds



---
Regards,
Linux Bluetooth


--===============4076630514340726190==--
