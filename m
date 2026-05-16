Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA525405C31
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778925018; cv=pass; b=uOcfpU+pl2ESGv+PWM5vI9br0RpCzhka7sidxy7wRhLtq6JIeM4lr2tULSuTAvly6o7uCmYHDXyP8FzaqXYBaeO0BLCe59KB+BTtOIqDornlpDGb6fImaZXKUNqu5Gm1ka3EySfGEijzpCENxnDkiRjwgHTbZEybpmX84UEy/FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778925018; c=relaxed/simple;
	bh=Y4rxyzPpaqe7oR5uYPwTIwSOVgEn0V429skFUYXUETo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X0554IMm1qmnGwxFCpNaxFNW5VqxZIkDXumHgdlJ1sP/lnmi89yQKxV0REqNVWAl/P9Sy6DdmN5QU+22vHew0UeRmp4Tb4O8VBHqdLLHOXr1lFwxC3phY0dyyefHUwoA7VArAfW57ii3IqnKexLF8qIaYh0mjDj02sZxl0GsT0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=HVTEuh/Q; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="HVTEuh/Q"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gHfSB0dJKz49Pxd;
	Sat, 16 May 2026 12:50:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1778925003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d1RRDLcqli35jagBYE+CLURT8EwWMSUlbOhYoRrdl/0=;
	b=HVTEuh/QgOzuVrUcFG+10J3DoPc5bV380qH4G5me+l/1rGPn5Wjxg3B3I/yJzkSUQnfq1b
	x4lJTwAu4wR+NJDlK4UADtaz9lq+/tiY8N59lhNwpvXMv7bDWcdW0TM/yMRrckR2q9wedP
	p9y7AghwP1jCWd0Q2173qpRqO8pbtfWCDuHifyW5Ld/JUj5MZ3VFdiyavVOp84kZAVPKQw
	qd3ijUGa2QYObOvV7Sp08zwI4UtPvty1hS9R0+Vy284eBFu60ojqFV6jepdpqoFvcXsMDe
	HOQafnjQs8N9MZc2vke9TagJ9TA8fecAORkABx1LDKKkaNQR/1Ow/eM4IQYPaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1778925003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d1RRDLcqli35jagBYE+CLURT8EwWMSUlbOhYoRrdl/0=;
	b=T2zGEq2rXJJQJKLwsRBfUuHTGbdNAxxcA31epjO0+nFxbCfWB8d27DxXSbouqybKk4Y5k9
	bYe3IB1RVyuWE8kWdw2dquxqDrezCzFhP/oYNoJq/9+EtcsSom2kUbWYF9KTS8qXigVvZK
	JXpZT37sooPArhUERyv4MASivdeX5lDxLl4TwHvQFLsBaozPUNLzrdT6tHOYdmtU8fLgLK
	ZsjoulXLR8ytKKJiWkz2ddSTDImOsLZC9yOOMbWJz14rA+SlFNOJUqhHrdrKB2VDcxTg/L
	37IDQQaxbqwYaQbpJNA+1/wlQpPh2vZDbqBDdwt3N6aOFK/xKEBXOQbJ7Psa5A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1778925003;
	b=fZh8G75qQsWZUi2TUqIIL5JlE299Z0MyDRCL95c5c9Rzm4SCd9Kp4aAMy2WSy3359ih/hl
	pLBHEKnT6BO1OY0wXSzdxVLeXgYqP1Jtr5ovwv0+qCyzvvxbsYPjdjRbCsVX53zrEa5YN5
	ald/nTJW5LZkeCD6fPc6VuZKEac1dSRXIwka+qroCX44tv2YRCh/QQ/PSvH0M1CePqlsAM
	x8USAgypMNcwC0lmyj8DPp+xJZdsKS2wzCLOjjgBK9oYEIcQfvok1YfE81fyyjq5ltUQX/
	7S2VE6PIro8OzlQBWpue235SDzekGE8XZ4+W3DexyveHOoMZtVLVaqR4Y0YTKA==
Message-ID: <ce6dfd9300592c34c329e8ac2a4a50f7236d9299.camel@iki.fi>
Subject: Re: [PATCH BlueZ v5 00/16] Functional/integration testing
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 16 May 2026 12:50:00 +0300
In-Reply-To: <CABBYNZKaLPxRvMUDsTSByV64=iZKZCbtNZ6FTrjVohefY1+1bg@mail.gmail.com>
References: <cover.1778688966.git.pav@iki.fi>
	 <177878100755.31561.18184220318055008237.git-patchwork-notify@kernel.org>
	 <CABBYNZKaLPxRvMUDsTSByV64=iZKZCbtNZ6FTrjVohefY1+1bg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

