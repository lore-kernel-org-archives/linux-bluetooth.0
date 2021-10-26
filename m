Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406B1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 20:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2131160F24
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 20:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbhJZU3l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Oct 2021 16:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239166AbhJZU3h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Oct 2021 16:29:37 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E13CC061570
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 13:27:13 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id f24so656725uav.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 13:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=g7XZ86tDuSqFvSsE/P2ur16H/C9y8ieOv54tQFJ9jYY=;
        b=lCmDsLVFihY5jco6Lv7iez7LNUz03yDK4i5Nr3U5Lp9N+wmQ3665GPPv3J73N4dK8I
         iCv0V52MkPipGSkUhcuIJsyYJC9wSIM2by6xwZ0W1bC41yyRyAQFt9NsYWNlHVHbvZDQ
         gT45YIV2TXWsyzAZwLqhBOhJXt1t8ltAUpENPsdYE3plSFDEm4Z11HpU/7w8l7IyV8s+
         eAmrpR41Pc63g9KEXxvFCjTyynVV4FxhNMvJLu5WC+AIzvnjsQabl+owIoYknRBM3G0c
         D7MZYTzM7lsS5lxzMJsynPHOqaVSJsxUxn78FvNa4ILvnzjG4AmPXse7mng4kxI1ya2b
         pMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=g7XZ86tDuSqFvSsE/P2ur16H/C9y8ieOv54tQFJ9jYY=;
        b=Zk/H2UfyJy6DIW03X4mvM/QR2iON1CZoeREbBAg7u2zbvjTwhDxT9DMkEj1ZswU8Da
         WJUx/yrDUy1cSf3AG+DiFoFWDaLFW08IFJ92pWU5Wt5B8dsBMOPP+0XH0F9vzfP7sQru
         ceMHSlZAgcYbSMneJBIZq1AJBm0LHDCZ3xpKRxpBCFenILNIMJzAX2XqiKFYX+wZgasa
         TbWL58nKMUyZlqOklhKkueuISqO1XWVTg62Bhjz90XgmYUNw3NKi7v9o9DENJQhFq4mq
         Sjj4QAVkeSxY3UU0YbfBf25SezuCsfzuRXGkpARybqAABMMCH4ROoDCGFqj+1gqhBb3u
         PnsA==
X-Gm-Message-State: AOAM533M8X8ajQhLQpzSMymqTn3suHHZ/Kf0Bm7H4aYV49cmq3FrMzy5
        7nx+vrXSa9/zOFUPH4+ER6AIsycG4wUqVEVc/ooCPNfn
X-Google-Smtp-Source: ABdhPJzY8cThYp5aNDBlbW7R9AubvYFh8LQDjXfh4nLOcGSJBqQI+AuDZTzJXj6+0gKNWOmxIRu6WQXwne3kShgSwLE=
X-Received: by 2002:ab0:2b13:: with SMTP id e19mr25558457uar.3.1635280032086;
 Tue, 26 Oct 2021 13:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211026181815.1305602-1-luiz.dentz@gmail.com> <61784bf3.1c69fb81.18660.8cd6@mx.google.com>
In-Reply-To: <61784bf3.1c69fb81.18660.8cd6@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 26 Oct 2021 13:27:01 -0700
Message-ID: <CABBYNZJ7zzTUmRN5Ksshfbj16p9za0eEGLvFGFSV2w4LEMYn-A@mail.gmail.com>
Subject: Re: [BlueZ,1/2] Makefile: Fix code style
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Oct 26, 2021 at 11:41 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=570633
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      2.98 seconds
> GitLint                       PASS      1.96 seconds
> Prep - Setup ELL              PASS      52.53 seconds
> Build - Prep                  PASS      0.53 seconds
> Build - Configure             PASS      9.97 seconds
> Build - Make                  PASS      216.18 seconds
> Make Check                    PASS      9.08 seconds
> Make Distcheck                PASS      243.89 seconds
> Build w/ext ELL - Configure   PASS      9.39 seconds
> Build w/ext ELL - Make        PASS      184.54 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed.


-- 
Luiz Augusto von Dentz
