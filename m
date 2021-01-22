Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E972C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 22:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FEAE23B16
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 22:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbhAVWC1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jan 2021 17:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730801AbhAVWCH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jan 2021 17:02:07 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8457BC06174A
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jan 2021 14:01:26 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id x71so7663663oia.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jan 2021 14:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Q8/yrf1DqzLg0M+qYgfGcFxuIbXKaKiQrmX89gLPtf0=;
        b=e9MewOtyKTK77+Fi9F7JFGe0w8oGusg1shwTVCgZxCcsTX9ERp7SyKPkvLqKpUc3HK
         KXC5mkysW1LhKMJVuiXIcBo3kA9UEH4NeSoVITmYAfK/exm7xxqRIok8LNPA6rN49NmI
         DQZU+sMo4D4LlC+75J7n9DBpPqcakrCyQeYa2wXpBpJEWDUOeWVCa/o2jHO0R8Rm/slL
         sZhdHz6UbdLyGjaCA5v8XeZ3P4jtokbqSr3rBS9hcW86WPIZKd3P9O8gO3W5ebq85X3N
         XzEwigJwO+l/xtvvYPoV+O4AvS12DQQA6cUiLguoo3jpVot895nA7njDpc92mF3hYZ8I
         LdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Q8/yrf1DqzLg0M+qYgfGcFxuIbXKaKiQrmX89gLPtf0=;
        b=MbBS6B76aI8QGHLOz6u4F2v2niPEaPfZ5RmcHQySvTSIiQB96sUW+cd12+w0juutCc
         zJS2eLRH15ukcsZ5XI1+ObFkBYKFEo7vfh8nnzpJAFa4DvnGLtaoCLqZcbHkZmgv6601
         f2womtmBgCNqcMHntv7tXQ9+xOL6xyeJHX200VRS+bnOkO5o+CKzGSq8Q0kwtyIMm/L6
         cYLiFpzQUoCfLYH7fLiNc/LpS5/SzKfHKGdG+QWd8Xkn//wld50PuYLUoBuAhFqK712D
         ZT1wGMDLjXDtVYqL/HUEMP9g9nG3/gk+HFT7VgCBQT/DWD7CWmehGBs4/Ie5xxcA9aVm
         89qQ==
X-Gm-Message-State: AOAM532MsnjDXnBJdcUG5ImyvDi3JzvJ3GIrciiMqQ/7vt2c98dp+Bmc
        fdZ9BDowLEBWY0Pofi7c5A1XH1XR0lO6Db0RnNjiiM2gEi0=
X-Google-Smtp-Source: ABdhPJyP6rv64Em1vcwsqZuO71leD1R0qgEB4nzvQCqtocu743pxVb5qoV9VLG8m66ZxPbSg7OlcHHB5525INR6NaqU=
X-Received: by 2002:aca:fd0d:: with SMTP id b13mr4675431oii.64.1611352885749;
 Fri, 22 Jan 2021 14:01:25 -0800 (PST)
MIME-Version: 1.0
References: <20210121010955.1193543-1-luiz.dentz@gmail.com> <6008e007.1c69fb81.8873e.1167@mx.google.com>
In-Reply-To: <6008e007.1c69fb81.8873e.1167@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 22 Jan 2021 14:01:14 -0800
Message-ID: <CABBYNZKOGZfTM4tLj9JtgGnKtwM1sYquG4ETw_2n8NrC0y2qYg@mail.gmail.com>
Subject: Re: [BlueZ] a2dp: Handle remote SEP disappearing
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Jan 20, 2021 at 5:59 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=418663
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

Pushed.

-- 
Luiz Augusto von Dentz
