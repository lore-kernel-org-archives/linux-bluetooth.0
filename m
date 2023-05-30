Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F267DC77B73
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 12:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjE3M4F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 08:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjE3Mzu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 08:55:50 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949DA11A
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 05:55:28 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-39815ce6db2so3905476b6e.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 05:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685451314; x=1688043314;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MixUHuwtVhm+I5wydznrjUFjWxWYXkx4hfdRkb0oYwE=;
        b=RpujK4q5UuXNarsQPzH2g3jJOADVysszw1SK8/4BblWOq392+wKjf8MhHlUzLAsGWU
         1MFjXQbMGrGs4eVHALyYDMFMxErFTy3TCFk/1cH5y9Ucp7Zx3JEHlKifthHvhri9l66K
         T73cv0aWewXPsDJVVtyVko/KDiL2/OH10ANKg32X5Tj7Txhoxro82OxvaGwrnW0NhM9n
         7ABdUKi9I4RKDN/Fx7kTbce6mh/Z7xbtu4zeQpc76qZNnk7Lrjo1+7ynq2xS1LWM/AjM
         7ziU5D72YGAPy4z8C7HGDoM5pD0dzsBiUwYdnMUTN6+ZiR4igeml3Cf9ZQQsp/8Sn6xu
         GHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685451314; x=1688043314;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MixUHuwtVhm+I5wydznrjUFjWxWYXkx4hfdRkb0oYwE=;
        b=B6ClObuFtpcyAJJdpM+1Ov0fx036GZEXWsYid0cvWF7k5e0CMKwozX3FGj4utZ/cBb
         H7qfwuhn8iAyZjhHC7QeK6naVqG1GtFVzz3waQvbKLrlzvVFvGTp7fJJ9XJUcBEhCMDb
         FwjPLdfNPzL1Svtu8LEtCan8/ucjTLTSH/YeSUSwUbAy4eJQkuNyItK3YBIvzUtQ27L/
         0TgUkfifVbjIfzSSrvkvaFU/kZnSOtOEx14gPM8f5Hzu4Q/F27pRHdi06oFxDUHzkfcK
         ivFRJ7n9lgIqCzgxv7I5uuFsSZ1AWx8LqmOGlUMdVrp1FS1F9bo/12+eCpOK5wsvcwFY
         AZOw==
X-Gm-Message-State: AC+VfDwnW1HvHtFA1IwMg42Ex8cr3lUCKY8ZO08i/ziWkDrW+8l9WHIc
        m0HZBLvFDHKAsyH63SAoARPhip/Wv+8=
X-Google-Smtp-Source: ACHHUZ5IEwzubOddw1o767ucIyxdK1OuoEFTvlz7iHHWgrQhVmPhpHgYvzS0p4X6koC5N/d5aA30Mg==
X-Received: by 2002:aca:e0c3:0:b0:399:ed2a:f4b5 with SMTP id x186-20020acae0c3000000b00399ed2af4b5mr5756275oig.24.1685451314248;
        Tue, 30 May 2023 05:55:14 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.174.231])
        by smtp.gmail.com with ESMTPSA id b7-20020a4aba07000000b0055516447257sm5124101oop.29.2023.05.30.05.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:55:13 -0700 (PDT)
Message-ID: <6475f231.4a0a0220.ef40e.70a4@mx.google.com>
Date:   Tue, 30 May 2023 05:55:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6988559729830396430=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dragos.panait@windriver.com
Subject: RE: Hardening against CVE-2023-2002
In-Reply-To: <20230530122629.231821-2-dragos.panait@windriver.com>
References: <20230530122629.231821-2-dragos.panait@windriver.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6988559729830396430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sock.c:987
error: net/bluetooth/hci_sock.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6988559729830396430==--
