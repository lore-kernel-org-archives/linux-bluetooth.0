Received: from out-29.smtp.github.com (out-29.smtp.github.com [192.30.252.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E062377AAC
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347838; cv=none; b=WtgD5zhjes5mSfOTCYrGw+qlZDjRu4K0Pf+87K5GSWEzx3Dag5MyFCG02INi0ucE7zOGDfvxWngs4GSmiW1niYOMIDTW4J1zG+wzQ46wK5ItCw9WRaA9aogGqQEObtXOyvAdKW302vLTdeuwHIYi51pi+6u1r+zmyyLTNkbRCaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347838; c=relaxed/simple;
	bh=tYRlaFbIZaKvbBjQ80GizGksbVPG5kbm42J85NTCiFA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SUyZ1EKFRuBNAikBdHU5tUmk97yrQLgjnqMrniunOHhg2MtoFIZBpZL2QnkXcwGUt96wQIPw6Y7Wp8Qk6ARGXpV+KRfhMfJ/B0kzqSkagJrHkdtwwwFUzxwtpPeVQE45UC+upSqkNN3mbnx1raMk78KGa3x4G/fH4X2a1mWD5js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Sj+Gv+US; arc=none smtp.client-ip=192.30.252.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Sj+Gv+US"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790347836;
	bh=nUSsBmzigilRfBrTB/iHSYyACNmac1uKC+n8SdPjdcE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Sj+Gv+US2W7+SSWNNrvCmeYyD+HGhsm0xgqyxADjUsF0k6tAzcfM4OYCpN2ToX/5c
	 CWA6RH7HGenR7Fuvqp6puVLRL+XuWLFVeFrcUU9KF6ylV8lY6pPFI6JQ7zBaAD7TLC
	 L0XWsGGtfEL4Cz+dmWbXn6DvlHAR4jhrn/gbMBIg=
Received: from github.com (hubbernetes-node-2f5a1e3.ac4-iad.github.net [10.52.131.37])
	by smtp.github.com (Postfix) with ESMTPA id 1D3BA321047
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 07:50:36 -0700 (PDT)
Date: Fri, 25 Sep 2026 07:50:36 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1173777/000000-d0e147@github.com>
Subject: [bluez/bluez] ae3b8f: audio/hfp-hf: Add HFP HF server and SDP record
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

  Branch: refs/heads/1173777
  Home:   https://github.com/bluez/bluez
  Commit: ae3b8f76c286ca73f9c43adbe4dd1b744b76f5f9
      https://github.com/bluez/bluez/commit/ae3b8f76c286ca73f9c43adbe4dd1=
b744b76f5f9
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add HFP HF server and SDP record


  Commit: da406a51f8c34c236ecab78a3a777580a28fb6b8
      https://github.com/bluez/bluez/commit/da406a51f8c34c236ecab78a3a777=
580a28fb6b8
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
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


  Commit: 9fc38a9c4f812e0ace204ee684a84a37ac285494
      https://github.com/bluez/bluez/commit/9fc38a9c4f812e0ace204ee684a84=
a37ac285494
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add MediaEndpoints for HFP HF codecs

Assisted-by: Claude:claude-sonnet-5


  Commit: 161535b8f647b0ab0285da76adcf51f842809091
      https://github.com/bluez/bluez/commit/161535b8f647b0ab0285da76adcf5=
1f842809091
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Add hangup all calls support

This releases all calls except waiting calls. This includes
multiparty calls.


  Commit: 789455f85bd19fec5f36aeb2ae3343f6a0e5181a
      https://github.com/bluez/bluez/commit/789455f85bd19fec5f36aeb2ae334=
3f6a0e5181a
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add hangup all calls support

This releases all calls except waiting calls. This includes
multiparty calls.


  Commit: 4a7c0fdfec93c9ae86d4680bfee8ca3968bbec7f
      https://github.com/bluez/bluez/commit/4a7c0fdfec93c9ae86d4680bfee8c=
a3968bbec7f
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Add send tones support


  Commit: cd81974533d3a70f06083d0fa885bf0ea939844d
      https://github.com/bluez/bluez/commit/cd81974533d3a70f06083d0fa885b=
f0ea939844d
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add Send Tones support


  Commit: 6ff4d9ff194fc6f2c90b526ca89f514342a2da54
      https://github.com/bluez/bluez/commit/6ff4d9ff194fc6f2c90b526ca89f5=
14342a2da54
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    M client/telephony.c

  Log Message:
  -----------
  client/telephony: Add Send Tones menu entry


  Commit: 34bfe5362616f2b243db5d56d401934578fd7c00
      https://github.com/bluez/bluez/commit/34bfe5362616f2b243db5d56d4019=
34578fd7c00
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add multi calls support

This implements the SwapCalls, ReleaseAndAnswer, ReleaseAndSwap and
HoldAndAnswer methods from org.bluez.Telephony1.


  Commit: c7d74770246fe85faa34a9a7d92532fd4672d078
      https://github.com/bluez/bluez/commit/c7d74770246fe85faa34a9a7d9253=
2fd4672d078
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    M client/telephony.c

  Log Message:
  -----------
  client/telephony: Add multi calls support

This adds menu entries for the SwapCalls, ReleaseAndAnswer,
ReleaseAndSwap and HoldAndAnswer methods from org.bluez.Telephony1.


  Commit: f6e6c73ab1a4e446604d33c1f8a7bdb0a36ccc74
      https://github.com/bluez/bluez/commit/f6e6c73ab1a4e446604d33c1f8a7b=
db0a36ccc74
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

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


  Commit: d0e147f788c320d9511208f0cebac7f02e50edbe
      https://github.com/bluez/bluez/commit/d0e147f788c320d9511208f0cebac=
7f02e50edbe
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add codecs support


Compare: https://github.com/bluez/bluez/compare/ae3b8f76c286%5E...d0e147f=
788c3

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
