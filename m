Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769738;
	b=ySmljvIHW/K5F8fH0nDhcKL33BthSdSCWvyNrhwkQEyhPVF/mQuUE+nN/9/FuHp5Mz0s
	 wqjzi1T7Mj/OR3Uqx7N3c/hkUDpfD6OMrb4CSu/PMclwC/uI1ldOyFamJ6pmNG4lapJOL
	 9WkG6Y+Exw59bVMj/CHAqcnKSixtOQep1Ab8NAaNuDmXAn3c1aCwnNFdOG5f8hj22tv3o
	 Fg4CJ5FfNPVp2pdp3VA8CwHjxy5sE2ZxcjpIxMvFffdntYa6XysILV433mwmLnkdmCGgL
	 LGg3IDVzrpEhwuttUaEAxqlyqa4c2R6Lya3o6Cs42h1XP5vq52p+9xo9LrOiOtUBeew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Qa6NfB4CHcmw8nmC3M28T2elijpKbjoMO+0dZ+uJAo8=;
	b=r8Ilwf9+GV/3xGcC0w3Eu0Zx/FkA04YL/8UDac9VGxwG9PfMclny+scRR6AWb+yqDIbZ
	 bxj4BnLNVjdMhMN31YDH88te+ZvCouvPhpGkvKAKT7oDdsdIrsaU8NEMhCLPiS7pIMbds
	 K4/oecO93+uayS2tK4/twc3CfpvXRXYC/rzQ+W7vcUgoDxXNDAO7e96w66praH7j1eAHB
	 p3Ee6gVHycKCIEVOxRojm5lVVRwG7XUjFbHZl+fDaVWO6uDRjqOaGJKptw2SWj+pCUi7B
	 qIXNb4yGj3JuRcvht1MCzJqFQT+oVBRBgnr1n7wLAoHKusZfXOfyluFUalGDAMcFw1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=phDG4Mx3;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E69606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 08:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32E69606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=phDG4Mx3
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4a440c9e13aso543709f8f.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 00:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769736; x=1796374536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qa6NfB4CHcmw8nmC3M28T2elijpKbjoMO+0dZ+uJAo8=;
        b=phDG4Mx3qXHQXjPtwOrx/CJhKVkAPuPpRvjJ9fCAcuMAPb6t9UgAkaix8neMy/zLCo
         aHt25PXcUlnFsKcTq08kpfsC9JRvKEFmdkuUe3Z3UAcZyKxWzMeAc0QdHjqA2B4OZGpg
         JMGZ5SNAxXtwZEnNQuYsvShIYUWK7yEZwp7MpDpNkapJCE7OfWryzbXEjOktiWT7Igxk
         DZXANxDirGhh5rGx/n8yGGp+5YHMssZUtQ+dh3XBpFRQxE1SKRXLzdThsN0C7iI2oLm+
         nQmNc10jj92wYg3ji2WCQp1mOcRR66MrW2jLwLtWoWCekBeHf1/vGbvLZ/9kIG470yIP
         JF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769736; x=1796374536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qa6NfB4CHcmw8nmC3M28T2elijpKbjoMO+0dZ+uJAo8=;
        b=sqrcb5jqIAm1YQ9pagBXXJKfKv9lz8ZbHxZCSeZctBU7QWlHVWCr1A7MpS/Ad+hNHy
         632oMoOyzg7EwlepPqFfjzkOSWkwgCNlOa6m9l7BqtpWM+hWroJODz8l6Kq32IndYgUN
         U9Njnf4G/2i2S6SSKl91XsKTmO7viuFXEkz6I7gB+1PW3DDQsR/Ec0eqXRq/YK+O21BO
         /gZETy09ACp0cr10MgRGxN5qMDedDLmtFRXXXackx8lt3aUFnarkN39GjivPM8DHxk/X
         Z3Hijik3wQ2YIkXRISr94jxtYT3Pye2LP7RvwvCjIohPejFU6JzZHd69E1Z7exUPq9/M
         eZWw==
X-Gm-Message-State: APuU4Z9ow+3NNilZSfHM8Sb8eqGpFsBV6bFO/v3y88d4DCpGyQfJ/y9e
	KEFh95sDBBLCXZA9iXbB2AkXjYrPPM8Zu5RZxRUx13lLQnH07mwgJEeW2zsLqZqv
