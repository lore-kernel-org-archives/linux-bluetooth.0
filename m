Return-Path: <SRS0=EGv/=VC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF38C46499
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jul 2019 07:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4C3218BA
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jul 2019 07:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXL5pa5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfGEH32 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jul 2019 03:29:28 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35171 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfGEH32 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jul 2019 03:29:28 -0400
Received: by mail-yw1-f68.google.com with SMTP id o7so1404042ywi.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jul 2019 00:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hAJyrHvDZtwVuzH3RZAjPqQlRNu6PlXAJBAkOhCsREI=;
        b=AXL5pa5r5cP8W/9U1FoxwLwzKbMklToYjsWZiNFSioVm4Dqk74eEqoo2HUjQ/q1ni3
         IPY1Y095lTwiaibV0HDnV3bv7VzsdQ5/e7Btt+ib3FWrXu7LVD8jNBOuFEbXTaMr0Pr0
         KHTSNJ3EaiCiKezQhQZnbTfzZZbf99MSkbTFijvC/XkC90LBxEXz0tGvu/0GMrTv/scq
         fetDi5bNy7db9ykKen4fWHc3k7l60Cu8oP45TQIT+ZzU4z6t41sOcv177hJKQsYpcnwT
         vXRtwx1SD2An4Ii99RTwda9HPBWyL6O4Pg2G1eAvxxzWdVoX0p4f1i1YLagJ3NxzWdzl
         wOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAJyrHvDZtwVuzH3RZAjPqQlRNu6PlXAJBAkOhCsREI=;
        b=c8fAjR/snu08E8FQX3eQfpkTLk6c/eNsV1O1WGWx3WeMUdPkYqmHe12YezRgtW7wfA
         MhcLRswj1O2EwLTId2/1ncujL9+ixt/votgFoJW0irkk0ixIuLXZdJ7JYDMC2I7CsyIQ
         YRcoaREfxxnxfvYDctLKfvzQ94L9zPniH6ruihWLhsx03/NNP9+OxbsKQr9OrHuKLa2U
         Ol0rSmfzIdry74GM4j907CwzZTcXntG24NewKNaehy76RWZWZ6td1P3s4NhauGUbwPGe
         t6jNmbrczXQRqLWrA5V4AyD35QkArZBhHbdxR9eKi1D0q8GV5IUq1m5QkjoMi7OICQ14
         hyRQ==
X-Gm-Message-State: APjAAAXzTHtDFw3ISUwdMM+y5jIxPVUsLlqWvlQxlbw40KDfkGcWcosR
        obLic97IwJr6fgKjOlogg11j1IqMT7tNbNxMwYE=
X-Google-Smtp-Source: APXvYqzTehM0xDk4zYc71Ik4uZjo0c1rlu9UKUTmiFwZQif5b9soJoxSG9KH6Cr13Mr4ytA6+yCwcP1+oHrklHSB9Z4=
X-Received: by 2002:a81:6586:: with SMTP id z128mr1206754ywb.12.1562311767825;
 Fri, 05 Jul 2019 00:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190704212644.GA13491@n14xzu>
In-Reply-To: <20190704212644.GA13491@n14xzu>
From:   Barry Byford <31baz66@gmail.com>
Date:   Fri, 5 Jul 2019 08:29:16 +0100
Message-ID: <CAAu3APaed3UXY646Vr+2WyKhFRoohDV=7=aeD6sANf9N4BJw-A@mail.gmail.com>
Subject: Re: Missing manual? - GAP Central connecting to multiple peripherals.
To:     John Whitmore <arigead@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello John,

There are various Python examples available in the tree under the test
directory:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test

There are a number of Python libraries that have been implemented to
help with what you are looking to do.
There is a list of some of them at:
https://github.com/ukBaz/python-bluezero/wiki

I hope that helps.

Regards,
Barry

On Thu, 4 Jul 2019 at 22:32, John Whitmore <arigead@gmail.com> wrote:
>
> BLE at the wrong end of a learning curve and trying to piece things together.
>
> Perhaps I could just give a rough outline of the project. I want a Linux
> device to listen for advertisements from a particular BLE sensor and connect
> to those sensors, as and when they appear. Once connected, the Linux device
> can send commands to the sensor, to turn on/off an LED or request sensor data
> from each of the connected sensors.
>
> The Linux kernel is 4.15 is an Ubuntu 16.04 based system.
>
> I was looking at the latest bluez-5.50 doc directory but didn't see a file for
> gap.txt, but adapter-api.txt looks like the API I'm looking for.
>
> I'm trying to do this from Python, so currently thinking of using DBus
> interface, another learning curve to address.
>
> So after all that a specific bluex questions. I'm missing things, and possibly
> incorrectly assuming that I need a certain kernel specified for bluez5.50, but
> can't see any mention of versions of bluez relating to versions of kernel.
>
> Secondly bluez-5.50 appears to be building an applicaiton, so I assume that
> application has to be running to interface to Linux Kernel bluetooth stack and
> handle the DBus API. So bluez should be a system service just started on
> powerup?
>
> Thanks for any help, I get the impression that this list is predominately for
> guts of the Linux Kernel's bluetooth stack, but user side list is hard to
> find.
>
> Thanks again
>
> John
