Return-Path: <SRS0=UGHn=TS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFDDC04AAF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 May 2019 05:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3940320872
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 May 2019 05:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5FVhCLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbfERFdy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 18 May 2019 01:33:54 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42208 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfERFdy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 18 May 2019 01:33:54 -0400
Received: by mail-ot1-f67.google.com with SMTP id i2so3274010otr.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2019 22:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8yY5HWu/0lrFAwj7lPMQ+ZVfCBTII63bYSh09HLmIvU=;
        b=C5FVhCLFJhNo8kdD+CwOchiIJo9v1a939UXlP6kIaIvcWFEtWqFrDCwdqOimXbLnC8
         VWurRCK424xEKZPom0pDBl9gqsERu5vmYQ2XPRJksyPSNt5uzpGMWZOmM+eYzkohDv3e
         qB3E2upCKZMEuwrDWcN28dYm6b3Pq5S+Svyml6pWEBMIthxsYan5E67cL9SAJkolYwY+
         QKgRTy1MB7oVuzfaBteAoUxid1ISVcFhIkxq7Cd2UV6rFoR64QKMgq3hXsht0fF66bNF
         gpQz5/zR14uRfQnPFACdHoygRXry50xIgeaWJLo6Xfpa3voNqLZHFKvnaxQkKWMfDa8y
         pjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8yY5HWu/0lrFAwj7lPMQ+ZVfCBTII63bYSh09HLmIvU=;
        b=H2Wd6QQmbbqIeGtr/GON94ZfYAa1dLAwy8yGhyOF66kmuY07orep9J9EwpUVj5RXv3
         Aimxo9naUZzp1IbC8nPi0Glpx1iK1vDeIoPxcJyXarxIw/dRQu+CpZCol7OqtToqoypY
         CFOygRN+lh16y318BVI1y4zdL4ygKsoYeBVmPDcSYXvENm2NBriqfdIJAHMM8hpjvWfG
         U+esqH60CgMe9XCiZxqgyKF9mJm9UzMOThetr1RbqJE+eFItac4l9sNgdHCCIQg3/VL3
         QiJF4tWdNxCkP/7h9KRr/PPP7GJeXfSQyKRUZGHLGURzScWQmH/ts2LTLsPdKydKGtH7
         b+1g==
X-Gm-Message-State: APjAAAViOm1UH4fFXFI163UbL25Hm4kxkmz/4A/0a684cdU0R1oN3y3d
        ldLMWz/qxa0GQbbmDpJkE75D4fxZhNCjI10WpZo=
X-Google-Smtp-Source: APXvYqy2Q6a+HqtOdZn5DIJTAxEC23WuZ1KeFQh63NOQDKc3ArS7FoPYpMXoUKMmeZ1TYxgwarBBQc8ohmhG4QkGe9E=
X-Received: by 2002:a9d:469b:: with SMTP id z27mr14031278ote.11.1558157633486;
 Fri, 17 May 2019 22:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAELgYhdqAxTGA98RsUEOSEA5WfhxGaVn7C_DegAfU13sHx817A@mail.gmail.com>
 <CANxMttCx4uFeVpM9EsYmfg9VoXG45ihpzw=phJcx0Uy53cGD_A@mail.gmail.com>
In-Reply-To: <CANxMttCx4uFeVpM9EsYmfg9VoXG45ihpzw=phJcx0Uy53cGD_A@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sat, 18 May 2019 08:33:40 +0300
Message-ID: <CABBYNZLGgUL6W=-v+stoaukpN5kvt1AHFBQ_vEdh=sqU9JO0LQ@mail.gmail.com>
Subject: Re: After kernel update: connect/disconnect forever while attempting
 to auto-reconnect
