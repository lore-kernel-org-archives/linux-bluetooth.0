Return-Path: <SRS0=9IM7=WP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AF7C3A5A0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Aug 2019 16:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBE020651
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Aug 2019 16:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="mk0s9Q+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfHSQIV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Aug 2019 12:08:21 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:55150 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfHSQIV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Aug 2019 12:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=M8IGGelqJ9oCBv1s/6h8taTm9q5IfnPtn5/ZoqCg56Y=; b=mk0s9Q+pEl+0TtOk5b5Y6YjFvv
        yHqGZcR1u6Fmtqirq1CZMRPCQ5tQBh8sMgmIBA7nhLNxNwcV2bUE9ZH6+A8syGlpUkJi2ggN37abE
        LsH0sJddWSZQ/w6LTcEXmYLO9MoxfFFhOPMDTpvM5oi7en4dRGi3bWqNrARomt68SuAQ=;
Received: from p200300ccff07d0007ee9d3fffe1fa246.dip0.t-ipconnect.de ([2003:cc:ff07:d000:7ee9:d3ff:fe1f:a246] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1hzkCg-0003im-5d; Mon, 19 Aug 2019 18:08:19 +0200
Received: from [::1] (helo=localhost)
        by eeepc with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1hzkCd-00044d-Hh; Mon, 19 Aug 2019 18:08:15 +0200
Date:   Mon, 19 Aug 2019 18:08:13 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Carey Sonsino <csonsino@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/1] bluetooth: validate BLE connection interval updates
Message-ID: <20190819180813.04a8e771@kemnade.info>
In-Reply-To: <0cda8242-304e-a073-90d8-63e656e3600c@gmail.com>
References: <f9176553-d4d5-c2e0-ecd7-937cac0d8098@gmail.com>
        <138296C5-49FA-475D-9618-FC8D241B8823@holtmann.org>
        <20190815104419.161177fa@kemnade.info>
        <0cda8242-304e-a073-90d8-63e656e3600c@gmail.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Carey,

On Mon, 19 Aug 2019 07:58:19 -0600
Carey Sonsino <csonsino@gmail.com> wrote:

> This seems like the exact "downside" situation that I described in the=20
> patch writeup.
>=20
> I would still claim that as a Linux system administrator, I should have=20
> control over my system.=A0 If I am operating in a low power environment, =
I=20
> do not want to allow a remote device to apply a setting which causes me=20
> to use more power without any say in the matter.
>=20
In principle I agree here. High connection interval has its downsides,
low connection interval also. Just curios: What are the numbers about
power consumption here? A few mA? I have only compared these values on
peripherals running on low-power SoCs like e.g. the nrf stuff from nordic.
I see around 1 mA difference there with a power consumption besides of that=
=20
usually measured in the =B5A range. Never tested these things on a linux ma=
chine.

The point here is that with this patch there is insufficient control
about this. Yes, there is the debugfs interface.

But if you want to provide a driver to a gatt service living on top of
bluetoothd dbus api? Ask people to not use distribution kernels?
What options do you have?
using the monitor interface to sniff the connection handle and then
call hci_le_conn_update() to set things?

> The connection min/max interval settings are configuration options that=20
> control how my bluetooth device operates.=A0 Why are these down in debugf=
s=20
> anyway?=A0 I think that a much more appropriate fix would be to migrate=20
> some of the BLE configuration options to sysconfdir (some place like=20
> /etc/bluetooth/ble.conf).=A0 That would also help in the persistence of=20
> these configuration settings, which is kind of a pain with the debugfs=20
> mechanism that gets wiped out and recreated on bootup.
>=20
I think that these things should be part of the  dbus api provided
by bluetoothd so that a driver could decide and having defaults outside
of such a dark corner like the debug fs.

> A quicker fix would be to simply set the default connection min interval=
=20
> and connection max interval values to the full range (6, 3200).

Or just maybe a flag allowing such behavior?

> *think* that this could be done by simply updating the values in=20
> hci_core.c, the hci_alloc_dev() function:
>=20
>  =A0=A0=A0 hdev->le_conn_min_interval =3D 0x0018;
>  =A0=A0=A0 hdev->le_conn_max_interval =3D 0x0028;
>=20
> would become:
>=20
>  =A0=A0=A0 hdev->le_conn_min_interval =3D 0x0006;
>  =A0=A0=A0 hdev->le_conn_max_interval =3D 0x0c80;
>=20
> This should allow all devices to negotiate whatever connection interval=20
> they want by default.=A0 If I'm running on a device with debugfs (which I=
=20
> happen to be most of the time), then I can still override these defaults=
=20
> to control my system.
>=20
> Please let me know if you would like me to do any further work towards=20
> resolving this issue.=A0 I'd be happy to test and submit a patch that=20
> changes the default connection min/max interval values- I could probably=
=20
> get that done in the next day or two.=A0 If you would like me to=20
> investigate migrating configuration settings to /etc then I'd be happy=20
> to do that as well, but it might take a bit more effort and time.
>=20
Well, all these things are important, but are new features but there is a
problem:
The kernel patch has gone into the stable trees and from there into distrib=
utions,
so how can these new features flow down the same path.

Regards,
Andreas
