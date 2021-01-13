Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E107C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 10:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A032337F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 10:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbhAMKfo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jan 2021 05:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbhAMKfn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jan 2021 05:35:43 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55170C061575
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 02:35:03 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id b19so533639ioa.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 02:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=FG4nBysn8WqbSZkLL/qUzl2t62J5RtTsWXl6FurgTbw=;
        b=YgxuuOSzHae37F7M46qUnlCkmXe5IKw3jC+69eKVcY0UAF8QcsrVuSXsr1KjCbrhVz
         ZVsWDCZ2E//AaYkXfCWUhL59dnwmNCvGCIxTUw/X+F+/CYENwCGTDrrW5AVPdYVFYj75
         YjK/xnqJEsZfHpFe/oNST01FrPHL5C6wbEqeKlk4y0dGBrwF84Fejl1/phUQdQhKYQwd
         ofHhsq9/bAGkuPWqbIGdyH5cfJ5pD3XnfzgSkGx6zDTV3i5pKS7kulZIlIzYXgKInBvg
         bU8H4PCZFTbfgT77IcAPRL9v4byNMN58tg+XbxvH60a3IjqAcZV6e6n/YKbU/eNSRQpa
         Crtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=FG4nBysn8WqbSZkLL/qUzl2t62J5RtTsWXl6FurgTbw=;
        b=px2MaV1vxmeLwdSxjfvk0No3Rc/27Sis1zYoYdJTkjknVpC9l1t+nZ+F3HsTLzqs8P
         cgwECiqBivuHEn/nDTrr+xSZ80hpd/vGX6UIst8QklCVw1nzUTcf5WPNi87dqEU2N4LL
         YQ1aXrw/92+bOLI9qyt58kIMrelfZTYmPAzqRkdFSNAZdHZOE9ZaDZRRxkgKNN65Xtgg
         s16m1y0CHJYCAtoTKJxWZrstJ+3hVLRPhFw9/4dd/KRlD1qpoIvmyyaacamA46kZN5ZP
         cVLZOZQ1+LAhR2LR0gddSShZo0xQ59hlz0xlsIvcZCU+hYj+cNm7+Ykg7xpZtWq6Oces
         HF2g==
X-Gm-Message-State: AOAM530J0C/PioAJMVA3gbdbRwMCDIXq5Td0voaTfR9Z09rUI0rF2SYj
        ogMENb1bt2t97WLy/+F6CWyTGAKWDD0=
X-Google-Smtp-Source: ABdhPJxfWmux2Rm/JBIEIuO9+AoId2WVXsiihlgET07GmCJKwFPJcxTe8Pwa+K+gj8Gm9sQfTvbbIQ==
X-Received: by 2002:a92:cec4:: with SMTP id z4mr1714547ilq.217.1610534102671;
        Wed, 13 Jan 2021 02:35:02 -0800 (PST)
Received: from [172.17.0.2] ([40.70.66.244])
        by smtp.gmail.com with ESMTPSA id q7sm1223393ilt.58.2021.01.13.02.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 02:35:02 -0800 (PST)
Message-ID: <5ffeccd6.1c69fb81.95495.646a@mx.google.com>
Date:   Wed, 13 Jan 2021 02:35:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2414079892430696002=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: Support advertising monitor add pattern with RSSI opcode
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210113174829.Bluez.v2.1.I90bb4b25451e7f726fc2c8771cfe642b16312ce3@changeid>
References: <20210113174829.Bluez.v2.1.I90bb4b25451e7f726fc2c8771cfe642b16312ce3@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2414079892430696002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=413705

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============2414079892430696002==--
