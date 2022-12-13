Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB04C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Dec 2022 12:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbiLMMXY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Dec 2022 07:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbiLMMXV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Dec 2022 07:23:21 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CE81AA29
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Dec 2022 04:23:19 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id h17so4893710ila.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Dec 2022 04:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nnikF7CY97jlGhpkR+qFMTv5cTE0f+uIDf997FaMPjM=;
        b=K4SikM8eNtESyaxdG6wHcaxykxFCgtPuvPd0Y7PvwzYbpJRFdkBI7ApWzYRmj1DjlN
         uc9+a7JLy/E5eiGXldA862du4omuDmjL3B8s46cVnQmYFi2DRcZVahS7c1aW+FBfb5fL
         KmYb0jULYL3Scapn4gGMPZBrUmf+hywWYuFUHqPkdC/wmIiUR1lE5YXUnkRMbxAzRVb7
         rbghF4RUxuAi/AkfbUND3Im8qht+bMOM4oCImG0BU60RDzR9k52rPVJLeQMTCGntfFYF
         T+kUkjfkGyEEyyzgkHoENZJ44lXLJxEAbqi4udWzck85dTJqiwtsaM5TbiDWmRwkzOT3
         YVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnikF7CY97jlGhpkR+qFMTv5cTE0f+uIDf997FaMPjM=;
        b=de7j0xspVrTUIuXL4ypyedRoKJevq1mAx7LDrqTQmb2HB0uccgz353BW8IvIe813ZE
         v/3am6nMOix5HYF40oR7GPOqC+ZBu40cB8jyER1W02uNveFM0XwSUoq63Iwu9pRRlubQ
         yPH3tLvN+TkFrhULyvxyvP+aYtioxmuuML0GWv/p54p/UZmKLpLnb2YrPMknfDQJN6QD
         p9pvHj8Mbz1uRHn8Y0xP/Wg0LwwlC3R2gPp8zxSmHhn0dSg2xroSrUg/9tqBLQrUa1kh
         HivbR0+NUJTyYYqCq7HFFarD4PsX4ArmTymuqkVlXb9aMnNEE2Z0Bqiv/fHShLYiCGDq
         Avmw==
X-Gm-Message-State: ANoB5pn/pi48YB6ETBdicUsrEEm23JbQMv+EdXgXwRdJxIRSTOCVWQGG
        l384Mc0oJkX+bJzXxMy51mpl3JJ/rhY=
X-Google-Smtp-Source: AA0mqf5cVJSDSpGEMlhLJyAqrG6VoPmi5iRxDVSbIBPkyw0Qih5/+DmBg7+sgXoCCLEqvJG496P3RA==
X-Received: by 2002:a05:6e02:11b0:b0:304:c04a:f9fd with SMTP id 16-20020a056e0211b000b00304c04af9fdmr3095537ilj.26.1670934198982;
        Tue, 13 Dec 2022 04:23:18 -0800 (PST)
Received: from [172.17.0.2] ([20.9.60.17])
        by smtp.gmail.com with ESMTPSA id b19-20020a026f53000000b003636c5dcf29sm803677jae.176.2022.12.13.04.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 04:23:18 -0800 (PST)
Message-ID: <63986eb6.020a0220.8e135.1573@mx.google.com>
Date:   Tue, 13 Dec 2022 04:23:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6363972465263757572=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v4,1/2] Bluetooth: Add hci_nxp to hci_uart module to support NXP BT chipsets
In-Reply-To: <1670931569-3566-1-git-send-email-neeraj.sanjaykale@nxp.com>
References: <1670931569-3566-1-git-send-email-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6363972465263757572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: tools/btattach.c: does not exist in index
error: tools/hciattach.h: does not exist in index
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6363972465263757572==--
