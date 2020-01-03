Return-Path: <SRS0=BOlL=2Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289C7C3276C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jan 2020 02:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9F2217F4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jan 2020 02:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1x7isBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgACCUH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jan 2020 21:20:07 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:35166 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbgACCUH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jan 2020 21:20:07 -0500
Received: by mail-ot1-f43.google.com with SMTP id k16so54765153otb.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jan 2020 18:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gLmbLsdDi+NQmqG7XSZhzlxZF55zCcAyyttWwNKyWgg=;
        b=q1x7isBjQ8rViccIE2cZrHdKiHEBddoymPgp25Vh8KVOlHP2UqRpWNuKNqgdONfYC1
         LakFBlmltl7/n48kjqecZ2JYcv+Af7x8jaQUMXYg9WbEMDKXS8auZHTHguQwVCT9gOih
         7nzCbdqUa1/udcqMVGkWEKdEijI5UaznGHFlUEhZoVRP7KZJkj6yqyLq1SAdGuauRTPo
         6ae7QB9iwtyT7iuW27lgGx5kOVGV4wio9gTpAP3xPPeNxv+37IdimDI+c7NLpA9sSFlT
         WbAsWOx3cTfN2QJTmxGsBnjgFIs8vXwsSJjxjAk9IW33kpKyIzd3P+m2g+pksVf6sW7v
         UNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gLmbLsdDi+NQmqG7XSZhzlxZF55zCcAyyttWwNKyWgg=;
        b=fxohyqqFA8alTEbeOG1iL+RvXLObDznjIcITqZOcelpz6fX+vir/qnHW7zLtAftSD7
         Gw1Mj8oMwc2pbkU11pgDcmwaxY2zBbE/WndJ/5vjFszYuutAvnrQuj1Y4V8CQl7Xc9al
         KY1rqoDjQV37lTRZd9NB0qu4xE9p+fNcGeCIAtJW1/U5EYjBA6LDzcp9Re0+Mlly6s99
         G39rJp6+Jd3ggJwcKGxgTrIscL3n84UbOAK0wlj2SOKHW9UKgW4oY+OZol8KLRJvQX5Q
         63o/8raUvb87MWnW+tUQunPFql7Ja3j9SykJtsKg6XB3T5JRA1A0bSfeT+gNq3G++vnp
         c9OA==
X-Gm-Message-State: APjAAAV5PM6+iV9F9N4Yppw6ogP6hvyBPsaq4gEk/z2PIHOFtV1ZtQST
        B9G0bPkT+88QSdyvs+YkKUzS1vO9GMLdYQV3dqs=
X-Google-Smtp-Source: APXvYqzyww2qrg44MbNPs2E0MGw9sDlnZjAHQ+4ivqlwkU99dTI3sdh1cIzsMdWJj53O1gf1BLMgaJ+BuCWv8hljzeA=
X-Received: by 2002:a9d:5542:: with SMTP id h2mr39715538oti.146.1578018005539;
 Thu, 02 Jan 2020 18:20:05 -0800 (PST)
MIME-Version: 1.0
References: <CAAERL8RHaWGAg5FOwts_pdDmagSdDj-Ui3ittmop+beVj9y6dQ@mail.gmail.com>
 <CABBYNZLe=ZmiPXg8mrU2BxY9H0hv_WvkvigyJBAs_wnq5ct_Cg@mail.gmail.com>
 <CAAERL8SK8rHhhGFN95+gWZF-2K4vozRcmZkA5aU9Fwx3a58+7w@mail.gmail.com>
 <CABBYNZ+UZezf7e4ra7t7sAHhcm8=bNUszMB_4evqtEUG2ktFoQ@mail.gmail.com> <CAAERL8TAdaFMMuJ7CgL_MGGw_smcfaSTLg=r+-tBkG2EeOdcJw@mail.gmail.com>
In-Reply-To: <CAAERL8TAdaFMMuJ7CgL_MGGw_smcfaSTLg=r+-tBkG2EeOdcJw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 2 Jan 2020 18:19:52 -0800
Message-ID: <CABBYNZ+Xnu_1Xp0g9xx84yOxn3J3+4FRY-GrpPSzwi7TsLfKfA@mail.gmail.com>
Subject: Re: Problems reading characteristics with Bluez 5.52
To:     Peter Belau <pbelau1@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Peter,

On Thu, Jan 2, 2020 at 6:10 PM Peter Belau <pbelau1@gmail.com> wrote:
>
> hci trace doesn't give me much of anything although I'd be happy to
> attach the trace. Which 'spec' should I check here?

https://www.bluetooth.org/docman/handlers/DownloadDoc.ashx?doc_id=243126

