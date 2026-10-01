Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8761495515
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 21:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889052; cv=none; b=g3xehaLdq6aHxUTu+eMWj5KogW8//ohnPsD+ZPwEcYeLNyvtgzmWk7ibjRQhTDzpxjI9pYzSh3PQ3yfjWxQeb+kUBWb0HVLoKkXDY5wf9M0rHK7JilJpvUMfQmjtozKSb7k0Wfvyg18+g0wEEKjhwBvtAEMdbzm0Zu3J6dLfNOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889052; c=relaxed/simple;
	bh=6LmeEMEeOEjg1TRuj2whwy8CQ8+JSXg79jPMHPQGfYU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=Dj1fvIR7ThJgDFPuWZFml26sanlOZPJIFcnXWVKPeKIC0bUnzoxHLBFmB4hvsE3aFt15bqEMTGeBMpXRTiGPWwHfyg2sLBtbyCxrbX9aPtZRhAhK3Tj61cwFRcHlMU6qVVaIYuz5lX7utq7b0bH5X4JaFIAcR/v6BjRdQ4YDYWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qKwoB4GZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qKwoB4GZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790889041;
	bh=6LmeEMEeOEjg1TRuj2whwy8CQ8+JSXg79jPMHPQGfYU=;
	h=From:To:Subject:Date:From;
	b=qKwoB4GZzRZXKJCy7D0nWN9fQgte83XxNkGLDA7Dsfh7mULHgTZRb9zozkA3YpOjK
	 oXqlDm+HB03rfq/8A6SvWTFOA0KjSDrq7IHn/gbN5TzbVxNZjT/vO9YUZaU80gE9va
	 N81WxXzCc56sL7bzwda9nq1iIQTri/58anhavhlWfUGKpCJaBJ68pR8p4FSWnzetLM
	 W4WK6y7RPuzVlqmUxU/2+SVK6IF0pyjD1WPboe3ehdX7c8562oN7h5lH/LELT0XFOh
	 3AGxl/G5AmaFv7Oqlg7Yx6sFZuukhomlEaM3QshguaF3PhscCmPl91/JfHgmEjDO15
	 dIetUxGcXEq0A==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3F29F17E015A
	for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 23:10:41 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 00/12] hfp-hf: Enhance HFP Hands-Free profile support
Date: Thu,  1 Oct 2026 23:10:24 +0200
Message-ID: <20261001211036.1760396-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This series enhanced the HFP Hands-Free (HF) role support in BlueZ:

 - Registration:
   - Register the HFP HF profile with an SDP record so BlueZ is
     discoverable/connectable as a Hands-Free device.

 - Audio path:
   - Register a MediaEndpoint1 per supported HFP codec and wire up
     MediaTransport creation/configuration so SCO audio is exposed
     through the standard Media API instead of a bespoke interface.
   - Extend bluetoothctl (client/player) with matching menu entries
     to select/manage the HFP HF MediaEndpoints.

 - Codec negotiation:
   - Implement AT+BAC / +BCS handling in shared/hfp so the supported
     codec list is advertised during SLC setup and codec selection
     from the AG is honored (or renegotiated when unavailable).

 - Multi-call handling:
   - Implement SwapCalls, ReleaseAndAnswer, ReleaseAndSwap and
     HoldAndAnswer on org.bluez.Telephony1, plus corresponding
     bluetoothctl menu entries.
   - Add support for releasing all calls except waiting ones
     (including multiparty calls), both in shared/hfp and audio/hfp-hf.

 - DTMF:
   - Add AT+VTS-based Send Tones support in shared/hfp and audio/hfp-hf,
     with a bluetoothctl menu entry to trigger it.

New related PipeWire BlueZ backend draft can be found at:
https://gitlab.freedesktop.org/pipewire/pipewire/-/merge_requests/2978

v1->v2: Fix make distcheck

Frédéric Danis (12):
  audio/hfp-hf: Add HFP HF server and SDP record
  audio/hfp-hf: Add MediaEndpoint for HFP codecs
  client/player: Add MediaEndpoints for HFP HF codecs
  shared/hfp: Add hangup all calls support
  audio/hfp-hf: Add hangup all calls support
  shared/hfp: Add send tones support
  audio/hfp-hf: Add Send Tones support
  client/telephony: Add Send Tones menu entry
  audio/hfp-hf: Add multi calls support
  client/telephony: Add multi calls support
  shared/hfp: Add codecs support
  audio/hfp-hf: Add codecs support

 Makefile.plugins           |   6 +-
 client/player.c            |  18 +-
 client/telephony.c         | 237 +++++++++
 profiles/audio/hfp-hf.c    | 979 +++++++++++++++++++++++++++++++++++++
 profiles/audio/hfp-hf.h    |  26 +
 profiles/audio/media.c     |  76 +++
 profiles/audio/media.h     |   6 +
 profiles/audio/transport.c | 158 ++++++
 src/shared/hfp.c           | 229 ++++++++-
 src/shared/hfp.h           |  13 +
 10 files changed, 1740 insertions(+), 8 deletions(-)
 create mode 100644 profiles/audio/hfp-hf.h

-- 
2.43.0

