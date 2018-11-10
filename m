Return-Path: <SRS0=nRr/=NV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12708C43441
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Nov 2018 18:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB23720892
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Nov 2018 18:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOUVf032"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB23720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbeKKEP3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 10 Nov 2018 23:15:29 -0500
Received: from mail-it1-f177.google.com ([209.85.166.177]:35071 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeKKEP3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 10 Nov 2018 23:15:29 -0500
Received: by mail-it1-f177.google.com with SMTP id v11so8048235itj.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Nov 2018 10:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bDUKUlRfppojjx5PiwwGO3w01zSueHNm50cwhAaKB1c=;
        b=gOUVf032Z8nslkVai80VFMS2fMPIu897CSfMIJvNLpLbd/bkJwmzHYsb5PunXHupU3
         YPJRESUEKKai9Zrfqn3IsUH2T3OwUgy9FUYdVTRohdImpX0CbKvghM7EsZ/dowqZWiQA
         M03nGEbCeEEOs0yrK2Dp1B8yS1VwzOhkA+mC+I3L1sTtu3InF46O4QJoSWVXuUCFJ1r+
         Z5D4ct2pGXSm4tFynX39LF9nGkwc6LVGtefnmPTriyOt0PwPWJhMrdlKJEWRjHhb80Tz
         XSYXuQXZl2NIWMlgcuJ2ie0Oxys1MbtL84tBjWWJLoEdMuStOatpy3COHKrtYR2K0fpf
         qQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bDUKUlRfppojjx5PiwwGO3w01zSueHNm50cwhAaKB1c=;
        b=KBv48cmarVNCu/qBgP3a9CM8Ix+BZtsGDQ54zgDwyzCxLtHDJ7ZlS4NBW9gSnyd1qr
         zwKxw/CciF2208ZIsswfdu5CUGE8/YRl0hBuKoXz28QVXSBZ0mg2q7IoTRnsGauwvjzq
         HFkOBLyBalragrv2wSrDLHAqw4L3lSuKZORRoaM1PLbB4u5Bm3SOf8Tftbmnv+q/aTgg
         kYqh+WrBL36OBkFQnvjbN5ug8alor/0I8NO1J9ByBLuXXt0a9c+q5ASq6GyNcC7xwyNc
         c9SV33Dng5718tL/1bEfrDXNfbwVzmfx69DLYcTpC15eilprr6+Nhxj0u4dG/Js4V3s0
         +JxA==
X-Gm-Message-State: AGRZ1gKFDoD1FZXt2uLVyJaJS5KNOujEUi4P4kinjXUyc8nYVmQemySN
        C5HhPk6dMuoz5OtfHY4McRkBEwCITpwgMHGb/sv8vy95
X-Google-Smtp-Source: AJdET5fcO2CGQBoL3Ki8vXo8m7DuIj1VgL5C/Hi1Rq8+jUdJVBRff41SJi2eqiRMJz0jiUWnL2+lknK4SwvdgqcV3dk=
X-Received: by 2002:a24:d42:: with SMTP id 63-v6mr6419002itx.91.1541874573418;
 Sat, 10 Nov 2018 10:29:33 -0800 (PST)
MIME-Version: 1.0
References: <CABatt_x1aNftgFVuDxrhyZVs4bGmOZFccjPKU_BpfbGmMWTazA@mail.gmail.com>
 <CABatt_zHbVz+cbb6Vig820W5bdXd+Cd1Jjh02MdqnBiX0WQuEg@mail.gmail.com> <CABBYNZJ0uT-qX2njVfFan2vVWaEveDR+waOC3FSZrTfpaBkHew@mail.gmail.com>
In-Reply-To: <CABBYNZJ0uT-qX2njVfFan2vVWaEveDR+waOC3FSZrTfpaBkHew@mail.gmail.com>
From:   Martin Townsend <mtownsend1973@gmail.com>
Date:   Sat, 10 Nov 2018 18:29:22 +0000
Message-ID: <CABatt_wSMSiW+Fmi5cccAnejMbAAHdNWb-jW0qLcijtdWETHzw@mail.gmail.com>
Subject: Re: Operating central and peripheral roles concurrently
To:     luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
On Sat, Nov 10, 2018 at 6:03 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Martin,
> On Fri, Nov 9, 2018 at 7:57 PM Martin Townsend <mtownsend1973@gmail.com> wrote:
> >
> > On Fri, Nov 9, 2018 at 4:32 PM Martin Townsend <mtownsend1973@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > I see someone has already asked this question not long ago but I am
> > > seeing the same problem.  I have an embedded platform running 4.9
> > > kernel and Bluez 5.50 and the bluetooth device is the BroadCom
> > > BCM4343W which supports bluetooth 4.1.
> > >
> > > I can run the btgatt-server and example-gatt-server fine and connect
> > > to it from my phone using nRF and read the relevant attributes.  This
> > > I believe is where my device is in the peripheral role.  If I close
> > > the GATT server down I can use gatttool to query the characteristics
> > > of another GATT server setup on my PC, I think this is then acting as
> > > central role.
> > >
> > > But if I can't do both at the same time, once the GATT server is
> > > running and I try and query the other GATT server, I get
> > > root@mach-cw-rnet-ppm-1717:~# gatttool -b 5D:3C:72:B5:23:BE -t random
> > > --characteristics
> > > connect error: Connection refused (111)
> > >
> > > I've noticed that if I start bluetoothctl whilst the GATT server is
> > > running it looks as if it has connected to my phone
> > >
> > > root@mach-cw-rnet-ppm-1717:~# bluetoothctl
> > > Agent registered
> > > [LG K8 (2017)]#
> > >
> > > Maybe this is expected but it does look like it has made a connection
> > > back to the phone and I'm wondering if this is stopping it from acting
> > > in the central role?
> > >
> > > Not really knowing much about the bluetooth stack I was wondering if
> > > anyone has any pointers on how to debug this or let me know if I'm
> > > doing something wrong?  I'm quite comfortable putting debug code into
> > > the kernel and/or bluez5 and recompiling to get more information if
> > > required.
> > >
> > > Any help would be greatly appreciated,
> > > Martin.
> >
> > I turned on DEBUG for a few of the hci_.c files and here's the output
> > of the failed connect in case it helps
> >
> > These occur on connect from gatttool:
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: 00:00:00:00:00:00 ->
> > 7b:bd:e7:6a:8a:8d
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 orig refcnt 9
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: requesting refresh of dst_addr
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 dst 7b:bd:e7:6a:8a:8d
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 orig refcnt 10
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: addr 7b:bd:e7:6a:8a:8d (type 1)
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: addr 7b:bd:e7:6a:8a:8d
> > (type 1) auto_connect 5
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hcon 97310400 orig refcnt 0
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 hcon 97310400
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 cmd_cnt 1 cmd queued 2
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 type 1 len 10
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 Event packet
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200b
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: opcode 0x200b status 0x00
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200b
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 cmd_cnt 1 cmd queued 1
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 type 1 len 5
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 Event packet
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200c
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: opcode 0x200c status 0x00
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200c
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0
> > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 Event packet
> >
> >
> > Then just before Error: connect error: Connection refused (111) many
> > seconds later:
> > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hcon 97310400 state BT_CONNECT
> > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 hcon 97310400
> > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 orig refcnt 10
> > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 hcon 97310400
> > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: addr 7b:bd:e7:6a:8a:8d (type 1)
> > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hcon 97310400
> > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 hcon 97310400 chan 97421c80
> > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 orig refcnt 11
> > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 cmd_cnt 1 cmd queued 1
> > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 type 1 len 5
> > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 orig refcnt 10
> > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0
> > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 Event packet
> > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200c
> > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: opcode 0x200c status 0x00
> > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200c
>
> Not sure if it is exactly the same problem but you can try checking if
> the following like is causing the problem:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/hci_event.c#n5075
>
> So we cannot be both slave and central, or at least that is what the
> code suggests, though I think we should drop that line and leave the
> controller to fail if that is the case.
>
>
>
> --
> Luiz Augusto von Dentz

Thanks for replying, just to confirm that this maybe the code to take a look at

/* Most controller will fail if we try to create new connections
* while we have an existing one in slave role.
*/
if (hdev->conn_hash.le_num_slave > 0)
return NULL;

If so, I'll put some debug code around it and try disabling it to see
if it makes a difference.

Regards, Martin.
