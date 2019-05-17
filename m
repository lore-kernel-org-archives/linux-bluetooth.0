Return-Path: <SRS0=oIVb=TR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9D4C04AB4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 May 2019 21:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359ED206A3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 May 2019 21:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHVwT9hf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfEQVkU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 May 2019 17:40:20 -0400
Received: from mail-it1-f177.google.com ([209.85.166.177]:35566 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbfEQVkU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 May 2019 17:40:20 -0400
Received: by mail-it1-f177.google.com with SMTP id u186so14343501ith.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2019 14:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+15LxQewfOrVaZ1Ep9gQkJWWK8FEIYAOLGm/cUXQNz0=;
        b=GHVwT9hfA5IUwKYawPj3UHG28jwaKrP6emM8QVRS57gfKPnCGb6Mt5mq9wvkS7G6z4
         MLk64UAEgQLKmav9t2+OaBup8V//uTazBTiPwHHFe2Y3l7wL88WB/9/o7O9dwqQDCvqd
         a6aDF4YxKvj8BHcTvDyZBWBZgA3GQIVYY2nR7ys+EDgFRXImhQTDsNL1MENxvaErK9t9
         CQlAw6D0AnM2x9CP00mBPKgGz1YbnCbXNCYzuAAdeBKzYiRHAV/Lheavsnxb1lq3e1Gs
         cfqRFSXR/+TQ783e0VYXLesgXs5sTGELD79vnJU+376M/wDPH5UcMpGS3Yn4A/Pq/ugx
         IYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=+15LxQewfOrVaZ1Ep9gQkJWWK8FEIYAOLGm/cUXQNz0=;
        b=BgMFMcLjYnZ5zZZpGLq2prNQkZDsFoK2slGND1Zlth9y5FkF5+OJLEvRFjhlSgQCN7
         01FM7gNMbY3IdSKOi4LLF6FKp17WzqvHFVPkyFzzmZOhTRy5QCsw3DyTsLQ7NpbCoptk
         Pm10FZpc8j1oY+4+rhqFmv+292pVd1wVePRat0QNAZgBj1iT5M07VTFBjmdMTghrHRCY
         FUITnhXthb5rzk4me3FREr+OK8ZVovANe6QlQlSn9nbsWLkSMDrq04zjfS8g/8avn0TH
         wZl5UTbkjaHVfFDcUnJ3g0xk+JH1/RoWG1ScURa/xkPNXRnSI8KKtO/8KIE2EqqkPRGM
         bPjw==
X-Gm-Message-State: APjAAAVKIhuIa+lVYTpeAtu6ptDI8o7E0X7HtLnyarAduTFXWCKlqQmi
        mE92DHkzvj/Ht9Tfv9xeoNZSM0yrrgqYb5fPSe5m0A==
X-Google-Smtp-Source: APXvYqyPSMerqeXiHZzPMsAfaFalxiF1gStopQrNdDGE9u8yIMbt59U97aUSsO/oXt9X3ALNg5lVSiMFkS2xbiUtRUQ=
X-Received: by 2002:a24:c204:: with SMTP id i4mr18750948itg.83.1558129219236;
 Fri, 17 May 2019 14:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAELgYhdqAxTGA98RsUEOSEA5WfhxGaVn7C_DegAfU13sHx817A@mail.gmail.com>
In-Reply-To: <CAELgYhdqAxTGA98RsUEOSEA5WfhxGaVn7C_DegAfU13sHx817A@mail.gmail.com>
From:   Alexandre Pereira Nunes <alexandre.nunes@gmail.com>
Date:   Fri, 17 May 2019 18:39:52 -0300
Message-ID: <CANxMttCx4uFeVpM9EsYmfg9VoXG45ihpzw=phJcx0Uy53cGD_A@mail.gmail.com>
Subject: Re: After kernel update: connect/disconnect forever while attempting
 to auto-reconnect
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I'm seeing the exact same behavior, but on a mouse (bt 3.x mouse; I
also have another which seems to be BLE and it still connects fine).
Reverting to 5.0 always works.


Em sex, 17 de mai de 2019 =C3=A0s 03:03, Carlos Pita
<carlosjosepita@gmail.com> escreveu:
>
> Hi,
>
> after upgrading to kernel 5.1.1 (and also 5.1.2) my bluetooth speakers
> are unable to auto-reconnect. I can connect them without problems, but
> once I turn them off and on again an unending sequence of connections
> and disconnections begins:
>
> ---- manual connection ok ---------
> [bluetooth]# connect E0:D1:E6:07:62:E1
> Attempting to connect to E0:D1:E6:07:62:E1
> [CHG] Device E0:D1:E6:07:62:E1 Connected: yes
> Connection successful
> [CHG] Device E0:D1:E6:07:62:E1 ServicesResolved: yes
> ---- turned off speakers and on again ----
> [CHG] Device E0:D1:E6:07:62:E1 ServicesResolved: no
> [CHG] Device E0:D1:E6:07:62:E1 Connected: no
> [CHG] Device E0:D1:E6:07:62:E1 Connected: yes
> [CHG] Device E0:D1:E6:07:62:E1 Connected: no
> [CHG] Device E0:D1:E6:07:62:E1 Connected: yes
> [CHG] Device E0:D1:E6:07:62:E1 Connected: no
> [CHG] Device E0:D1:E6:07:62:E1 Connected: yes
> [CHG] Device E0:D1:E6:07:62:E1 Connected: no
> [CHG] Device E0:D1:E6:07:62:E1 Connected: yes
> [CHG] Device E0:D1:E6:07:62:E1 Connected: no
>
> I've tested this with a number of kernels:
>
> linux-lts 4.19.43: doesn't work
> linux 5.0.13: works
> linux 5.1: works
> linux 5.1.1: doesn't work
> linux 5.1.2: doesn't work
>
> All the above tests were done against bluez 5.50. I've also tested
> bluez git master against linux 5.1.2 to no avail.
>
> During failed attempts to auto-reconnect, the debug log shows:
>
> May 17 02:25:27 carlos bluetoothd[8178]:
> src/adapter.c:connected_callback() hci0 device E0:D1:E6:07:62:E1
> connected eir_len 5
> May 17 02:25:27 carlos bluetoothd[8178]:
> src/adapter.c:dev_disconnected() Device E0:D1:E6:07:62:E1
> disconnected, reason 3
> May 17 02:25:27 carlos bluetoothd[8178]:
> src/adapter.c:adapter_remove_connection()
> May 17 02:25:27 carlos bluetoothd[8178]:
> plugins/policy.c:disconnect_cb() reason 3
> May 17 02:25:27 carlos bluetoothd[8178]:
> src/adapter.c:bonding_attempt_complete() hci0 bdaddr E0:D1:E6:07:62:E1
> type 0 status 0xe
> May 17 02:25:27 carlos bluetoothd[8178]:
> src/device.c:device_bonding_complete() bonding (nil) status 0x0e
> May 17 02:25:27 carlos bluetoothd[8178]:
> src/device.c:device_bonding_failed() status 14
>
> Some other info that may be relevant:
>
> > uname -a
> Linux carlos 5.1.1-arch1-1-ARCH #1 SMP PREEMPT Sat May 11 13:02:48 UTC
> 2019 x86_64 GNU/Linux
>
> > yay -Qi pulseaudio
> Version         : 12.2-2
>
> If you need something else to track down this issue, please let me
> know. I've also reported this to pulseaudio tracker:
> https://gitlab.freedesktop.org/pulseaudio/pulseaudio/issues/674.
>
> Best regards
> --
> Carlos
