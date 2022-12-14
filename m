Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3DCC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Dec 2022 22:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiLNWVt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Dec 2022 17:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiLNWVY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Dec 2022 17:21:24 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC0725DB
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Dec 2022 14:21:15 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id p8so12774136lfu.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Dec 2022 14:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bdz6wjXt02MyxMXIJ1tcha/KdK6cRH5Ee0ZI/czPse0=;
        b=lv8hA2CrMZF9tgrEh8VEjv+um2GPvLYMyqhX/aFv10eYmP0R5u6ZVrtq/zbxh65UGA
         4iYvPgwvZCUoJvqkhepdx4GEI6JCPj9tbP788cMncbTLx4D7ZrvsOJ581eE6fLG6C1wv
         FtbdQ8T1f5imLUBomxZb7pbK3RvxyOoGL0X+vnXS1Rte2lfCIJNZUYw2Cz9N4s4rGP4n
         OFPV5hVRwxuaZwAUAcJA6DBPtWKVyKcujb9vNywBE5/AgPkv5JgKqb+euUgdUAM+/D4k
         Jju7Gbi/tLdKxIrLJY2svVyuUGgL8zlPbsjTWPa1rxC27Sozjy42Eht65WGZMoRoXjii
         pvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bdz6wjXt02MyxMXIJ1tcha/KdK6cRH5Ee0ZI/czPse0=;
        b=oD166kUkdfsyhNXM3k7ldLiuXNdcdgEQzWs1yFON/WZCXrkofdshZj/dp959CkTEIj
         8BrOl9iFChQTzi8oJ2PSHoRw6AX6UmQc6nHlazZk/ihFH6YHbHTsO4YYMTVzJeDklwdS
         9i5i2R3+lKQS1HbRkXt5goCKIRdWfAFpaf6CqYw3n3cCDAhCrV8QMGsLorAhYCYTE3sD
         3lsB+0J4RamtGVkH91TB83jq0fSLQvGIhbk5gpnK5i/OqBWtFM0t6cRCpRF7GWDHTC8b
         x8v5KpJffOZNGHp1ZjJLDuu5Qed9YpRLVZtF0FCTVOv26xU/BrpkcNb5i+VXgk2iVDds
         uKhA==
X-Gm-Message-State: ANoB5pkuBIyH2jPnpCSFsTcQphBPU8oWOt1rgAsJWTIADoaE5i/zwYXR
        kNN/RI+zhdRabrj169wd0GLXT9QsyViKKFWqVmn70D8O8GFznw==
X-Google-Smtp-Source: AA0mqf79WCQEnp/C+MXVVir8QBEXs9xrHBIeg1SEgBKraGruS0ZvhmfSV9bXd+84Ch9dGdYgCzNw6sg07guK5bMfvB4=
X-Received: by 2002:ac2:4e07:0:b0:4a2:2a60:ecf5 with SMTP id
 e7-20020ac24e07000000b004a22a60ecf5mr35436840lfr.57.1671056473196; Wed, 14
 Dec 2022 14:21:13 -0800 (PST)
MIME-Version: 1.0
References: <1670931569-3566-1-git-send-email-neeraj.sanjaykale@nxp.com> <63986eb6.020a0220.8e135.1573@mx.google.com>
In-Reply-To: <63986eb6.020a0220.8e135.1573@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 14 Dec 2022 14:21:01 -0800
Message-ID: <CABBYNZJH5o41vh2ktpzgPL2RoNkfk4bNGV5Pf2_3CD-E=GMYNQ@mail.gmail.com>
Subject: Re: [v4,1/2] Bluetooth: Add hci_nxp to hci_uart module to support NXP
 BT chipsets
To:     linux-bluetooth@vger.kernel.org
Cc:     neeraj.sanjaykale@nxp.com, Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Tue, Dec 13, 2022 at 4:36 AM <bluez.test.bot@gmail.com> wrote:
>
> This is an automated email and please do not reply to this email.
>
> Dear Submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.
>
> ----- Output -----
>
> error: tools/btattach.c: does not exist in index
> error: tools/hciattach.h: does not exist in index
> hint: Use 'git am --show-current-patch' to see the failed patch
>
> Please resolve the issue and submit the patches again.

Weird, looks like our CI is detecting this as userspace patch?

-- 
Luiz Augusto von Dentz
