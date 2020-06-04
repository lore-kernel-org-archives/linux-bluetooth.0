Return-Path: <SRS0=9nD+=7R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8960C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 08:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF6A20878
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 08:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxurhFlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgFDIQN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgFDIQM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jun 2020 04:16:12 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCCBC05BD1E
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2020 01:16:12 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g18so4459262qtu.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2020 01:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uUZ+4vPEHAEhfVyjFU8yZDUTzOpR9+Dde7eRMpK/YzU=;
        b=dxurhFlbrXR3Sq7RSrRKGjJdYyjDaqkhDSGgpS3Gg2LNzjrolRueKnjaYY9la1BrUE
         eqr6THH32yqSKBt95tRMkCXEgj+V+79mJ4nMhexGpSGTQAcAdRI3FWi0ZT/7Udttsh1p
         zymAVsvpPFb5bJHljMDCHVj7Ji0DcO7NIv86tRQ2fus17j0yfZps4W7PdzuILblDRYo8
         7HczKMe5hzIhkwyJG77udoEMo+NYcB/ogzq1VVxVVYyVMs8DIVZ30z/Gv/CXEEMNibk4
         HIRl4wELVPKowjGziwKgPZGqsi9OhDjkOVwu7qPB2tCXvXQr1Gjzqz9cQ004unOL1uGk
         ki/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uUZ+4vPEHAEhfVyjFU8yZDUTzOpR9+Dde7eRMpK/YzU=;
        b=Y/pmJ55c+sHuT3+9/Thgp7jM00+GtrfEdOLH33gbzbgdZXhnBu+XQxzUFyIfhN4YOK
         MaJch0vS4Wgnp+yFBCbmH0Lp3ej7ichgILTQBpmgnbR9TO1C/AVlkbtrvARXHor7JDHR
         mBIPK/CGBPRkO5lqjl0Jwavsxn+3H5V16UqwhuLBfn1WduSMwZhAeB2har9ztpEUgvQF
         ZdOwTLaGQVIF6xnwZxFUWBqUIKEW5waCdtt/q/FSyJw0+gGxyMi3Ebf6e87kzRIi9VuX
         IGNARoEFhNLPKC1eZ/fbono1uhpoas8pwNxFR2cajJYBgCaXB3wKjjSzTQ/dMQlpdtAm
         IitQ==
X-Gm-Message-State: AOAM530hrpVtHp30EApFgMggsPoFYzxmw5VJi8pEDfnpOLPMi6knZdHG
        EnPmCePYOHorEG9Ghz+r47zhNLMwOJZJYf6zoog8wZCZ
X-Google-Smtp-Source: ABdhPJwj2ZaJalgGDib+q7cJWMV59xNNXLvJee2UFV9jVsRS1TfxenB6N/LGeRymkDtfkS0rlrmuHUNwC4kOFQiOpmE=
X-Received: by 2002:ac8:6c23:: with SMTP id k3mr3322843qtu.298.1591258571323;
 Thu, 04 Jun 2020 01:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAGpqJgrBtwdauxv03jXsq+8+EG_BW-4QZXryXt-e5Y8HA_5+_g@mail.gmail.com>
 <CABBYNZLLx+zX_XyNjkW99D7HG_6+eZM_MP7EWVVAuuRtf0J6dw@mail.gmail.com>
 <CABBYNZJxVsnGtpnJkCCQtQFKXOiSEV7490me1vjAOOGynCdfUw@mail.gmail.com>
 <CAGpqJgrcxd0iwWUu=VB=MhiSS9+TRMLLsyTjbwQMdJ+6u66u6Q@mail.gmail.com> <CABBYNZKTQzEuBpP3YG7=Ms6c-36mnR7qAc4A1XDOLfggDPXXCA@mail.gmail.com>
In-Reply-To: <CABBYNZKTQzEuBpP3YG7=Ms6c-36mnR7qAc4A1XDOLfggDPXXCA@mail.gmail.com>
From:   Arthur Lambert <lambertarthur22@gmail.com>
Date:   Thu, 4 Jun 2020 10:15:58 +0200
Message-ID: <CAGpqJgraPcsGkoNdzG94JTqwxVaMxUBKtVpNfyvBkuy7TWW_sA@mail.gmail.com>
Subject: Re: Segmentation fault in bluetoothd with btgatt-client
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

I just test your fix! It is working perfectly \o/.

I will probably add a kind of watchdog to check that Bluetoothd is
always alive on my device to reset
it in case of failure just in case.

Is it possible that this crash happened when a mobile app tried to
connect to my embedded device?
Or is it possible that this issue impacts the cache service/charac
feature? I am not sure to fully
understand the perimeter of the issue.
We have a problem with the cache update for a few weeks. Basically the
problem is that mobile app is
doing request on bad characteristics after firmware update with new
characteristic available.
The problem was already present but very very rare. On my last
firmware update, it is more frequent.
It is like the mobile app is using the old UUID mapping. The issue
happened after Bluez update from 5.52
to 5.54. But we are not sure that the issue is related to Bluez. It
can also be related to the phone.
It is weird also because the issue happened only with Android and IOS
is just fine.

Thank you for your quick fix and reply!


