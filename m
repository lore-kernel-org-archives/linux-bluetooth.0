Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C2FC4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 17:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiKSRNy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Nov 2022 12:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKSRNx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Nov 2022 12:13:53 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8735013F7D
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Nov 2022 09:13:51 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id o13so3941233ilq.6
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Nov 2022 09:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mHhryjDNPwX9Z/3b1iaiutGt1qfy2L0YB9tjdokOIB4=;
        b=dMBblATU2YbzNP/I1nRl1/D3dlq3+1DxWPOg1XgfkMyCJpMzB0dM+s0yLbPPbqktGS
         OnYRb8mFBBL3MoM9GEmR1hHN3EgTDlyeaFuc+bNNkhbZtwIseJfrb98E+7RgJ47hlb8f
         WbI4tv40pey4ygvrl9Y68Q3SXxSwLptDOySmjIPj3ChUTKCyfQPmRoSev8OptH6ZfD8R
         Q4eh1UZFXrUBVlIL9X76y5GFXZKxUr8MUAveTEhAZbougTl+pa0BE8ToAY4ElbgAKN3R
         aAv1bSYPD3pOAfew3/88uDyVxlBPFEM/LK3mtjjyg+0zLT1HH5ewwRHHSF1RiMHCgkFs
         2mmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHhryjDNPwX9Z/3b1iaiutGt1qfy2L0YB9tjdokOIB4=;
        b=bOFutBB39SWZzNf0+C6y4pwDK+o3+nkQV563cIeFJcOXG1TCyVNEbaELpp1UenuoBY
         U4yESukcqB/UZRMdFfkKTSnYCY074hHj24jW/Wet+vQDyl8uHd2YsX7lkyNsVOKldcgV
         Qj9kOjegzPaMgzy33iGo/TqPxdnL0XWApeHCmJad6cZO7qdgHBMEG7EFH49FjxAgfker
         eOWfHDmCI9Pj4djN0nnH955k6Hg8kQtYQlx247SbPdtvHU0MOKgykMJa7vrgJyG9UZqK
         azjiYF4lQ4SUbhUnpCGT0FBHjSCnPS6AgJx8UnrzXHWM9l4YRLPFypmWaw0hrXxVnis/
         SgEA==
X-Gm-Message-State: ANoB5pnuC+Ml5GbzuEfDlIhxIY0+4liF1gKDLQhN4SUzJTxLmKKOITkZ
        +/z8Ja8EIpOOcYlupkLCGIvx45ODv1M=
X-Google-Smtp-Source: AA0mqf4iDel57YcUWKrr+bqSlH/JHYV2fLA7XnQsXYqrFLPCx2/xis3sSqq1qVhzvdezPJvR7BHGBA==
X-Received: by 2002:a92:cb4e:0:b0:302:bd25:d752 with SMTP id f14-20020a92cb4e000000b00302bd25d752mr221738ilq.262.1668878030706;
        Sat, 19 Nov 2022 09:13:50 -0800 (PST)
Received: from [172.17.0.2] ([40.78.153.184])
        by smtp.gmail.com with ESMTPSA id p70-20020a022949000000b00374fe4f0bc3sm2378712jap.158.2022.11.19.09.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 09:13:50 -0800 (PST)
Message-ID: <63790ece.020a0220.f799c.57bd@mx.google.com>
Date:   Sat, 19 Nov 2022 09:13:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7491886932450857178=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, MihirKhatri@proton.me
Subject: RE: btusb: HCI_QUICK_NO_SUSPEND_NOTIFIER causes kernel panic
In-Reply-To: <zEEbuiH5Idm8MyWzcjDThSGXk1jtLq8YxNQPGtHSClFG3F-22Zb3kYwj_IR_YVLszbAnWC-9cqTvWS-RjiZHlNqX8Ftduyy6fwIL8iDHkns=@proton.me>
References: <zEEbuiH5Idm8MyWzcjDThSGXk1jtLq8YxNQPGtHSClFG3F-22Zb3kYwj_IR_YVLszbAnWC-9cqTvWS-RjiZHlNqX8Ftduyy6fwIL8iDHkns=@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7491886932450857178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:2267
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7491886932450857178==--
