Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CBC3B79F
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 May 2024 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716798194; cv=none; b=dfYRNRlz0arxPolpMG8Ycd+uaUP/0EN4jLckCA6zWhONRjEhVhdBbznKjqfj6paJR/cOUHakz9g5mV19nqUNXC6cISSZSk4gfGlLyqIEFJNKlZvZVyZEVdq5clRNl7Qho8xUqdl0ZHcbwzN2t590upMQRlpGGdUHkY4DpuwG4XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716798194; c=relaxed/simple;
	bh=kV3Y3/B15SS7YHVquldk7lUlPQZs8vZ9luyLgF+RpdQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mwdh3MJuGzmXfy+BC68ktsQUL/Gx2Yjz5kSck6WPrLSdwdOsnRqmXiWdaSz4AYaL9Ll0V5wEEpMEOjmFNQcvURQglH+8HtrSvn5ZMbG+bjcRAgJWrS7PkjwQ6PcfkgBKHonqnHcPXZi2C5FKf5mc/gFO3YF6GloTewcwohfER1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4ADC2FF803;
	Mon, 27 May 2024 08:23:10 +0000 (UTC)
Message-ID: <b302038a5ba5455b7482f3f2738b1fd1e7041a86.camel@hadess.net>
Subject: Re: [BlueZ 00/15] Fix a number of static analysis issues #2
From: Bastien Nocera <hadess@hadess.net>
To: patchwork-bot+bluetooth@kernel.org
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 27 May 2024 10:23:09 +0200
In-Reply-To: <171589263382.16065.450653433983934585.git-patchwork-notify@kernel.org>
References: <20240516090340.61417-1-hadess@hadess.net>
	 <171589263382.16065.450653433983934585.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net

On Thu, 2024-05-16 at 20:50 +0000, patchwork-bot+bluetooth@kernel.org
wrote:
> Hello:
>=20
> This series was applied to bluetooth/bluez.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>=20
> On Thu, 16 May 2024 11:03:04 +0200 you wrote:
> > "main: Simplify variable assignment" makes a come back, moving out
> > the
> > single special-case out of the function.
> >=20
> > For "shared/gatt-client: Fix uninitialised variable usage", please
> > verify
> > that this default value is correct.
> >=20
> > Happy to iterate on any patches you feel are suboptimal. Note that
> > the
> > only patches that received any sort of real-world testing are the
> > one
> > mentioned above and the gdbus one.
> >=20
> > [...]
>=20
> Here is the summary with links:
> =C2=A0 - [BlueZ,01/15] main: Simplify variable assignment
> =C2=A0=C2=A0=C2=A0 (no matching commit)

This one wasn't applied. I'll resubmit it separately with a better
commit message.

> =C2=A0 - [BlueZ,02/15] shared/ecc: Fix uninitialised variable usage
> =C2=A0=C2=A0=C2=A0
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D0a1159dc1055
> =C2=A0 - [BlueZ,03/15] shared/gatt-client: Fix uninitialised variable
> usage
> =C2=A0=C2=A0=C2=A0
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D75eda690c4af
> =C2=A0 - [BlueZ,04/15] tools/mesh-cfgclient: Fix uninitialised variable
> usage
> =C2=A0=C2=A0=C2=A0
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dc63b7b0d732e
> =C2=A0 - [BlueZ,05/15] test-runner: Remove unused envp
> =C2=A0=C2=A0=C2=A0
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D9f4b2d0287ef
> =C2=A0 - [BlueZ,06/15] test-runner: Fix uninitialised variable usage
> =C2=A0=C2=A0=C2=A0
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D0640d99ebfae
> =C2=A0 - [BlueZ,07/15] test-runner: Fix uninitialised variable usage
> =C2=A0=C2=A0=C2=A0
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D9672cf410f8b
> =C2=A0 - [BlueZ,08/15] shared/bap: Fix possible use-after-free
> =C2=A0=C2=A0=C2=A0
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D52336ad64548
> =C2=A0 - [BlueZ,09/15] isotest: Fix bad free
> =C2=A0=C2=A0=C2=A0
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D7a6385570494
> =C2=A0 - [BlueZ,10/15] test-runner: Fix fd leak on failure
> =C2=A0=C2=A0=C2=A0
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D566af9c2f5ef
> =C2=A0 - [BlueZ,11/15] isotest: Fix string size expectations
> =C2=A0=C2=A0=C2=A0 (no matching commit)

Committed as:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3Df05e448cf81=
b6ff0a8c7fc1e3accdb4f436a46e0

> =C2=A0 - [BlueZ,12/15] mgmt-tester: Fix non-nul-terminated string
> =C2=A0=C2=A0=C2=A0
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D49d06560692f
> =C2=A0 - [BlueZ,13/15] gdbus: Check sprintf retval
> =C2=A0=C2=A0=C2=A0
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D20a0255b9e5f
> =C2=A0 - [BlueZ,14/15] shared/bap: Fix memory leak in error path
> =C2=A0=C2=A0=C2=A0
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D377f2ec0721f
> =C2=A0 - [BlueZ,15/15] android/handsfree: Check sprintf retval
> =C2=A0=C2=A0=C2=A0
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dc9fe888793e5
>=20
> You are awesome, thank you!

