Return-Path: <SRS0=Gf0L=6V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938B4C38A2A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 20:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 645F8208CA
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 20:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJNsPU1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEGUaN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 May 2020 16:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726514AbgEGUaM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 May 2020 16:30:12 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F83C05BD43
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2020 13:30:12 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id z25so5573321otq.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2020 13:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kM0ddBaHNuFIW5z7xPpkMgsIUt5fVKtR5hyQ0tZZReU=;
        b=mJNsPU1kIIQ/A5qkU6SmNNCMj1/Ne26qHsLkMlG63nJR/lXTElLhgISVEibMXKpg1a
         222v/gq/t9LArZJVFsEKw47X3WTuW8vv2ngPte742QkxyiLVTznZioqaN6SWXZfQJJYx
         2GJPRUnU9d0uzkj6TyBhhmcbpxqJhAvvuIsuEQ0vn/2qbiE1+3gW1WvWU6wDm3eQJGr4
         ZFnbad8Sd+/ulEbjentmQ/t0fAa6njOr1Gb0ZWA2NCpwnzTvju/X6LRx75D6hb3ILVVy
         /LaVGjmyWKGQpN8SobjZk5kC8PjproKrWIO6wbaic5gaNHREzzBKJ64IcGuJ7e7RavAl
         jwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kM0ddBaHNuFIW5z7xPpkMgsIUt5fVKtR5hyQ0tZZReU=;
        b=QsSuxbK07JuyFgAZXwofFg45ENCBI2BUsbntINrvpDTEZivAcI22ECxA0KUOjqrh0b
         m0TFl+3iPLi12TRKEQCV4NAX28LetCSFVls3/lX+T2owyxjvouTw9jjBrWsq4Xps5cBY
         IRYI8b/Xp/xptIQ+0TnbNogvyPQFDvRcFOPD/tiJw918Pz2g6jT+N3QqrywXX0ZgPTDp
         iS0bVF3PnLpy2OKwfVv6ehROYFit1eNq03kun8TcW+me+61Dfu1oU36mrVMUWEuTD1OA
         p3sPOONA/LhJp4+G5rW5I+ldaipAKvRCKWGkWWzUmH56fblK9yF31pOGz3BnIWTIavqU
         kKnA==
X-Gm-Message-State: AGi0PuaCIJaEuj8IZXTs99dQ0NAMv1T+MCul8Zsy4MdvU6uLEX6ivfKb
        7O3unuy/ND5gMf48yjccxIEHZwBhYm/etKFsFpI=
X-Google-Smtp-Source: APiQypLcb1VI96Oa+vdwsMeoxnCfo6aXq1RycLpKh+PQpvdqeW3dLgpMqm2Dr6Mj2gSy8dKKXSaO1JGaPIY+VoYGHRI=
X-Received: by 2002:a9d:3637:: with SMTP id w52mr10616514otb.177.1588883411799;
 Thu, 07 May 2020 13:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <7c4e6f59-d2ef-36c0-46df-0195fad40e7e@gmail.com> <76911d0f-dd24-5536-586a-a8e9bc7ad786@gmail.com>
In-Reply-To: <76911d0f-dd24-5536-586a-a8e9bc7ad786@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 7 May 2020 13:29:59 -0700
Message-ID: <CABBYNZKr3r-6cXGAS3w6SR2-fw2h9gHqvnH=H7O6MSxnandUcg@mail.gmail.com>
Subject: Re: avrcp: Cannot connect Sennheiser Momentum True Wireless 2
To:     Andrey Semashev <andrey.semashev@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andrey,

On Wed, May 6, 2020 at 10:32 AM Andrey Semashev
<andrey.semashev@gmail.com> wrote:
>
> On 2020-05-06 19:56, Andrey Semashev wrote:
> > Hello!
> >
> > I have a problem connecting Sennheiser Momentum True Wireless 2
> > headphones over Bluetooth. The headphones say "Connected" and then
> > reboot immediately after. After reboot the headphones say "Power on" and
> > try connecting again, and fail the same way, and so on.
> >
> >  From the Bluetooth packet dump it looks like the problem happens after
> > bluetoothd sends AVRCP ListPlayerApplicationSettingAttributes message to
> > the headphones. The headphones send Not Implemented response and then
> > reboot. Both in the request and the response Wireshark shows warnings
> > about encoding issues.
> >
> > I'm attaching a packet dump captured from one of the connection
> > attempts. The ListPlayerApplicationSettingAttributes message is in
> > packet 262 and the response is in packet 264.
> >
> > This is on Kubuntu 20.04. I tried bluez 5.53 from Kubuntu and revision
> > 3146b7a0785758be2d4e894d44e99d29c0db983e from git master - the behavior
> > is the same.
> >
> > I've also verified that the headphones do work on Windows 10. On that
> > system, ListPlayerApplicationSettingAttributes is not present in the
> > packet exchange. I can provide the packet dump from Windows, if needed.
> >
> > I hope this is the right place to report problems like this one. If not
> > - sorry, and please point me to the right place.
> >
> > Thank you.
>
> I'll add that I can connect the headphones if I disable AVRCP by adding
> --noplugin=avrcp to bluetoothd command line.

Weird the ListPlayerApplicationSettingAttributes should only really be
used when the remote device claims to be have target role but I doubt
the headsets would be implementing that so perhaps we are not
detecting this properly, do you have the HCI traces in btsnoop format?
You can collect that with use of btmon.

-- 
Luiz Augusto von Dentz
