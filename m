Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA6EC25B0E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 17:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbiHPRE3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 13:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiHPREZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 13:04:25 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8DF69F44
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 10:04:22 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id g16so6373170qkl.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 10:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc;
        bh=qDSIqfen+i5z1iQwQLRSHuCDe8fnVaAMW6J4fK8zz7s=;
        b=iCtmrwbdNe3CTolxLozfQB9IJpMbRgERQg5GX2Lla9njjV6s1vHiLFNx9G3/x5EjhF
         0ls/28Ljk0RqQuT3Dyhu127eeIkUv6CzsfIRmXH6r9RFboAEMUPO2pioqT/iy+0aPFN7
         0dscbzYdwQ6ziFkSrtFsibQzHyLyLZVe61MIY4etZ1Ck3m2jypZaqDBbUhMjfk6OT9D5
         WS2M496qZe7gT2DstUhSZYXmYuRtSP4jQI9iMEG6MLqeJnI1VmXiS66WfQ5kOgpERc9k
         hE/11whveL+zopCD3EjhfFe74h/fYzdEzRtXLk8GppLR32QMeIgV61mae5TKMq7Mk38C
         fIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=qDSIqfen+i5z1iQwQLRSHuCDe8fnVaAMW6J4fK8zz7s=;
        b=f6AXD2+BxEn0Rbw6zV/YFgbzv4MZmKlOKw+jsVxSTZOpo8OnLrDrIa6Nx6T7jgFOso
         AyzL8EA8ysc6Eng0X5IsQjpMkr5I1PalhsaF1wl1sK9JUmHGI4v4ltUUnZVOOKrFJlOR
         sXUAQivVX1PW4a1kb9e6+ryhd34GpDQjqP+h7X5RdTu3ci+NlCaudhf+KaYz0x7adSCt
         MXcb3JjRPcQnphNuySFXz0DOAUlSzxE0R158R3c69yMO3ry9dF6a8G/U3e7krIcO54Qm
         mzdXGMtxtK0DvIEUxmzcH/s7gJqadfCf6vWR9Xwc6FD3SIjezdPh6bEFllhS3orpenJV
         Ix3w==
X-Gm-Message-State: ACgBeo0V7jdq/PXIineqUEpgYj6ZKsHpXISKnp0dDn4xHj2zM+7CIzsF
        z40sWWuB5Y1dwWd5AHF301DDvGmBBdGw1A==
X-Google-Smtp-Source: AA6agR7vNGMEcBTNLX45Iiv/qSXyMPrPalJM2UUq7PCnRXzalNltnF/OiuEqb/KP6gR8vEjsESq3ZA==
X-Received: by 2002:a05:620a:1928:b0:6bb:83e3:3249 with SMTP id bj40-20020a05620a192800b006bb83e33249mr937094qkb.245.1660669461807;
        Tue, 16 Aug 2022 10:04:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.185.19.16])
        by smtp.gmail.com with ESMTPSA id m6-20020a05620a24c600b006b60d5a7205sm13005464qkn.51.2022.08.16.10.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:04:21 -0700 (PDT)
Message-ID: <62fbce15.050a0220.19ee9.c5b9@mx.google.com>
Date:   Tue, 16 Aug 2022 10:04:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1737964323443080301=="
MIME-Version: 1.0
Subject: RE: [v3] Bluetooth: Move hci_abort_conn to hci_conn.c
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
In-Reply-To: <20220816164120.1002822-1-brian.gix@intel.com>
References: <20220816164120.1002822-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1737964323443080301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: net/bluetooth/hci_request.c:909
error: net/bluetooth/hci_request.c: patch does not apply
error: patch failed: net/bluetooth/hci_request.h:73
error: net/bluetooth/hci_request.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1737964323443080301==--