To:     Alexandre Pereira Nunes <alexandre.nunes@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Sat, May 18, 2019 at 12:44 AM Alexandre Pereira Nunes
<alexandre.nunes@gmail.com> wrote:
>
> I'm seeing the exact same behavior, but on a mouse (bt 3.x mouse; I
> also have another which seems to be BLE and it still connects fine).
> Reverting to 5.0 always works.
>
>
> Em sex, 17 de mai de 2019 =C3=A0s 03:03, Carlos Pita
> <carlosjosepita@gmail.com> escreveu:
> >
> > Hi,
> >
> > after upgrading to kernel 5.1.1 (and also 5.1.2) my bluetooth speakers
> > are unable to auto-reconnect. I can connect them without problems, but
> > once I turn them off and on again an unending sequence of connections
> > and disconnections begins:
> >
> > ---- manual connection ok ---------
> > [bluetooth]# connect E0:D1:E6:07:62:E1
> > Attempting to connect to E0:D1:E6:07:62:E1
> > [CHG] Device E0:D1:E6:07:62:E1 Connected: yes
> > Connection successful
> > [CHG] Device E0:D1:E6:07:62:E1 ServicesResolved: yes
> > ---- turned off speakers and on again ----
> > [CHG] Device E0:D1:E6:07:62:E1 ServicesResolved: no
> > [CHG] Device E0:D1:E6:07:62:E1 Connected: no
> > [CHG] Device E0:D1:E6:07:62:E1 Connected: yes
> > [CHG] Device E0:D1:E6:07:62:E1 Connected: no
> > [CHG] Device E0:D1:E6:07:62:E1 Connected: yes
> > [CHG] Device E0:D1:E6:07:62:E1 Connected: no
> > [CHG] Device E0:D1:E6:07:62:E1 Connected: yes
> > [CHG] Device E0:D1:E6:07:62:E1 Connected: no
> > [CHG] Device E0:D1:E6:07:62:E1 Connected: yes
> > [CHG] Device E0:D1:E6:07:62:E1 Connected: no
> >
> > I've tested this with a number of kernels:
> >
> > linux-lts 4.19.43: doesn't work
> > linux 5.0.13: works
> > linux 5.1: works
> > linux 5.1.1: doesn't work
> > linux 5.1.2: doesn't work
> >
> > All the above tests were done against bluez 5.50. I've also tested
> > bluez git master against linux 5.1.2 to no avail.
> >
> > During failed attempts to auto-reconnect, the debug log shows:
> >
> > May 17 02:25:27 carlos bluetoothd[8178]:
> > src/adapter.c:connected_callback() hci0 device E0:D1:E6:07:62:E1
> > connected eir_len 5
> > May 17 02:25:27 carlos bluetoothd[8178]:
> > src/adapter.c:dev_disconnected() Device E0:D1:E6:07:62:E1
> > disconnected, reason 3
> > May 17 02:25:27 carlos bluetoothd[8178]:
> > src/adapter.c:adapter_remove_connection()
> > May 17 02:25:27 carlos bluetoothd[8178]:
> > plugins/policy.c:disconnect_cb() reason 3
> > May 17 02:25:27 carlos bluetoothd[8178]:
> > src/adapter.c:bonding_attempt_complete() hci0 bdaddr E0:D1:E6:07:62:E1
> > type 0 status 0xe
> > May 17 02:25:27 carlos bluetoothd[8178]:
> > src/device.c:device_bonding_complete() bonding (nil) status 0x0e
> > May 17 02:25:27 carlos bluetoothd[8178]:
> > src/device.c:device_bonding_failed() status 14
> >
> > Some other info that may be relevant:
> >
> > > uname -a
> > Linux carlos 5.1.1-arch1-1-ARCH #1 SMP PREEMPT Sat May 11 13:02:48 UTC
> > 2019 x86_64 GNU/Linux
> >
> > > yay -Qi pulseaudio
> > Version         : 12.2-2
> >
> > If you need something else to track down this issue, please let me
> > know. I've also reported this to pulseaudio tracker:
> > https://gitlab.freedesktop.org/pulseaudio/pulseaudio/issues/674.

Please use btmon to collect the HCI trace and attach it to the problem.

--=20
Luiz Augusto von Dentz
