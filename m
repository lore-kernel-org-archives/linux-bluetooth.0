Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD95C432BE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Aug 2021 10:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B9AE604DC
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Aug 2021 10:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbhH2K7a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 29 Aug 2021 06:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbhH2K73 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 29 Aug 2021 06:59:29 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F60C061575
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Aug 2021 03:58:37 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y34so24738754lfa.8
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Aug 2021 03:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YetByjkPgLMS1+j5KfbqJiKC1zSrjpr6R58KqkbSask=;
        b=muo7OljRyIhRx81GLxMT/CtS18U6NnprUvPX4YK+pzNnNRKaPYHV8BNKP8ysxw3GiW
         nd3IhXBzlZu0z5K8KQ032Qr7NYlnbDLuAE1oCYnsWV3czqOAXHeQw2rHXF6YVAjNhIW9
         Hs/ZEi20dEqrnOaItkDr4EUjUeY9qBqpKnPRnbr94Fs2wimIHawuO3/lUbM6JCea4PRD
         cqW1p/nyMkd9d6V8iUX0r83SIUMPUNxSUoL+nFS20fqda+XxQbJZ8Q27FChNukzo78kH
         cen2jNtV9cLwVetZT3tPT7sdJBBYRQjkG5rJEL7i7jcRhjoD0J/BRhdzqcfKKJXyfX1J
         YA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YetByjkPgLMS1+j5KfbqJiKC1zSrjpr6R58KqkbSask=;
        b=dWM34m9hBKQ/Dr7KDNeZtXJPKqqcHf+G3KnC6SFYeMI+GkZnWIPayRRmM4JfQxuC7T
         u0zR0SkmkgzWvZqO4HG6530arByvOrOKUjq4V1dvNWKNErCnUJBLOhtbt/nf8a/7UNly
         4dR+bnV9XvfARvpmHp0WIxdXXQX1TRlTNIz38CW6eqS3dIxV6yyJKj83upIiNsLCoVF9
         Y2XGAnaro6j0UigtZrbtLNb5s/PqxS0A9Kd0M+oQqxUqDsitTpyLr5D/lYTpyjD3tLxt
         juld+xMOdl053zO5NK34oA6oo9OfEML22nVNvKmI8OcR6I9ykKELKWzXWSNvo9w8hK6u
         gHkg==
X-Gm-Message-State: AOAM531dJYmVfHmsq0thpSvUNC4/P6ljCx3V2pCuSb9ujV7D9hCP/xZC
        ouyfMTeL4MnfDIuCxRDjmFCIFt1izoQggSEDuSxRKHLy
X-Google-Smtp-Source: ABdhPJypxlimguP7Swt2urITTX44vcWTmXfmdUftXpGyNZnkuhvxofuG6KVrZ92JbblfxsssHodCVgnBl+Ecf4baiYc=
X-Received: by 2002:ac2:5bde:: with SMTP id u30mr13714562lfn.60.1630234715595;
 Sun, 29 Aug 2021 03:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAC9s0NZGAJH-7Ojbx_nrAu-nB+KRYKak2prD14YZhWgOx-Ow-A@mail.gmail.com>
In-Reply-To: <CAC9s0NZGAJH-7Ojbx_nrAu-nB+KRYKak2prD14YZhWgOx-Ow-A@mail.gmail.com>
From:   Raul Piper <raulpblooper@gmail.com>
Date:   Sun, 29 Aug 2021 16:28:23 +0530
Message-ID: <CAEwN+MCDisr--ULqcOSoJ_WPBFJ6YcdKg2m7LuTSacD6UqOPYg@mail.gmail.com>
Subject: Re: How to install manually built BlueZ 5.50 on board?
To:     Kenny Bian <kennybian@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

did you get any success?
Regards,R

On Tue, Jun 1, 2021 at 1:30 PM Kenny Bian <kennybian@gmail.com> wrote:
>
> I managed to build BlueZ 5.50 by using Ubuntu 18.04. I did the cross
> compilation for the code for the armhf architecture.
>
> I copied the build folder to the embedded Ubuntu board. I then run
> "make install" but get errors:
> checking whether the C compiler works... no
> configure: error: in `/home/user/bluez-5.50':
> configure: error: C compiler cannot create executables
> See `config.log' for more details
> Makefile:3310: recipe for target 'config.status' failed
> make: *** [config.status] Error 77
>
> I then tried to manually install the build on the board. I tried "make
> install" on my VirtualBox Ubuntu Desktop. So I used the similar way to
> install the build(all of the folders are already created):
> sudo /bin/bash ./libtool   --mode=install /usr/bin/install -c
> client/bluetoothctl monitor/btmon tools/rctest tools/l2test
> tools/l2ping tools/bccmd tools/bluemoon tools/hex2hcd
> tools/mpris-proxy tools/btattach '/usr/bin'
> sudo /bin/bash ./libtool   --mode=install /usr/bin/install -c
> src/bluetoothd obexd/src/obexd '/usr/lib/bluetooth'
> sudo /usr/bin/install -c profiles/cups/bluetooth /usr/lib/cups/backend/bluetooth
> sudo /usr/bin/install -c -m 644 src/bluetooth.conf '/etc/dbus-1/system.d'
> sudo /usr/bin/install -c -m 644 obexd/src/org.bluez.obex.service
> '/usr/share/dbus-1/services'
> sudo /usr/bin/install -c -m 644 src/org.bluez.service
> '/usr/share/dbus-1/system-services'
> sudo /usr/bin/install -c -m 644 tools/rctest.1 tools/l2ping.1
> tools/bccmd.1 tools/btattach.1 tools/hid2hci.1 '/usr/share/man/man1'
> sudo /usr/bin/install -c -m 644 src/bluetoothd.8 '/usr/share/man/man8'
> sudo /usr/bin/install -c -m 644 tools/97-hid2hci.rules '/lib/udev/rules.d'
> sudo /usr/bin/install -c -m 644 src/bluetooth.service '/lib/systemd/system'
> sudo /usr/bin/install -c -m 644 obexd/src/obex.service '/usr/lib/systemd/user'
> sudo /bin/bash ./libtool   --mode=install /usr/bin/install -c
> tools/hid2hci '/lib/udev'
>
> My questions are:
> 1. How to install the build on the board? "make install" doesn't work.
> 2. How can I tell if the build is installed correctly?
> 3. How can I verify if the BlueZ 5.50 works or not?
> 4. I tried "sudo btattach -B /dev/ttymxc2 -S 921600", but btattach doesn't exit:
> Attaching Primary controller to /dev/ttymxc2
> Switched line discipline from 0 to 15
> Device index 0 attached
> 5. I also tried "sudo /usr/libexec/bluetooth/bluetoothd". There is no
> output. "bluetoothd" doesn't exit either. By the way, "bluetoothd"
> doesn't run after the build is installed. So I try to manually run it.
> 6. By running "/usr/libexec/bluetooth/bluetoothd -v", I got "5.50".
> By running "/usr/libexec/bluetooth/bluetoothd -d", I got:
> D-Bus setup failed: Connection ":1.50" is not allowed to own the
> service "org.bluez" due to security policies in the configuration file
>
> Thanks in advance!
