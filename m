Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DC78F77
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Apr 2025 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744997188; cv=pass; b=pjaz0A+S9YA3Je7WaxQmngA1sU9DKnl34vrvUZfI3CTD8Y0fmPEKAy6HwHMQgOdWmXCTjhlVYH+b87ehoYpNRZkePaqhrAnEp9ViSeMemW4XaFRGcbm23gYgd1Q57jjMGTKflOEJ2/mt4PtVJp3ekUX1MFOhSaY2th6POG3Ink0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744997188; c=relaxed/simple;
	bh=YSII+tshobAsg/QCz6vKL8dQHcpsyPB80+n/sUDXVgc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V2pzzxITMLoIZHXwG5tHzv7mvqgchFqIS+vOXToF2fpJA65LEF/fGU38SMV56GgxKxW1rnok4SGSlJMhCkC+tD/k0lRndfD+EyYNyVNAQMh1pPnVmlEDPaX3NKnNdq3pA4s8CTAGERTDABw6SzRWTfAZobiMSDF1HL7nDRZSHzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=mwTa7DB6; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="mwTa7DB6"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZfMB11GMFz49Q5M;
	Fri, 18 Apr 2025 20:26:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1744997178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vX8bYBAQInHKzqdMwQ73ki6KunleGzzOGh3vVhxvrzw=;
	b=mwTa7DB61Nch1ANMjqNpEFSpKeAIic4rk2k/lSiR5M5iCQ0XodMY42rt6nk8PlnTS1eHag
	b1Odqu3Z4noWm85s6iTOljP3hTuuJLHfXIXB/bNmKNjPYuDIgIvf1/sliQOAwtEpnsVnVf
	5MUSmd7nXLUEzdeL/U7Xu6Z8ptO8zGTqhj4IpY1URMID5KPDckSAWy8Qk+R5opLrjuHRye
	9mjzMCOFGVUcxmDlCIXscdcP9cvw4NOwDD1/WPsM+3lemesMucjITjjTvDpNQjKtIs9ME3
	GMTnHRIDY5kHcjiYpm9qoin2DaFeq9LLyzkaMdUKEaezEEfESLVLk/sbxwiT1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1744997178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vX8bYBAQInHKzqdMwQ73ki6KunleGzzOGh3vVhxvrzw=;
	b=ammejL64q8X9v9NQWnFWox6nDT1vjxgjwNSw1L2+oQdN6ME0R5/XgeLk+CKJCBiKtle10l
	FqTQi10rK3GzluU5L5OfYt4Swn6jcrN4dgt+Fl147MdLE4LjUCNYr34ZxSH6NaGlzmtrSM
	164kMWJOO4Zpa7KBwx0UYkKTUyvzu7xxwpm/rqbREHvw4fwz/WXvWW4MQ/vlj3gk1CrU8S
	YnabDfgOglAStviq7EJrfAWHUjvzLWt5YFR/wex+O4v+CA8WGOlGO3J1vt4uHTjlMZ0mBU
	JlYho9G1kxTB5scCaeWbJWPSyLQbjzKx4/BGD0R9exxiZJf+mhZX26mFIpgKsg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1744997178; a=rsa-sha256;
	cv=none;
	b=i6fZpdjJGtOJ3sSXO6DJhtC22IOuB6TNdJX8IQXKrZw+Us5KkabxF3u3OQASoMDTlN0YQW
	QGQpm6Lm0HdeSRB3aGmPPlopBLyJhOjOZ4/A/Yx3ov3jBSLm1gOxBRIq0WOC5TfXX4tbJn
	0dtULMZiDhpT92yENmcjTAKStjv1aLCCjplZfukZ/9JgdjJkxDJTPuTCogvh3WIx/vSYll
	Yno4WjjaitHqeJ0eqjBV7KQPpt3vVlbYnJ+88K/D+QE9UwH4OtikPFY8s6v0zbjGrWSxNU
	xsKCyKaCKovbwE/Kl81pfI4VWPiO4cd+pRI8qiRAMVLTz43JqkwDzt/JPNaOlQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <29aef2f3132a7212a84294aa513200f9c0482e07.camel@iki.fi>
