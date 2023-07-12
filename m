Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D59FEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 23:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjGLXN5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjGLXNs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 19:13:48 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71C32683
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 16:13:20 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b8baa72c71so36897a34.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 16:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689203600; x=1691795600;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=znj+4q+TQh6sfUKALZ94Ur+6iAhuqrpKrTHlRdoRPfM=;
        b=nRCej8UHbS1TAirPmGuYwjkO9NAKJ0saz0b2hSi75avj5fGHNLFP9v9WlUhByDNmJD
         YaxHSRfLqekGIDG8uHEQ3MHJdBvmLY+8zpIVcVVFL99zXK4aAYzq4Iqwk1LgakgTqe4f
         Lv3mlSXjGVg/6sOkTBT4CFCs/59oGs7V1rZI5HYg44X0j/uwt+Vwd4d2kWcp8gpb2Pa0
         oty3HwyfwZ3SpnL5gVbHNIpdNdpLHgZsI9NqMX04rZc55JxgjjpMzcMz9M4+e58Aljgv
         zLLTVBSYBAzStUnM0TXUo6FuruF9Iw90k1ZX/RmILClGpjUQmLz58blgTyWzDr7uDCVN
         nXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689203600; x=1691795600;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znj+4q+TQh6sfUKALZ94Ur+6iAhuqrpKrTHlRdoRPfM=;
        b=IVw09HQ/F8ATBZ7L1aF51TN86JO73YwIK24+E9PwfBHVkk01Q+3yEbL4s/DxhrAuaf
         MsnpfM2hHfLF+DJTDGZhYl216FeFWkiJiIMjTT/ZTpbvTXnvUSg0k+9RE2NKLPX2ZPFb
         y+vW7Lzrp7mp/HB2EO+UhdxIctn0rFgYXufuGLBz/Fxi1YvvRsAgw3ATV/usMtO5rdvI
         dxOjIJiEnIPmnktjp884X38Vj0OqKzDHGR2lWzNgBBW7YCXZF2q5D3YK1MJ6HLZebzkx
         i92n26tehzu4MtPk9te45Id47yLa26iMHwLWsRga7P/co9C7TqHNuFC8IXVTL/X+hWUF
         lIcg==
X-Gm-Message-State: ABy/qLY4n+2CXOS4YNXvwwWvEpddL6ZEtYkPSDSxC2Xi3jhgMhZCbcaa
        mEC7Fc4pSZFzNXJ7R2nskXuXQ/aXwFI=
X-Google-Smtp-Source: APBJJlHIuIVBhXW9SGNMILMUJWRYl+gK5oNxJdA7QI6yMiQevmMRhsQIv05NToURN8hA4Sxuw2QjRA==
X-Received: by 2002:a05:6870:4711:b0:1ad:e92:62e1 with SMTP id b17-20020a056870471100b001ad0e9262e1mr110109oaq.54.1689203599822;
        Wed, 12 Jul 2023 16:13:19 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.106.80])
        by smtp.gmail.com with ESMTPSA id h5-20020a0cf205000000b006238d903f9bsm2547055qvk.42.2023.07.12.16.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:13:18 -0700 (PDT)
Message-ID: <64af338e.0c0a0220.ee0b4.96fa@mx.google.com>
Date:   Wed, 12 Jul 2023 16:13:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5559254486973012908=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bugzilla-daemon@kernel.org
Subject: RE: [Bug,217651] BCM20702B0 Bluetooth device in MacBook no longer working
In-Reply-To: <bug-217651-62941-Hk3dwMQ6SC@https.bugzilla.kernel.org/>
References: <bug-217651-62941-Hk3dwMQ6SC@https.bugzilla.kernel.org/>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5559254486973012908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:3831
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5559254486973012908==--
