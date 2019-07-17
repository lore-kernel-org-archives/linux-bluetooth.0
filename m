Return-Path: <SRS0=OoMZ=VO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1493C76186
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 09:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69F52077C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 09:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="l3lq6ZFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfGQJ0G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jul 2019 05:26:06 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:40713 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfGQJ0G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jul 2019 05:26:06 -0400
Received: by mail-lj1-f171.google.com with SMTP id m8so22877737lji.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jul 2019 02:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EKfthPEQeRtjy8fRdyEEF4k2CR1tHydze9NEwECC2Po=;
        b=l3lq6ZFfKFTRJuleWANfivElFdlT+IkwuP/Z85aPgjuxLZMG5QS9IsiI7VH6Bht5Rt
         YTm5dN8rFmMmVcc+9zUHBuNUZqbCk6c+Ch3JIcw6lghGhOv71+3ut8AG3/5Cj7sA0E+c
         OCnIwjX6NJJVTfy2TKhel1OiygzuaIRFjb2xtuIfSljmOcH3OI0O9ZRYqe3ZaeMNTO4/
         MDCdIcKDDF/brToQxRYzOOsY03swFMxQG3R7szFDnHCA5QoPXbrbYAz+guLpKx2qwx+Z
         3nNI8v9QyGgLP4DRmoBYqDmVKoAdbWIeoOcTqOIu7nu7213w1c84FFWhiUflFTuuxMTW
         RKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EKfthPEQeRtjy8fRdyEEF4k2CR1tHydze9NEwECC2Po=;
        b=kpe0w98V38SnvqW8QMteWK+jQG6O6q+pwORL7e8QwPOgvOp+Sv0a7WxIsFa/MUqVXE
         Yks/t0fZ4q9Fnwql+e4joGh5Zd0Ja7k/EQW2sXTX+sReH9sKh7Kj0jP8yr9QqnzrMEiR
         ZrchPKPExHqXCITJs/P8R01gRICUx4JDSfz2ijr4H3eXuwmT55Ijb8ioEUFpGttb0vYS
         wjwVI43ecezOzweY9G+Hp3r1YYYunxOEy3PwKvNM9p6iMt9XER6u1noDSQSCyDHgvW+3
         KA38JN3v3rn2TrwHQ49cFQbw1w6KXW/am3WTFmXM9q00hUKj3oGMUjRfajUzKqwS02Lz
         NRhQ==
X-Gm-Message-State: APjAAAVbBb9yGWLJT/UZltsrJ/81mKBmla+Ezsue8Eo1ZOYRSodEV20B
        12FY9wQGDF5x2zQidTLsY1WG6a79IeA=
X-Google-Smtp-Source: APXvYqwmHQROFrX0OSAwHhVv2wbLMVzGyjGHqNGzKYDwPK+pnP50IMHc4P/Q8XafJbOeE4QisRZ5wQ==
X-Received: by 2002:a2e:b047:: with SMTP id d7mr20816651ljl.8.1563355563756;
        Wed, 17 Jul 2019 02:26:03 -0700 (PDT)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id g5sm4383554ljj.69.2019.07.17.02.26.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 02:26:03 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: bluetoothctl: list-attributes doesn't list services from example-gatt-server
Date:   Wed, 17 Jul 2019 11:26:01 +0200
Message-ID: <16286916.LhmCvT1dVb@ix>
Organization: CODECOUP
In-Reply-To: <c08604d7-5708-ed37-9e55-93e67e06a3da@gmail.com>
References: <c6e32190-c23d-2311-10f0-b5dcd58784bf@gmail.com> <c08604d7-5708-ed37-9e55-93e67e06a3da@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Rafa=C5=82,

On Tuesday, 9 July 2019 14:14:07 CEST Rafa=C5=82 Mi=C5=82ecki wrote:
> On 07.07.2019 12:14, Rafa=C5=82 Mi=C5=82ecki wrote:
> > I decided to test GATT. On elitebook I started:
> > ./test/example-gatt-server
> > and waited to let matebook refresh all info.
> >=20
> > After that I got:
> >=20
> > [elitebook]# info 20:16:B9:D8:A9:3B
> > Device 20:16:B9:D8:A9:3B (public)
> >=20
> >          Name: elitebook
> >          Alias: elitebook
> >          Class: 0x001c010c
> >          Icon: computer
> >          Paired: yes
> >          Trusted: yes
> >          Blocked: no
> >          Connected: yes
> >          LegacyPairing: no
> >          UUID: IrMC Sync               =20
> >  (00001104-0000-1000-8000-00805f9b34fb) UUID: OBEX Object Push        =
=20
> >  (00001105-0000-1000-8000-00805f9b34fb) UUID: OBEX File Transfer      =
=20
> >  (00001106-0000-1000-8000-00805f9b34fb) UUID: Headset                 =
=20
> >  (00001108-0000-1000-8000-00805f9b34fb) UUID: Audio Source            =
=20
> >  (0000110a-0000-1000-8000-00805f9b34fb) UUID: Audio Sink              =
=20
> >  (0000110b-0000-1000-8000-00805f9b34fb) UUID: A/V Remote Control Target
> >  (0000110c-0000-1000-8000-00805f9b34fb) UUID: A/V Remote Control      =
=20
> >  (0000110e-0000-1000-8000-00805f9b34fb) UUID: Headset AG              =
=20
> >  (00001112-0000-1000-8000-00805f9b34fb) UUID: Phonebook Access Server =
=20
> >  (0000112f-0000-1000-8000-00805f9b34fb) UUID: Message Access Server   =
=20
> >  (00001132-0000-1000-8000-00805f9b34fb) UUID: Message Notification Se..
> >  (00001133-0000-1000-8000-00805f9b34fb) UUID: PnP Information         =
=20
> >  (00001200-0000-1000-8000-00805f9b34fb) UUID: Heart Rate              =
=20
> >  (0000180d-0000-1000-8000-00805f9b34fb) UUID: Battery Service         =
=20
> >  (0000180f-0000-1000-8000-00805f9b34fb) UUID: Vendor specific         =
=20
> >  (00005005-0000-1000-8000-0002ee000001) UUID: Vendor specific         =
=20
> >  (12345678-1234-5678-1234-56789abcdef0) Modalias: usb:v1D6Bp0246d0532
> >=20
> > That seems all correct for now. Test example-gatt-server registers
> > Heart Rate, Battery & Test services. All of them appeared as expected.
> >=20
> > My problem is that I can't list GATT attributes. I don't any output.
> > Is there anything I'm doing incorrectly?
>=20
> I decided to test nRF Connect Android app. It showed something
> interesting about my bluetooth devices. It nicely displays & parses
> advertising data.
>=20
> Logitech M590 advertises:
> 0x01 Flags
> 0x03 Complete List of 16-bit Service Class UUIDs
> 0x09 Complete Local Name
> 0x0A Tx Power Level
> 0x19 Appearance
>=20
> BlueZ on "elitebook" advertises:
> 0xFF Manufacturer Specific Data
> or to say precisely:
> 0x1BFF750042040180AE78BDBC0B7E307ABDBC0B7E2F01000000000000
>=20
> Any idea/hint why BlueZ 5.30 on my "elitebook" notebook doesn't
> advertise more data?

Just to be sure, are you using 5.30? If so, update to 5.50..

=2D-=20
pozdrawiam
Szymon Janc


