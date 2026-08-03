Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A88B2F90C5
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Aug 2026 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796188; cv=none; b=UQa7ca2CuIjO8jgKNRl1AfRwgw7WeWAvMn/jzVGLPq9DrYCuRB+ZLGahNaNJFFHXqavWHnNDdWi5NNdbRjnWVZOPByZcNvg7EtrZk9niVjEBw2tWjIOCj+KjV1p2WrEsrAHKkKK7wYuiLkOQvrEkcUlY7U1wPKT4r567vexo8W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796188; c=relaxed/simple;
	bh=qSaCiYyDEuQQiy0J85tHTk8vq3v94RvaebL7X21bQFg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PKxiDbjHnub8ZdmYhW+42pIcoKgGDyBpNMX5YG/+NbrbqEnpqxl+hhFQXxZSQtooIVuOk1jrfCWPt7pHqhV5nSrIXYZx3Ozc4aWVThzivNINd4MAOrlH8yNAONhRudE+ilFe7nL/bmudT3A5LpAir/NCk13V5gMp3YOM1aYJoiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C196A3EB8D;
	Mon,  3 Aug 2026 22:29:37 +0000 (UTC)
Message-ID: <a2f0a4fdec3a761053ae83ee06c51adbe6cec3ff.camel@hadess.net>
Subject: Re: [PATCH BlueZ 1/1] Add cover art support
From: Bastien Nocera <hadess@hadess.net>
To: Jan-Michael Brummer <jan.brummer@tabos.org>, 
	linux-bluetooth@vger.kernel.org
Date: Tue, 04 Aug 2026 00:29:37 +0200
In-Reply-To: <6716CF9D-9856-4371-B55E-FFB8E6914B74@tabos.org>
References: <20260803195620.255866-1-jan.brummer@tabos.org>
	 <20260803195620.255866-2-jan.brummer@tabos.org>
	 <2a1b99854117a6fbde6a7e28a4fb33edf239fe1f.camel@hadess.net>
	 <6716CF9D-9856-4371-B55E-FFB8E6914B74@tabos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Score: -100
X-GND-Cause: dmFkZTFkaHFzhFrK4QbdDqwz7nmbEuogDrYZQmJPV46kd+WKHMv/cKcEEP2Ajz+stsjFbxOMy7LYSIl/qqdXQbHkBi60oL++rtheOuUTKHCvVA8Fv60Ab3ElxRRLnG5KL7toBw9sE3huINn8rR8PsvtN+ciqkf9pfsSOU7gVl9c3tE6+SpkyA+7uSZyt2Mv6THZAmwyRVfzukxyB0R1wV3+Gj6bR5G9nXT3IjeZYXepQTtMOvFaWqZjPWLKMwHPL3ujaQWR3BKNRXSp1uD4vV9jZv+1jgc9MHUyL0U0lwk/zXuARS2rVU/3C2ZEaejV5nlu1alpZ4ciDiqw8Qih5qF1jYIUgJIBDdVuwgyOfgQl1HerEFAvtPyPdLDUp4WplBGtyGkmcPWi+TyZwona1KqkLueP7uI888f/SCoPGF1izxqk8cHXwInP6fRXJ69iIM5FiFKgL5ByhsJVy6PXhG7Wa9FpIWH2pBaUQYgtvCeLcmGA8iqoJAA63Z4RflV40A5VBMD50cX62S49VAXkx/f+S4fzhWDxWD3hTOsTsdhMkyZSKlYe3gKBMQJ0FQPrvonLNRr5su3hNVrKHwaXB4eKCw0+fH/B7p+YBJwlBacbJ7Vjdx04FbC6IYGTKdxlwkrsZb2GGdt3Pow7e59DUcW1xUQf3ryy8HPu5x5cNt34Yh8v90g
X-GND-State: clean

On Mon, 2026-08-03 at 23:03 +0200, Jan-Michael Brummer wrote:
> Maybe you have an alternative solution in mind? I'm open to change
> it.

I think you might need to extend MPRIS to allow making image data
available instead of a URL.

This could also help with avoiding, say, gnome-shell having to make
https calls to fetch a remote cover, or third-party playback control
apps having to cross apps boundaries to get to another sandbox app's
cover art.

Maybe this new feature is what we want?
https://gitlab.freedesktop.org/mpris/mpris-spec/-/merge_requests/4

I looked through the MPRIS repo after writing the above.

Cheers

> Am 3. August 2026 22:56:39 MESZ schrieb Bastien Nocera
> <hadess@hadess.net>:
> > Hey,
> >=20
> > On Mon, 2026-08-03 at 21:55 +0200, Jan-Michael wrote:
> > > =C2=A0# Filesystem lockdown
> > > -ProtectHome=3Dtrue
> > > +# Cover art referenced by MediaPlayer1 metadata (mpris:artUrl)
> > > usually
> > > +# lives in the user's home directory (e.g. ~/.cache of the
> > > player),
> > > so
> > > +# bluetoothd needs read access to serve it via the AVRCP BIP
> > > responder.
> > > +ProtectHome=3Dread-only
> > >=20
> >=20
> > This is going to be a show-stopper.
> >=20
> > Having a root-running daemon rummaging around in user's files is
> > not
> > something we want *at all*.
> >=20
> > Cheers
