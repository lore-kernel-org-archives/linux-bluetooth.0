Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF8FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 May 2022 11:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbiE3LoZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 May 2022 07:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbiE3LoX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 May 2022 07:44:23 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CA8299
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 May 2022 04:44:21 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id b7so10590822vsq.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 May 2022 04:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foxdogstudios-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C+U803PsD05rTNoisE+ikzBWtw7fVVtUPD6fXlsX50E=;
        b=ULb/k7BiJlfwHV9rm6q7f16Gx4e89n+FWWmSXbgHHF4samXHhsZ0+l8itSka5+pcA6
         zwkav8dhxp4ibEcQMOj4dPEYb14cWOr7SuekeXbBee1Pmg1DsoX1ShDbFawEYYLH6Rcq
         LOvb8zfiLY4qiih+pe2j0OfJTmT67EisvgKweQGEkqIBCnnDnKA84nWzLrtiL4juA8n0
         OyAMk/CSMn7+OOJF68ji0rYLnecdPAUy0FHT6RFhB3oMy/RqjhqX75bGaUorPprDRWMT
         tu0KDpowTOfRyhqcb4uLWfryMlRzxqQj+EwqBcLQXFY+fzZ58r8Cha85gkhoF0i5/IQI
         be6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C+U803PsD05rTNoisE+ikzBWtw7fVVtUPD6fXlsX50E=;
        b=Aa5emCpH3YIopJu6LvGQ4Y5QoAatxM7vRjsfSkuhTDGP4SgibUVMztmU8Hv7nVdIyl
         OiW2oeKmYT6vTPGQnfzzuYX7XPJ8xF/Gbrhnayo+UeD8xXuL4nffYDwmOwamp+eSBijJ
         9ZfcbMwXm7R9ROsQaEQZ1gA9Ww9Kk99i2rz7yc0zt5Be1upIi00ZCuIn3zn2NZ1GTz5X
         Sp3tDGhnw4CgR2bEUEB7k/mcTVDGKH/Zg7OD1yDhErWs9B5qXIbSyFh4vzIsEEKN5HYa
         YkGBk01Vc4Iq3LQlxaumI1BJ8euDkM+byZltbRmyeEcf7fZwsSHhRvx5qfgmKLlkgOdO
         PNkA==
X-Gm-Message-State: AOAM531Qc09JwLyeojfD16ZKxdS2aPEnjTzTNWZ2mu9f4OqInVdAbNbg
        ox66wdVCCzh/EcRo6hxQwbiBB8C6Ess8Kvxa73Cu8g==
X-Google-Smtp-Source: ABdhPJxI7NeBWQG2QWibjO1WFAl8uZUNpYeffue0k21ew2M/elSF4LW5l9jYUSJYa+MaFMDAoDmTafmnIm1X/nx6ULw=
X-Received: by 2002:a67:d91e:0:b0:337:935e:517a with SMTP id
 t30-20020a67d91e000000b00337935e517amr18117504vsj.19.1653911060435; Mon, 30
 May 2022 04:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAD+dNTsbuU4w+Y_P7o+VEN7BYCAbZuwZx2+tH+OTzCdcZF82YA@mail.gmail.com>
 <24e95c8b-dc05-0d00-50bb-58b71c5baf94@molgen.mpg.de>
In-Reply-To: <24e95c8b-dc05-0d00-50bb-58b71c5baf94@molgen.mpg.de>
From:   Peter Sutton <peter@foxdogstudios.com>
Date:   Mon, 30 May 2022 12:44:09 +0100
Message-ID: <CAD+dNTuRThoa2OSzQ27tENB29GJ4oD0j3D+P4k42HzopEeTJMw@mail.gmail.com>
Subject: Re: [Bug] [Deadlock] Kernel thread deadlock in rfcomm socket release
 when connect interrupted
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthew Leach <matthew@mattleach.net>,
        Lloyd Henning <lloyd@foxdogstudios.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Commit b7ce436a5d798bc59e71797952566608a4b4626b is the probable cause.
I compiled a custom Arch Linux kernel package [1] and the bug was
present. Reverting the commit fixed the bug. Below is the reply I was
writing before Matt found the suspect commit and I tested with the
custom kernel.

> What hardware is that?

$ dmesg | grep iwlwifi
Me: Intel(R) Dual Band Wireless AC 8260, REV=0x204
Matt: Intel(R) Dual Band Wireless AC 8265, REV=0x230

We both get:

$ lsusb | grep Bluetooth
Me & Matt: Bus 001 Device 006: ID 8087:0a2b Intel Corp. Bluetooth
wireless interface

> As a lot of patches are also applied to the stable series, do you know,
> if this is a regression? Does it work with Linux 5.15(.0) or 5.10?

Bug is present on current Arch Linux LTS kernel:

$ uname -a
Linux taffer 5.15.43-1-lts #1 SMP Wed, 25 May 2022 14:08:34 +0000
x86_64 GNU/Linux

Matt tested on 5.10.115 and the bug is not present. So I guess it's a
regression. Anecdotally, we encountered this behaviour 1 yr ago
(difficult to say exactly), then it went away but came back about 1 or
2 months ago. All of this is on Arch Linux, I update about once a
week.

[1] https://wiki.archlinux.org/title/Kernel/Arch_Build_System
