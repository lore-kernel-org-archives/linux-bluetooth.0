Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C04C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Feb 2021 08:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1677464E6A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Feb 2021 08:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhBMIYd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 Feb 2021 03:24:33 -0500
Received: from smtpo90.poczta.onet.pl ([213.180.149.143]:51461 "EHLO
        smtpo90.poczta.onet.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhBMIYc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 Feb 2021 03:24:32 -0500
Received: from [192.168.0.110] (unknown [193.200.46.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: webczat_200@poczta.onet.pl)
        by smtp.poczta.onet.pl (Onet) with ESMTPSA id 4Dd3Kr1KvNz1xDR;
        Sat, 13 Feb 2021 09:23:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.onet.pl;
        s=2011; t=1613204624;
        bh=atv/QgNh8M36Vs93SJVImBBsW/v0hQ2YTs1s2c3i7P4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jyHR7iqvytioTlgNbMI7he8nn744dkv9Hfwb2Io8skJAWLrElq99TvYM46V3CRDed
         UHYBUWR42pkg+J0lj4+nmjpEwn6kXvBUMhlNmni9a+WW/84P8WD4ZWVEamaXiHXJCc
         rfTAzm1kiA02hvwLcH8XqUu5SBDhAChvOR7KAoKU=
Subject: Re: Bluetooth not working in 5.10 kernel?
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     linux-bluetooth@vger.kernel.org
References: <ddf00862-515e-a295-dbcc-068592220e94@poczta.onet.pl>
 <YCeA5hF+5yn4w/EY@eldamar.lan>
From:   =?UTF-8?Q?Micha=c5=82_Zegan?= <webczat_200@poczta.onet.pl>
Message-ID: <d46a0bac-cd81-b9a0-a9bd-e3ccbbdbdcd9@poczta.onet.pl>
Date:   Sat, 13 Feb 2021 09:23:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YCeA5hF+5yn4w/EY@eldamar.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ecEtLtBw66216HxrXkVmJdJzIk31sISBH"
X-ONET_PL-MDA-SEGREGATION: 0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ecEtLtBw66216HxrXkVmJdJzIk31sISBH
Content-Type: multipart/mixed; boundary="2rkPgmtgPbzjMDvcMKesup2e2IV4jdx2S";
 protected-headers="v1"
From: =?UTF-8?Q?Micha=c5=82_Zegan?= <webczat_200@poczta.onet.pl>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: linux-bluetooth@vger.kernel.org
Message-ID: <d46a0bac-cd81-b9a0-a9bd-e3ccbbdbdcd9@poczta.onet.pl>
Subject: Re: Bluetooth not working in 5.10 kernel?
References: <ddf00862-515e-a295-dbcc-068592220e94@poczta.onet.pl>
 <YCeA5hF+5yn4w/EY@eldamar.lan>
In-Reply-To: <YCeA5hF+5yn4w/EY@eldamar.lan>

--2rkPgmtgPbzjMDvcMKesup2e2IV4jdx2S
Content-Type: text/plain; charset=utf-8
Content-Language: pl-PL
Content-Transfer-Encoding: quoted-printable

Interesting,
These may be related, but I myself do not see that error about not
supported firmware anywhere in dmesg, the only thing I see when loading
module is that the usb device is registered.
Then I actually do see /sys/class/bluetooth/hci0, no firmware error, but
also no adapter in bluez. It's still possible it's the same issue.
Also why it was detected on system boot, just not when reloading?
Or at least it seemed to work until I tried to actually connect with
something.
Will definitely test the change when it appears in an actual kernel to
see if fixed.

W dniu 13.02.2021 o=C2=A008:33, Salvatore Bonaccorso pisze:
> Hi Micha=C5=82,
>=20
> On Thu, Feb 11, 2021 at 11:42:39PM +0100, Micha=C5=82 Zegan wrote:
>> Hi,
>> I have 5.10.13 kernel on archlinux and bluetooth seems to misbehave.
>> Not sure if that is known or fixed?
>> Namely, I have some atheros bluetooth using btusb driver or so it seem=
s,
>> laptop lenovo ideapat 310.
>> I managed to turn it on, then when turning on bluetooth on my phone
>> (devices are paired) it triggered connection with the pc, but my sound=

>> suddenly silenced, then after a minute I got a connection error on pho=
ne
>> and pc went back to normal.
>> Then I tried again, this time my sound started looping on the pc, and
>> after some time went back to normal, phone showed errors again.
>> I removed the pairing at phone side, disabled bluetooth from gnome and=

>> tried to reload the driver (btusb).
>> However, now bluez does not detect my adapter, bluetoothctl command
>> "list" shows nothing. Gnome tries to turn on bluetooth but shows it
>> turned off each time.
>> In addition, even though list is empty, I see the device in
>> /sys/class/bluetooth.
>> I have found some reddit thread about a similar issue,
>> https://www.reddit.com/r/archlinux/comments/kwpw6j/bluetooth_not_worki=
ng_anymore/
>=20
> See both reports at
>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D210681
> and
> https://bugzilla.kernel.org/show_bug.cgi?id=3D211571
>=20
> So the fix is now pending in bluetooth-next.
>=20
> Regards
> Salvatore
>=20


--2rkPgmtgPbzjMDvcMKesup2e2IV4jdx2S--

--ecEtLtBw66216HxrXkVmJdJzIk31sISBH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEE8PeJXyv9t1Bfiq63mRxoPZnIFPkFAmAnjI8FAwAAAAAACgkQmRxoPZnIFPkt
hQf+MxeqDPy8TGeA/oSXsEQaxeecuVYitqcCFhPk4vdw9wbiqjL4cvRfCmxFE05x2zFWuRBVn/jM
YOBlqs2sIBke5zMgdbjUEpR27d7nr9RZ2eLfEnLHKtzl4o4VmZxIsubVlL/iqr86pkrD+CRoxtPC
hfMHkW+pHyPeCprixC1cOgWcjuCexteEhml6ZY389Sezj6CekdvwgAhaeqHwGNl5pCZt0wiLn8Qh
mDmCz4c8lSM/WE/Y6Uo++/G575+emYDZsBi4csebsyT2d+WKWcCzAkflt+xQRK/wIzcMt9z4R2J3
w6JHRfpPH/ul00FhillpyIYS2BTJRqQp2seWg9VH5A==
=5ONc
-----END PGP SIGNATURE-----

--ecEtLtBw66216HxrXkVmJdJzIk31sISBH--
