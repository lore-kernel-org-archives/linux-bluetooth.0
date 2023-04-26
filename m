Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993ABC7EE20
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Apr 2023 19:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbjDZTMR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Apr 2023 15:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbjDZTMO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Apr 2023 15:12:14 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C9C86B6
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Apr 2023 12:12:11 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-541f2112f82so2580200eaf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Apr 2023 12:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682536330; x=1685128330;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PXtmVRj35/3vBAVDUJfGvxfIJG36W2lNkxnAktQSeZM=;
        b=m0I2T/s+dru9zZy+gy3lf7ufBo5QshXrtDmHtUD4ONcCq02YJa7KKsGa0BPhKymr5/
         QiIhQMhS5xEKVXlT9U2MnBon2rq9pqBeWosw5s2p7BAo13a/z49APNIWHwJRarN98GHB
         RPri/0h9tx2qAuidDcreAJhwdM2AHHOeU6Fu1Xij4Hnc/IDTk3S+GnMVMFKVXliNKVcn
         Q9BRe1V4eDfwhml8Ue/xImh/+g/ZixXCH1W3haefuZNvTujvhiS3ptpcaplCZAn5kU5U
         oPOLL1kDKpYBlqv2OYKQ5oRC3wp2sfSiZg6MCrJ2cgKB528rqs/uL19ffDghq/VmHHxS
         Z3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682536330; x=1685128330;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXtmVRj35/3vBAVDUJfGvxfIJG36W2lNkxnAktQSeZM=;
        b=Q/0MThgtwabvqevEwsVE6RiGjmMG2eCWUNm9ECOwOp6f3mPkFT8OyhiH0SrehRbULz
         A3vu/0E3Hwrxkrqera58Aba1F7g+3UkZGJV3vSOr2Z7Y17IxCLMDsnpcVH0bvAwtwKUj
         Q/7/gG1vx5/PS44JGtOOX6Z5J8BmDqaH0kfH6ivvejy4DUiKCuYYWywZJM90nL3RKHKW
         cKFbL+IVBrMFYTUxqx9s2Zyp3HQcbjcu1xdh5HVFZJH+eJQnCgHlNJ19DKyMsdLfFb1i
         WKekfXBrd2dUe0FcVLm8MVsY2r+grmYxf/LNtqLFDJ3NRO3wG0uGVgia77c+dY8W6/Ng
         XMBw==
X-Gm-Message-State: AAQBX9cxeXGsOF1BQ9LwkAtr2URvAHPkPC5UuGJroLK8rKg1t+cBnW4v
        wWvq9HtNNhSEiKNPfBvBMADxJr1riWQ=
X-Google-Smtp-Source: AKy350Z4Gv6xZwOC68oggBOVBqpvOuLmA+oFWM/HyVTQBYOtGYkHg+sTsYVyaU+77BRcEzw30tRlLw==
X-Received: by 2002:a05:6871:b28:b0:187:bbb2:9586 with SMTP id fq40-20020a0568710b2800b00187bbb29586mr12744223oab.33.1682536330696;
        Wed, 26 Apr 2023 12:12:10 -0700 (PDT)
Received: from [172.17.0.2] ([157.55.189.37])
        by smtp.gmail.com with ESMTPSA id u36-20020a056870b0e400b0016e49af5815sm6847479oag.51.2023.04.26.12.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 12:12:10 -0700 (PDT)
Message-ID: <6449778a.050a0220.d4ecf.0ff2@mx.google.com>
Date:   Wed, 26 Apr 2023 12:12:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4151595695799154613=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, raul.cheleguini@gmail.com
Subject: RE: [v2] Bluetooth: Fix unexpected SMP command errors for ATS2851
In-Reply-To: <20230426184017.2051211-1-raul.cheleguini@gmail.com>
References: <20230426184017.2051211-1-raul.cheleguini@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4151595695799154613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:4374
error: drivers/bluetooth/btusb.c: patch does not apply
error: patch failed: include/net/bluetooth/hci.h:316
error: include/net/bluetooth/hci.h: patch does not apply
error: patch failed: net/bluetooth/hci_sync.c:4581
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4151595695799154613==--
