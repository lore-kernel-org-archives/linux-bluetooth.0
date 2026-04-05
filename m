Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7F61A285
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775393168; cv=pass; b=CrA6XRj6J0XJ2R6NDnx2/8JLpKwn33cO8A1YhP/ytG3ejuXAcHKb0RwXQRg0vXEnxx66UHjABizKcH+VSBwoTB2GMqQoSikMLmvIA9SM19Ws6+bvnujVvpwDvR1waabfeKT4KA642mKX7ydAUroNvmtC6H7+VMoZ9snofnixHZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775393168; c=relaxed/simple;
	bh=a4oih04jlTUOj6HrlfYVdeeRbA5HVLZm7qwaDTqCJGU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rhd5k5iOeBr2SC3sTvWxo3UQB6/0vnr3qYwG1f0k8AakenE5LjZPkGURYHnVWE1SuxThhjswDEiU+0iwtm/CNttRDaV4bOITlQl5Zbo1c/NW+CzF+Nm/zILSeFMIvlkgKjKesfU1Ngiav9Ot4ZxwSRqGHeOKNmanzlwQjL+hL7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=U5r5uz9Q; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="U5r5uz9Q"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fpX6Z2r3jz49PvR;
	Sun, 05 Apr 2026 15:37:42 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1775392662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPvgHHYKCMbfWOo+F/9+Pidcxmv8CoZ5dpcu19/NApI=;
	b=U5r5uz9QuPtZoOlsepUQJsGBOt4nb8Brj9xuysOKRTEFt3FMxn76Avc0/+0ZthMjCGaNq1
	yuoxNkBH/yEAsyGqPBIqHPHQpYl3V1hcyAtXMrQC+PozgZNakaR9PDahpFIPyMZLqIoP/t
	giFv25TwjajmV41HMQW0mNjemWDkW4xfVV78X90rn8/Z4QbRedRTiSvqpQepLx+ei4xXSc
	lX6sFByJBAALZETA5VsU95OrgkpCQAIVqKWG6MU0pQ9wq8cvorFQKGi/A056R280wwCT2t
	IhLJ1stD9L2KZNqO4eVctqRFcjbNWvdLJfs1AL5vcJWId58eJ6UCYJwV8nJB9Q==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1775392662;
	b=tRCET54T0mu56/b3l91KUadfCqIcmh4qaLllaiHS4crAAveQaN3Z18vCj3P4ZSGmaYHC+N
	2+RTtnNujxEHuK9fA3DXauZQXEhRWoCQ9Gk0VOf/HzhWmkLjez9HrqtcpAIZCsyHX3pumc
	ck1owk4oluJgAsRvqudV3N3bLiq3c74exY9ETcDsoOhwRm+rVSy8QsO3CV+Wdjjr2Rg9Ps
	YE/zp7FhIX/PBoaSqmejJAupiU70dGU5e+bnogRhddYNhi1J0pFSLKa1hiznP5SpFXwYQV
	XvNT9PSlmoIfvkQL3tQqwMoWggoxkIv0HbxDNcrqQz3skVBIrQcrK+nggBt8gg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1775392662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPvgHHYKCMbfWOo+F/9+Pidcxmv8CoZ5dpcu19/NApI=;
	b=LRm4kNIDxSXOox8W8GXiVgP9oyPfTZQ8FiND9OoLZuK1kBYfwxtIf2FfSQvQ24VgBUFFHj
	V8iS2ZmwQub1YPObaEJReEyEUf6T+Ksr6kX1r9vA5ppv9woDKd2gTOqDlbbtC3Xz1RiOSk
	8RAl4WaRFqdVIrx2TxmcJB5mKdrYy4C/oknIP1zIg8lHVOP1iWJC6aFPSUAB7FU9oZlGAb
	ekThPx2VqIXX24bhf2so0MZr9KUCYcvNiFUWhfbOuiZkY+ehi2kedK4Gndhv200JDUG0o5
	OduqEiP4/tmsj9QQqjbHlC6r8XMieIE71vhjKV2nyYuuaRZPTVU8oSDDf5DNXg==
Message-ID: <15bf885f56faa1bd5eed300f8e436428c98906ca.camel@iki.fi>
Subject: Re: Integration testing for BlueZ
From: Pauli Virtanen <pav@iki.fi>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sun, 05 Apr 2026 15:37:41 +0300
In-Reply-To: <600acd737462930466b32072e7d86c857ba35c93.camel@hadess.net>
References: <20260218024605.70890-1-ronan@rjp.ie>
		 <20260218024605.70890-3-ronan@rjp.ie>
		 <CABBYNZJqjaDJmkEy0yvyqLXP6kFH-dVjnzcCVknAkpu39zspaA@mail.gmail.com>
		 <defdb4fb77123ebe7abea7e8f225720e4e72e6c5@rjp.ie>
		 <CABBYNZLgugMFofwxAV4qFFP=RCnXG22MbcTgdt88ydbkSEKO9Q@mail.gmail.com>
		 <cc92dcae7bf3c7832643071df30eb5734097d2d1.camel@hadess.net>
		 <c606541c5c1309b9d4be685962f429581eaa7ffb.camel@iki.fi>
		 <177a2b4ff440d84853662e042082f6580e41aed4.camel@hadess.net>
		 <628CF193-5AAC-49F4-A7D0-D4417EC6B4D2@iki.fi>
	 <600acd737462930466b32072e7d86c857ba35c93.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

