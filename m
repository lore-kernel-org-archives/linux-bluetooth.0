Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C914AF142
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554531; cv=none; b=qI9vHlFG0a90Dvpml511K7wIm1tFi0hNcP9qhG464x4GJXslXX7NlrpSvnxuNtdonwe4vxOP6h0LfEW0xB+w4mUEcn16wt0SQuJfo1a3OGarXMRh4glxoMjZXJcutjSzp1y2rsULHW71gwKWqVayr8XJT7gOgndyJangIyEqR4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554531; c=relaxed/simple;
	bh=G7qwX0sNVnqR8S3IQ5RIcLEPjxlYM1URjwHQgz8q1Ww=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=uUnwcaeXTKfaWj48Jbn+U2WgRBNSL4Y1NrEqJqt+b5CdjYPCR1/6f8wchcCJADfwnQ4jpANpMLiZQxk96m3C+G5AXnppLq9uPZhH5vetiAQ8LTvmBJdiOYU5mNjHR5Ky081r4jpjRezwB+So2dTbsWNXp2MyyIXdaWrI85wXEFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=UAJiSP0J; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="UAJiSP0J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789554487; x=1789813687;
	bh=LF+ZQGzoqmZJkFhukgobwUN1vHGJcpsIGUJQaMr9ma4=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=UAJiSP0JE84BtXqXkJleOBpE853yOEQHc7xdkGXycx/1cWyqwBTWFLiM/wRlH6BED
	 yfo/ebIqes99SwYyqW8ilznigfvBmksjfa4YewUC7H56xz63Juc7uirykhF5MkfLqw
	 v8muXxul33Xm41ljgsPYydA30SI3vVQQpW5PO/c1406hQxbiOna0dkkhsqKSThj13r
	 pMU4q6GDOIMP5CRcWfyOGuPuEJAjKmdq0gXBpi4vaKhL6PZMsJjmaPkjnK7Bxh6bB4
	 z4gJSuydtuVPolSc/PIb93aI0HPuA1ushv19OwqEGQTi1Fs2ijliFEybdusPMRk05H
	 LiCzQQd6Yw/dQ==
Date: Wed, 16 Sep 2026 10:28:01 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: dt <derektern@proton.me>
Subject: [PATCH BlueZ 0/2] Avoid local metadata Config notifications
Message-ID: <IGuo_ED6hoZcdNfKi5TCkYNNfYCJKn1CUSYS4a4ZNZ9WjaZCMI3rmBzLoslV22TvEjShB4iyBBAec3nrM4mMGI_r8dHKBUfAGLjZxXmgfIE=@proton.me>
Feedback-ID: 213585229:user:proton
X-Pm-Message-ID: 8e07f07e7c5e7a4751ca50960132dd6fa1887e8c
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

When a client reuses a Codec Configured ASE, caching local metadata
emits a CONFIG-to-CONFIG callback before the peer reports the new
codec configuration. The profile treats that callback as completion.
If the control point response arrives before the peer ASE notification,
QoS setup can run while the stream still needs reconfiguration.

The first patch caches metadata without emitting a client CONFIG
notification. Peer notifications, server metadata handling, and initial
IDLE metadata remain unchanged. The second patch adds regressions for
both remote Sink and Source ASEs: reuse a real configured stream,
verify metadata retention, reject QoS before the peer notification,
and require successful QoS request and wire exchange afterward.

Validation on canonical and GitHub master
 e2ec6827f7bed94912c23288a34f868e7002e847:

- make -j4 check: all 35 configured unit-test programs passed,
  including all 699 BAP cases.
- Both new regressions fail at the premature QoS assertion with only
  the source fix removed, and pass with it restored.
- git diff --check and checkpatch with the documented BlueZ options
  passed without diagnostics.

Two stock BlueZ 5.87 profile-switch captures showed local QoS failure
about 0.2 ms after Codec CP success and before fresh CONFIG arrived
about 2 ms after that response. Internal flags are a source-backed
inference, not directly observable in those captures.

The equivalent fix in a private BlueZ 5.87 build passed initial duplex
and three playback/duplex round trips. Control captures showed fresh
CONFIG before each QoS request and no extra Release during new
configuration. It was subsequently retained in the reporter's local
stack; the reporter now considers ordinary-use testing satisfactory.

Hardware testing used other local kernel and PipeWire changes. It was
not an isolated stock-stack A/B test, and the refreshed upstream daemon
has not been run on hardware. Earlier intermittent transport failures
and Receiver Stop Ready errors after Release are not claimed fixed by
this change. The regression tests cover the shared API and wire
fixtures, not the complete profile scheduler or four concurrent ASEs.

This differs from b3dd59987, which addressed initial metadata in IDLE.

Derek Tern (2):
  shared/bap: Skip local metadata Config callbacks
  unit: Test metadata during BAP client reconfig

 src/shared/bap.c |   5 ++
 unit/test-bap.c  | 134 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+)


base-commit: e2ec6827f7bed94912c23288a34f868e7002e847
--=20
2.55.0

