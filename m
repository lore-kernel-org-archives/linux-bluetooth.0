Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1243009724.3147.100.camel@localhost.localdomain>
References: <E1M7QzU-0001CY-00.obivankinobi-mail-ru@f83.mail.ru>
	 <1243009724.3147.100.camel@localhost.localdomain>
Date: Fri, 22 May 2009 16:33:26 -0300
Message-ID: <2d5a2c100905221233i2e51905fre1cce0d0940f719@mail.gmail.com>
Subject: Re: Configure bug
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?KOI8-R?B?8s/Nwc4=?= <obivankinobi@mail.ru>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, May 22, 2009 at 1:28 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> seems like you ended up with ${alsa_enable} =3D yes and ${alsa_found} =3D=
 no
> and this is causes this mismatch.

Recently I hit the same problem, I was using bootstrap-configure
without libasound-dev, wouldn't be better if we just make configure to
fail in such situation?

--=20
Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o
