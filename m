Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328501DF982
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Feb 2025 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739644055; cv=pass; b=WGeclb9IkqRURaDdIQqT0ZI+HAp4Q4K34AX+65g7NZyf1J/4+6TJlFbW7OT+q+dbITlbFmIbtVZ+B9wX5y7UGWoHfbj4rcm3co8Js7iXYeXfD8oJvxxdeQJvoqVkePYskXIfTjlhXMQok/cfCfQ+/Rp4AhRj7LjHLIOlRu2NPLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739644055; c=relaxed/simple;
	bh=afFwcHemJ4WoJqSi6Jb0MBiEEf5SEk7z0d2D75NHBtQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jr1uVPqO1FqsppCHMGFh/ljwEtNKXFw9FQ3rNQdn2NCD5HjxMUbrX0ENN/nc6TtQqUovWXJpAwbQmqRIFWMQlA1nbUt2pN7FVphW+Bt6AnhMg/bPLwonVQFqLBs6hzHwxGMOURZ38YusKAvS0ovbicvP/8XtvXCnG2GQrPGwzzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=cvQ30rM+; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="cvQ30rM+"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YwHTF0Pbwz49PxW;
	Sat, 15 Feb 2025 20:27:28 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1739644049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3zBNTNEkjilCv8mouS8aM8fI4ZZU3qqoH3k/1Xc27M4=;
	b=cvQ30rM+vrsJmUDKWaIdjKA4xqGIF3lEheOA3mkFlbAx+dJwAaFA5CFyx8lxRjDN8rnD1K
	i76ly/CivH9pS1iREloIVwGw0S8ykgV0HR4VKpxRUQ4mJ+ch54reReUrQF7Vy/of6SWTe0
	OtOvxLIwx3pu+johnah7hl04w0FOhmxMlAZTH2f/vW/SyYJYnQ1K90oQJZxx+D1fBweer6
	C4TycFkwblz/NIMF+Z2ADh6w5oE3wAtA6U8uybrOROM5zCHscj/D2ZNplODsEADnxkwgxe
	vhLkyFUxNk8VUFYC2b3/czbAzpMtBT80ZRCTaCq4DZBpPUS4bNLxkI/ZUwptGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1739644049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3zBNTNEkjilCv8mouS8aM8fI4ZZU3qqoH3k/1Xc27M4=;
	b=S8mg3HpV8G2XYnjZYB0RmZQ1Wwekh5Vz5ne/D1Kikip7v/qpxG377j54K6CExG6CP23rlw
	Rex+5jvoCDaHSKhveDTfPR9CdiGXOTcFys1UJ25onCtecAu4HElFVZE5zVbKUQv5q6Tx6p
	LhzdPgWpzpiHJg3FbStbFRj63HdZps3Ozqcwe4Dm03UbFmVNX80uc47/skH7k2vXrA/gXi
	rrTZj2EQw/yUwoahxGsvhXozWboon1IYzXeMKjq11Pz+xDCvYfTwxc0SWHC4GtkIHQrSJe
	HKihw9mk9GBWpemqF+YbZJ7LA6nmNZzWqPWeSe23LuWS8FVBL+hpXVcN96Ezrw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1739644049; a=rsa-sha256;
	cv=none;
	b=OwGoeNMjC41tnZqcXelJtxLHoYCDU8MnXddhIQYQZMwObcjQIT5BgzNwGcuxSsnz3LvruF
	2gG5ZIXa09tJ7gQo55mrCcDf2ZMQZxqINEDTQfM0Sv/4FgPTSVmNmCRz2VP7hmeEv1rj2R
	g4e7Zb0A+kc38ptZfu2RFxX61v44hgbFfyxRSKLcZtf6F1z5o/vcEbO7duX32dJHe18Tmw
	q6G1uiYsg4iy1kKzBA+bS8J87KpWF7tocwIkjczxFmrjbgtAPWn9eVfXeQaCVQLLwMZ/2Z
	0Jh2+jaQ1GyRLLaj1WI+EK4xigp9iNHKiFSttYEfaGngAX0K1CEKA18qh1w+yQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pauli.virtanen@iki.fi
