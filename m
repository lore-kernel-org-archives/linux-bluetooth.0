Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C621349E5E9
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342747; cv=none; b=lKanA+up7C60EI/1eyCn6EBGg17MNRD9y+fiZfNrnnf7vl5hpnUqU5X1JGm53n07NP/eWV46rluwuIHzXpSubxVtqrc4664h5goWJ4HHHrOge5HT/qdB0JnMftarTSLfWjiYn4XPNHsoDQjmVFwWZHuBQQ1Hnwzxum5RvrJlm7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342747; c=relaxed/simple;
	bh=TbEI5ftTRTHpgnZ49KkhaMInpM8PcIYHG03jj+x4JNw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=AlSJ5jtddwpAj1u5okYQLaAVhSDlm4uXuqHYNvFqSDOmicVLTtK7t7jdQT5nl2rQtf7yuYU548PQ5UGXuZTN7qqfh4ryDBY6IBJaebDmFNloP0BP2zb8uZR/Nksmkv/RAsiHWvqRXRJmGxtsp+HMKo7GhPJPj2X2jbjwv8ZZScY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XxiNT4Cv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XxiNT4Cv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790342735;
	bh=TbEI5ftTRTHpgnZ49KkhaMInpM8PcIYHG03jj+x4JNw=;
	h=From:To:Subject:Date:From;
	b=XxiNT4CvPkuh0iL9Z0feGBHRHo1xg1zYOykkY8Zhv14BxQ4NqJTyLR10NSOuTQNhn
	 Jhv4qwnvCoIcz9A38X+5OIKPAnucLJfTXOgIUutf4Kw6sROJKEfxw/99JRxLMIWyQu
	 GFVXX4iQjiPNqGJIYmWEP+bE7Szyf8UcI3nylmlQ2B8/ja3qCa4UFIGMr8OHd0VMeR
	 RtQz1cU8S/WSBeCNi6GZgrAXBlFkFoe39/1xZ8RpG268K0nOAXNZadvV+Rmu4sTp6m
	 WzrnQernEjUUsnJ3Tbm7xtSADT1ECQ1W1OZBupb9AGdEO3Lan9b33WxeCiafp7jjwf
	 M+GlBOmXlgPNw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8035917E0082
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 15:25:35 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 00/12] hfp-hf: Enhance HFP Hands-Free profile support
Date: Fri, 25 Sep 2026 15:25:16 +0200
Message-ID: <20260925132528.3361517-1-frederic.danis@collabora.com>
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

 client/player.c            |  18 +-
 client/telephony.c         | 237 +++++++++
 profiles/audio/hfp-hf.c    | 979 +++++++++++++++++++++++++++++++++++++
 profiles/audio/hfp-hf.h    |  26 +
 profiles/audio/media.c     |  76 +++
 profiles/audio/media.h     |   6 +
 profiles/audio/transport.c | 158 ++++++
 src/shared/hfp.c           | 229 ++++++++-
 src/shared/hfp.h           |  13 +
 9 files changed, 1735 insertions(+), 7 deletions(-)
 create mode 100644 profiles/audio/hfp-hf.h

-- 
2.43.0

