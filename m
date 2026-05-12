Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0339F3C9EF8
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617621; cv=none; b=pNMJ461LJZKWpqa1l3+TEKhvcL8WfdCq1JFtTKLs0PInj7jJ2J/PLrIgAqotb3Cd1TpFRDI70WqFUOFWwdDHSIbG/e+zkcGpX+jQPXkJJr3DdB5BDdYP6UekMAQ2ccdGquVU4+51PDcH9UO5w3+HpWTpgAxR3tSq9HKy4m94Bk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617621; c=relaxed/simple;
	bh=0JUE0P+SgXykj5K+OhIv7/9F3qTT28tXqPqL7ARXZBw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IpkWIQXaNkYDgmrxOoo+54ZevNCAww8h5o6cRjIVi8uDUWjdU4M8v3zZoKIsBVCbaJWTQnRnUKXJgXUjGGWzufDJqFn3ZVxXuHuFB9s/nQ3t3epxREzfPypn/t1+d0Mf2Lo0C3wGhq9bmVHoecMbDRmHcKTaq2I+tm5iXh+W0EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id BCFD958129F
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 20:12:52 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1830D3EC06;
	Tue, 12 May 2026 20:12:44 +0000 (UTC)
Message-ID: <c08f3ddc3ec984687ab0b0d2e4f069c8cdf87b4a.camel@hadess.net>
Subject: Re: [BlueZ v3 0/6] Add helper for "cleanup" variable attribute
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 12 May 2026 22:12:44 +0200
In-Reply-To: <CABBYNZ+RZH25K0jhRsrTbYOZxQQeV9EvxYK907sgGW0Ot-mR3Q@mail.gmail.com>
References: <20260511132131.1283892-1-hadess@hadess.net>
	 <177861361154.3045511.1045324340041670862.git-patchwork-notify@kernel.org>
	 <CABBYNZ+RZH25K0jhRsrTbYOZxQQeV9EvxYK907sgGW0Ot-mR3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTG2p/bHZkgw6xmsX4ACWRwK1XLxqY8cMDc7tOPx6t1OoohCIGNZbvzDJ3bRrQKORaTvRvtLTI1N1DU/Q3svJHzYAzp61SscAjxPL+628dABiSfsGh5aq9sHq5Z72dN4//ZQCXhXz//eXWi5TUBnNKl9PmICw+/MEHrda6H2GiigPPPyXJ/V4zi9kt1FJAyzijfu4gGomHc6XHGAQfUm9U0ioqXcWJxjHpU6ZcGfvIfvSSaiJGIODCrrMJvncdt5rWrPc/K8HkuxmwDBIBIr6cNLuPktqEtzomZL+UpaBXkNl0vNUFs/6yt5abeRNjfEIjnuoCElMv2Fu0VBt8U29dnBBcO3tMAXjRLGxFe/odfjDABOgQV8HYbebN4HFo5VJ+VVzXziR4DMfdJANkP/xDRTFZBTphw7wquUS9hn8GJcFThkyHY0HQPZ2031sAwigk6H6YHpdy0tLMlq//GprDvR1Fpw8RhRDwN7ijbbPzHFu3GK0KoVfhPOq0l+nx6GhZpRHlZVqwdzlZshzc223KfN5AGoGHsbF+KczqQBnyHahS6GgITON3r7df6hT8SOyZnxlx2HppQ3NC6OQtMQI4OLLTL3Rtgs3bYCgtEAlZntymR4fHfRgp2az6zUSWX4XZ1mFH0VtzpPfUyt4RvVIFrOSwTNZLCkHHyUYaxrIoI8OQ
X-GND-State: clean
X-GND-Score: -100

On Tue, 2026-05-12 at 15:38 -0400, Luiz Augusto von Dentz wrote:
> Hi Bastien,
>=20
> On Tue, May 12, 2026 at 3:21=E2=80=AFPM <patchwork-bot+bluetooth@kernel.o=
rg>
> wrote:
> >=20
> > Hello:
> >=20
> > This series was applied to bluetooth/bluez.git (master)
> > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> >=20
> > On Mon, 11 May 2026 15:18:03 +0200 you wrote:
> > > As discussed in:
> > > https://lore.kernel.org/linux-bluetooth/ed949f2550f79a4bef19bd482bf8b=
069ad5b7e0c.camel@hadess.net/
> > >=20
> > > Implement a cleanup helper.
> > >=20
> > > The MIN/MAX fix is here because it touches the same hunk in
> > > src/main.c
> > > as the other patches. Feel free to pick it up straight away while
> > > the
> > > rest is discussed.
> > >=20
> > > [...]
> >=20
> > Here is the summary with links:
> > =C2=A0 - [BlueZ,v3,1/6] all: Remove more unneeded MIN/MAX macro
> > definition
> > =C2=A0=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dca2b39b0c08e
> > =C2=A0 - [BlueZ,v3,2/6] shared/util: Add helper for "cleanup" variable
> > attribute
> > =C2=A0=C2=A0=C2=A0 (no matching commit)
> > =C2=A0 - [BlueZ,v3,3/6] doc: Recommend using _cleanup_ and friends
> > =C2=A0=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D9ba6c13df5fb
> > =C2=A0 - [BlueZ,v3,4/6] main: Use _cleanup_() to simplify configuration
> > parsing
> > =C2=A0=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D140e3569295c
> > =C2=A0 - [BlueZ,v3,5/6] client: Use _cleanup_fd_ to simplify urandom
> > access
> > =C2=A0=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3De33f5027b898
> > =C2=A0 - [BlueZ,v3,6/6] btattach: Use _cleanup_fd_ to simplify error
> > paths
> > =C2=A0=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D02aa9a8cfe6a
> >=20
> > You are awesome, thank you!
> > --
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
>=20
> We will probably need to revert the cleanup changes, they are causing
> crashes and other problems when run under Valgrind.

Please do, I've managed to reproduce some of the problems locally,
which I didn't see in my testing, even running under valgrind.

I'll send a v4 later.

Cheers
