Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C8D2BDC0B
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772046362; cv=pass; b=smX7Twm58b1VAcF7w553mvHx2Opq267ruRdhY5sXEZL1CIr+eNe02ZBgDA3YxbFaUVlaSHzWfGULsHOo8DG2JyclndCHDJtDmUY2Ifs3nr2JKpSFvHrRhpZ32piDZVn59Mn1GKRJFRp3ti6Y16P5fYo0UrNoOOdgSSPVRWCnn2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772046362; c=relaxed/simple;
	bh=Ar9AKyMCBn/dWmoE8jLOHik7RD19lhxSdmnZkk69Ibs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mEjz8rHVD8L6X8L6ZWvIZeoCF+GwWWzS9HkzsFNs7dTqgfDBhu6gSIApPBNkNnVjaKylCk7t8UizgHgqEdOwbSJwZORbjgsQ6qJQvnTjJWqWvXx6M0jD8TP1ge2HUqCgXw8OI40NSeUYr9te1Q3BNs8IwH/ErKF6CvmGeEZHqJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=WwBnhF/l; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="WwBnhF/l"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:d:f011:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fLkPq2RJhz49PxF;
	Wed, 25 Feb 2026 20:58:23 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1772045904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ar9AKyMCBn/dWmoE8jLOHik7RD19lhxSdmnZkk69Ibs=;
	b=WwBnhF/lMWyHrcSB79OSJRBi7Sv7tzmL//kV4VuqyIo04k7MelqI9nBW4rZfysFSfE3Txh
	jOMzGuOqY7mtDBNYw1C9pwVHKvrbBndpQjZSZxBx7PF89YYYE8VC6wkPy0AnT70siCeA+o
	BJFQKJhGdlgm683RHgykUEbF3sbdrcgEd2W7O1CN/Ge+8b8/CWQI+qmPjm69+Ae2PsL9nJ
	Bh8eJWAjjfg9UOAuElp62uzPW5b3UuNcAu+i6PnbrF+8GCGwaYN9YUrbihX7ZknpZeFotn
	M7Oaqil3d33SIYBnS6pTQqII3wj8W1/8ljt/40LSX7vlcUtoQ+rbISDh2Kb4xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1772045904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ar9AKyMCBn/dWmoE8jLOHik7RD19lhxSdmnZkk69Ibs=;
	b=iuv5jc43GpX4bzxu+upKZiMjU9j31O9sR6gScAPyj992SfpZenk5BilHxsyDCscyo9BN2E
	GfW022DuiNHpPYR4PRwb4KWqoBHz+q6xaabOSVG00qHjup751JCCrbjCPMYOl2DQzQSGKt
	66TsodpWGUcRyb+5T20HtnJ20ce0/JIQkv+nz0yUw4k48TiJNDF2XtYoeZ3Q9rckzKiXRr
	roAt7Trz1pYoNF5YCAkmegOW1CP6NlgcHQfrUDG7uR0IYYfdOmQuJkrCimjhy2IMuAYfLj
	tHnvWoO7QGnsIsXYJpvDuawgqWih/gbey+m3Wbx9G1igZ5oxZafgESr11P/82Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1772045904;
	b=ZrmF2Ba5r4mIo58O4ZsGVlvdPr+1qU3wp4d0GZCnmNo3yplNhMf7tbrmy9/YRWrcEYbcdH
	sfPOjWAi2IVZw6U+0J/bIymqXGrQbhsU6bWM4sdU2qC5i8FUJvcxJcozxdBV2+k+g2ukFQ
	MrWHitQbXTF13qnEnB+AanKl/9Q2Qt3IeuJoHu9DavmBBE8M9QyGCYMpMDqxUuUZwcsUqE
	W9X630iVZ5leL30NVO0EEKd8ZjwtR87sbWHHQIIp9RMrz93GfLJY4YQIMGkl55jIqBlt3c
	dlYb235zt5c/5fM4qsikBGYU4/i4uhssO33vTN+ATB3z+/MzxNsD9AnyhHfmGQ==
Message-ID: <c606541c5c1309b9d4be685962f429581eaa7ffb.camel@iki.fi>
Subject: Integration testing for BlueZ
From: Pauli Virtanen <pav@iki.fi>
To: Bastien Nocera <hadess@hadess.net>, Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 25 Feb 2026 20:58:20 +0200
In-Reply-To: <cc92dcae7bf3c7832643071df30eb5734097d2d1.camel@hadess.net>
References: <20260218024605.70890-1-ronan@rjp.ie>
		 <20260218024605.70890-3-ronan@rjp.ie>
		 <CABBYNZJqjaDJmkEy0yvyqLXP6kFH-dVjnzcCVknAkpu39zspaA@mail.gmail.com>
		 <defdb4fb77123ebe7abea7e8f225720e4e72e6c5@rjp.ie>
		 <CABBYNZLgugMFofwxAV4qFFP=RCnXG22MbcTgdt88ydbkSEKO9Q@mail.gmail.com>
	 <cc92dcae7bf3c7832643071df30eb5734097d2d1.camel@hadess.net>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ke, 2026-02-25 kello 17:01 +0100, Bastien Nocera kirjoitti:
[clip]
> > Feel free to git a review to Lars's patch; hopefully, that will help
> > us get this resolved quicker. We might as well create a unit test for
> > shell to try to emulate different modes and environments. That way,
> > we
> > prevent introducing regressions like this in the future.
>=20
> I wrote one, which I can integrate into meson.
>=20
> This starts "btvirt" (so requires root), launches bluetoothd if there
> isn't a daemon already running, and launches "bluetoothctl list".
>=20
> You can run it manually with:
> $ sudo top_builddir=3D/path/to/bluez/builddir/ ./integration-test.py
>=20
> If "bluetoothctl list" doesn't output any text, the test errors out.
> I've tested that pointing the bluetoothctl_path() output at an old
> version of bluetoothctl worked.
>=20
> This pattern of using Python to create test suites using python-
> dbusmock is something I've already used in PolicyKit, upower, power-
> profiles-daemon, gnome-bluetooth and many other places.
>=20
> This test is pretty heavy-handed if we just want to test whether
> bluetoothctl outputs things correctly, but it has the benefit of
> testing the emulator as well as bluetoothd. We could start adding more
> tests to the mix, such as creating more adapters, pairing them, etc.
>=20
> Hopefully, this is a useful test to run on CIs, although I'm probably
> missing spawning a system bus on top of everything else.
>=20
> What do you think?

Adding some testing for this is a good idea, and I'd think Python is
the way to go.

I was planning on pushing this a bit further, and automate also end-to-
end integration testing.=C2=A0That is, QEmu instances connected to each
other via btvirt, so we can have repeatable tests in a "real"
environment.

This is maybe overkill for simple bluetoothctl command line tests, but
it allows things like automated testing of Pipewire <-> Bluez <->
btvirt <-> BlueZ <-> Pipewire audio setup.

This involves lots of subsystems, and it's currently 100% relying on
manual testing and sometimes things are missed, like breaking A2DP in
some setups in 5.86, or breaking BAP in 5.85.

Here's a working prototype, needs some more work though so details may
change but the general shape is probably going to stay:

https://github.com/pv/bluez/blob/func-test/unit/func_test/test_cli_simple.p=
y

https://github.com/pv/bluez/blob/func-test/doc/test-functional.rst


--=20
Pauli Virtanen
