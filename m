Return-Path: <SRS0=BOlL=2Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D78C3276C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jan 2020 02:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB6F2084D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jan 2020 02:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDeyEpOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgACCEL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jan 2020 21:04:11 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:38527 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgACCEL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jan 2020 21:04:11 -0500
Received: by mail-ot1-f52.google.com with SMTP id d7so54890336otf.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jan 2020 18:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cCNKU2jR6HFU2VSnoj3ibl2vPmS9DzhAfWPL9iyvKtQ=;
        b=jDeyEpOsWn2HgQP4/WQf+1zWLW1hn//ILOselqj5JNK3SQ1HAFomrRCdIP5g73xm3a
         9b5X7aG/SqdW9s/nQ8XixusVK4tLx1Oh0arkJAP56vF/+6RW46doeXcct0uXCDB0Bfp/
         uLgU9n6UMrWh8YriQ3R8q9aSoasHSdPqhlcO2J9Lr3KVi5ssaXLBQb3eZzJoE6aBAsbS
         FAz+nscAeusy8KQXIkcFtyGLo5+3Wpo1D7J5q0RUHR1zs0IT3lsYUvYfAG9g1tY/JhlT
         1uN97qYa2k+m9AUT+PRsfglfhvYfDy8NaLtvvIw0rQpLA0Egzta6vt9bLOR571cXq0Nv
         dyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cCNKU2jR6HFU2VSnoj3ibl2vPmS9DzhAfWPL9iyvKtQ=;
        b=gZTKSPTn4kcsdL0iTIxDWy9fSjwqx/fhQosx9LupOlsWCoxmSHcFXC0lmF6hXwDQkl
         jWsjbzwwunYJPXVtV57RQX+O7EecmaPrush/NBsoTqXkvKAI7vp7vgySl94LPuOh4M5H
         g1Uzcgl5FnB7oVl8rEcumcTBFbh+nSJv8E/bEAfgfOWHBz+L1He/FxVNrQSvZTjxzmy0
         LVX5ZmoWX1HlSGDe7WanU0RVZsgRr+PgsHSnMDvph+HttKXsg7q/osO8eCfo6C7F70mH
         BmutX9Fkhz/CX4I/JDH7CtHiJiIfudaXszOIHHQ9u/qmMkH1xJPT6CEL/R+Bl3ZTXVoY
         m3KA==
X-Gm-Message-State: APjAAAV6z+PyuIZWVDVSHfwC6Ex2y8aAAQPjzPDp6X/9MN8sqogMsepm
        LGZ9HRNqoZEYMbFkz0flNqLliRqyUzAslt6roU4IEwyf
X-Google-Smtp-Source: APXvYqw2IedtIWL5aVaTJfLlTg6pFjG1Xw7b4nhVRKrRFBmdgV17haMbUw+ufIYPaTyPeinzDq8BEK5hpN2ADzT7FyE=
X-Received: by 2002:a05:6830:605:: with SMTP id w5mr96072434oti.79.1578017050424;
 Thu, 02 Jan 2020 18:04:10 -0800 (PST)
MIME-Version: 1.0
References: <CAAERL8RHaWGAg5FOwts_pdDmagSdDj-Ui3ittmop+beVj9y6dQ@mail.gmail.com>
 <CABBYNZLe=ZmiPXg8mrU2BxY9H0hv_WvkvigyJBAs_wnq5ct_Cg@mail.gmail.com> <CAAERL8SK8rHhhGFN95+gWZF-2K4vozRcmZkA5aU9Fwx3a58+7w@mail.gmail.com>
In-Reply-To: <CAAERL8SK8rHhhGFN95+gWZF-2K4vozRcmZkA5aU9Fwx3a58+7w@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 2 Jan 2020 18:03:54 -0800
Message-ID: <CABBYNZ+UZezf7e4ra7t7sAHhcm8=bNUszMB_4evqtEUG2ktFoQ@mail.gmail.com>
Subject: Re: Problems reading characteristics with Bluez 5.52
To:     Peter Belau <pbelau1@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Peter,