ma, 2026-03-30 kello 17:03 +0200, Bastien Nocera kirjoitti:
> On Mon, 2026-03-30 at 12:59 +0000, Pauli Virtanen wrote:
> > > Do you still have a copy of the above file somewhere? I wanted to
> > > finish porting them into my own integration tests which I'm hoping
> > > to
> > > add to the regression/unit tests that are usually run for every
> > > commit/MR.
> >=20
> > https://github.com/pv/bluez/blob/func-test-v3/test/functional/test_blue=
toothctl_vm.py
> >=20
> > and test_btmgmt_vm.py
> >=20
> > Although these don't currently contain much, but could be extended.
> >=20
> > FWIW I'd maybe consider using pytest also for Python regression &
> > unit tests, at least if you can make them run without root.
> >=20
> > There's interesting bluetoothd mock dbus library by the bluez-alsa
> > developer, which looks like it could be useful for bluetoothctl/etc
> > utility testing
> >=20
> > <https://github.com/Samsung/bluezoo>
>=20
> I'm pretty familiar with python-dbusmock which includes a bluetoothd
> mock server which can be used as non-root:
> https://github.com/martinpitt/python-dbusmock
>=20
> It's used extensively in the gnome-bluetooth test suite:
> https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/blob/master/tests/integr=
ation-test.py?ref_type=3Dheads
> along with its mock upower implementation.
>=20
> bluezoo looks more like a complete replacement including some behaviour
> when running certain commands. The python-dbusmock implementation is
> voluntarily simpler.
>=20
> The questions at the end of the day boils down to *what* we want to
> test:
>=20
> 1) Just like the gnome-bluetooth test suite, we could only care for our
> own code, bluetoothd and upower are mocked, no specific hardware or
> permissions is required.
>=20
> This usually requires tweaking the mock implementation to better match
> the behaviour of the real thing.
>=20
> 2) As I've implemented in this integration test:
> https://github.com/hadess/bluez/blob/wip/hadess/add-meson-ell-wrap/unit/i=
ntegration-test.py
> we test command-line tools against the real bluetoothd which we
> compile, it requires either root (to run btvirt if needed, and run
> bluetoothd), or a machine with a real/mocked hardware and bluetoothd
> already running. Ideally, with root access, you're testing the
> "integration" of the command-line tools and bluetoothd.
> Do we want to run those against a mocked bluetoothd that could get out
> of sync with reality?
>=20
> This wouldn't allow us to test bluetoothd itself as I've done in one
> test, but maybe that's good to allow us to run those tests in more
> circumstances?
>
> My goal was being able to run "meson test" on my local development
> machine without worrying about a layer of possibly outdated mocking
> code.
>=20
> I'd be fine running those tests that could be against a mocked
> bluetoothd, if that means more tests being run.
>=20
> I'd expect both those first options to be run for every merge request
> or patch set, possibly even for every commit if we run into errors.
>=20
> 3) We have your variant of the test suite that does what 2) does but
> with many more moving parts, and pretty high requirements in terms of
> setup (and possibly resources). The only thing that's mocked is the
> Bluetooth adapters, and not even for all tests.
>=20
> In short, I think I might, before sending a patch out, re-focus the
> basic tools tests to run against a mocked dbusmock bluez, so they
> always run, whatever the environment.
>=20
> Next, we can try to figure out whether some tests like the bluetoothd
> startup warning one can be shared between the "run on every merge
> request" (option 2) vs. "run once a week or once a day" heavier duty
> tests (option 3).

Yes, mocked tests make sense only for subset of tests, here I was
thinking about the regression tests that check that "--help" works and
"bluetoothctl" prints things correctly. Didn't remember dbusmock had
stubs for some bluetoothd services.

The VM-based tests have some advantages in that the environment is more
reproducible, you are able to test against bluetooth-next kernel, and
they are more convenient to run on dev workstation as they don't need
root or interfere with system services.

In principle several of the tests could run both on host kernel with
btvirt,=C2=A0and with some extra work you could define a compatible test
fixture that can reuse the exact same test code, or just write the
tests in a way that the test core can be reused. Although the
bluetoothd + kernel stack is written in a way that controllers are
independent, the single-host test setup is not exactly the same as
multiple hosts, so there's probably some value in end-to-end tests.

Performance-wise there is some room for improving the VM test speed,
eg. not compiling kernel with lock debugging etc. slow debug options
on, and using virtiofs instead of 9p as it appears the emulated 9p disk
access is somewhat slow. The VM boot time is already amortized by
reusing the VM instances, and bluetoothd etc environment restarts can
be avoided where possible, so you could write multiple tests like the -
-help one with VM adding mostly a fixed cost.

The tests that pair devices first spend time on waiting on the btvirt
page timeout which is adding many seconds per tests. So there is also a
non-negligible part of test time that is not limited by VM execution
speed.


For any tests running outside VM, it's probably simplest to write them
in such a way that the test core could be reused. E.g. the bluetoothctl
completion crash for example like would be

def check_bluetoothctl_completion_crash():
    child =3D pexpect.spawn(bluetoothctl)
    child._decoder =3D AsciiDecoder()
    child.expect(r"\[bluetoothctl\]> ")
    child.sendline(" \t")
    child.expect(r"\[bluetoothctl\]> ")

    time.sleep(0.5)

    assert child.isalive()

@bluetoothd_reuse_config
def test_bluetoothctl_completion_crash(hosts):
    (host,) =3D hosts

    host.call(check_bluetoothctl_completion_crash)

This adds ~0.8 sec to the total test duration in VM (compared to ~0.7
outside VM with system bluetoothd), as the test does not require
bluetoothd or VM restart.

I'd also write all tests properly as Python package that can be
imported elsewhere as needed, and follow the pytest convention that
tests are in files named `test_*.py`, so that they and any helper
functions are more reusable. If you use pytest for them, you also don't
need a runner script.

For deciding what to run on CI, probably real runtime numbers are what
matters. If the VM tests are fast enough, I'd think it would be OK to
run them for all patches, as is done with the kernel VM testers.

--=20
Pauli Virtanen