Message-ID: <3e36e6c2c9b201a5c06c0bc166cd4d38bb8067b3.camel@iki.fi>
Subject: Re: [PATCH BlueZ v1] org.bluez.Device: Introduced PreferredBearer
From: Pauli Virtanen <pauli.virtanen@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Date: Sat, 15 Feb 2025 20:27:27 +0200
In-Reply-To: <CABBYNZJmigw_3=5CZ5eaSGC8ZHTzmsZA11p558EtcET-FcrVEA@mail.gmail.com>
References: <20250214202129.968369-1-luiz.dentz@gmail.com>
	 <CABBYNZJmigw_3=5CZ5eaSGC8ZHTzmsZA11p558EtcET-FcrVEA@mail.gmail.com>
Autocrypt: addr=pauli.virtanen@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

pe, 2025-02-14 kello 15:32 -0500, Luiz Augusto von Dentz kirjoitti:
> On Fri, Feb 14, 2025 at 3:21=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >=20
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >=20
> > This introduces PreferredBearer property which can be used to indicate
> > what bearer shall be connected first rather than just using last seen
> > bearer which may not work always since it seems some devices sometimes
> > advertises on LE bearer but expects connections over BR/EDR e.g:
> >=20
> > https://github.com/bluez/bluez/issues/1092
> >=20
> > Also with the introduction of LE Audio this might become even more of a
> > problem since most likely users would like to select which bearer to us=
e
> > rather than using the last-seen policy.
> > ---
> >  doc/org.bluez.Device.rst | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
> > index f8d4a68a6b41..e3cf4d12b173 100644
> > --- a/doc/org.bluez.Device.rst
> > +++ b/doc/org.bluez.Device.rst
> > @@ -40,7 +40,8 @@ void Connect()
> >         are skip and check latest seen bearer.
> >=20
> >         3. Connect last seen bearer, in case the timestamps are the sam=
e BR/EDR
> > -       takes precedence.
> > +       takes precedence, or in case **PreferredBearer** has been set t=
o a
> > +       specific bearer then that is used instead.
> >=20
> >         Possible errors:
> >=20
> > @@ -346,3 +347,23 @@ array{object, dict} Sets [readonly, experimental]
> >         :byte Rank:
> >=20
> >                 Rank of the device in the Set.
> > +
> > +string PreferredBearer [readwrite, optional, experimental]
> > +``````````````````````````````````````````````````````````
> > +
> > +       Indicate the preferred bearer when initiating a connection, onl=
y
> > +       available for dual-mode devices.
> > +
> > +       Possible values:
> > +
> > +       :"last-seen":
> > +
> > +               Connect to last seen bearer first. Default.
> > +
> > +       :"bredr":
> > +
> > +               Connect to BR/EDR first.
> > +
> > +       :"le":
> > +
> > +               Connect to LE first.
> > --
> > 2.48.1
>=20
> Please have a look at this since we might need some integration with
> upper layers, at very least bluetooth settings needs to be involved,
> this is similar to the likes of Windows and Android settings which
> allows enabling LE Audio on per device basis but instead of being
> specific to LE Audio, which rules out other services that maybe
> exposed over LE, this enables the connection policy to be tuned per
> bearer. Now there maybe another policy which we could use which is to
> do dual-mode, but I don't think headsets will deal nicely with that,
> specially because no-one seem to be doing it, that said that would
> make things simpler since we could expose things to be just a
> codec/transport switch rather than a entire bearer switch.

This sounds like like it could solve the problem that currently we more
or less have to set ControllerMode=3Dle to get LE Audio on initial
pairing.

In Pipewire this probably allows adding an user selectable "profile"
entry for LE Audio when connected via bredr, which would switch bearer
and issue disconnect + reconnect.

Probably Gnome BT settings also would need to grow a corresponding
setting. Labeling such setting so that people understand it is maybe
harder...

There's a few questions:

- Is there something that tells which bearers are available for a
device? It would probably be needed too if it doesn't exist.

- Interaction with CSIP, if you pair initially with bredr I think you
don't get the other earbud paired. If you switch bearer + disconnect +
connect, does it pair & connect the other one?

- Who is going to be the agent that accepts the pairing of the other
CSIP devices? GNOME BT settings I think is not running all time (and
does it do CSIP accepts?).

- Whether disconnect+reconnect should be needed to switch the bearer,
or if just changing the property is enough if already connected? Maybe
it is needed?

--=20
Pauli Virtanen
