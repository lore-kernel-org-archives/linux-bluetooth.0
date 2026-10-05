Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F2C3905EA
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 21:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791237364; cv=none; b=eRvoTPFf+1C3SeXe/W2ZVoZk6FmJXT/exOu+ugUTTjNmIUPA7DQ2aqMg4cjPzUEQ+PqTGeRvuPYFbUkg/hdjL4nBXDL89TkMQoxegFYv3kWYp2cUFLIqvqmEZbPICnNJWczfo7f2PvZ9sVJJP99Ed0z9mHCd6WyZc1DKnPirLr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791237364; c=relaxed/simple;
	bh=gHEP7qoiJwhGU+nLWSGM6heJYv90N6fIkLzTikDjECc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kojqRr8o4dZjXHQazUSD6HHIJ/QJLDc8KRj07wNDqOg1JLD21DomXlMd6iH8lfHAFZvU4rEK66DexkH3sYW01e9bqW/BClVY4JBESdEJMgHXfCrDgr/wV8awfiBf5MKM2zoQ/0aiiaXG8ZH/vZU6M7kqtd958ruL+PuYMIZhIzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=Wr4B/8Mj; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="Wr4B/8Mj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791237360;
	bh=Fj1xzhuhfNim5jOjHtOmfSTxQXPbffBAV2Iszghr3wc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Wr4B/8MjDpRvsN4soq6c6UVM2WSVDGDhV0b/8e9ApBH2oM92cUZSYVuzPK+g7wm3X
	 glSnPCRc5JAjXsI7OeJNMWTPIZtZQN5Bm16yM6yo9xxATBC2wyNjuQRA9hlv8LPtml
	 6GwCQHUguxf5D55UFXR6vWmwv2+M6mfuwvQJMDLxiayKram73ps9QrBOkVO/LatyyW
	 0falfdJ7WkJB1c9/j3DOYc67770lzVrQE/vpWmTCON9ELPjtd4UMHKvru9QVre/S89
	 Jk3ti74P613OtBKZhzk2V/aPG0kz24LB0DkhhpKdVHPbCTgVBga53lLIyPREA7jgrO
	 NznLyKuSWPldg==
Received: from github.com (hubbernetes-node-f2bcb60.ac4-iad.github.net [10.52.148.35])
	by smtp.github.com (Postfix) with ESMTPA id C1ECE780765
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 14:56:00 -0700 (PDT)
Date: Mon, 05 Oct 2026 14:56:00 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4dc15b-7edaa6@github.com>
Subject: [bluez/bluez] 7878ae: audio/hfp-hf: Add HFP HF server and SDP record
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 7878ae60a2e2ba01fed06bf2850fcebd93d37b62
      https://github.com/bluez/bluez/commit/7878ae60a2e2ba01fed06bf2850fc=
ebd93d37b62
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-10-05 (Mon, 05 Oct 2026)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add HFP HF server and SDP record


  Commit: 89b91a4806fb76a26863f7e12e8a823c689d2e8c
      https://github.com/bluez/bluez/commit/89b91a4806fb76a26863f7e12e8a8=
23c689d2e8c
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-10-05 (Mon, 05 Oct 2026)

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


  Commit: 9e2a7ddbb178591ec3e30bf9bb942581c317f713
      https://github.com/bluez/bluez/commit/9e2a7ddbb178591ec3e30bf9bb942=
581c317f713
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-10-05 (Mon, 05 Oct 2026)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add MediaEndpoints for HFP HF codecs

Assisted-by: Claude:claude-sonnet-5


  Commit: f7fd0acef7ee1955dde4640fc5f47cb266f352f9
      https://github.com/bluez/bluez/commit/f7fd0acef7ee1955dde4640fc5f47=
cb266f352f9
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-10-05 (Mon, 05 Oct 2026)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Add hangup all calls support

This releases all calls except waiting calls. This includes
multiparty calls.


  Commit: 0a8dfeff2f79670d80ce3def3b8bc9a3b8096ce3
      https://github.com/bluez/bluez/commit/0a8dfeff2f79670d80ce3def3b8bc=
9a3b8096ce3
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-10-05 (Mon, 05 Oct 2026)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add hangup all calls support

This releases all calls except waiting calls. This includes
multiparty calls.


  Commit: 67883db59611b38df858313e8e6e308666bd3b0c
      https://github.com/bluez/bluez/commit/67883db59611b38df858313e8e6e3=
08666bd3b0c
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-10-05 (Mon, 05 Oct 2026)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Add send tones support


  Commit: e9046f3fb78d8833409708a2d569e9e7a84b53ed
      https://github.com/bluez/bluez/commit/e9046f3fb78d8833409708a2d569e=
9e7a84b53ed
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-10-05 (Mon, 05 Oct 2026)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add Send Tones support


  Commit: a9b8a5ef6ec791082ae41c7bd4c1bbc0bc7336ac
      https://github.com/bluez/bluez/commit/a9b8a5ef6ec791082ae41c7bd4c1b=
bc0bc7336ac
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-10-05 (Mon, 05 Oct 2026)

  Changed paths:
    M client/telephony.c

  Log Message:
  -----------
  client/telephony: Add Send Tones menu entry


  Commit: 2a4adbb2a7179573b6875f219c9fae5d1ae7a35e
      https://github.com/bluez/bluez/commit/2a4adbb2a7179573b6875f219c9fa=
e5d1ae7a35e
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-10-05 (Mon, 05 Oct 2026)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add multi calls support

This implements the SwapCalls, ReleaseAndAnswer, ReleaseAndSwap and
HoldAndAnswer methods from org.bluez.Telephony1.


  Commit: 45384edcd1c70b0883ce1927c462837972c77377
      https://github.com/bluez/bluez/commit/45384edcd1c70b0883ce1927c4628=
37972c77377
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-10-05 (Mon, 05 Oct 2026)

  Changed paths:
    M client/telephony.c

  Log Message:
  -----------
  client/telephony: Add multi calls support

This adds menu entries for the SwapCalls, ReleaseAndAnswer,
ReleaseAndSwap and HoldAndAnswer methods from org.bluez.Telephony1.


  Commit: 003db642000844d2ecd27ec5c81c7355561fbec2
      https://github.com/bluez/bluez/commit/003db642000844d2ecd27ec5c81c7=
355561fbec2
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-10-05 (Mon, 05 Oct 2026)

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


  Commit: 7edaa61403390fe1cf2f1fb6d45fdd90fe6e93b3
      https://github.com/bluez/bluez/commit/7edaa61403390fe1cf2f1fb6d45fd=
d90fe6e93b3
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-10-05 (Mon, 05 Oct 2026)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add codecs support


Compare: https://github.com/bluez/bluez/compare/4dc15be8ee3f...7edaa61403=
39

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
