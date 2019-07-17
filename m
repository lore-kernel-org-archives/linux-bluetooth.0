Return-Path: <SRS0=OoMZ=VO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91092C76186
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 09:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C0B20880
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 09:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="XqW3vZ1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfGQJoz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jul 2019 05:44:55 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:46774 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfGQJoy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jul 2019 05:44:54 -0400
Received: by mail-lf1-f53.google.com with SMTP id z15so11651211lfh.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jul 2019 02:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LGta1AgP4hZFp2pbGt4EFdudsKSBBjWXDst94UILPJM=;
        b=XqW3vZ1LojJ9jOhin+Prrsm06uuWe/GhkTnxjw60BhPEd4/nRPMYW0kwHOozoboJCL
         xLfjy6KHNqoflsK5uCbIJZ4aWTEHFrkyHCDC1zFP7pj6C6VboVYu4Qh+TjGQSVOQjQ1c
         zaRkCiU44rdhoxD2Rx2bhmnbBFbwH6EpeUD95zutEzFcNzSpJI0wuAQfB4JEXxFp3PP/
         bG1ET65V1/fFCJupEeovFxH+kPzn8aqVrLG50HzL8MP0YOr8cY8LpBVFPIIBPTRnkWHh
         uGyqEtwk7BdRcM4aSmkv2b9a+mZOsyYcEia0k5q1Lhp0jx5L1nkbpgr2htWtRJyBj1Q+
         288A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LGta1AgP4hZFp2pbGt4EFdudsKSBBjWXDst94UILPJM=;
        b=ulcEkgMEXMdPfoGiHE+pDwIb0GNkiOLR+JmjSLgweC/8EV9MvvqB3FdEs4dxuAep5f
         997U/yz6rIyzXOX9GHBc8kU+XDLP3Jb/ebVXKHji2q7I0tkeNA6Uc86RBz1hkCCvSCOz
         GzdKn9CkIojQSdZedV9tg9LC3oIy9nu6my4Y/7DkMBLZFoa0Isjq0CSxf+LHS2fQazsH
         IHRYofwIS9hTLPAGKNvCGwl5LbK1+fPf09BoJZMqnE431UoQmNBPRiac9l9dzSj9BCSm
         a7BOFpPsG+7e/QDrMdYcZx7Zr9Z7jKFAvrj/ezkiMbkVQOBbqffo7G1OoT4G3DkvHjyU
         oITQ==
X-Gm-Message-State: APjAAAWULP4LBdVHCqkNUrQUcywW/KnhFLpjXtcN/bsWOgk/nIPxnQEf
        6JisHkcDiPSv4+jls0Czzf5oAg==
X-Google-Smtp-Source: APXvYqxHJHMDoNrEj11+TTMZBTDrvtJ6AGugZO0zXqz0VHjktAD+agndIRKAO134B7XNhD7uHe8Emw==
X-Received: by 2002:ac2:596c:: with SMTP id h12mr17694598lfp.101.1563356692558;
        Wed, 17 Jul 2019 02:44:52 -0700 (PDT)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id t25sm3354350lfg.7.2019.07.17.02.44.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 02:44:52 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: bluetoothctl: list-attributes doesn't list services from example-gatt-server
