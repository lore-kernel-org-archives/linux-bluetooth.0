Return-Path: <SRS0=V72R=7W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCCDC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 12:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E62F9206A4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 12:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtYIrzwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgFIMMl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Jun 2020 08:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgFIMMk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Jun 2020 08:12:40 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C92C05BD1E
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2020 05:12:40 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id ec10so9936703qvb.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2020 05:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=71dUmFCQdLK5II4ryq3e6addoMvW8a160wSO+bZd9bQ=;
        b=YtYIrzwOVWpQD0AdlyHCXjBwMylGwLYtDpxQFOQShf1HTrBVbYuT9RSfZmW6gHuuqL
         N+ZdplZ5ztOmBMfyhACdu49+YXiH5SGDs9qsPw6ZSjmqS/4IpkWf90i67igbBiN3TKCg
         coT1rHHFdWi7/DlykfFHberLNnC03wTNBtUEnsdziLmCFYFN8ibxMAaB6FGagkzqs2TC
         nHQmIBRRe0c63KRIWzKzimP6oA8xC6AaSMhTMCcPNjDNt4UYmeeq7SdzLvBfdUxpbykH
         sVZFlt3ImbBNsl77seXYNCNI12hTPSh0ZIRY1+Gbfg6eZq8pDvhczECnhOJEu7KjhBge
         flHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=71dUmFCQdLK5II4ryq3e6addoMvW8a160wSO+bZd9bQ=;
        b=fdMm8VWYSk3hL2Wk7jQaVgfDF3M53Uytg3aU1QcQNfq7Ov2aymKN8VcBPi81CDoF1K
         EvFu4R6tyYvrqJr9xI7uywOvCL5Vi45gqmNYHwHcH4xhzVACd5Dkji0XWgQTwO9RlAUt
         RLFdoB3AD2zQzTi2OvvBR/OJzE4bSvljcBPAu1kPCAFbGiUPbmKvLEeTIXo0p280i9kV
         6qoOCU16hr6HxHV/bkV3PiLVOceLfCT8Zs4I8BtZJrXFBtv7hSWpjjL1GG75RR/w6A+r
         lrnIw5E2l7vg71BbVdejccfmxUoTNv9M+CcgGkQvus/yNfJrtMbjTn9+gUyeQbj/D1OX
         Q95g==
X-Gm-Message-State: AOAM532rhedGifuwWBdqbrCYX5v8T2xCMRZaPyUtgRXickWtc8xJSIsu
        pj8+lj9ac1+vn7wQ86XRUoU1Te752IGCnlbicmg=
X-Google-Smtp-Source: ABdhPJzgb1TjBEQyEb23MMW8P3hBouAee+kYSngy+6tbo07jPFCQanjsY7Xl9zvJzWr5LjrQXenKTbmlPcLEgVp0h8E=
X-Received: by 2002:a05:6214:1333:: with SMTP id c19mr3570233qvv.72.1591704759308;
 Tue, 09 Jun 2020 05:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAGpqJgrBtwdauxv03jXsq+8+EG_BW-4QZXryXt-e5Y8HA_5+_g@mail.gmail.com>
 <CABBYNZLLx+zX_XyNjkW99D7HG_6+eZM_MP7EWVVAuuRtf0J6dw@mail.gmail.com>
 <CABBYNZJxVsnGtpnJkCCQtQFKXOiSEV7490me1vjAOOGynCdfUw@mail.gmail.com>
 <CAGpqJgrcxd0iwWUu=VB=MhiSS9+TRMLLsyTjbwQMdJ+6u66u6Q@mail.gmail.com>
 <CABBYNZKTQzEuBpP3YG7=Ms6c-36mnR7qAc4A1XDOLfggDPXXCA@mail.gmail.com> <CAGpqJgraPcsGkoNdzG94JTqwxVaMxUBKtVpNfyvBkuy7TWW_sA@mail.gmail.com>