On Thu, Jan 2, 2020 at 5:58 PM Peter Belau <pbelau1@gmail.com> wrote:
>
> Thank you very much for the response;  I did not realize that
> 'indicate' was exclusive to doing an attribute read. However, "notify
> on" doesn't seem to help. The device disconnects after a read and now
> I can no longer connect to it at all:
>
> QardioARM:/service0400/char0410]# notify on
> Notify started
> [CHG] Device 5C:D6:1F:0E:0A:7D ServicesResolved: no
> [CHG] Device 5C:D6:1F:0E:0A:7D Connected: no
>
> [bluetooth]#  connect 5C:D6:1F:0E:0A:7D
>
>
> Attempting to connect to 5C:D6:1F:0E:0A:7D
> Failed to connect: org.bluez.Error.Failed
>
>
> On the bluetoothd side I'm seeing:
>
> bluetoothd[20426]: src/agent.c:agent_disconnect() Agent :1.626 disconnected
> bluetoothd[20426]: src/agent.c:remove_default_agent() Default agent cleared
> bluetoothd[20426]: src/adapter.c:set_mode() sending set mode command for index 0
> bluetoothd[20426]: src/agent.c:agent_destroy() agent :1.626
> bluetoothd[20426]: src/agent.c:agent_unref() 0x55e718787df0: ref=0
> bluetoothd[20426]: src/adapter.c:new_settings_callback() Settings: 0x00000a01
> bluetoothd[20426]: src/adapter.c:settings_changed() Changed settings: 0x00000010
> bluetoothd[20426]: src/adapter.c:settings_changed() Pending settings: 0x00000000
> bluetoothd[20426]: src/agent.c:add_default_agent() Default agent set
> to :1.627 /org/bluez/agent
> bluetoothd[20426]: src/adapter.c:set_mode() sending set mode command for index 0
> bluetoothd[20426]: src/agent.c:agent_ref() 0x55e7187b7a00: ref=1
> bluetoothd[20426]: src/agent.c:register_agent() agent :1.627
> bluetoothd[20426]: src/adapter.c:new_settings_callback() Settings: 0x00000a11
> bluetoothd[20426]: src/adapter.c:settings_changed() Changed settings: 0x00000010
> bluetoothd[20426]: src/adapter.c:settings_changed() Pending settings: 0x00000000
> bluetoothd[20426]: src/device.c:att_connect_cb() connect error:
> Connection refused (111)
>
> I should note that I've tried a number of BTLE blood pressure devices
> with a variety of BT controllers and Bluez cannot seem to maintain
> reliable connections with any of the configurations I've tried. Any
> help would be much appreciated.

HCI trace would probably help here, you can collect it using btmon.
Have you check the spec if there are other steps before subscribing?

> On Thu, Jan 2, 2020 at 7:30 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Peter,
> >
> > On Thu, Jan 2, 2020 at 5:22 PM Peter Belau <pbelau1@gmail.com> wrote:
> > >
> > > I'm trying to get a Qardio ARM BP monitor working with Linux/Bluez but
> > > cannot seem to read any device characteristics with Bluez. My
> > > interaction through bluetoothctl looks like this:
> > >
> > > # menu gatt
> > > # attribute-info  00002a35-0000-1000-8000-00805f9b34fb
> > > Characteristic - Blood Pressure Measurement
> > >     UUID: 00002a35-0000-1000-8000-00805f9b34fb
> > >     Service: /org/bluez/hci0/dev_B0_49_5F_02_B5_61/service0400
> > >     Value:
> > >   16 7f 00 49 00 5b 00 00 00 00 00 00 00 00 35 00  ...I.[........5.
> > >   00 00                                            ..
> > >     Notifying: no
> > >     Flags: indicate
> > > # select-attribute 00002a35-0000-1000-8000-00805f9b34fb
> > > # read
> > > # Attempting to read /org/bluez/hci0/dev_B0_49_5F_02_B5_61/service0400/char0410
> > > Failed to read: org.bluez.Error.Failed
> > >
> > > I have bluetoothd running with debug flags but nothing appears in the
> > > debug logs. What am I doing wrong?
> >
> > Look at the flags, it only has indicate so it doesn't support reading directly.
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
