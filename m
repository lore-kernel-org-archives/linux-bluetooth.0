Return-Path: <SRS0=zLyx=BB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC4CC433EB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jul 2020 08:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9462120674
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jul 2020 08:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onzlud5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbgGVIcq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730308AbgGVIcp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jul 2020 04:32:45 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C10C0619DC
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2020 01:32:45 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h22so1561888lji.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2020 01:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=IMVVJQQuxuEV0PUj8MxtntHQHgLdO4Fa98kN1mhXpqs=;
        b=onzlud5VX/igA7rZHiE3FOxPFG/rs9p6WvI+ksOXg876vfHHljJQzKnjQ5ysI2ZS2y
         reyGRYdFKcd0aGuAebfqlSnCjiq1M5DTds3AmonOQjPpF3SCoNZdWMXyr9R15jncfL5j
         2cD9zgwtI6yzL20ZkBHbwbBndtznr21Nef9AMzFfaKRn1DU1Gggwi+5Am5pcoWbi1h9p
         Qu+RxGM+eJdXNSKBEzWS3ZXLQ3p5Fwi+sk8yRriggD8xc8qI0oi0S+AZBusuCN39Q/aQ
         Nj8EzHvhy1+dOC86TSHrnaDRqiPL2LtwfF3qlA5NzWe9BO6CIHKN+K5KWunAUdZw/Puo
         qg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=IMVVJQQuxuEV0PUj8MxtntHQHgLdO4Fa98kN1mhXpqs=;
        b=Bq23M18tVk7VmhDmzlwjtXYgeqUAYaczWsqhftSG05H6c9pi+ick6jlvFidfi78duM
         95ceG5Zq1CTN2PmAHGGyoqpvrmAhsfGj3RLRC6wz05lehNXypIcUyPWYQEWEprpNk1Vf
         /9MsBZ701Spvudsj6O2k7kT9W23+P77RfHlGsdxmryulPrsz+Vi+JS54UEqeYfwrJMQ4
         woeXDZAcymny/9FnsRmio+B+qGI5ZlhpFiV9TzU9MQU9t9mIr7ITtHpMgkvCLpqUyxy/
         oAnleDdlULecnmkDObeDGNTnw8sbyb1Wur4XPiNrzbiT9u25b3S+lv6UvhK5YoEl1rqx
         2XlQ==
X-Gm-Message-State: AOAM532zxpnxVLKu/cCM91P5nCWxbjoG4MnyvDErJlPhT8gVEIcwVpIP
        AsAi2LhMMceQiZT60VtyNYssfSsYBbOVipFbCBGAY+RsGL0=
X-Google-Smtp-Source: ABdhPJymKqHSvC96L7W6mkTFM2zTw6gldpTrylO/EzhIHxk6+O3M7C0IzjrQgYTkUMxHyIA3SnYb704exkfgDnBaSeg=
X-Received: by 2002:a05:651c:8c:: with SMTP id 12mr13432655ljq.420.1595406762356;
 Wed, 22 Jul 2020 01:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAAu3APZ_SqZniWRsp68cKtnjUoP2u3Sx8j2esDDj7cM65rksEw@mail.gmail.com>
 <CABBYNZLW=wDistFCgtKxBid4jxSV2zACLZDrT2fMz6UZTkzohg@mail.gmail.com>
In-Reply-To: <CABBYNZLW=wDistFCgtKxBid4jxSV2zACLZDrT2fMz6UZTkzohg@mail.gmail.com>
From:   Barry Byford <31baz66@gmail.com>
Date:   Wed, 22 Jul 2020 09:32:30 +0100
Message-ID: <CAAu3APZSMGGqPh6+kmMx0z_Cim4CTeHktaV8vb+fNuy=GW1TBg@mail.gmail.com>
Subject: Re: Networking - NetworkServer1
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thanks for the quick response. Very much appreciated.

On Wed, 22 Jul 2020 at 00:27, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> > =3D bluetoothd: bnep: Can't add bnep0 to the bridge tether: No such
> > device(19)                     21:54:01.138304
>
> Well it looks like the bridge (tether) does not exist so we can't add
> the bnep interface, perhaps the idea is not to have it attached to any
> bridge in case of GN, PAN and just bring the interface up when an
> empty string is given as bridge.
>
An empty string also produced the error.

However, I created a bridge using the bridge utilities package
$ sudo apt install bridge-utils
$ sudo brctl addbr bluez

And then used
server.Register('panu', 'bluez')

This enabled the connection to be accepted from the client to happen
without error.

$ service bluetooth status
=E2=97=8F bluetooth.service - Bluetooth service
   Loaded: loaded (/lib/systemd/system/bluetooth.service; enabled;
vendor preset: enabled)
   Active: active (running) since Tue 2020-07-21 09:27:49 BST; 24h ago
     Docs: man:bluetoothd(8)
 Main PID: 625 (bluetoothd)
   Status: "Running"
    Tasks: 1 (limit: 2200)
   Memory: 3.3M
   CGroup: /system.slice/bluetooth.service
           =E2=94=94=E2=94=80625 /usr/lib/bluetooth/bluetoothd --experiment=
al

Jul 22 07:27:43 raspberrypi bluetoothd[625]: bnep: bridge bluez:
interface bnep0 added



I think the bridge probably needs more refinement as there does not
appear to be a route between the two devices still.

Any pointers on that appreciated.

Thanks again for your help on this Luiz.

Regards,
Barry


$ brctl show
bridge name     bridge id               STP enabled     interfaces
bluez           8000.b827eb2257e0       no              bnep0

$ brctl showstp bluez
bluez
 bridge id              8000.b827eb2257e0
 designated root        8000.b827eb2257e0
 root port                 0                    path cost                  =
0
 max age                  20.00                 bridge max age            2=
0.00
 hello time                2.00                 bridge hello time          =
2.00
 forward delay            15.00                 bridge forward delay      1=
5.00
 ageing time             300.00
 hello timer               0.00                 tcn timer                  =
0.00
 topology change timer     0.00                 gc timer                   =
0.00
 flags


bnep0 (1)
 port id                8001                    state                  disa=
bled
 designated root        8000.b827eb2257e0       path cost                10=
0
 designated bridge      8000.b827eb2257e0       message age timer          =
0.00
 designated port        8001                    forward delay timer        =
0.00
 designated cost           0                    hold timer                 =
0.00
 flags

$ ifconfig bluez
bluez: flags=3D4098<BROADCAST,MULTICAST>  mtu 1500
        ether b8:27:eb:22:57:e0  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

$ ifconfig bnep0
bnep0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 169.254.91.109  netmask 255.255.0.0  broadcast 169.254.255.255
        inet6 fe80::ba27:ebff:fe22:57e0  prefixlen 64  scopeid 0x20<link>
        inet6 fe80::64d6:60a1:4a0d:3e4  prefixlen 64  scopeid 0x20<link>
        ether b8:27:eb:22:57:e0  txqueuelen 1000  (Ethernet)
        RX packets 111  bytes 20669 (20.1 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 57  bytes 16084 (15.7 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

$ route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Ifa=
ce
0.0.0.0         192.168.1.254   0.0.0.0         UG    202    0        0 eth=
0
169.254.0.0     0.0.0.0         255.255.0.0     U     233    0        0 bne=
p0
192.168.1.0     0.0.0.0         255.255.255.0   U     202    0        0 eth=
0