Date:   Wed, 17 Jul 2019 11:44:51 +0200
Message-ID: <1815601.YRP3FTkMZ6@ix>
Organization: CODECOUP
In-Reply-To: <84f01445-74e2-5632-225a-02c369c53c07@gmail.com>
References: <c6e32190-c23d-2311-10f0-b5dcd58784bf@gmail.com> <c08604d7-5708-ed37-9e55-93e67e06a3da@gmail.com> <84f01445-74e2-5632-225a-02c369c53c07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wednesday, 17 July 2019 11:38:21 CEST Rafa=C5=82 Mi=C5=82ecki wrote:
> On 09.07.2019 14:14, Rafa=C5=82 Mi=C5=82ecki wrote:
> > On 07.07.2019 12:14, Rafa=C5=82 Mi=C5=82ecki wrote:
> >> I decided to test GATT. On elitebook I started:
> >> ./test/example-gatt-server
> >> and waited to let matebook refresh all info.
> >>=20
> >> After that I got:
> >>=20
> >> [elitebook]# info 20:16:B9:D8:A9:3B
> >> Device 20:16:B9:D8:A9:3B (public)
> >>          Name: elitebook
> >>          Alias: elitebook
> >>          Class: 0x001c010c
> >>          Icon: computer
> >>          Paired: yes
> >>          Trusted: yes
> >>          Blocked: no
> >>          Connected: yes
> >>          LegacyPairing: no
> >>          UUID: IrMC Sync               =20
> >> (00001104-0000-1000-8000-00805f9b34fb) UUID: OBEX Object Push        =
=20
> >> (00001105-0000-1000-8000-00805f9b34fb) UUID: OBEX File Transfer      =
=20
> >> (00001106-0000-1000-8000-00805f9b34fb) UUID: Headset                 =
=20
> >> (00001108-0000-1000-8000-00805f9b34fb) UUID: Audio Source            =
=20
> >> (0000110a-0000-1000-8000-00805f9b34fb) UUID: Audio Sink              =
=20
> >> (0000110b-0000-1000-8000-00805f9b34fb) UUID: A/V Remote Control Target
> >> (0000110c-0000-1000-8000-00805f9b34fb) UUID: A/V Remote Control      =
=20
> >> (0000110e-0000-1000-8000-00805f9b34fb) UUID: Headset AG              =
=20
> >> (00001112-0000-1000-8000-00805f9b34fb) UUID: Phonebook Access Server =
=20
> >> (0000112f-0000-1000-8000-00805f9b34fb) UUID: Message Access Server   =
=20
> >> (00001132-0000-1000-8000-00805f9b34fb) UUID: Message Notification Se..
> >> (00001133-0000-1000-8000-00805f9b34fb) UUID: PnP Information         =
=20
> >> (00001200-0000-1000-8000-00805f9b34fb) UUID: Heart Rate              =
=20
> >> (0000180d-0000-1000-8000-00805f9b34fb) UUID: Battery Service         =
=20
> >> (0000180f-0000-1000-8000-00805f9b34fb) UUID: Vendor specific         =
=20
> >> (00005005-0000-1000-8000-0002ee000001) UUID: Vendor specific         =
=20
> >> (12345678-1234-5678-1234-56789abcdef0) Modalias: usb:v1D6Bp0246d0532
> >>=20
> >> That seems all correct for now. Test example-gatt-server registers
> >> Heart Rate, Battery & Test services. All of them appeared as expected.
> >>=20
> >> My problem is that I can't list GATT attributes. I don't any output.
> >> Is there anything I'm doing incorrectly?
> >=20
> > I decided to test nRF Connect Android app. It showed something
> > interesting about my bluetooth devices. It nicely displays & parses
> > advertising data.
> >=20
> > Logitech M590 advertises:
> > 0x01 Flags
> > 0x03 Complete List of 16-bit Service Class UUIDs
> > 0x09 Complete Local Name
> > 0x0A Tx Power Level
> > 0x19 Appearance
> >=20
> > BlueZ on "elitebook" advertises:
> > 0xFF Manufacturer Specific Data
> > or to say precisely:
> > 0x1BFF750042040180AE78BDBC0B7E307ABDBC0B7E2F01000000000000
> >=20
> > Any idea/hint why BlueZ 5.30 on my "elitebook" notebook doesn't
> > advertise more data?
>=20
> I've discovered I also need to run test/example-advertisement. Then I
> can see my notebook advertise UUIDs and characteristics. It seems that
> test/example-gatt-server is insufficient on its own.

Yeap, gatt-server is only for GATT. And advertisement has spearate API as=20
those are not necesserily used together.


=2D-=20
pozdrawiam
Szymon Janc


