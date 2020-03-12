Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC57C4CECE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 22:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935352072F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 22:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqEpjg7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgCLWg4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:36:56 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40822 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgCLWgz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 18:36:55 -0400
Received: by mail-ot1-f67.google.com with SMTP id h17so8075115otn.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2020 15:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wnG1HQNVrKL/+M1dFy+AqrmXgyM+DRXJqQIRRgUEO+c=;
        b=BqEpjg7OeoeOzeBxQ7jBrjEPOEhCWaW2GdPhFm0sevsXFHC+5v7DOml61aBHddVVGx
         X0TxWbq2QVuV/TvTOGgjPSSScgmKxYGLNmp9uJz/WZVjWEWuFwfR23HolPP3sFMBAZrM
         1ozeHisDI8N164wIFQpZWU1tXA72splqQTWeuu76JcVk6thDjsMfaP9XGgJsuOQY5/Se
         kntjXMKKiMw4WLzAv0nPm65HDrb3/FigXsFH5y0njpmkIIKRmzF4VU0PmPN8JmipYHuV
         e9ELWNOyTniXKVJyRj1SuEZ9vPHwEBZa8XfoUq3saJ4H/44KAmJHXCf10dHleMKHK7rh
         0JVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wnG1HQNVrKL/+M1dFy+AqrmXgyM+DRXJqQIRRgUEO+c=;
        b=A0ovDu5bLAZGwGqJA+YriSMCFMRReWFQms3Ea13udSUn/mCTsaERJnPemMviD7NJGz
         1JLjnMVe2P4uFau/cklh2fKXD4UrMPzRvx4V0HiFQLW2yfx6o8ria7eEIAhnZiZ/FJ6d
         tCTeK/vM3H15Mm0hlNLhhxPg5YnDbE3B9ckWerKgf08CajelAp0T7lu7LAkE2zamwxUD
         sAW9Rj+9Qni+7j/bEEvNNJHviz3aWogcn2Zbtrfxxv0ZgZYsW2wk8VQQlBHKbHdC+9PB
         FMQD8ua5/BZM4xvt8A71u7TeMaUbangR9AILrdjqZxHp8b/P8vstxvilTvsINRHBTRCV
         lX5g==
X-Gm-Message-State: ANhLgQ2YtCozbKZAxj6PVZllvE993k4H+c5+E3upDD/HoPLyID29yJvX
        AJPIjE3OLgv7jhF3HZbwwx1X3dluRjzyFa9wbt4=
X-Google-Smtp-Source: ADFU+vsNNp5bwErXYHofuwLm1ffrkvpZfC2vxkqUHChwZnk3h2lDkF5SHu0ieGdGHziM+ufxDx7rMPEHeLDTY+nHzSY=
X-Received: by 2002:a9d:3f4b:: with SMTP id m69mr7793505otc.146.1584052615195;
 Thu, 12 Mar 2020 15:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200311185937.9032-1-luiz.dentz@gmail.com> <20200311185937.9032-2-luiz.dentz@gmail.com>
 <B5E587C9-4EC9-4559-856E-BDCFD27CFDC1@holtmann.org>
In-Reply-To: <B5E587C9-4EC9-4559-856E-BDCFD27CFDC1@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 12 Mar 2020 15:36:44 -0700
Message-ID: <CABBYNZK9AeP6cSWibg5zEE7AYdH_Xhur4sH+pqxeO4nW2OLuOQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] input: Add LEAudioSecurity setting to input.conf
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, Mar 12, 2020 at 12:24 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > LEAudioSecurity can be used to enable/disable automatic upgrades of
> > security for LE devices, by default it is enabled so existing devices
> > that did not require security and were not bonded will automatically
> > upgrade the security.
>
> LEAudioSecurity?

Derr, will fix it, luckly it is just in the commit message the option
is actually LEAutoSecurity.

-- 
Luiz Augusto von Dentz
