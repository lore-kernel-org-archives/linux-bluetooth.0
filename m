Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E377FC433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Feb 2021 22:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85FB364E44
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Feb 2021 22:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhBKWye (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Feb 2021 17:54:34 -0500
Received: from smtpo115.poczta.onet.pl ([213.180.149.168]:41841 "EHLO
        smtpo115.poczta.onet.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhBKWyb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Feb 2021 17:54:31 -0500
X-Greylist: delayed 664 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2021 17:54:30 EST
Received: from [192.168.0.110] (unknown [193.200.46.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: webczat_200@poczta.onet.pl)
        by smtp.poczta.onet.pl (Onet) with ESMTPSA id 4DcBTr67MzzkyH
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Feb 2021 23:42:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.onet.pl;
        s=2011; t=1613083360;
        bh=ITpuqb0bFTtlaULe4KXrRKXckvir+O0oPHrwqRPiXQU=;
        h=To:From:Subject:Date:From;
        b=n+DNaFwWdwBcsppn+1omxyeHkv9luDYwVBb0YBGMzPUAMeiZFz5qlVcfPCAswOlUb
         IFLnhl/M9pF/YazF8yqheJTA9D3VrYVxA85IL1LUVqN9bT0yH4NLL54Pn5uyw7Vn+L
         LLLAPMnE+087YmKgBfm2k7jAYeTuZnVI7wObvC68=
To:     linux-bluetooth@vger.kernel.org
From:   =?UTF-8?Q?Micha=c5=82_Zegan?= <webczat_200@poczta.onet.pl>
Subject: Bluetooth not working in 5.10 kernel?
Message-ID: <ddf00862-515e-a295-dbcc-068592220e94@poczta.onet.pl>
Date:   Thu, 11 Feb 2021 23:42:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YUgY6DXBZEj5NntBu6xIL0zf5EUEKKuFe"
X-ONET_PL-MDA-SEGREGATION: 0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YUgY6DXBZEj5NntBu6xIL0zf5EUEKKuFe
Content-Type: multipart/mixed; boundary="S21IsT7im6BS4oMkhcU4g6LwM6lgnZZJe";
 protected-headers="v1"
From: =?UTF-8?Q?Micha=c5=82_Zegan?= <webczat_200@poczta.onet.pl>
To: linux-bluetooth@vger.kernel.org
Message-ID: <ddf00862-515e-a295-dbcc-068592220e94@poczta.onet.pl>
Subject: Bluetooth not working in 5.10 kernel?

--S21IsT7im6BS4oMkhcU4g6LwM6lgnZZJe
Content-Type: text/plain; charset=utf-8
Content-Language: pl-PL
Content-Transfer-Encoding: quoted-printable

Hi,
I have 5.10.13 kernel on archlinux and bluetooth seems to misbehave.
Not sure if that is known or fixed?
Namely, I have some atheros bluetooth using btusb driver or so it seems,
laptop lenovo ideapat 310.
I managed to turn it on, then when turning on bluetooth on my phone
(devices are paired) it triggered connection with the pc, but my sound
suddenly silenced, then after a minute I got a connection error on phone
and pc went back to normal.
Then I tried again, this time my sound started looping on the pc, and
after some time went back to normal, phone showed errors again.
I removed the pairing at phone side, disabled bluetooth from gnome and
tried to reload the driver (btusb).
However, now bluez does not detect my adapter, bluetoothctl command
"list" shows nothing. Gnome tries to turn on bluetooth but shows it
turned off each time.
In addition, even though list is empty, I see the device in
/sys/class/bluetooth.
I have found some reddit thread about a similar issue,
https://www.reddit.com/r/archlinux/comments/kwpw6j/bluetooth_not_working_=
anymore/


--S21IsT7im6BS4oMkhcU4g6LwM6lgnZZJe--

--YUgY6DXBZEj5NntBu6xIL0zf5EUEKKuFe
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEE8PeJXyv9t1Bfiq63mRxoPZnIFPkFAmAlst8FAwAAAAAACgkQmRxoPZnIFPnu
0wgAiArrZjCXh4i9k3DdQfI7sJR+tTZjTwij9IU0KycJho7X2pCWWKMzjghMTVvLbkdVex5FibIk
7pZPBCln5P4CMno+M8onJ7CvSbiqH3Q8TL39GFX0yKlklyL6HWCgDai5Me2CesbqpSEiI6hvQJv5
nnU5CfEMnJAcfK2n2rLjFsCzZDl4E8dEaNiO0RKswitvaCxowjstSo4vunTtPNoAf3I2Sm6YJh7Y
/aCOzIeSqK3QpUAxD8DiYg8CqpZUbmGX4/xsPPN4aRQ1ddyD2kQkKHs8toaPmPfdEQjPg66KeFms
AbXlafHFtxIBy3rpFRkXWMKPuXZAhiBqoVO98Mx/lw==
=9+Jy
-----END PGP SIGNATURE-----

--YUgY6DXBZEj5NntBu6xIL0zf5EUEKKuFe--
