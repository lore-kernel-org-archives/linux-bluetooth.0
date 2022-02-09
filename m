Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B489C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Feb 2022 15:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbiBIPEX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 10:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbiBIPEV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 10:04:21 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8415C0613C9
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 07:04:22 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id j24so1786215qkk.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Feb 2022 07:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=uFKphhMUppnplotc9+xhmJtKHlN4Ux1Hhh1soUTEWr8=;
        b=m4czT3r5OJ9f9e0lumgiK29vapgh6nc5q7FGr5cU4ukpeZckuJQ6r0d6AwnB9ifRRA
         n/dOsrfSIxmEsJmqgnwEN+7yXt29eAw+oumWSvrpnzIXT3lH6s/pGuek3TJNgTdTzeLc
         5sEUuSgqIPhZnOYOoLzQQh1nNm5FNdh+x04zpeKErjzIqeXeIYPnGutPo0/bodsU+zEq
         V5v7kZrtYu5pyAjOZTVSmiqIDAqdEa03kQYPLqLQco4C7IQXla7lULQV64TxY0RQhXVZ
         kG2dMqFYIkOqoyMwzuR9wWByFGfWbkU5Rp1Lvk70fXU6dGIFvj+zzYa2rwsBWa70wL2m
         So0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=uFKphhMUppnplotc9+xhmJtKHlN4Ux1Hhh1soUTEWr8=;
        b=jY0TRVorGSXr8q5Keg4EwK/dSkCMxKllKAzHCGWT+dgdgS3tJ1jsiv/gu/5s50MI9T
         81htVoc3SV3rxWEa3IdK5n1DHzzecxLX/WPr+s2CMbM8XUgq7tUCVUIr1nC5ulPOrtRl
         FuZAl8t8W4KGZcHvCy+512mKXx8uCpahZ1G1rEY1HCi2xVC3PES2kbW/iZNsfCA9VzAj
         IeFAMFFCaOIkCJ4ziewwN4aZqQ/pddyP/GJ1RkA6htd1eMPlVu2S8xOAOxbhByLl0u9B
         asz8Zcw1G+1Vuz3o3g6wXyiX3BCX6s/hUZ+R+JZoSEMchpPH1J2E357clx8pAZyjRiFs
         BXfA==
X-Gm-Message-State: AOAM532eNNRnPMrVQN4fzC3jCPwcTskAV9BdYrWeQqp81wx5e5J0wFCe
        9xFx8+RMttHNLyiXNHNYBQZqU32kcKgc9A==
X-Google-Smtp-Source: ABdhPJx4MzJ+J5iLCyVvwPFaqNX8fz4g0Yw95AgnTh/59NVOCZPIJ4nLWEqFyhnQeNk2JeehQDX85g==
X-Received: by 2002:a05:620a:b0c:: with SMTP id t12mr1286705qkg.132.1644419061376;
        Wed, 09 Feb 2022 07:04:21 -0800 (PST)
Received: from [172.17.0.2] ([20.114.227.176])
        by smtp.gmail.com with ESMTPSA id p70sm8358744qka.62.2022.02.09.07.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 07:04:21 -0800 (PST)
Message-ID: <6203d7f5.1c69fb81.e90a4.bbda@mx.google.com>
Date:   Wed, 09 Feb 2022 07:04:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2415277303675563313=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, niels.dossche@ugent.be
Subject: RE: Bluetooth: hci_event: Add missing locking on hdev in hci_le_ext_adv_term_evt
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <436acf8a-ea5f-a308-0e3e-fc7c6ffde7aa@ugent.be>
References: <436acf8a-ea5f-a308-0e3e-fc7c6ffde7aa@ugent.be>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2415277303675563313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=612647

---Test result---

Test Summary:
CheckPatch                    PASS      1.60 seconds
GitLint                       PASS      1.04 seconds
SubjectPrefix                 PASS      0.85 seconds
BuildKernel                   PASS      29.24 seconds
BuildKernel32                 PASS      25.92 seconds
Incremental Build with patchesPASS      36.10 seconds
TestRunner: Setup             PASS      457.23 seconds
TestRunner: l2cap-tester      PASS      12.96 seconds
TestRunner: bnep-tester       PASS      6.09 seconds
TestRunner: mgmt-tester       PASS      98.82 seconds
TestRunner: rfcomm-tester     PASS      6.91 seconds
TestRunner: sco-tester        PASS      7.28 seconds
TestRunner: smp-tester        PASS      6.88 seconds
TestRunner: userchan-tester   PASS      6.17 seconds



---
Regards,
Linux Bluetooth


--===============2415277303675563313==--
