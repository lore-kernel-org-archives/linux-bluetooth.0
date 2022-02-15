Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ACEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 15:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240714AbiBOPow (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 10:44:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240970AbiBOPoj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 10:44:39 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FDAEBBB8
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 07:38:54 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id l125so24118404ybl.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 07:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=QzwgD6zicErGab0dqYGEaGnGucmO3vrlCY6XT/06Z8g=;
        b=vxulHR0VNVsFzAzrNPe1QgdVPS6ZTDog05kep6rpLAWbV+WDexl0Gkrq3/6uWsDYbK
         JFm+KtLRahBlOJ7j16J5swGT1UR80F3V19UYbDDKBTh63vOhU3NHINf/qhsV3d/Mvbfc
         eCfYZFxGYiYZ7asu6L1A8vZauyqnWNXW8H56cmpwU44XlPLsjh2KC5tSjCEWJHoJeOpR
         Q9x1pa3U+Nvj1uLFTlT1KK5MNJoXhAX8P4OIRD0pN/xIMqCpoIch+f6lfGZVz4JUQebT
         SsVrvG0pKmmyDrha4+P0bJ6JePJ2g6r/svxPI+5QuswNbu8QCh9i9ThMD5iCh/q9uuVu
         3brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=QzwgD6zicErGab0dqYGEaGnGucmO3vrlCY6XT/06Z8g=;
        b=ZGgGLiXlBgWCd7aI7fIDYQDyiCIBg5pbspHNr32BwleSMpXqFVgiut5OCi3dhZ2jvK
         rOPgMl1OWmOlL8DMAW97RztBjZfWSj7E78/gX6UhoOH6AZ3D9bQayLyTaiw4nnlNQWn9
         rf8PB0ZTN4HWsjswGWRB2etXzn4QIXOYJo8xdYifoBtAqfVr/9J73xawyIbevEmhmW54
         V1iybFhMJcn0TBuOtzpYyU9tbh+3fIWRKq++w0qQwoCjWjo0DIzqzsItiTqOT88YyMYU
         aot4UQ1BDPSAY+ZYG9xS475AkuoZLDsjLgnHzeFHbKgtiw/MQ9O1Ryzm8utsTbeC7T6x
         FtVQ==
X-Gm-Message-State: AOAM530azu+Pr1BDcZk/okdspcDC2aA+kS4LDoFXCGjI+X8YMQaf2VZZ
        SvalZ1C94034OY6jIsGlv/2DiAQIOr7Qe1rCRJUhsiy8psa3EPJ6
X-Google-Smtp-Source: ABdhPJzYOZC+oIcdesu3wA1xJtCnft3+Ai2RiOcIrIRIUhz0aVhrnInKuFzpCgJe7EpGD6ryoAoqA7qx/gP82LBbWYA=
X-Received: by 2002:a81:2ed6:: with SMTP id u205mr4149034ywu.23.1644939533194;
 Tue, 15 Feb 2022 07:38:53 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
 <CAJCQCtTdiPNkV1_b478_LkG11TMOPEdDGHTjf5LfZJpwWrK+bg@mail.gmail.com>
In-Reply-To: <CAJCQCtTdiPNkV1_b478_LkG11TMOPEdDGHTjf5LfZJpwWrK+bg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 15 Feb 2022 08:38:37 -0700
Message-ID: <CAJCQCtTNk25u6sm_Xqt8qzf7mM5kmOrnXyD6pT1GKJ5z5-Kqbw@mail.gmail.com>
Subject: Re: bug kernel 5.17, qualcom and intel adapters, unable to reliably
 connect to bluetooth devices
To:     Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Feb 15, 2022 at 8:29 AM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Thu, Feb 10, 2022 at 6:44 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> > Case 2:
> >
> > Bus 001 Device 005: ID 8087:0aaa Intel Corp. Bluetooth 9460/9560
> > Jefferson Peak (JfP)
>
> Comparing 5.16.9 (working) and 5.17.0-rc7 (non-working) on this
> Thinkpad X1 Carbon, I'm seeing two notable differences:
>
> Multiple messages like this:
> [   15.731405] kernel: Bluetooth: hci0: unexpected event 0xff length: 5 > 0


This matches with a complaint I found here
https://lore.kernel.org/linux-bluetooth/20220125144639.2226-1-mike@fireburn.co.uk/
about this patch
https://lore.kernel.org/linux-bluetooth/20211201000215.1134831-13-luiz.dentz@gmail.com/



-- 
Chris Murphy
