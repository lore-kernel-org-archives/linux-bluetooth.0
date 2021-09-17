Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06877C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Sep 2021 20:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D669D61246
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Sep 2021 20:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhIQUeT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Sep 2021 16:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbhIQUeK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Sep 2021 16:34:10 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A084C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Sep 2021 13:32:47 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id k10so10573313vsp.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Sep 2021 13:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z00E/TCxnukR+QWVK45ZngAppITG616Dl6DNTgCNqa8=;
        b=VARiV+5dXd54g0jY8Pr5wjrL2AqBOabIKMRrCx//xUTktzJPt9XzMyv/Wya5hd27pK
         zITXz6v2kvw4oHnnA1vGP6OO2Yf+HZxQ0gSWA50A4dch0DpKl3j4J5WZkRdAMuFoXDvl
         6z2ErWRGxsQZhd3eqlTBy51BLVY3iwl71xwbJHuLqtag/F1mJdE8ljfffDZLPoWIVn7l
         xFVcXwNcI6w9Co4Xvu/AT1wb7nkOqd5+UdvQW3rLVaCtYWrIxvURLEkVXXVFUayjIhM/
         0NahRLPkBnY4tZ+sSIJxwYGjgxo8S5im9v301LERPMIG4l03hJKIzKMASYob0gC1r2MC
         ep+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z00E/TCxnukR+QWVK45ZngAppITG616Dl6DNTgCNqa8=;
        b=Mk+VlZJzYQwNQ7OanRR3fj2mMhlhcB8kb4LYyH88JGx6HIOWFggxVzV4IBW01nmjHK
         zQ2Ym5r6YqdbefVBasLGd1X14QX1wn0fPKkNeMaE7GElZt5BWKrtV/fUpntzZuBb9+Ja
         WV2w7jCpi/GeB7uwtNU33kH9iBToECosj0/COU6mz0FPing/gKKLraVOu+DFKlbSbh0y
         zHs3ARiXf4kBY+sN6RWemgWMg1nPiCjoLNNoEcbGW9fIRK20DIafkaEXnH6iaFr/5zQ3
         uXWn29snraytQYMqTltxEvprtBstVUWyEYtolooaYT2wgkzOtznM2MqzkCB+taXP8X5H
         HtXg==
X-Gm-Message-State: AOAM531hh/BCgahUJyOcd7LZZye2Kq9ZDaY6oecIBR4kXAFMSCXzbLS2
        VNn1JbwYHZVnpLvZPljuq/lKkBRdl4N90mQv00poV8Hz
X-Google-Smtp-Source: ABdhPJwRN3Zs+kru1XLxcNDD42Y5xdDmP1ZYSdAgOCbvC4IsN6UxetUKqqBSeCnMotkE7Zcdh3a+kQB+ETz+lULdTeY=
X-Received: by 2002:a05:6102:22f1:: with SMTP id b17mr10575841vsh.10.1631910766457;
 Fri, 17 Sep 2021 13:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210820050705.76853-1-hj.tedd.an@gmail.com> <611f3f1f.1c69fb81.758dd.ffdf@mx.google.com>
In-Reply-To: <611f3f1f.1c69fb81.758dd.ffdf@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 17 Sep 2021 13:32:35 -0700
Message-ID: <CABBYNZJm96qpO=02gbDLOFvJD=Ofw2C4ysWk3NQ9re6yPLJd4g@mail.gmail.com>
Subject: Re: [BlueZ] tools: userchan-tester: Add test case for the closing channel
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Thu, Aug 19, 2021 at 11:00 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=534645
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.40 seconds
> GitLint                       PASS      0.12 seconds
> Prep - Setup ELL              PASS      48.16 seconds
> Build - Prep                  PASS      0.14 seconds
> Build - Configure             PASS      8.45 seconds
> Build - Make                  PASS      203.34 seconds
> Make Check                    PASS      9.51 seconds
> Make Distcheck                PASS      238.94 seconds
> Build w/ext ELL - Configure   PASS      7.95 seconds
> Build w/ext ELL - Make        PASS      190.48 seconds
>
> Details
> ##############################
> Test: CheckPatch - PASS
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
>
> ##############################
> Test: GitLint - PASS
> Desc: Run gitlint with rule in .gitlint
>
> ##############################
> Test: Prep - Setup ELL - PASS
> Desc: Clone, build, and install ELL
>
> ##############################
> Test: Build - Prep - PASS
> Desc: Prepare environment for build
>
> ##############################
> Test: Build - Configure - PASS
> Desc: Configure the BlueZ source tree
>
> ##############################
> Test: Build - Make - PASS
> Desc: Build the BlueZ source tree
>
> ##############################
> Test: Make Check - PASS
> Desc: Run 'make check'
>
> ##############################
> Test: Make Distcheck - PASS
> Desc: Run distcheck to check the distribution
>
> ##############################
> Test: Build w/ext ELL - Configure - PASS
> Desc: Configure BlueZ source with '--enable-external-ell' configuration
>
> ##############################
> Test: Build w/ext ELL - Make - PASS
> Desc: Build BlueZ source with '--enable-external-ell' configuration
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