X-Gm-Gg: AZFdTZfeXv65X5Y+x/Bd9tuqAfBPA/YSRD7J64vl5PcS3nR4wxPu2Il2Jh2UgWEQ455
	8OzV+qzZ+C6UOTKuoQpxWMEpzaFntamjtB8mehmtigoT0M1rmpxcyU7Shan5Tuw8HPR6BlH3Ca5
	gIAq/zgBtd6Rho8h94NoMRKO3ltiPOdsueSWfVZVDX3yBy2uROqwkBfegfSNL6mkEAcrlP3vYz1
	C6JeMTuJylXzVXCfcUDQN4d7bixsm+iCveiS4G5BjJptR9MJLvApYXt1mInq7smy4YTCOBKGEvF
	78sQzrT1V1PhwIbdXZjrTFPqC/S7bi/0My8fi8r9s7NJyDY3SNuypIdK4ei3sYlLzkp+n1V4A3w
	Ap1cidndOtHPrXdJ1KuysECRwZB6x6/CWk3mMHHsoYFwf3ZrsxFpbkmNG6b+qU+40l2B1mWeAIt
	IEi6SgJHE3Xj8DYRypM9TQfehDW3oaqq8Bcloa0Qu3TqCrGm1NQjFyl6GqQzJftMXsxUwPcWg0y
	5ue+7ZlHIxiAE3SCF6toJHsyweJFhELpsuhxVZLlxK5ZOyJ+hmHE++rhMwiDWAUZ9TC2GwrVZrY
	06AnHLIDqnp7TeaKImUy9uu8R60CmXluH/c=
X-Received: by 2002:a05:600c:154c:b0:4ad:5ec2:d3b3 with SMTP id 5b1f17b1804b1-4bb887f43d8mr455510285e9.1.1795769736454;
        Fri, 27 Nov 2026 00:55:36 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853c9170sm739587505e9.14.2026.11.27.00.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:55:36 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Roland Schober <rolandschober1968@gmail.com>
Subject: [RFC PATCH BlueZ 0/9] Periodic advertising and PAwR over MGMT
Date: Fri, 27 Nov 2026 09:55:16 +0100
Message-ID: <20261127085525.264299-1-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the user space side of the kernel RFC
"[RFC PATCH 0/5] Bluetooth: Periodic advertising and PAwR over MGMT":
a MGMT interface for periodic advertising and for the advertiser side
of Periodic Advertising with Responses (PAwR), with emulator support
and tests.

Patch 1 documents the three commands and two events in
doc/mgmt-protocol.rst; it is the place to comment on the interface.
Patch 2 adds the definitions, patch 3 the btmon decoding.

Patch 4 adds three btmgmt commands: pa-params sends Add Periodic
Advertising Parameters, pa-data sends Add Periodic Advertising Data,
pawr-serve answers the subevent data requests and prints the response
reports.

Plain periodic advertising:

  btmgmt add-ext-adv-params -P 1M 1
  btmgmt pa-params 1 0x50 0x50
  btmgmt pa-data 1 "0x05 0xff 0x59 0x00 0x01 0x02"
  btmgmt add-ext-adv-data 1

A PAwR train with 5 subevents of 5 response slots:

  btmgmt add-ext-adv-params -P 1M 1
  btmgmt pa-params 1 0xff 0xff 5 0x30 8 0x50 5
  btmgmt pawr-serve 1 5 5 &
  btmgmt add-ext-adv-data 1

Patches 5 to 8 are the emulator:

 - Patch 5 adds the PAwR HCI definitions to bt.h. They are the ones of
   my btmon series "monitor: Decode Periodic Advertising with
   Responses", which is not applied yet; the patch is dropped here
   when that series is in.
 - Patch 7 makes the emulator refuse to remove an advertising set
   while periodic advertising is enabled on it, as a controller does.
   The kernel series has a fix for exactly this.
 - Patch 8 adds the PAwR advertiser to controllers of version 6.0 and
   later: the parameters [v2], the subevent data requests once per
   periodic advertising interval, and the subevent data command, which
   answers Too Early and Too Late for data that was not asked for.
   Nothing is transmitted: the responder side and the response reports
   are not emulated yet.

Patch 9 adds 31 mgmt-tester cases. They need the kernel series; on a
kernel without it they fail.

Also tested with the kernel RFC in QEMU against the Nordic SoftDevice
Controller on a simulated nRF52 (BabbleSim), with Zephyr's
periodic_sync_rsp sample as the responder. That run covers what the
emulator does not: a synchronised responder and its response reports.

The D-Bus API is not part of this RFC; it follows when the MGMT
interface is agreed. For PAwR I expect bluetoothd to keep the data of
each subevent and to answer the data requests itself, since a D-Bus
round trip per request does not fit the controller's lead time.

Roland Schober (9):
  doc/mgmt: Add periodic advertising and PAwR commands and events
  lib/mgmt: Add periodic advertising and PAwR definitions
  monitor: Decode periodic advertising and PAwR MGMT commands and events
  client/mgmt: Add pa-params, pa-data and pawr-serve commands
  monitor: Add PAwR HCI definitions
  monitor: Add Too Late and Too Early error code definitions
  emulator/btdev: Keep advertising sets with periodic advertising
  emulator/btdev: Add Periodic Advertising with Responses advertiser
  mgmt-tester: Add periodic advertising and PAwR tests

 client/mgmt.c         |  275 +++++++++++
 doc/mgmt-protocol.rst |  208 +++++++++
 emulator/btdev.c      |  263 ++++++++++-
 lib/bluetooth/mgmt.h  |   74 +++
 monitor/bt.h          |  176 +++++++
 monitor/packet.c      |  204 ++++++++
 tools/mgmt-tester.c   | 1024 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 2222 insertions(+), 2 deletions(-)

-- 
2.47.3