Le mer. 3 juin 2020 =C3=A0 23:06, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> a =C3=A9crit :
>
> Hi Arthur,
>
> On Wed, Jun 3, 2020 at 11:22 AM Arthur Lambert
> <lambertarthur22@gmail.com> wrote:
> >
> > Hi Luiz,
> > thanks for your reply!
> >
> > Sorry I am lazy and stupid. I know that your next question will be
> > around symbol...
> >
> > After removing the binary strip option and enable debug symbol :
> >
> > bluetoothd[246]: src/device.c:device_svc_resolved()
> > /org/bluez/hci0/dev_80_32_53_37_58_A6 err -5
> > bluetoothd[246]: src/device.c:gatt_debug() Read By Grp Type - start:
> > 0x00bb end: 0xffff
> > bluetoothd[246]: src/device.c:gatt_debug() Read By Grp Type - start:
> > 0x0001 end: 0xffff
> > bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
> > 0x0001 end: 0x00ba
> > bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
> > 0x0001 end: 0x00ba
> > bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
> > 0x002a end: 0x00ba
> > bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
> > 0x0053 end: 0x00ba
> > bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
> > 0x007a end: 0x00ba
> > bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
> > 0x00a3 end: 0x00ba
> > bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
> > 0x00ba end: 0x00ba
> > bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
> > 0x0001 end: 0xffff
> > bluetoothd[246]: src/gatt-database.c:db_hash_read_cb() Database Hash re=
ad
> > =3D=3D246=3D=3D Invalid read of size 1
> > =3D=3D246=3D=3D    at 0x4831BA4: memcpy (vg_replace_strmem.c:1035)
> > =3D=3D246=3D=3D    by 0x87F3B: read_by_type_read_complete_cb (gatt-serv=
er.c:392)
> > =3D=3D246=3D=3D    by 0x892AB: pending_read_result (gatt-db.c:145)
> > =3D=3D246=3D=3D    by 0x8B2FB: gatt_db_attribute_read_result (gatt-db.c=
:1866)
> > =3D=3D246=3D=3D    by 0x3AB0B: db_hash_read_cb (gatt-database.c:1156)
> > =3D=3D246=3D=3D    by 0x8B1AB: gatt_db_attribute_read (gatt-db.c:1825)
> > =3D=3D246=3D=3D    by 0x87DB7: process_read_by_type (gatt-server.c:482)
> > =3D=3D246=3D=3D    by 0x8854F: read_by_type_cb (gatt-server.c:559)
> > =3D=3D246=3D=3D    by 0x81727: handle_notify (att.c:966)
> > =3D=3D246=3D=3D    by 0x81873: can_read_data (att.c:1057)
> > =3D=3D246=3D=3D    by 0x8B91B: watch_callback (io-glib.c:170)
> > =3D=3D246=3D=3D    by 0x488A413: g_main_context_dispatch (in
> > /usr/lib/libglib-2.0.so.0.5600.3)
> > =3D=3D246=3D=3D  Address 0x0 is not stack'd, malloc'd or (recently) fre=
e'd
> > =3D=3D246=3D=3D
> > =3D=3D246=3D=3D
> > =3D=3D246=3D=3D Process terminating with default action of signal 11 (S=
IGSEGV)
> > =3D=3D246=3D=3D  Access not within mapped region at address 0x0
> > =3D=3D246=3D=3D    at 0x4831BA4: memcpy (vg_replace_strmem.c:1035)
> > =3D=3D246=3D=3D    by 0x87F3B: read_by_type_read_complete_cb (gatt-serv=
er.c:392)
> > =3D=3D246=3D=3D    by 0x892AB: pending_read_result (gatt-db.c:145)
> > =3D=3D246=3D=3D    by 0x8B2FB: gatt_db_attribute_read_result (gatt-db.c=
:1866)
> > =3D=3D246=3D=3D    by 0x3AB0B: db_hash_read_cb (gatt-database.c:1156)
> > =3D=3D246=3D=3D    by 0x8B1AB: gatt_db_attribute_read (gatt-db.c:1825)
> > =3D=3D246=3D=3D    by 0x87DB7: process_read_by_type (gatt-server.c:482)
> > =3D=3D246=3D=3D    by 0x8854F: read_by_type_cb (gatt-server.c:559)
> > =3D=3D246=3D=3D    by 0x81727: handle_notify (att.c:966)
> > =3D=3D246=3D=3D    by 0x81873: can_read_data (att.c:1057)
> > =3D=3D246=3D=3D    by 0x8B91B: watch_callback (io-glib.c:170)
> > =3D=3D246=3D=3D    by 0x488A413: g_main_context_dispatch (in
> > /usr/lib/libglib-2.0.so.0.5600.3)
> > =3D=3D246=3D=3D  If you believe this happened as a result of a stack
> > =3D=3D246=3D=3D  overflow in your program's main thread (unlikely but
> > =3D=3D246=3D=3D  possible), you can try to increase the size of the
> > =3D=3D246=3D=3D  main thread stack using the --main-stacksize=3D flag.
> > =3D=3D246=3D=3D  The main thread stack size used in this run was 838860=
8.
> > /usr/bin/bluetoothd: can't resolve symbol '__libc_freeres'
> >
> > is it the crypto error that you expect?
> > Could you share a sha1 commit or a link to the patch to test the potent=
ial fix?
>
> Ive just pushed the fix:
>
> commit 41a5413023fa85bc711d461eb736a0624542df2d
> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Date:   Wed Jun 3 10:31:59 2020 -0700
>
>     gatt: Fix possible crash when unable to generate hash
>
>
> --
> Luiz Augusto von Dentz



--=20
- Arthur LAMBERT
