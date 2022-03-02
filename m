Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382DEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 23:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiCBXuV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 18:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiCBXuU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 18:50:20 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D0FD04B1
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 15:49:30 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id g1so6781019ybe.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Mar 2022 15:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=rApAQflFgIl6bduPt1rO2/geSPsmKiokzWx57N0toNo=;
        b=UXf4B/iYRUq0GVYZTePTPAnpnK79JLXSiIWGSTmFv46SvhXTLIN0PNwbc/47KL1ncF
         SRDxcjacNzvft3uH3+731zuaC4MtGRmetcdHhL7UqkzCPu3bqTAZZXVbc4I9YnxKL57c
         AqUqIXYdaA2XhtTaohtwyP3ZsJuayTq/UdKR1oXbHff+B63dP7u77qxFaU2wKPFiw1bs
         sX5OP5RzdUT7zaARZmLOVdTOlgZpWsJYzC3TFAwmg7mL5u5Uk0krfQTTdEvkdtxvCpEA
         F1Uovp6hRubfASMHGZMeaNXmu+Wc21cUp3tQq66KBzjeUuMrERLeCyfEQD65cWj05akg
         +ZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=rApAQflFgIl6bduPt1rO2/geSPsmKiokzWx57N0toNo=;
        b=MqKYg3nEP0T/Cysqu+swNrT4gF6GCV2eayibJXH8dhMMWZnthz8bHTnUomIJqJ/iGO
         p+FL+1HF547GMORWXuICrJox/pFyvMjNpXf2EKUsLg+QemR1Bwl7lbKkn8KIV60SUGY2
         sWpcRmhVUW3k9iYMTvi3b6ZYTfI7rkTo0C17gUq+2msEZ1w6hCu5xPg4xjmAoWzRquxs
         ctWNa0+srSC+l92Tyu75DzdYUoL4TOfgpnudNdcqF2SzrsiNRXda7KGpFa76VgUV/UUj
         8i9RDjG4WjPBBDndWMj0+YnHHROyZWvuEtuJ3ApekyE4yiuHbHnM9O0cOKg4pfBGo5mW
         Dhsw==
X-Gm-Message-State: AOAM530FNs49iF/b6OIruYy2vrEodIwKayx8RRRnipsS5F7hdMsUP8c4
        Fsn3lWcLF7KXf/K36HfWIG0l028P+NCLntXFp/2lshHS
X-Google-Smtp-Source: ABdhPJxHHL5UhlHQYTuhMbDXfO4iajM4aBoMgXtNP8sicaX9ocxPwMgutTfshNI1PcIPPp3crR9bf15NxV5z75oSHjo=
X-Received: by 2002:a81:846:0:b0:2db:f920:5c62 with SMTP id
 67-20020a810846000000b002dbf9205c62mr8787095ywi.489.1646263322794; Wed, 02
 Mar 2022 15:22:02 -0800 (PST)
MIME-Version: 1.0
References: <20220225215505.560382-1-luiz.dentz@gmail.com> <6219e3ed.1c69fb81.5fe35.3180@mx.google.com>
In-Reply-To: <6219e3ed.1c69fb81.5fe35.3180@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 2 Mar 2022 15:21:52 -0800
Message-ID: <CABBYNZJhzOBVWyBVi=Gra0ioc7CDFAUjNVT5068=Z=3rRE3=hg@mail.gmail.com>
Subject: Re: [BlueZ] btproxy: Attempt to bind the next index
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Sat, Feb 26, 2022 at 12:25 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=618201
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.54 seconds
> GitLint                       PASS      1.12 seconds
> Prep - Setup ELL              PASS      49.94 seconds
> Build - Prep                  PASS      0.81 seconds
> Build - Configure             PASS      10.22 seconds
> Build - Make                  PASS      1453.81 seconds
> Make Check                    PASS      12.85 seconds
> Make Check w/Valgrind         PASS      516.33 seconds
> Make Distcheck                PASS      271.07 seconds
> Build w/ext ELL - Configure   PASS      10.39 seconds
> Build w/ext ELL - Make        PASS      1434.14 seconds
> Incremental Build with patchesPASS      0.00 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth
>

Pushed
-- 
Luiz Augusto von Dentz
