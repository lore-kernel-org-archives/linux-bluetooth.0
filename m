Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3D2C25B06
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Aug 2022 18:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240181AbiHNSwX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Aug 2022 14:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiHNSwW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Aug 2022 14:52:22 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44A265B4
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Aug 2022 11:52:20 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id v185so4533725ioe.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Aug 2022 11:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc;
        bh=ZHoxNEYAEeW/+IccmzBqidq+boCnvZwEl4dd7Ph+nhU=;
        b=aIX6SXE5HOiWSfnmoknyY2SvVCkm6ll8K/dZjaHLRni9htepGeQmhYJlziuhZ4irhc
         qPpxc+0yCYe3ioZoRR60Vtsnq5nwvs2ISk4eQnt0J8Dja2TNwz0gCp7inQJb9ByKnO6X
         IyStFIAViewrG9UbsWkmNyGAT1fVb8qVrZU7UkHo/YOQPDKVOHMV74ylmy+DiA3EoALo
         a6Q9NmzpyVYURt6fwYZmKx6Uc/n5SzPhsnTvUV4ljSJQz0anhKH165hhalXf0RSNnDVR
         Q7vvnzlkjiKB5+cRINDbASrvcdhhXQl0LVRNcTw9frUxqTTCVBwDL4rswCuevrGkFwm1
         3kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=ZHoxNEYAEeW/+IccmzBqidq+boCnvZwEl4dd7Ph+nhU=;
        b=NTA5aHEz9uBdWisUrtfmpe3bPMvHuYOC8yGuFT/vBAGjqblkH/MnXxRUyK1Z6/mXY0
         /+pxQmi82KZ3tLkmjYP39lyEDoj7gOXk0p1NQwOwUncYiDBPrpXOB7KAowdDrRjj8dEN
         pgO9hZ6MtHNu3YMgDer48pvd0T4f/rLrTulVdbL5lWvOKSrEC/FxOyTvZ7LT/p1zYjGq
         FMg9aavl5myUPRf4q7dSTReEDTAUVmVFxffPMBIqKNpe+rSsb8CW42jr7Er6ELso5lIa
         Dv7ANCSgGBiYJ6XL+hQKxCMkmTTJJfd89vmxseNjAM4uGw01g4w75OK9ItyHaOY7NLQW
         GqiQ==
X-Gm-Message-State: ACgBeo2XUD4+YHXsxxs11Pavd6dkFi8k/iSA6PcQZkwnvxDbbYdEHCjM
        xDzql2DXGmP9jrzvs+OOeWmfjbgGPmI=
X-Google-Smtp-Source: AA6agR4/4nxchzz1cMLiHV/HoBPO25W7GuYnqGF78yQJWZJV0z+2DELOpIGQZYSsoWbDpovxvTJGxQ==
X-Received: by 2002:a05:6638:24d1:b0:343:25c0:a2d with SMTP id y17-20020a05663824d100b0034325c00a2dmr6057470jat.76.1660503138721;
        Sun, 14 Aug 2022 11:52:18 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.59.240])
        by smtp.gmail.com with ESMTPSA id r10-20020a056e0219ca00b002ddee24695dsm3114449ill.48.2022.08.14.11.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 11:52:18 -0700 (PDT)
Message-ID: <62f94462.050a0220.f4292.2c70@mx.google.com>
Date:   Sun, 14 Aug 2022 11:52:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2385590725455667707=="
MIME-Version: 1.0
Subject: RE: Bluetooth: btusb: Add BT devices 0bda:4853 and 0bda:887b from RTW8852BE to tables
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, Larry.Finger@lwfinger.net
In-Reply-To: <20220814180713.27069-1-Larry.Finger@lwfinger.net>
References: <20220814180713.27069-1-Larry.Finger@lwfinger.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2385590725455667707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: drivers/bluetooth/btusb.c:427
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2385590725455667707==--