to, 2026-05-14 kello 15:11 -0400, Luiz Augusto von Dentz kirjoitti:
> On Thu, May 14, 2026 at 1:51=E2=80=AFPM <patchwork-bot+bluetooth@kernel.o=
rg> wrote:
> >=20
> > Hello:
> >=20
> > This series was applied to bluetooth/bluez.git (master)
> > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> >=20
> > On Wed, 13 May 2026 19:17:17 +0300 you wrote:
> > > Add framework for writing tests simulating "real" environments where
> > > BlueZ and other parts of the stack run on different virtual machine
> > > hosts that communicate with each other.
> > >=20
> > > *** v5 ***
> > >=20
> > > https://github.com/pv/bluez/compare/func-test-v4-r..func-test-v5
> > >=20
> > > [...]
> >=20
> > Here is the summary with links:
> >   - [BlueZ,v5,01/16] emulator: btvirt: check pkt lengths, don't get stu=
ck on malformed
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3De19c771841=
e9
> >   - [BlueZ,v5,02/16] emulator: btvirt: allow specifying where server un=
ix sockets are made
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D5ee43f9993=
dd
> >   - [BlueZ,v5,03/16] emulator: btvirt: support SCO data packets
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dcc077e4a12=
dd
> >   - [BlueZ,v5,04/16] emulator: btdev: clear more state on Reset
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Df1a303e1d0=
7a
> >   - [BlueZ,v5,05/16] test-runner: enable path argument for --unix
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dff2ecb82e4=
c3
> >   - [BlueZ,v5,06/16] test-runner: Add -o/--option option
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D82c635c879=
bf
> >   - [BlueZ,v5,07/16] test-runner: allow source tree root for -k
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D1929b3a99d=
2f
> >   - [BlueZ,v5,08/16] test-runner: use virtio-serial for implementing -u=
 device forwarding
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D908c14fc3a=
bb
> >   - [BlueZ,v5,09/16] doc: enable CONFIG_VIRTIO_CONSOLE in tester config
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D7856de4d69=
d6
> >   - [BlueZ,v5,10/16] doc: enable KVM paravirtualization & clock support=
 in tester kernel config
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D48cb22a572=
c7
>=20
> Push the ones that didn't introduce new functionality, there were some
> complaints from the likes of checkpatch regarding scripts with execute
> permission,

This checkpatch warning I don't get, the repository already has a large
number of executable scripts, and isn't that more convenient?

IIUC the warning is about +x bits on random source files, which is not
the case here.

>  and Id like to go more in detail about how to write tests
> and what is the RPC message protocol since we could in teory use the
> same protocol used for autopts for example.

Generally the idea in the design here is that the plugins add arbitrary
test-specific capabilities to the lower tester / IUTs, and the 'test_*'
functions are the upper tester which uses the plugins to orchestrate
the test and obtain data to verify the outcome.

It's straightforward to write test-specific plugins, so you are not
required to write something like a separate monolithic BTP client.=C2=A0You
can reuse btpclient etc. of course if useful.

There are several examples of full-stack BlueZ<->BlueZ integration
tests in the series.

Examples of PTS-style unit tests where lower tester probes specific
parts should still be figured out are missing though.

The main issue here is the lower tester BT stack, it will need to have
controlled mock functionality. Maybe this could be still BlueZ, but
with plugins disabled and we do raw ATT / GATT, or through BlueZ GATT
DBus API. Or, use something like https://google.github.io/bumble/ to
talk to the btvirt controller directly.

For reusing autopts, I would just add a plugin that launches the client
in the upper tester / IUT, and talks to it in their XML-RPC protocol,
encapsulating any protocols used. The autopts protocols appear somewhat
tied to details of the PTS implementation, doesn't seem like a good
idea to use it natively as it's more complex and I don't see what would
be really gained from it.

AFAIK it's not possible to use the full PTS infrastructure here, the
important parts are closed source and not license compatible.

>=20
> >   - [BlueZ,v5,11/16] doc: add functional/integration testing documentat=
ion
> >     (no matching commit)
> >   - [BlueZ,v5,12/16] test: add functional/integration testing framework
> >     (no matching commit)
> >   - [BlueZ,v5,13/16] build: add functional testing target
> >     (no matching commit)
> >   - [BlueZ,v5,14/16] test: functional: impose Python code formatting
> >     (no matching commit)
> >   - [BlueZ,v5,15/16] test: functional: add some Agent1 interface tests
> >     (no matching commit)
> >   - [BlueZ,v5,16/16] test: functional: add basic obex file transfer tes=
ts
> >     (no matching commit)
> >=20
> > You are awesome, thank you!
> > --
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
> >=20
> >=20
> >=20
>=20

--=20
Pauli Virtanen
