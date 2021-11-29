Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB071C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Nov 2021 22:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbhK2WvY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbhK2Wtv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Nov 2021 17:49:51 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4439BC0C2375
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Nov 2021 09:49:49 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id n6so35866402uak.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Nov 2021 09:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yiVmZCcDTNnFIMU1Bi+h3fHzZePmaOFaXE/NfzpQOWg=;
        b=cSCLOJnPB98eAaYA5lwT+lxK4lqGmlS7q9XRTqAAXqgL1Bv5D5Jo+uti0CGDg5b2/h
         t5nFwQto5R6s4HjBgb/rn+t8ZNBZuNubz+k564GVi9uA4ch9IM87AT+r1pE9cQW+QMrM
         3qNCwLYKjcbztmV82A/8qRh9OGh2kMEAghLG9rMo7+L5M/bMk4FK07zlRXeVQFdBBv67
         6HwCcTFF2AJ1untQVsRWXK71D2FiQ0t1bFuubrOfHYHOEXIkce918RAapAg6tZZ8Tv76
         2TvJ6509C6BkFkW9Io87j9VA3e1QFQbtSOomWAYyPT0hpWTXEMtEhRN/LicRjs+0sRFT
         JkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yiVmZCcDTNnFIMU1Bi+h3fHzZePmaOFaXE/NfzpQOWg=;
        b=5KxbzuDPKDMwKbOQ8FQ5mY3UNOMGuqZfPBfYf/2IHQk+sWJZRjG6saoSjF7B/vwTQL
         BMxChPLDIRU2uPyjEDJiSQptrc0Yz0g8BqqElLhRKjn0UEMz7Yi/69AyDLinHtKiYSxw
         E3gVNFPYD3Nws1giB5MenC9c43jF1gx3n1P2yVsNJEtip1/wG6ZQEozJ5v5KqZkmR9rz
         +Uo1Rr/bILx3RD3/8qLrE6eg28pS0HxOqxJmWEeWKX/3gFsjer4WvQLGv4su0GLtlQTY
         mmX0bkVGkrZ8wqErpGGPW1vERAs4VxB3wp/MS3fWH/5X5zUb2meigNKYBBpKrLoRCCeD
         svDQ==
X-Gm-Message-State: AOAM531xmOO7maiUgVu1/7MRY8xqNUl7imd86GGxKz9xMxjRWPc2xFmK
        gKkUoRfO4w818xZDqMyquugtX+qLJhR9cxy1PlIkr9Or
X-Google-Smtp-Source: ABdhPJyWd65e877nflF91Wp/yKIa1yWnkNWtkaqmPmFLcC4Q99IPK1SAsrCjO8uhZNQbVMMzVOygUW/Jeq4PBd8rn50=
X-Received: by 2002:a67:b103:: with SMTP id w3mr34167524vsl.84.1638208188173;
 Mon, 29 Nov 2021 09:49:48 -0800 (PST)
MIME-Version: 1.0
References: <20211125150558.Bluez.v4.1.I78857808e0b20c6e4dd934b174d3f1106fe3402d@changeid>
 <619f3d27.1c69fb81.eee49.61de@mx.google.com>
In-Reply-To: <619f3d27.1c69fb81.eee49.61de@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 29 Nov 2021 09:49:37 -0800
Message-ID: <CABBYNZJfG_xy8p3djbq=QRx9u_arxf7yovyM7PQRjXwAQG_+Ag@mail.gmail.com>
Subject: Re: [Bluez,v4,1/5] mgmt: Add NAME_REQUEST_FAILED flag for
 device_found event
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Archie Pusaka <apusaka@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Fri, Nov 26, 2021 at 4:10 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=585657
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      6.86 seconds
> GitLint                       FAIL      4.42 seconds
> Prep - Setup ELL              PASS      48.93 seconds
> Build - Prep                  PASS      0.49 seconds
> Build - Configure             PASS      9.03 seconds
> Build - Make                  PASS      215.85 seconds
> Make Check                    PASS      10.07 seconds
> Make Distcheck                PASS      264.17 seconds
> Build w/ext ELL - Configure   PASS      9.51 seconds
> Build w/ext ELL - Make        PASS      203.22 seconds
>
> Details
> ##############################
> Test: GitLint - FAIL
> Desc: Run gitlint with rule in .gitlint
> Output:
> [Bluez,v4,1/5] mgmt: Add NAME_REQUEST_FAILED flag for device_found event
> 14: B1 Line exceeds max length (121>80): "https://patchwork.kernel.org/project/bluetooth/patch/20211028191805.1.I35b7f3a496f834de6b43a32f94b6160cb1467c94@changeid/"
>
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.



--
Luiz Augusto von Dentz
