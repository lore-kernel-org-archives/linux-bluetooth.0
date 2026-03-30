Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AA533436A
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774883030; cv=none; b=DylYPwAdKG7Isdl5UfWH58DQ9OVn5NVwQ+ot7Ti7s/M2N0s6CUVskctGNL2xrEFcPiuW5LTfZUT/yUhFShH8ItwvUldGewAL+5b8j9lc/T8Hk4rkR+IgXK7wfzKTmez4jHAgfeFVUbuVkKZOYRr/8EtP8xjCWjidSMiLf04C45Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774883030; c=relaxed/simple;
	bh=ch/Vt7R/w0zXjWVENWfacUwMJ9MOPSnsOZvTUwrXjwE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a+kOsSY/lV6xAzBBlQWbnGdTOi24Uyu9TDOfSNJIO1yZTXL/zz3iouR7/byBFmE9AG96OcNw8Y1fmpn6hOuTqEtO1R1xQQIF4fs9IuRcowtQC4IKrESomalBSGU1sy7vFcc/ueTwlmpCzr/ZfigG66WAY142HJJyP8DcSGpqV34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6988F3EC17;
	Mon, 30 Mar 2026 15:03:46 +0000 (UTC)
Message-ID: <600acd737462930466b32072e7d86c857ba35c93.camel@hadess.net>
Subject: Re: Integration testing for BlueZ
From: Bastien Nocera <hadess@hadess.net>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Mon, 30 Mar 2026 17:03:46 +0200
In-Reply-To: <628CF193-5AAC-49F4-A7D0-D4417EC6B4D2@iki.fi>
References: <20260218024605.70890-1-ronan@rjp.ie>
	 <20260218024605.70890-3-ronan@rjp.ie>
	 <CABBYNZJqjaDJmkEy0yvyqLXP6kFH-dVjnzcCVknAkpu39zspaA@mail.gmail.com>
	 <defdb4fb77123ebe7abea7e8f225720e4e72e6c5@rjp.ie>
	 <CABBYNZLgugMFofwxAV4qFFP=RCnXG22MbcTgdt88ydbkSEKO9Q@mail.gmail.com>
	 <cc92dcae7bf3c7832643071df30eb5734097d2d1.camel@hadess.net>
	 <c606541c5c1309b9d4be685962f429581eaa7ffb.camel@iki.fi>
	 <177a2b4ff440d84853662e042082f6580e41aed4.camel@hadess.net>
	 <628CF193-5AAC-49F4-A7D0-D4417EC6B4D2@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFl1MjfQKmO+NLo0keK/H8efcTmOltLI+f/+n5RrskmUCkDgz0ZI2T77y7v8b4ExU1BI+Mk4h0pwWrLMjgbRkJxDFSluYjU8uR8RNs36JbAvuAxd46cLZ+itHmyP2uzF3shn/T4Z9kW501qZ7bdVirxDWgMcQUR0OptN+I6e9Z6oTwGjoHd8LiDQjHz5BDVcbBtbAqzRbTKVMQcTRs5BkCBti7IA8z+u713Klcy9fmdQP3P/tUa7zkiWcS4OF1ZgeDwYhf0GqqewmOlqiX4NGVMkzrgNDLG+dWy4WcgEymYuRkWXLrC4yK6HMtMRvUDMrtBeDMMgWKNZcPJl6Mu5Qu5WLrjV/ZLCnP/OQmsO0acK+MkZFrk+yqp84eoUXbJvtIC7oL4qK+Vik6xtMJp3L/6uVoUr7AV2mj4mNcRLJd4gWJH4FTAmGslzjwQXvVR13EmOfP2UuHmWglodvHiMcHaRdKBe9bjr9gvaLM2XH6SG7wjeoq5h4bkE0WI1t9er0wGF5Ad7Zm13C0tjyQ3POfSMD9E/XiXddqkE9A0ppZ9j7vMzRfV7eKoCzEuN2aBfy3nXCYEwTIp61JiWHV0L/UdT67jHiJbMv8mdWv9lj/L1Mg0Wtaq9TOLJDQrr3RnV3n7mesYwAv7kg/vLw92f+zwj2lWagY7Z+1tHIZcvk780g

On Mon, 2026-03-30 at 12:59 +0000, Pauli Virtanen wrote:
> > Do you still have a copy of the above file somewhere? I wanted to
> > finish porting them into my own integration tests which I'm hoping
> > to
> > add to the regression/unit tests that are usually run for every
> > commit/MR.
>=20
> https://github.com/pv/bluez/blob/func-test-v3/test/functional/test_blueto=
othctl_vm.py
>=20
> and test_btmgmt_vm.py
>=20
> Although these don't currently contain much, but could be extended.
>=20
> FWIW I'd maybe consider using pytest also for Python regression &
> unit tests, at least if you can make them run without root.
>=20
> There's interesting bluetoothd mock dbus library by the bluez-alsa
> developer, which looks like it could be useful for bluetoothctl/etc
> utility testing
>=20
> <https://github.com/Samsung/bluezoo>

I'm pretty familiar with python-dbusmock which includes a bluetoothd
mock server which can be used as non-root:
https://github.com/martinpitt/python-dbusmock

It's used extensively in the gnome-bluetooth test suite:
https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/blob/master/tests/integrat=
ion-test.py?ref_type=3Dheads
along with its mock upower implementation.

bluezoo looks more like a complete replacement including some behaviour
when running certain commands. The python-dbusmock implementation is
voluntarily simpler.

The questions at the end of the day boils down to *what* we want to
test:

1) Just like the gnome-bluetooth test suite, we could only care for our
own code, bluetoothd and upower are mocked, no specific hardware or
permissions is required.

This usually requires tweaking the mock implementation to better match
the behaviour of the real thing.

2) As I've implemented in this integration test:
https://github.com/hadess/bluez/blob/wip/hadess/add-meson-ell-wrap/unit/int=
egration-test.py
we test command-line tools against the real bluetoothd which we
compile, it requires either root (to run btvirt if needed, and run
bluetoothd), or a machine with a real/mocked hardware and bluetoothd
already running. Ideally, with root access, you're testing the
"integration" of the command-line tools and bluetoothd.
Do we want to run those against a mocked bluetoothd that could get out
of sync with reality?

This wouldn't allow us to test bluetoothd itself as I've done in one
test, but maybe that's good to allow us to run those tests in more
circumstances?

My goal was being able to run "meson test" on my local development
machine without worrying about a layer of possibly outdated mocking
code.

I'd be fine running those tests that could be against a mocked
bluetoothd, if that means more tests being run.

I'd expect both those first options to be run for every merge request
or patch set, possibly even for every commit if we run into errors.

3) We have your variant of the test suite that does what 2) does but
with many more moving parts, and pretty high requirements in terms of
setup (and possibly resources). The only thing that's mocked is the
Bluetooth adapters, and not even for all tests.


In short, I think I might, before sending a patch out, re-focus the
basic tools tests to run against a mocked dbusmock bluez, so they
always run, whatever the environment.

Next, we can try to figure out whether some tests like the bluetoothd
startup warning one can be shared between the "run on every merge
request" (option 2) vs. "run once a week or once a day" heavier duty
tests (option 3).
