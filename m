Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8BC5B5D3
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681156; cv=none; b=OtEtHm5OnjPDfqprndfR/i4mLe4xRi9SfK7vfFu+YxXQaWx/A7Udz8p2c9pQBugWXFaUVaWDxlFjovZ6KdDUFtb0N1st4NMfsOBlNnopXMNjG8+KmLFe1K/nB2DFeMlz9Wj6r3x/kweLuoFvt2u5T4rKdZMm6dnsi3AScg1GvTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681156; c=relaxed/simple;
	bh=Leyc9rNXfismxXbcqgI0v1FeMq2aARRWIRJUl84tUQ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bYLhujLxCL18g2fMbc6x/11woCoiOExqMe1IG7QHR4E6YtamneIP5NzDvfQV8FJzkweEagk3Z7IrFtLIvzy/xLcq1uK3XCQhJ3tNW6DMzu4O5KQt+QWKkJNeWSz0NkvMDKKgHy8PDCJ6I93pcYr/ioJRF0rRSPo5uwrQZ1OgguU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C4126000E;
	Tue, 14 May 2024 10:05:45 +0000 (UTC)
Message-ID: <c7847f16f683a367b86d01cb572533236ec84bad.camel@hadess.net>
Subject: Re: [BlueZ v2 00/20] Fix a number of static analysis issues
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	patchwork-bot+bluetooth@kernel.org
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 14 May 2024 12:05:45 +0200
In-Reply-To: <CABBYNZJevU71O4wp_=UG+ch5HY42Gp9=7Fqf5OERp0GvZ9Cppg@mail.gmail.com>
References: <20240510121355.3241456-1-hadess@hadess.net>
	 <171535563283.2819.15014215823661998089.git-patchwork-notify@kernel.org>
	 <CABBYNZJevU71O4wp_=UG+ch5HY42Gp9=7Fqf5OERp0GvZ9Cppg@mail.gmail.com>
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

On Fri, 2024-05-10 at 12:42 -0400, Luiz Augusto von Dentz wrote:
> Hi Bastien,
>=20
> On Fri, May 10, 2024 at 11:48=E2=80=AFAM <patchwork-bot+bluetooth@kernel.=
org>
> wrote:
> >=20
> > Hello:
> >=20
> > This series was applied to bluetooth/bluez.git (master)
> > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> >=20
> > On Fri, 10 May 2024 14:10:10 +0200 you wrote:
> > > Changes since v1:
> > > - added 6 patches
> > > - Fix syntax error in "client/gatt: Check write_value() retval"
> > >=20
> > > Bastien Nocera (20):
> > > =C2=A0 adapter: Use false instead of 0 for bool
> > > =C2=A0 attrib/gatt: Guard against possible integer overflow
> > > =C2=A0 client/gatt: Don't pass negative fd on error
> > > =C2=A0 client/gatt: Check write_value() retval
> > > =C2=A0 client/main: Fix array access
> > > =C2=A0 client/main: Fix mismatched free
> > > =C2=A0 monitor/att: Fix memory leak
> > > =C2=A0 bap: Fix memory leaks
> > > =C2=A0 media: Fix memory leak
> > > =C2=A0 main: Fix memory leaks
> > > =C2=A0 isotest: Consider "0" fd to be valid
> > > =C2=A0 isotest: Fix error check after opening file
> > > =C2=A0 client/player: Fix copy/paste error
> > > =C2=A0 shared/vcp: Fix copy/paste error
> > > =C2=A0 isotest: Fix fd leak
> > > =C2=A0 iso-tester: Fix fd leak
> > > =C2=A0 sdp: Fix use of uninitialised memory
> > > =C2=A0 monitor: Work-around memory leak warning
> > > =C2=A0 avrcp: Fix uninitialised memory usage
> > > =C2=A0 main: Simplify variable assignment
> > >=20
> > > [...]
> >=20
> > Here is the summary with links:
> > =C2=A0 - [BlueZ,v2,01/20] adapter: Use false instead of 0 for bool
> > =C2=A0=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dd3fcc77f99da
> > =C2=A0 - [BlueZ,v2,02/20] attrib/gatt: Guard against possible integer
> > overflow
> > =C2=A0=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D1e22fd9adbb3
> > =C2=A0 - [BlueZ,v2,03/20] client/gatt: Don't pass negative fd on error
> > =C2=A0=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D1ba9e5f21ca2
> > =C2=A0 - [BlueZ,v2,04/20] client/gatt: Check write_value() retval
> > =C2=A0=C2=A0=C2=A0 (no matching commit)
> > =C2=A0 - [BlueZ,v2,05/20] client/main: Fix array access
> > =C2=A0=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Df3f762b77b58
> > =C2=A0 - [BlueZ,v2,06/20] client/main: Fix mismatched free
> > =C2=A0=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dab325450b0c2
> > =C2=A0 - [BlueZ,v2,07/20] monitor/att: Fix memory leak
> > =C2=A0=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D0b842fe9b1fe
> > =C2=A0 - [BlueZ,v2,08/20] bap: Fix memory leaks
> > =C2=A0=C2=A0=C2=A0 (no matching commit)
> > =C2=A0 - [BlueZ,v2,09/20] media: Fix memory leak
> > =C2=A0=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D3652e98d2bb6
> > =C2=A0 - [BlueZ,v2,10/20] main: Fix memory leaks
> > =C2=A0=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D45d151ec8a0f
> > =C2=A0 - [BlueZ,v2,11/20] isotest: Consider "0" fd to be valid
> > =C2=A0=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dd30dc38b0425
> > =C2=A0 - [BlueZ,v2,12/20] isotest: Fix error check after opening file
> > =C2=A0=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D9a36f191aa78
> > =C2=A0 - [BlueZ,v2,13/20] client/player: Fix copy/paste error
> > =C2=A0=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D6f041df23ecf
> > =C2=A0 - [BlueZ,v2,14/20] shared/vcp: Fix copy/paste error
> > =C2=A0=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D856353b254da
> > =C2=A0 - [BlueZ,v2,15/20] isotest: Fix fd leak
> > =C2=A0=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D3e03788ba80c
> > =C2=A0 - [BlueZ,v2,16/20] iso-tester: Fix fd leak
> > =C2=A0=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dc81f9320357b
> > =C2=A0 - [BlueZ,v2,17/20] sdp: Fix use of uninitialised memory
> > =C2=A0=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Ddc60ce0b460a
> > =C2=A0 - [BlueZ,v2,18/20] monitor: Work-around memory leak warning
> > =C2=A0=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3De5925dbb84fa
> > =C2=A0 - [BlueZ,v2,19/20] avrcp: Fix uninitialised memory usage
> > =C2=A0=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Daf2634ce0a62
> > =C2=A0 - [BlueZ,v2,20/20] main: Simplify variable assignment
> > =C2=A0=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D87edbabf3956
> >=20
> > You are awesome, thank you!
> > --
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
>=20
> Had to revert the last one since it was causing bluetoothd to crash
> at star.

Thanks very much!

I should have at least mildly tested the resulting builds, my fault, I
also misunderstood what this portion of code did. I've made another
attempt at fixing this issue, and will be submitting more bug fixes in
the near future.

Cheers

>=20