In-Reply-To: <CAGpqJgraPcsGkoNdzG94JTqwxVaMxUBKtVpNfyvBkuy7TWW_sA@mail.gmail.com>
From:   Arthur Lambert <lambertarthur22@gmail.com>
Date:   Tue, 9 Jun 2020 14:12:27 +0200
Message-ID: <CAGpqJgoYaqGfwQ+j1S2dnoYGk04fZSDcOaZ4=2vmM2W7ceFjhA@mail.gmail.com>
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

I have 25 devices running with bluez 5.54 + the fix that you push. I
have always segmentation fault but not very frequently. I have a demon
which is checking that Bluetoothd is always alive. The check is
running every minute.
Two times, my watchdog was able to detect the Bluetoothd was not
running anymore. In both case it was just after a disconnect. But I
dont know if the disconnect is triggered by
the crash on bluetoothd or if the crash happened just after

I cannot reproduce it in a deterministic way. I cannot deploy valgrind
on all device of course. Is there another way to share with you data
to help you to fix/understand the issue?

Arthur.

Le jeu. 4 juin 2020 =C3=A0 10:15, Arthur Lambert
<lambertarthur22@gmail.com> a =C3=A9crit :
>
> Hi Luiz,
>
> I just test your fix! It is working perfectly \o/.
>
> I will probably add a kind of watchdog to check that Bluetoothd is
> always alive on my device to reset
> it in case of failure just in case.
>
> Is it possible that this crash happened when a mobile app tried to
> connect to my embedded device?
> Or is it possible that this issue impacts the cache service/charac
> feature? I am not sure to fully
> understand the perimeter of the issue.
> We have a problem with the cache update for a few weeks. Basically the
> problem is that mobile app is
> doing request on bad characteristics after firmware update with new
> characteristic available.
> The problem was already present but very very rare. On my last
> firmware update, it is more frequent.
> It is like the mobile app is using the old UUID mapping. The issue
> happened after Bluez update from 5.52
> to 5.54. But we are not sure that the issue is related to Bluez. It
> can also be related to the phone.
> It is weird also because the issue happened only with Android and IOS
> is just fine.
>
> Thank you for your quick fix and reply!
>
>
> Le mer. 3 juin 2020 =C3=A0 23:06, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> a =C3=A9crit :
> >
> > Hi Arthur,
> >
> > On Wed, Jun 3, 2020 at 11:22 AM Arthur Lambert
> > <lambertarthur22@gmail.com> wrote:
> > >
> > > Hi Luiz,
> > > thanks for your reply!
> > >
> > > Sorry I am lazy and stupid. I know that your next question will be
> > > around symbol...
> > >
> > > After removing the binary strip option and enable debug symbol :
> > >
> > > bluetoothd[246]: src/device.c:device_svc_resolved()
> > > /org/bluez/hci0/dev_80_32_53_37_58_A6 err -5
> > > bluetoothd[246]: src/device.c:gatt_debug() Read By Grp Type - start:
> > > 0x00bb end: 0xffff
> > > bluetoothd[246]: src/device.c:gatt_debug() Read By Grp Type - start:
> > > 0x0001 end: 0xffff
> > > bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
> > > 0x0001 end: 0x00ba
> > > bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
> > > 0x0001 end: 0x00ba
> > > bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
> > > 0x002a end: 0x00ba
> > > bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
> > > 0x0053 end: 0x00ba
> > > bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
> > > 0x007a end: 0x00ba
> > > bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
> > > 0x00a3 end: 0x00ba
> > > bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
> > > 0x00ba end: 0x00ba
> > > bluetoothd[246]: src/device.c:gatt_debug() Read By Type - start:
> > > 0x0001 end: 0xffff
> > > bluetoothd[246]: src/gatt-database.c:db_hash_read_cb() Database Hash =
read
> > > =3D=3D246=3D=3D Invalid read of size 1
> > > =3D=3D246=3D=3D    at 0x4831BA4: memcpy (vg_replace_strmem.c:1035)
> > > =3D=3D246=3D=3D    by 0x87F3B: read_by_type_read_complete_cb (gatt-se=
rver.c:392)
> > > =3D=3D246=3D=3D    by 0x892AB: pending_read_result (gatt-db.c:145)
> > > =3D=3D246=3D=3D    by 0x8B2FB: gatt_db_attribute_read_result (gatt-db=
.c:1866)
> > > =3D=3D246=3D=3D    by 0x3AB0B: db_hash_read_cb (gatt-database.c:1156)
> > > =3D=3D246=3D=3D    by 0x8B1AB: gatt_db_attribute_read (gatt-db.c:1825=
)
> > > =3D=3D246=3D=3D    by 0x87DB7: process_read_by_type (gatt-server.c:48=
2)
> > > =3D=3D246=3D=3D    by 0x8854F: read_by_type_cb (gatt-server.c:559)
> > > =3D=3D246=3D=3D    by 0x81727: handle_notify (att.c:966)
> > > =3D=3D246=3D=3D    by 0x81873: can_read_data (att.c:1057)
> > > =3D=3D246=3D=3D    by 0x8B91B: watch_callback (io-glib.c:170)
> > > =3D=3D246=3D=3D    by 0x488A413: g_main_context_dispatch (in
> > > /usr/lib/libglib-2.0.so.0.5600.3)
> > > =3D=3D246=3D=3D  Address 0x0 is not stack'd, malloc'd or (recently) f=
ree'd
> > > =3D=3D246=3D=3D
> > > =3D=3D246=3D=3D
> > > =3D=3D246=3D=3D Process terminating with default action of signal 11 =
(SIGSEGV)
> > > =3D=3D246=3D=3D  Access not within mapped region at address 0x0
> > > =3D=3D246=3D=3D    at 0x4831BA4: memcpy (vg_replace_strmem.c:1035)
> > > =3D=3D246=3D=3D    by 0x87F3B: read_by_type_read_complete_cb (gatt-se=
rver.c:392)
> > > =3D=3D246=3D=3D    by 0x892AB: pending_read_result (gatt-db.c:145)
> > > =3D=3D246=3D=3D    by 0x8B2FB: gatt_db_attribute_read_result (gatt-db=
.c:1866)
> > > =3D=3D246=3D=3D    by 0x3AB0B: db_hash_read_cb (gatt-database.c:1156)
> > > =3D=3D246=3D=3D    by 0x8B1AB: gatt_db_attribute_read (gatt-db.c:1825=
)
> > > =3D=3D246=3D=3D    by 0x87DB7: process_read_by_type (gatt-server.c:48=
2)
> > > =3D=3D246=3D=3D    by 0x8854F: read_by_type_cb (gatt-server.c:559)
> > > =3D=3D246=3D=3D    by 0x81727: handle_notify (att.c:966)
> > > =3D=3D246=3D=3D    by 0x81873: can_read_data (att.c:1057)
> > > =3D=3D246=3D=3D    by 0x8B91B: watch_callback (io-glib.c:170)
> > > =3D=3D246=3D=3D    by 0x488A413: g_main_context_dispatch (in
> > > /usr/lib/libglib-2.0.so.0.5600.3)
> > > =3D=3D246=3D=3D  If you believe this happened as a result of a stack
> > > =3D=3D246=3D=3D  overflow in your program's main thread (unlikely but
> > > =3D=3D246=3D=3D  possible), you can try to increase the size of the
> > > =3D=3D246=3D=3D  main thread stack using the --main-stacksize=3D flag=
.
> > > =3D=3D246=3D=3D  The main thread stack size used in this run was 8388=
608.
> > > /usr/bin/bluetoothd: can't resolve symbol '__libc_freeres'
> > >
> > > is it the crypto error that you expect?
> > > Could you share a sha1 commit or a link to the patch to test the pote=
ntial fix?
> >
> > Ive just pushed the fix:
> >
> > commit 41a5413023fa85bc711d461eb736a0624542df2d
> > Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > Date:   Wed Jun 3 10:31:59 2020 -0700
> >
> >     gatt: Fix possible crash when unable to generate hash
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
>
> --
> - Arthur LAMBERT



--=20
- Arthur LAMBERT
