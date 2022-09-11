Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9BCECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Sun, 11 Sep 2022 15:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiIKPmm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 11 Sep 2022 11:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIKPml (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 11 Sep 2022 11:42:41 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54916348
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Sep 2022 08:42:40 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id o123so6630364vsc.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Sep 2022 08:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foxdogstudios-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=6x1wHSCicuV7iaAZJLjAByjqQhgogB5Bf/Ei/pyFzrI=;
        b=q2hF5mcOkk29lNAMk/DBCl2IjSeN8KjDVs+/9SLWYsihYpAAC/x40xy9FF8hHZFC9y
         rAU2ktrI6aFIr7Q5d8q18m+eoetvo5zSQzX3VSK573zn8KfTFJzc9DM5iULta01o9F6S
         0mKxDVNqY43wy1mFCzVmDGMZY5IZOPGwdikvfgG7RlyeY9qrUisP6He4kcK+Q+Mg2I7j
         tGppJTo4UZpDyooTGG8vTbDdOiZ9VUKRTOTrJDEy3CAX336LrsYA0e8ECV+H7rPjBqaW
         d4xw0vSmzVhNgcCdr9Rwxw0U9dtBaa0NR4amoQm5GzsmTYlOHz1zVLs7Q5XsswRKcHtj
         MuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6x1wHSCicuV7iaAZJLjAByjqQhgogB5Bf/Ei/pyFzrI=;
        b=qJQbi+Fuqd0IOcOJ52qkxZmbpju147MZWde8Lv7sE5t2oTtqqGH1oRN2ryb/FqkMTA
         OAVDUB0bV8B3ImPEwaCsKyFfTPDpxcykYtMAQnkTfhINIifmfa8OkPbAC6dF0rHSGCgP
         XNSyeeKVTC0G8zWbPcwNWy0CjyQjIgb9RPzAilR2T3YJOpCCNvEA+dWn7WxUdQC0TbH/
         sILQLbD/31XPrH3JtPtgZDhAlk7DS4BAp7RsdPjvDRrFOfb7GF+f/tvavvHX59MtlXnA
         YfNttfTDjuVP5y0Tyj3riCodZPpY1KKKF4CPWP2un8P5Jed3dXjVn+qyAtIxXEvNDh9r
         aZBA==
X-Gm-Message-State: ACgBeo0xWWuTtBC8cheOpWIRSWikZToWj644PZjkjWrQU4YY8vf5UiH8
        mQ6OvQb7usQVNXHdsg7OiURDNin3C1rXAt0FKPfFERs9FUg=
X-Google-Smtp-Source: AA6agR4yqtWkuY1b3zTqerwvGl1L0Y6qApKWe0sNhv9Uk2IhWDsPEBJN03CxqG7Kjn8yRvEj2W7F3TCVLqpxxz6wGto=
X-Received: by 2002:a67:ec04:0:b0:398:7ed6:2464 with SMTP id
 d4-20020a67ec04000000b003987ed62464mr667395vso.5.1662910959827; Sun, 11 Sep
 2022 08:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAD+dNTsbuU4w+Y_P7o+VEN7BYCAbZuwZx2+tH+OTzCdcZF82YA@mail.gmail.com>
 <24e95c8b-dc05-0d00-50bb-58b71c5baf94@molgen.mpg.de> <CAD+dNTuRThoa2OSzQ27tENB29GJ4oD0j3D+P4k42HzopEeTJMw@mail.gmail.com>
In-Reply-To: <CAD+dNTuRThoa2OSzQ27tENB29GJ4oD0j3D+P4k42HzopEeTJMw@mail.gmail.com>
From:   Peter Sutton <peter@foxdogstudios.com>
Date:   Sun, 11 Sep 2022 16:42:28 +0100
Message-ID: <CAD+dNTsqBEjzG7BinKtxveH9faJqss89WPufbSsaB5FZRDgOPA@mail.gmail.com>
Subject: Re: [Bug] [Deadlock] Kernel thread deadlock in rfcomm socket release
 when connect interrupted
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Just following this up. Is there anything I can do to help fix this?
Running a custom kernel is a real pain. I've been running with the
commit revert and upgrading with Arch Linux kernel releases with no
issue.

Thanks,


Pete.

On Mon, 30 May 2022 at 12:44, Peter Sutton <peter@foxdogstudios.com> wrote:
>
> Commit b7ce436a5d798bc59e71797952566608a4b4626b is the probable cause.
> I compiled a custom Arch Linux kernel package [1] and the bug was
> present. Reverting the commit fixed the bug. Below is the reply I was
> writing before Matt found the suspect commit and I tested with the
> custom kernel.
>
> > What hardware is that?
>
> $ dmesg | grep iwlwifi
> Me: Intel(R) Dual Band Wireless AC 8260, REV=0x204
> Matt: Intel(R) Dual Band Wireless AC 8265, REV=0x230
>
> We both get:
>
> $ lsusb | grep Bluetooth
> Me & Matt: Bus 001 Device 006: ID 8087:0a2b Intel Corp. Bluetooth
> wireless interface
>
> > As a lot of patches are also applied to the stable series, do you know,
> > if this is a regression? Does it work with Linux 5.15(.0) or 5.10?
>
> Bug is present on current Arch Linux LTS kernel:
>
> $ uname -a
> Linux taffer 5.15.43-1-lts #1 SMP Wed, 25 May 2022 14:08:34 +0000
> x86_64 GNU/Linux
>
> Matt tested on 5.10.115 and the bug is not present. So I guess it's a
> regression. Anecdotally, we encountered this behaviour 1 yr ago
> (difficult to say exactly), then it went away but came back about 1 or
> 2 months ago. All of this is on Arch Linux, I update about once a
> week.
>
> [1] https://wiki.archlinux.org/title/Kernel/Arch_Build_System