Subject: Re: [PATCH BlueZ v2 1/2] build: add bluez.tmpfiles
From: Pauli Virtanen <pav@iki.fi>
To: Andrew Sayers <kernel.org@pileofstuff.org>, Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 18 Apr 2025 20:26:14 +0300
In-Reply-To: <71a14d3e-7625-4414-9873-9105c991684d@pileofstuff.org>
References: <20250418153115.1714964-1-kernel.org@pileofstuff.org>
	 <20250418153115.1714964-2-kernel.org@pileofstuff.org>
	 <CABBYNZ+ig2=VWOwFQvkmZB4WebtY03C9AYktSXLmz6XZHXppMg@mail.gmail.com>
	 <71a14d3e-7625-4414-9873-9105c991684d@pileofstuff.org>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

pe, 2025-04-18 kello 17:40 +0100, Andrew Sayers kirjoitti:
> On 18/04/2025 16:35, Luiz Augusto von Dentz wrote:
> > Hi Andrew,
> >=20
> > On Fri, Apr 18, 2025 at 11:31=E2=80=AFAM Andrew Sayers
> > <kernel.org@pileofstuff.org> wrote:
> > > Systemd tmpfiles ensure the status of particular files.
> > > Add a file that bluez can use in future.
> > >=20
> > > Distributors should install the new "tools/bluez.tmpfiles" file, e.g.=
 by
> > > moving it to `debian/bluez.tmpfile` or using Fedora's `%{_tmpfilesdir=
}`
> > > variable.
> > I thought we would not be adding this anymore with the addition to '-'
> > prefix and the added comments that should be left to distros to figure
> > it out.
>=20
> Ah sorry, I thought you meant to add the comment *instead of* the '-'.
> Leaving it to distro's feels a bit dangerous, but Pauli Virtanen's idea
> seems like a better approach anyway (thanks Pauli!).
>=20
> I'll take a look at that and should be back with a v3 next week.

Note though that the seat state monitoring also has some drawbacks,
e.g. ssh logins are not considered "active" so for headless / system-
wide obexd configurations you'd probably want some command-line or
configuration option to disable the feature.

> > > Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
> > > ---
> > >   .gitignore              | 1 +
> > >   configure.ac            | 1 +
> > >   tools/bluez.tmpfiles.in | 0
> > >   3 files changed, 2 insertions(+)
> > >   create mode 100644 tools/bluez.tmpfiles.in
> > >=20
> > > diff --git a/.gitignore b/.gitignore
> > > index 108c3b820..e4431443f 100644
> > > --- a/.gitignore
> > > +++ b/.gitignore
> > > @@ -157,6 +157,7 @@ obexd/src/obex.service
> > >   obexd/src/org.bluez.obex.service
> > >   tools/obex-client-tool
> > >   tools/obex-server-tool
> > > +tools/bluez.tmpfiles
> > >   unit/test-gobex
> > >   unit/test-gobex-apparam
> > >   unit/test-gobex-header
> > > diff --git a/configure.ac b/configure.ac
> > > index 1e089aaa7..4ebd513d6 100644
> > > --- a/configure.ac
> > > +++ b/configure.ac
> > > @@ -530,5 +530,6 @@ AC_CONFIG_FILES(
> > >          src/bluetooth.service
> > >          tools/bluetooth-logger.service
> > >          tools/mpris-proxy.service
> > > +       tools/bluez.tmpfiles
> > >   )
> > >   AC_OUTPUT
> > > diff --git a/tools/bluez.tmpfiles.in b/tools/bluez.tmpfiles.in
> > > new file mode 100644
> > > index 000000000..e69de29bb
> > > --
> > > 2.49.0
> > >=20
> > >=20
> >=20

--=20
Pauli Virtanen
