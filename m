Received: from out-29.smtp.github.com (out-29.smtp.github.com [192.30.252.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7036E17A30A
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790899863; cv=none; b=i3POdxPA0J/x4/RhMPz+GkurJ9i/5u5hLyB33A+Z4XEOx1ItDlQWy1cPCohTkNHrB3I5dtWBepP1kWtR8/WwTlMOHPSG+tTS8msbKxN1uObKnSDqD16rzvPPqKtK/nTKhiezMfIi1CGz5GCUoer9ngY82YtETl1Tnn3tWugPyMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790899863; c=relaxed/simple;
	bh=q2BUfPw+upvUM8b+c1PgRhJbcCg75H2EMT7P27O6Rjg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dxJyL1tddzikk8zlx2I9OD4dJV/eI2eaxtJnfXuRmcYvJzYJZ4FTXCyRmka2Pj64riVrsZ7tcxRh/z7VgRPE/gkeVLqfO5SfU0Xlq6mUYWkw+Yi4jblzhAyTW92mSZCgP3ppeSpkQi0RifrhSKQh8wJTOjLn2ORuqeJUJpFeBbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=kaypUJ+6; arc=none smtp.client-ip=192.30.252.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="kaypUJ+6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790899860;
	bh=ztp7KnGUk+No+SGKh4PHeOHiupsEHcWxg2vr9+Wui/0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kaypUJ+67Dtrh4zXb3r3GdkEjva68HB94t3DUmGavKTU3MpRldtFt57cB49ges0pU
	 TNF12m4G4uS2v/T68bxGLpHT0HTD/l343vJOZyE51hRzKBIIa2Kc+FOTzC1vPt7fzT
	 EP9YYLv2ZwBnCSuFTzijTCBlBRah5+hYyAnYnVmfuvT26w3++eBZUZOxi5lQrXzvVo
	 XezmtVXJU4oaxr0dtosVxthTEYQMmGJiYhmG99EkH1UtI/FlbWwvNnKlGvWvXzOoTk
	 9/rp0ICT6Ng1e0eW0ZJwHyum7h+4d85uiUWpnNdpEHdoFNSLTCtLjHUYhRB40XCdDO
	 wCk8aqOklT0vA==
Received: from github.com (hubbernetes-node-a2a9520.ac4-iad.github.net [10.52.182.38])
	by smtp.github.com (Postfix) with ESMTPA id 8CBC93203B0
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 17:11:00 -0700 (PDT)
Date: Thu, 01 Oct 2026 17:11:00 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1177946/000000-a70d67@github.com>
Subject: [bluez/bluez] 0c40f1: audio/hfp-hf: Add HFP HF server and SDP record
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1177946
  Home:   https://github.com/bluez/bluez
  Commit: 0c40f16f89492cecee82142f12070102aa85fb11
      https://github.com/bluez/bluez/commit/0c40f16f89492cecee82142f12070=
102aa85fb11
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add HFP HF server and SDP record


  Commit: 6eba4417155d7ce020a0fdc7f7b2044f2c1a55e0
      https://github.com/bluez/bluez/commit/6eba4417155d7ce020a0fdc7f7b20=
44f2c1a55e0
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M Makefile.plugins
    M profiles/audio/hfp-hf.c
    A profiles/audio/hfp-hf.h
    M profiles/audio/media.c
    M profiles/audio/media.h
    M profiles/audio/transport.c

  Log Message:
  -----------
  audio/hfp-hf: Add MediaEndpoint for HFP codecs

Register a MediaEndpoint1 (org.bluez.MediaEndpoint1) for each HFP
codec supported by the remote AG, exposing SCO audio through the
standard media transport API.

Adds a SCO listening/connecting socket in hfp-hf, endpoint
registration/unregistration tied to the HFP connection lifecycle,
and wires MediaTransport creation/configuration for the HFP_AG_UUID
endpoint in media.c.

Assisted-by: Claude:claude-sonnet-5


  Commit: b11e1c313d0151eb829776cfdb04fd56ca962207
      https://github.com/bluez/bluez/commit/b11e1c313d0151eb829776cfdb04f=
d56ca962207
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add MediaEndpoints for HFP HF codecs

Assisted-by: Claude:claude-sonnet-5


  Commit: 581ed7dbbd59f23db200d8541e450312fc63c17c
      https://github.com/bluez/bluez/commit/581ed7dbbd59f23db200d8541e450=
312fc63c17c
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Add hangup all calls support

This releases all calls except waiting calls. This includes
multiparty calls.


  Commit: 9137028c41610ac358df560b94da72b1e35bda33
      https://github.com/bluez/bluez/commit/9137028c41610ac358df560b94da7=
2b1e35bda33
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add hangup all calls support

This releases all calls except waiting calls. This includes
multiparty calls.


  Commit: 5fecbc025cb2012eb2f0a2541898b365746b90d1
      https://github.com/bluez/bluez/commit/5fecbc025cb2012eb2f0a2541898b=
365746b90d1
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Add send tones support


  Commit: d0df1998da0ce4f2fb36958ac4a741accd712326
      https://github.com/bluez/bluez/commit/d0df1998da0ce4f2fb36958ac4a74=
1accd712326
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add Send Tones support


  Commit: c60578cd7320b5b70d9cdf92245a15c9245666b0
      https://github.com/bluez/bluez/commit/c60578cd7320b5b70d9cdf92245a1=
5c9245666b0
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M client/telephony.c

  Log Message:
  -----------
  client/telephony: Add Send Tones menu entry


  Commit: be30cfde8d6fc9cd4e95f9e0d40d96b3167792c0
      https://github.com/bluez/bluez/commit/be30cfde8d6fc9cd4e95f9e0d40d9=
6b3167792c0
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add multi calls support

This implements the SwapCalls, ReleaseAndAnswer, ReleaseAndSwap and
HoldAndAnswer methods from org.bluez.Telephony1.


  Commit: ccb7d1d369dcbe22c9fcb33a2b4e606c21727dba
      https://github.com/bluez/bluez/commit/ccb7d1d369dcbe22c9fcb33a2b4e6=
06c21727dba
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M client/telephony.c

  Log Message:
  -----------
  client/telephony: Add multi calls support

This adds menu entries for the SwapCalls, ReleaseAndAnswer,
ReleaseAndSwap and HoldAndAnswer methods from org.bluez.Telephony1.


  Commit: c724ac2fab514cd377f84306755e8e92c1b73960
      https://github.com/bluez/bluez/commit/c724ac2fab514cd377f84306755e8=
e92c1b73960
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Add codecs support

This send the AT+BAC command with the supported codec list during
SLC connection.

On reception of +BCS event to select a codec to use it replies with
the same codec if it is available, or re-send the AT+BAC to re-trigger
codec selection.


  Commit: a70d670f3e0e897731811b594a3466212a4084e6
      https://github.com/bluez/bluez/commit/a70d670f3e0e897731811b594a346=
6212a4084e6
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add codecs support


Compare: https://github.com/bluez/bluez/compare/0c40f16f8949%5E...a70d670=
f3e0e

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
