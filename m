Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97389C4363A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 17:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B3032076D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 17:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IauaBW48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgJ2RkU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgJ2RkU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 13:40:20 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59792C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 10:40:20 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 32so3107747otm.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 10:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vh8+lywdyb6RsQzdm69ce95Z/iL7ySQ6o9Tgn2b1j8A=;
        b=IauaBW48MZQqU8CpMndUVS4QQD2HsaRyUJ3VmXM1QKhNrexwgTwf8rw7GgmzoOdZJS
         s1w9fzh+ul3cUnallk0v8b4BEjrCp9VZ/MrUZUucNdpoXU98hn/JWcCpydaQFFCvNLCk
         faRJmklook9n+8Kd6NmHMNxygTC23V9/wGdWOUR2/ZqMmc/c9TrPrYYaS2awkh79vHyH
         iY29XkFOFpdGdJ5qR+ZYmazEL0p+O3ZRWhBDRuYXYX3T9HWy1gtN3GuSteh6dkbqcQQs
         07oiW5JuTRyvybaweHLZxlzSxXdaNr17zDhNxSRZjNdeBT7KFZGDGzJsTjndDY62pcpc
         pAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vh8+lywdyb6RsQzdm69ce95Z/iL7ySQ6o9Tgn2b1j8A=;
        b=YAFaImxWGpzn4dZOuQ3gwcnrZqm+xF/vffy+IbeoDgPSzogsnJT9+XS2W4ZdbOYrLO
         3c8pN25WR5NgO5HS0bAhuSgACIRe0Zn1PtEVPVNyKf2ufBdyw4dKWckO3oL4OIdXp2j/
         NKCiK6OCDi63Zew6JWg7gjBppFxqyaMuwJvz5beT7liKXhTzSJ89Fz++fn1vtDPOs7ym
         qUVKcrLaFZS3Qa+p+GTvRz1XjvuYl1cGutJkok5gxGEy5SGSJElTr2JmefEl2z+uttcm
         TtEpIM0Q7LX8NwRzU44qn5C9DVrE54fiIsNLlX9mF2w/3gn4HFd/zbNWeihGc3DrznXf
         Qc8w==
X-Gm-Message-State: AOAM533JdP9IWc5ZOgNn8TQp1N8meZ+ADHmt71q4V6HC7o08UWbJibJ3
        qdNdOEybUvB9BUB/NadaRVAHWbIRSAHWn8Dgc9aGWnEQJMk=
X-Google-Smtp-Source: ABdhPJwZNsobrM9iIG8Lh4eIyrAH9uhUbWcI89AMWQVgrqX08ik5JeKGXFHZawYxU6j6PJXctdecOUuJyOcYwlhPU8s=
X-Received: by 2002:a05:6830:400d:: with SMTP id h13mr4190395ots.371.1603993219432;
 Thu, 29 Oct 2020 10:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201029180756.BlueZ.1.I3e9cc07cf60d04d69c8045c442b6cf9f0c3292e7@changeid>
 <5f9a9bb9.1c69fb81.ed651.85c4@mx.google.com>
In-Reply-To: <5f9a9bb9.1c69fb81.ed651.85c4@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 29 Oct 2020 10:40:08 -0700
Message-ID: <CABBYNZKxNGmjB6Lid3HnQKq8+OyfGmWkZkoPy00VGSiUoJ6xQw@mail.gmail.com>
Subject: Re: [BlueZ,1/3] monitor: Decode ADV Monitor read feature command
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Yun-hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Thu, Oct 29, 2020 at 3:41 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=372967
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - PASS
>
> ##############################
> Test: CheckGitLint - PASS
>
> ##############################
> Test: CheckBuild - PASS
>
> ##############################
> Test: MakeCheck - PASS
>
>
>
> ---
> Regards,
> Linux Bluetooth
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
