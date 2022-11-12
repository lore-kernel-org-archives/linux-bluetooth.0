Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C007C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Nov 2022 09:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiKLJri (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Nov 2022 04:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiKLJrg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Nov 2022 04:47:36 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7706CF8
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Nov 2022 01:47:34 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id z1so4694395qkl.9
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Nov 2022 01:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NJCmpVB7QOarxsdf6kC9P2Lw76R+5eD13ezXYHtGHyg=;
        b=GgpZfdzf37Q04CU1QQGoik4mrDobHBxwLtGgGz/vLlMQc+1+uJh7323bjWhfdnFCx5
         Utwyt1+WA5EgYmkTif6dSXXc6OVl4CpjxB6S9BYNLuo2sjelC0N45WbjX1pb8EtUe9zf
         sVmjWUM1wd/9Wnb/yrdfyk2U1KIzB9reQiXSg8oHz34ygCrmGXNaJ6vYCMBXidiP/5zd
         N/SqTApaeBjgKNJyTiNmL+Yh1WAbxZW1UXKvbzow1Qd1gC1alnQ6DCL/0wTs6CjbFrK+
         0SfPjHyHH6GsVTRbeJHK3RdPMvDadcqnD2nT8iS2kVbKU+SsJOLvfjmbu54rBItY0j4B
         zupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJCmpVB7QOarxsdf6kC9P2Lw76R+5eD13ezXYHtGHyg=;
        b=H6AWTWikyr+pO0q+jK0ku1+j/BCWehgQbwoMFIVA8bO0riJ70w4IrE/kuqslzGE/N0
         pz2QakzVyxXsdTk5QH1qppS1OAF14JMdUsjFO6q+LkE5FH4BYK8zTnE9d6+cho3g1aFI
         /BIv0En0V1xXUN3iMXE67I5YEeyFAtVAqezwmMWRMq8vgAkbZHh6Pote9gGsXne9XNZf
         r6zQwIAxWNjhWpRffD0VPNstQ7eOgzirRzNK7UtunoDctOK23kOIPFFW1q+7n3By2fKl
         h//B1STGdcXJnJBxaKtHVStp3ybboKvYvzwgsAN/6zNCf/9f55Hyv7DhB3u8JxIAPwpP
         dD6g==
X-Gm-Message-State: ANoB5pnPL/hOqtyvpCKUFp/7FzmrpsjIWSxRxBPpNw5G86xYbA+QRquL
        b/JDDXjzz1xbAIOMKmhI6DXmC0Nq2acqOg==
X-Google-Smtp-Source: AA0mqf6EXKKP8j9y+UyCfEnHh+PJhls4J2CnkcLjWSA8gK9B+yu5kVZyoM61dgdV+YBs9tV5srPcSA==
X-Received: by 2002:a05:620a:1196:b0:6f9:f834:7c45 with SMTP id b22-20020a05620a119600b006f9f8347c45mr4195397qkk.253.1668246453972;
        Sat, 12 Nov 2022 01:47:33 -0800 (PST)
Received: from [172.17.0.2] ([172.176.109.253])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a2a1000b006fa617ac616sm3038291qkp.49.2022.11.12.01.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 01:47:33 -0800 (PST)
Message-ID: <636f6bb5.050a0220.6b2a1.9951@mx.google.com>
Date:   Sat, 12 Nov 2022 01:47:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3558242729250637285=="
MIME-Version: 1.0
Subject: RE: [-next] Bluetooth: hci_bcm4377: Fix missing pci_disable_device() on error in bcm4377_probe()
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yangyingliang@huawei.com
In-Reply-To: <20221112090437.3591380-1-yangyingliang@huawei.com>
References: <20221112090437.3591380-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3558242729250637285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: drivers/bluetooth/hci_bcm4377.c: does not exist in index
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3558242729250637285==--
