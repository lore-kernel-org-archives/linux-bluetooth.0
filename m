Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B333C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 22:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F243C206BE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 22:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTdED95y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgKIWTw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Nov 2020 17:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIWTw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Nov 2020 17:19:52 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0B0C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2020 14:19:52 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id m143so11993370oig.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2020 14:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=et7vVRI2NODZQWRqH8uiP/1JtLcVaSBISF8eM7oUvag=;
        b=sTdED95y50vwz/L8AuUaIG6dJSEmjNYiPkVyx3PN16PkcIuLpXxECfJbpZE9uqty7O
         FoQXCq9r7uFE35No6VtQXZQVBGby2bkY3RCvlxTIhWEyEhHy1WY7yah5DI/i0y2t8tcF
         L0HGYymMV6x9ZTxS0y1OEoItWPQe7gTF1hSePqARe/MnMuFtDwxaehJeB4fe3AH/Rme5
         KvbTMZ5lO0P26X4oGtSe6laPbMvUtZJOvUC3CFEjvcrHps06TCIpgKNxiL2bA4zWIFN4
         Dv4B7pbKfRlKG0eeyXEfcX45cEH9ppJ/zLTt5mFwOpcKzTo86xeSHZP5uJhs/OizCmn5
         uT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=et7vVRI2NODZQWRqH8uiP/1JtLcVaSBISF8eM7oUvag=;
        b=WwLBXMEJsjKwrHK2mgbVy3E/Jx8e90Ut4tSHe9bYK6+85ldGXEFFH1IySHHn2aWtUF
         EiqTHMPtDlrXJxqQhB2/5FLcRaROwYDaSjKr6U9YKDin4vi43bD8gh4T6IDwGU70lZY2
         HuL3JO1CB2RCGoqOx/Zz18yeT51cYlkxz/W6xHdmJZ842+jGfewKJpMbldq8c2cl3I9v
         btM4pQ25Wr7fHkcLfRJt1QqWh12zni+pXFa5YLVmbrJBMS3p6pNa9Ljbs9A2vmv+ehz4
         ryRuNci/6SbuUV5snyX8Xv311hcHw3Ybextn1OFu+OVkgQnqG47MQ2m4HhKehOfFy81X
         pfTQ==
X-Gm-Message-State: AOAM532HY9s0XFdSG2JvLya1ydIqj4jlWvb//UzEmrnXdvFVdINPYljx
        XNALTvRW14vwk6FXdkZ21OBoMSYAXedxwxsGrZqrnBJpnmc=
X-Google-Smtp-Source: ABdhPJzEyualchbQw+hhAyomeOLEDMiXXItClB2FT0OKb2QCRF/V+DjgTxNOnviKhFgoeHSIb/drm81ERTUyw6YPGu4=
X-Received: by 2002:aca:c70b:: with SMTP id x11mr933603oif.58.1604960390992;
 Mon, 09 Nov 2020 14:19:50 -0800 (PST)
MIME-Version: 1.0
References: <20201109105114.27827-1-bluez@heine.tech> <5fa926ec.1c69fb81.134d8.4ef1@mx.google.com>
In-Reply-To: <5fa926ec.1c69fb81.134d8.4ef1@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 9 Nov 2020 14:19:40 -0800
Message-ID: <CABBYNZKccgod_kLaUVx_zsCMYC+6P9CO5hjOx94KnkmLhdo01w@mail.gmail.com>
Subject: Re: doc/adapter-api: Add InProgess error to StartDiscovery
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     bluez@heine.tech
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Michael,

On Mon, Nov 9, 2020 at 3:28 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=380245
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

Applied, thanks.

-- 
Luiz Augusto von Dentz
