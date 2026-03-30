Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470873C9ECC
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875565; cv=pass; b=Rq4Bpi4UJBI/cfjLRnHbgmRnCWFbnFo/S4BchaOqdT3iUnF6sQTr9jmLRKZI4MeS629aIu+6RzIlrVnZEStc6JAaTjjpOnjfHgUxmu5NzqmeYYVvBFjcYVZvmJn584fGVd1cfL+pq1UT4VOT6KAA6Emdt1CMfxJoCV8VpdMmtXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875565; c=relaxed/simple;
	bh=48QiZB9XBAyWcxJfK4Fe27ymsr8mfRB5kTyPo51TI4g=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=BeeGgmmS9rY2ODo88ge4huGMhBa+ATv/v8RsgxRzA7bF1y3BbylOznVJ+P5KhKmlWcr4hw4Kt80u6bkh5V/enIqt2XXowNa3EOe7M6VFG1sHBgvnsUdMJthy3rShN/t7xfF3UUF53i4tFZgyK1IqBMcscgbZyW5C1jm/XrqqgAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=ZMko87Tz; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="ZMko87Tz"
Received: from ehlo.thunderbird.net (unknown [143.244.47.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fkrtH6tvBzyR8;
	Mon, 30 Mar 2026 15:59:19 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774875561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48QiZB9XBAyWcxJfK4Fe27ymsr8mfRB5kTyPo51TI4g=;
	b=ZMko87TzOoXb2rQCyqdKmDC3o1VEmVudC+8DJsYqdksiCFK4ox86u2hP967vq+ULtAVVzP
	vhe0haaHXe3SQUBEGJRkjbVkJQMYxQcQAep9iWObDyHv3h/WmWVNnWgVigLlrheP2IqFLD
	3d3IBT1wjoI3R9iLOzKbSZGp8MC2QPc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774875561;
	b=T3X0lcNBPr2c0EVmpuPbbCo6jWL5O0/qU6Xbr2MsjDeSir60M9R3HHYe7B2DHOXk2ApWje
	UMnWHBsdDBXOqDUo2QJn1L40aFE/o06BLfirt6zOJSOdmIp1S/WhKkEMHcszA7SjHBK5E4
	r7J0nBxnfIFwdbYmrdUGnnFxNcVqrI4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774875561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48QiZB9XBAyWcxJfK4Fe27ymsr8mfRB5kTyPo51TI4g=;
	b=OjbaSg2+tBPeztI1zoyEVoqJt1onqXbjYoJ/E0y89pkYCN0mzhj9Pq1G2Ybg8/l64MyoZF
	iadKqFYtbaaY2H9UkcUxx6UVaMvjvz3WLsyByvSyW/o5Mqn31cIlGhnw3JZ5aZmMJml+vf
	T37rNlYBa9ihqq7wMwx9EzSjaxuPukw=
Date: Mon, 30 Mar 2026 12:59:14 +0000
From: Pauli Virtanen <pav@iki.fi>
To: Bastien Nocera <hadess@hadess.net>
CC: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: Integration testing for BlueZ
In-Reply-To: <177a2b4ff440d84853662e042082f6580e41aed4.camel@hadess.net>
References: <20260218024605.70890-1-ronan@rjp.ie> <20260218024605.70890-3-ronan@rjp.ie> <CABBYNZJqjaDJmkEy0yvyqLXP6kFH-dVjnzcCVknAkpu39zspaA@mail.gmail.com> <defdb4fb77123ebe7abea7e8f225720e4e72e6c5@rjp.ie> <CABBYNZLgugMFofwxAV4qFFP=RCnXG22MbcTgdt88ydbkSEKO9Q@mail.gmail.com> <cc92dcae7bf3c7832643071df30eb5734097d2d1.camel@hadess.net> <c606541c5c1309b9d4be685962f429581eaa7ffb.camel@iki.fi> <177a2b4ff440d84853662e042082f6580e41aed4.camel@hadess.net>
Message-ID: <628CF193-5AAC-49F4-A7D0-D4417EC6B4D2@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

30=2E maaliskuuta 2026 12=2E38=2E49 UTC Bastien Nocera <hadess@hadess=2Ene=
t> kirjoitti:
>On Wed, 2026-02-25 at 20:58 +0200, Pauli Virtanen wrote:
>> Hi,
>>=20
>> ke, 2026-02-25 kello 17:01 +0100, Bastien Nocera kirjoitti:
>> [clip]
>> > > Feel free to git a review to Lars's patch; hopefully, that will
>> > > help
>> > > us get this resolved quicker=2E We might as well create a unit test
>> > > for
>> > > shell to try to emulate different modes and environments=2E That
>> > > way,
>> > > we
>> > > prevent introducing regressions like this in the future=2E
>> >=20
>> > I wrote one, which I can integrate into meson=2E
>> >=20
>> > This starts "btvirt" (so requires root), launches bluetoothd if
>> > there
>> > isn't a daemon already running, and launches "bluetoothctl list"=2E
>> >=20
>> > You can run it manually with:
>> > $ sudo top_builddir=3D/path/to/bluez/builddir/ =2E/integration-test=
=2Epy
>> >=20
>> > If "bluetoothctl list" doesn't output any text, the test errors
>> > out=2E
>> > I've tested that pointing the bluetoothctl_path() output at an old
>> > version of bluetoothctl worked=2E
>> >=20
>> > This pattern of using Python to create test suites using python-
>> > dbusmock is something I've already used in PolicyKit, upower,
>> > power-
>> > profiles-daemon, gnome-bluetooth and many other places=2E
>> >=20
>> > This test is pretty heavy-handed if we just want to test whether
>> > bluetoothctl outputs things correctly, but it has the benefit of
>> > testing the emulator as well as bluetoothd=2E We could start adding
>> > more
>> > tests to the mix, such as creating more adapters, pairing them,
>> > etc=2E
>> >=20
>> > Hopefully, this is a useful test to run on CIs, although I'm
>> > probably
>> > missing spawning a system bus on top of everything else=2E
>> >=20
>> > What do you think?
>>=20
>> Adding some testing for this is a good idea, and I'd think Python is
>> the way to go=2E
>>=20
>> I was planning on pushing this a bit further, and automate also end-
>> to-
>> end integration testing=2E=C2=A0That is, QEmu instances connected to ea=
ch
>> other via btvirt, so we can have repeatable tests in a "real"
>> environment=2E
>>=20
>> This is maybe overkill for simple bluetoothctl command line tests,
>> but
>> it allows things like automated testing of Pipewire <-> Bluez <->
>> btvirt <-> BlueZ <-> Pipewire audio setup=2E
>>=20
>> This involves lots of subsystems, and it's currently 100% relying on
>> manual testing and sometimes things are missed, like breaking A2DP in
>> some setups in 5=2E86, or breaking BAP in 5=2E85=2E
>>=20
>> Here's a working prototype, needs some more work though so details
>> may
>> change but the general shape is probably going to stay:
>>=20
>> https://github=2Ecom/pv/bluez/blob/func-test/unit/func_test/test_cli_si=
mple=2Epy
>
>Do you still have a copy of the above file somewhere? I wanted to
>finish porting them into my own integration tests which I'm hoping to
>add to the regression/unit tests that are usually run for every
>commit/MR=2E

https://github=2Ecom/pv/bluez/blob/func-test-v3/test/functional/test_bluet=
oothctl_vm=2Epy

and test_btmgmt_vm=2Epy

Although these don't currently contain much, but could be extended=2E

FWIW I'd maybe consider using pytest also for Python regression & unit tes=
ts, at least if you can make them run without root=2E

There's interesting bluetoothd mock dbus library by the bluez-alsa develop=
er, which looks like it could be useful for bluetoothctl/etc utility testin=
g

<https://github=2Ecom/Samsung/bluezoo>



>
>>=20
>> https://github=2Ecom/pv/bluez/blob/func-test/doc/test-functional=2Erst
>>=20
