Return-Path: <SRS0=BOlL=2Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF104C3276C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jan 2020 01:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9400F2084D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jan 2020 01:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fpo5red2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgACB6K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jan 2020 20:58:10 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:38620 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgACB6J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jan 2020 20:58:09 -0500
Received: by mail-io1-f53.google.com with SMTP id v3so40076907ioj.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jan 2020 17:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aPMvDTnKu4oucJQDd5iUBAF1eUyKvjyaMCaVh6gxCWY=;
        b=Fpo5red2wK0GRFA0d+F1n3CfCsZjascOW1d03MgrbE2XwvTcOja9sUAChWWva6vpRx
         /wmozPIPdT26IuiAc1FWdLkz2ELAjBUBCNC2PUus1z6qY/Au3Nf5f4FQaD/gjhMDRohj
         dY5t5GbDihPrm0mBzM65EVy8w8KOnRKM4w5b3OHbuhd8N4xDefImK0laZRO/eCe3Jkna
         5iskDOfXK4fVh4KhKh094slqnTLH0naePkrRXEpWQZl3wY82jbUSQuSfFquTp3KYaIXP
         glVQEeBgqCWjFIYiJjNyCO9FwApxhx/Gfb1iLPCDov1NXkg0jFIX7RIKxVXXXdbGug6v
         d6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aPMvDTnKu4oucJQDd5iUBAF1eUyKvjyaMCaVh6gxCWY=;
        b=LmOESo2R6ujiIWywPOvO3akP94maDlk1dF3uLsZGrNgCK1YDPzZxdNfq8w1i1TAFe2
         ead3xZw8tHgZvnbctDnVGo2PbVAZ39+MEj1P4bMisRJT4yzdQ0nKmsLvEowIEzFpagKr
         QfytyMhBskxTGyQZR/QTrsmTaAgDPolaoNANWCWqwnRDux68DvW2zKJfqdt/+9r2hEOX
         cGYaMdJcJjdOdzMQDPE78q1hsdnMvthEDAtk81r1isZbbHvnyXk/2I5T0ElvGvTDFaqO
         y0Jjggop+oloGPtWB64rlO8huDuhujWbqQTsjUfXB5boKOWbm4pt6P0CKNeq+yJMDP5I
         R/SQ==
X-Gm-Message-State: APjAAAWGC9+0yFvJm2G+8lySNXxcJK63q9ygRbX/pakO5teOiD406nFN
        yVhR1CmzBBgFdOEavTVpKvSBZE7ikz3ZE4oG+Qc=
X-Google-Smtp-Source: APXvYqwa2M2Fz2oUYlaOcVDgfZRvExc5NXifDCUfHaAcxcupsVdLjYzBTcjItSAK0mqsL1MUpplGQaoSdG6hZMCyQwU=
X-Received: by 2002:a02:ba91:: with SMTP id g17mr69054544jao.106.1578016688919;
 Thu, 02 Jan 2020 17:58:08 -0800 (PST)
MIME-Version: 1.0
References: <CAAERL8RHaWGAg5FOwts_pdDmagSdDj-Ui3ittmop+beVj9y6dQ@mail.gmail.com>
 <CABBYNZLe=ZmiPXg8mrU2BxY9H0hv_WvkvigyJBAs_wnq5ct_Cg@mail.gmail.com>
In-Reply-To: <CABBYNZLe=ZmiPXg8mrU2BxY9H0hv_WvkvigyJBAs_wnq5ct_Cg@mail.gmail.com>
From:   Peter Belau <pbelau1@gmail.com>
Date:   Thu, 2 Jan 2020 19:57:58 -0600
Message-ID: <CAAERL8SK8rHhhGFN95+gWZF-2K4vozRcmZkA5aU9Fwx3a58+7w@mail.gmail.com>
Subject: Re: Problems reading characteristics with Bluez 5.52
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thank you very much for the response;  I did not realize that
'indicate' was exclusive to doing an attribute read. However, "notify
on" doesn't seem to help. The device disconnects after a read and now
I can no longer connect to it at all:

QardioARM:/service0400/char0410]# notify on
Notify started
[CHG] Device 5C:D6:1F:0E:0A:7D ServicesResolved: no
[CHG] Device 5C:D6:1F:0E:0A:7D Connected: no

[bluetooth]#  connect 5C:D6:1F:0E:0A:7D


Attempting to connect to 5C:D6:1F:0E:0A:7D
Failed to connect: org.bluez.Error.Failed


On the bluetoothd side I'm seeing:

bluetoothd[20426]: src/agent.c:agent_disconnect() Agent :1.626 disconnected
bluetoothd[20426]: src/agent.c:remove_default_agent() Default agent cleared
bluetoothd[20426]: src/adapter.c:set_mode() sending set mode command for index 0
bluetoothd[20426]: src/agent.c:agent_destroy() agent :1.626
bluetoothd[20426]: src/agent.c:agent_unref() 0x55e718787df0: ref=0
bluetoothd[20426]: src/adapter.c:new_settings_callback() Settings: 0x00000a01
bluetoothd[20426]: src/adapter.c:settings_changed() Changed settings: 0x00000010
bluetoothd[20426]: src/adapter.c:settings_changed() Pending settings: 0x00000000
bluetoothd[20426]: src/agent.c:add_default_agent() Default agent set
to :1.627 /org/bluez/agent
bluetoothd[20426]: src/adapter.c:set_mode() sending set mode command for index 0
bluetoothd[20426]: src/agent.c:agent_ref() 0x55e7187b7a00: ref=1
bluetoothd[20426]: src/agent.c:register_agent() agent :1.627
bluetoothd[20426]: src/adapter.c:new_settings_callback() Settings: 0x00000a11
bluetoothd[20426]: src/adapter.c:settings_changed() Changed settings: 0x00000010
bluetoothd[20426]: src/adapter.c:settings_changed() Pending settings: 0x00000000
bluetoothd[20426]: src/device.c:att_connect_cb() connect error:
Connection refused (111)

I should note that I've tried a number of BTLE blood pressure devices
with a variety of BT controllers and Bluez cannot seem to maintain
reliable connections with any of the configurations I've tried. Any
help would be much appreciated.

On Thu, Jan 2, 2020 at 7:30 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Peter,
>
> On Thu, Jan 2, 2020 at 5:22 PM Peter Belau <pbelau1@gmail.com> wrote:
> >
> > I'm trying to get a Qardio ARM BP monitor working with Linux/Bluez but
> > cannot seem to read any device characteristics with Bluez. My
> > interaction through bluetoothctl looks like this:
> >
> > # menu gatt
> > # attribute-info  00002a35-0000-1000-8000-00805f9b34fb
> > Characteristic - Blood Pressure Measurement
> >     UUID: 00002a35-0000-1000-8000-00805f9b34fb
> >     Service: /org/bluez/hci0/dev_B0_49_5F_02_B5_61/service0400
> >     Value:
> >   16 7f 00 49 00 5b 00 00 00 00 00 00 00 00 35 00  ...I.[........5.
> >   00 00                                            ..
> >     Notifying: no
> >     Flags: indicate
> > # select-attribute 00002a35-0000-1000-8000-00805f9b34fb
> > # read
> > # Attempting to read /org/bluez/hci0/dev_B0_49_5F_02_B5_61/service0400/char0410
> > Failed to read: org.bluez.Error.Failed
> >
> > I have bluetoothd running with debug flags but nothing appears in the
> > debug logs. What am I doing wrong?
>
> Look at the flags, it only has indicate so it doesn't support reading directly.
>
> --
> Luiz Augusto von Dentz
