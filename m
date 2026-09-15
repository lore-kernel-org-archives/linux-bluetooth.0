Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9DA3F4DD0;
	Tue, 15 Sep 2026 18:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789496811; cv=none; b=LpR1K8/NSed+3Es7ZDlaGKUKqrGbF1ejYcVOnL7tIHhMDPPZbyTNCLPVoJ+F8LzHMfHaTRP9MnnQrH0KGHNWKdouwlBx/mGb/meb6i52tla9iZuFLyVpIT+Fl5LtR4/cd1K7ObNv1KBnKHZta2ZYS8SFlzOWtZLRbv6aRxeEpRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789496811; c=relaxed/simple;
	bh=gWf7H/JRy9uLIwg08PvbVwyLXKw8VaP3GyMaxifSlJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyFlDsH1kPL3Oc9xQXZ3mJjN9FxZwf3Uy7w2X8SGjIMXeQZ9p8tdyTlwciDQqPbE5GKKIhAti7sVPjmNvKfIAB7NYZgudnS4EZzfGt4vSWKKbbiteLSzRbksX2c1uPqN6qY303cGRgy54DAT5C0NjZp8smv5myi3ky/xtRy+j4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzY0pj5O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzY0pj5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499561F000FF;
	Tue, 15 Sep 2026 18:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789496810;
	bh=G89MKfJS0hMEArqVaDoqLxkrEZ+w09q0XaispIyKguQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RzY0pj5OE+zHVBg0L0c4XpYfg7KEe5dsK4Dh7oacA1BZzClbmAE2c2dDghl+bn+z1
	 UYMJXNs1twN0ulJgkNXGtQ1e6VMfXalrSVcToNwzmQyAFi9uPq5ChqIVVhNxyyfQlL
	 wJIkDDrVyWzlQ/87ZrxS17tYsJ2iQlBWbG+mJUJ8QsmG4tdU2FTNlO2FwWpPNBR3nc
	 prZMusJ40vC7o7nZixsjYETAv+MjUryC0RFu1VXZ6kWthrx+4xXY4lqaTGmbINE3KW
	 UCqbpOBvYEQ4l0x/3ZKsvv/ClTd30Mk1pLlIL7/yQpLHfDyvoit3k6HSL4uXtWQgQx
	 2B7pmYEL4hruw==
Date: Tue, 15 Sep 2026 19:26:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-09-07
Message-ID: <d5676b70-f60b-4ce6-b6e6-de564d5c0a29@sirena.org.uk>
References: <20260907172648.457103-1-luiz.dentz@gmail.com>
 <20260908135708.552fcead@kernel.org>
 <a0e8bc1e-c237-41fb-b448-9594bd484cfe@sirena.org.uk>
 <CABBYNZKrSve8b=Acj2qu0YBuEZ9u9xHJe-ffRb+78x5KPY8Ntw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xn3I0bKjnPwJ3YGY"
Content-Disposition: inline
In-Reply-To: <CABBYNZKrSve8b=Acj2qu0YBuEZ9u9xHJe-ffRb+78x5KPY8Ntw@mail.gmail.com>
X-Cookie: Void where prohibited by law.


--xn3I0bKjnPwJ3YGY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 02:07:39PM -0400, Luiz Augusto von Dentz wrote:
> On Tue, Sep 15, 2026 at 1:46=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:

> > FWIW I do keep reporting signoff issues to them:

> >    https://lore.kernel.org/r/aqQARvWlSUQEHMtw@sirena.org.uk
> >    https://lore.kernel.org/r/ap6Ze-_ckuTFyCMH@sirena.org.uk
> >    https://lore.kernel.org/r/04d6aba2-bf5c-4e73-8ba2-1fe57218fbd9@siren=
a.org.uk

> These have been fixed though:

> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.=
git/commit/?id=3D8d463624a249b6023e1bac6a5ebb0853a9c96d26
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.=
git/commit/?id=3Dbe1cc4fae4cb7d506ad01fa7746db363c41dcb6e
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.=
git/commit/?id=3D9ec9d1ade8ae7a3bd3cc061534d767fe305bedb6

Sure, they do mostly seem to go away eventually but I'm usually sending
reminders, and apparently at least some of these issues are making it
into upstream pull requests so it seems the reports weren't acted on.  I
did ask in the last of those mails if you should be a contact for the
tree given that you seem to be doing a lot of the updates but never
heard back on that - should I make that update?

Given the issues caused by the unusual workflow for the tree I do send a
lot of reports of issues in bluetooth.

--xn3I0bKjnPwJ3YGY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqpjeUACgkQJNaLcl1U
h9A73Af/U2OSrrhhHgy9Lz7uuiKkxafQNrG1bpLZpdjwmRHPvOZXxloUBmNHPGQp
ZTz/d2Gyo1DGLOgc6W8SKG7vID5iI2xK30DzDd+ma5rLhVEAAPFVYQmq79EJt3L4
Ar/YzvvpxbFsPXWAm6Rs2G5AXYlhXjldkNNfs6sRDHAGRj1QvE+Uzf/CXRihXu2P
BpOGMnmuB22OGhMZfpFiUDSRcls80A3Opu8K38xBko9I4kSi81QAvScqpaXWkr8D
BAbCgymfTZ4bW9MmxGsaqmIb9QJDUXTUrhqHVlxMeguojrGzBOFUGMavAZDzNMDF
uT/TjcXXObFTyE87OeiuT2A5S8uHTw==
=VWmZ
-----END PGP SIGNATURE-----

--xn3I0bKjnPwJ3YGY--