It doesn't look like there is anything required to subscribe but
perhaps it is disconnecting because there is no measurement in
progress or you have to set the time via CTS.

> On Thu, Jan 2, 2020 at 8:04 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Peter,
> >
> > On Thu, Jan 2, 2020 at 5:58 PM Peter Belau <pbelau1@gmail.com> wrote:
> > >
> > > Thank you very much for the response;  I did not realize that
> > > 'indicate' was exclusive to doing an attribute read. However, "notify
> > > on" doesn't seem to help. The device disconnects after a read and now
> > > I can no longer connect to it at all:
> > >
> > > QardioARM:/service0400/char0410]# notify on
> > > Notify started
> > > [CHG] Device 5C:D6:1F:0E:0A:7D ServicesResolved: no
> > > [CHG] Device 5C:D6:1F:0E:0A:7D Connected: no
> > >
> > > [bluetooth]#  connect 5C:D6:1F:0E:0A:7D
> > >
> > >
> > > Attempting to connect to 5C:D6:1F:0E:0A:7D
> > > Failed to connect: org.bluez.Error.Failed
> > >
> > >
> > > On the bluetoothd side I'm seeing:
> > >
> > > bluetoothd[20426]: src/agent.c:agent_disconnect() Agent :1.626 disconnected
> > > bluetoothd[20426]: src/agent.c:remove_default_agent() Default agent cleared
> > > bluetoothd[20426]: src/adapter.c:set_mode() sending set mode command for index 0
> > > bluetoothd[20426]: src/agent.c:agent_destroy() agent :1.626
> > > bluetoothd[20426]: src/agent.c:agent_unref() 0x55e718787df0: ref=0
> > > bluetoothd[20426]: src/adapter.c:new_settings_callback() Settings: 0x00000a01
> > > bluetoothd[20426]: src/adapter.c:settings_changed() Changed settings: 0x00000010
> > > bluetoothd[20426]: src/adapter.c:settings_changed() Pending settings: 0x00000000
> > > bluetoothd[20426]: src/agent.c:add_default_agent() Default agent set
> > > to :1.627 /org/bluez/agent
> > > bluetoothd[20426]: src/adapter.c:set_mode() sending set mode command for index 0
> > > bluetoothd[20426]: src/agent.c:agent_ref() 0x55e7187b7a00: ref=1
> > > bluetoothd[20426]: src/agent.c:register_agent() agent :1.627
> > > bluetoothd[20426]: src/adapter.c:new_settings_callback() Settings: 0x00000a11
> > > bluetoothd[20426]: src/adapter.c:settings_changed() Changed settings: 0x00000010
> > > bluetoothd[20426]: src/adapter.c:settings_changed() Pending settings: 0x00000000
> > > bluetoothd[20426]: src/device.c:att_connect_cb() connect error:
> > > Connection refused (111)
> > >
> > > I should note that I've tried a number of BTLE blood pressure devices
> > > with a variety of BT controllers and Bluez cannot seem to maintain
> > > reliable connections with any of the configurations I've tried. Any
> > > help would be much appreciated.
> >
> > HCI trace would probably help here, you can collect it using btmon.
> > Have you check the spec if there are other steps before subscribing?
> >
> > > On Thu, Jan 2, 2020 at 7:30 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Peter,
> > > >
> > > > On Thu, Jan 2, 2020 at 5:22 PM Peter Belau <pbelau1@gmail.com> wrote:
> > > > >
> > > > > I'm trying to get a Qardio ARM BP monitor working with Linux/Bluez but
> > > > > cannot seem to read any device characteristics with Bluez. My
> > > > > interaction through bluetoothctl looks like this:
> > > > >
> > > > > # menu gatt
> > > > > # attribute-info  00002a35-0000-1000-8000-00805f9b34fb
> > > > > Characteristic - Blood Pressure Measurement
> > > > >     UUID: 00002a35-0000-1000-8000-00805f9b34fb
> > > > >     Service: /org/bluez/hci0/dev_B0_49_5F_02_B5_61/service0400
> > > > >     Value:
> > > > >   16 7f 00 49 00 5b 00 00 00 00 00 00 00 00 35 00  ...I.[........5.
> > > > >   00 00                                            ..
> > > > >     Notifying: no
> > > > >     Flags: indicate
> > > > > # select-attribute 00002a35-0000-1000-8000-00805f9b34fb
> > > > > # read
> > > > > # Attempting to read /org/bluez/hci0/dev_B0_49_5F_02_B5_61/service0400/char0410
> > > > > Failed to read: org.bluez.Error.Failed
> > > > >
> > > > > I have bluetoothd running with debug flags but nothing appears in the
> > > > > debug logs. What am I doing wrong?
> > > >
> > > > Look at the flags, it only has indicate so it doesn't support reading directly.
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
