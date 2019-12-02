Return-Path: <SRS0=9PGa=ZY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AA0C432C0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Dec 2019 19:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573242071E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Dec 2019 19:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575316173;
	bh=mlKueMDRvYcpvxzG02vBGmdoW2OiT03TumQ2uae6pKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eTQ3na61QoclKn/xESRuEs1PFl4OYvSCdG4LA7HjoEprIWh+GoJA1SjjnoXa2eKAG
	 5d/BJA94OOY7ENwbIFy+yihRQhf9nxlkQL5OFyE2bD1Yac2CnNxY0iwixJYvdjk172
	 LDTEvNESpbXjG8jQslYNStULErJQ4HsgTbxgWxvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfLBTtc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:49:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbfLBTtc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Dec 2019 14:49:32 -0500
Received: from earth.universe (unknown [185.216.33.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E018D20715;
        Mon,  2 Dec 2019 19:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575316172;
        bh=mlKueMDRvYcpvxzG02vBGmdoW2OiT03TumQ2uae6pKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nolHYMR44uaUtIaVJ0ckCX+M4YLkvV9KX8v2ja7RAmi5Fm/AJmm5TlG0VPw38T1Lg
         VJYTH74Pot3OG0hu4kjrBRETrVQFT2h5JhyIDE3XcRXjz4Z7y9sPwAme7SjltMwr1H
         XoT8GroIwMeZwTr1QbOHcdITJ8wmY6kHxBo0TKyA=
Received: by earth.universe (Postfix, from userid 1000)
        id DA0AB3C0C7B; Mon,  2 Dec 2019 20:49:28 +0100 (CET)
Date:   Mon, 2 Dec 2019 20:49:28 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        General PulseAudio Discussion 
        <pulseaudio-discuss@lists.freedesktop.org>, ofono@ofono.org,
        devkit-devel@lists.freedesktop.org,
        Bastien Nocera <hadess@hadess.net>,
        Georg Chini <georg@chini.tk>,
        Russell Treleaven <rtreleaven@bunnykick.ca>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Tanu Kaskinen <tanuk@iki.fi>,
        Arun Raghavan <arun@arunraghavan.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: Proposal for a new API and usage of Bluetooth HSP and HFP
 profiles on Linux
Message-ID: <20191202194928.nmcucpoabwf2ce3n@earth.universe>
References: <20191201185740.uot7zb2s53p5gu7z@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3hixyzurn7x44vjr"
Content-Disposition: inline
In-Reply-To: <20191201185740.uot7zb2s53p5gu7z@pali>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--3hixyzurn7x44vjr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Dec 01, 2019 at 07:57:40PM +0100, Pali Roh=E1r wrote:
> [...]
>
> For handle this problem I would like to propose a new way how to use and
> implement HSP and HFP profiles on Linux.
>=20
> Implement a new HSP/HFP daemon (I called it hsphfpd) which register HSP
> and HFP profiles in bluez and then exports functionality for all other
> specific applications via DBus API (API for audio, power supply, input
> layer, telephony functions, vendor extensions, etc...). So it would acts
> as proxy daemon between bluez and target applications (pulseaudio,
> upower, ofono, ...)
>
> [...]

Makes sense to me. My TODO list for the power-supply subsystem
contains providing an API similar to uinput, but for batteries/chargers.
I suppose that would be very useful for the daemon :)

-- Sebastian

--3hixyzurn7x44vjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl3lasUACgkQ2O7X88g7
+prEDw//Z6n5Vqe7LPkVNBdWb5RcepC5SXsdMrOWcRZiG2l+ONx3TllLio1oKQzY
4ySobqzSsYjrMPuutOk5FkevIePy5Bz4CUj7N/GzguMBgBl/AwjM1YD5UvW+B/lU
AliVp4D7uNE4i4JgvKsVP5oC7BFzY8UPHC1vc6BS5r9HZZ7ftHFaNvVhYZpCEdn/
TiM3DcyL699MhXPZTXWIWJQNIUFJMNgk46Oqf6MYLfv6uMZy3R84jQ/z+8o81tMZ
4MtsYqJEGZrcmA8zhJrgHowV6ct7iVrdMKtam8yebFgHBOHLGIgOz3ELVO1V4P6r
/ysQQq1UwOqp25smRmpiXziQ0vVVj38IKlO+rnNCie+XdcNxR0HwpZsGhepIrR9e
+5HInSMZsfmF2MA97VVfB6JDbkCynk/8HEbddnRPm44suhkEvzMlrZOsnjVLBy2I
E52luL2LETOYrty9DHdM0SobZ7T4rAMHBuemr7zjYFm2gZ/0oYTdDIMWBDQrk0eS
BA/e79rgTzH7iMlKhzMCavfOuCRUbWujBayo/d0xyugOC6y8hsGD/PIVu03Bxj/P
w7oA4PPITTVvxKis4/pvg9QoZhU84b/8T7Ea7i3/LTqIXEhtZrSx8S/wkSRt9Cck
4qP1pasTIz08mJ+j5GibSI9NecpmP62zWOu+rKfXunzGcgTmzjo=
=vyz5
-----END PGP SIGNATURE-----

--3hixyzurn7x44vjr--
