Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456288;
	b=sVQdv+Bx57ybHZT3GVH4Sw6d0INTt8uEjcv11NaBSGB6nO8FZtIuH774HzBpa2NG5wIZ
	 7M4DYpnewD8Mvil5Z8h9NpyDVoCqRaTLd6MCCqV1Fn5+4WqNS466mMOwnrWv1r2xZXFeI
	 g4NlHGGCtl89Nm3Yht1HZaOZ2mZapaj2l6D+xtDOAaoLLS3LhzH6PZWcyFuWhQrOTPEKi
	 +QSGzkDxQNBxiqXNom90y3xGvJP/XOmKM5r6hT/E15IlsPS1P9qGyJZeLoVxA2FmWF/Go
	 4F+6OOIK5A6mJ+mt5rcnxuIXqAjCmNyb9w9wLM4lOJQDx2Uip13opSgZXGK2tziNBOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=s4PmUnSHprvb6WLzBDSGQwgk6eZduNFqSmehuOLrEiQ=;
	b=wMj8OoMsx2soms6dKCmQ5N7GQrzTpCz1i3DBFj2dE87Xa9jJxlp8JwsTXRzqXDnNPJFV
	 94sKXXfQgRa2t2uW18CPCKk36JZbLrmUO4byJwzemX9xCmm3//EDFkGlX1slP+tyJhrJf
	 gpHcKROsOMczpgF/0eUVxu8SXjqYmvzcGs1P+fLH9AwactgB9lKscNfW4bhGKRzwMqNmz
	 jnJAmGhQVdPFks3KuzvMkmL6o6f0tdGWsbtZfvBKwluGAIkLTAp75c6smu1JFJds4nKMT
	 0YYe/o+UyBFvj1lhmvgmFr1SNrwyekic9+PgHanvQAQgU2PGMQq/z1lkXYD0J2zCZHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m8jS2o6q;
	arc=none smtp.remote-ip=209.85.222.46
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2CE606A31A
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA2CE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m8jS2o6q
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-98fea7e52b7so2234891241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 09:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795456287; x=1796061087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s4PmUnSHprvb6WLzBDSGQwgk6eZduNFqSmehuOLrEiQ=;
        b=m8jS2o6q28toSFMUWJNAAuqcSR5nFSp1Uofjr2wpWBfXfaWa+yvHOX9H86/2mDg6fZ
         f33PoAVSSKz6jCxnwFMqjGcIlZRwb0wVCQETaT7KXTs54xvKBZVDRPiKAKFC9hGNtawM
         ixtvC4r2iq5kwj+pb8VBiWU042L2APIUPQrcO7HAaLo+NXYlN26TfBa/9IYSbjKm+jx5
         TPU2n11xwjDwB87yXWkTVzmScLpWfHbCklJp3iBMOLsQoairlBRD4Vg05riYUrgBYfbu
         VDUOGutb/EoZ257BCQ/MBOqPj+iolYUNhBRIyPntGPuIC6YsDIsKj/JsybJ7i0Hb+4FY
         Gs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795456287; x=1796061087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s4PmUnSHprvb6WLzBDSGQwgk6eZduNFqSmehuOLrEiQ=;
        b=HrR68sKYR1qgcIsOqzyhpvVmth+8EL3znYzA0SieIMyJ640+Oma6Io2lqadZDgmZZK
         PWwvV0pvNgJYpLjsupwwPMckZncOmBYxym+m3cLSQ9IYiKqWmkHPGdG51EecJssyJxv9
         UOpPG7IjV7eAjN2DH7rzLfrrMiJLImu+8H7h7Xa5UriuG/llmpnm3iaue2QV3b8ltewJ
         kY1DEltRBiq9gl3NUF4iIAsF/OIw0auQKbkR6eEinol3hATT3eM+s+1IFewR7f5JzxuM
         rRnPaXkmTASF2vGJ3zklN+Lrsu68YY7igDMFLgKMA++yssCUO4/Jvlx0sHrFgsB7WJ6Z
         CkEw==
X-Gm-Message-State: APuU4Z/ATCs9IVSudBWg75GK3vHeqAWkJEJeSETnMqo5QsnIGaD0gpJ4
	sx3TprFT0VJp5AZybgep83WdV4qjXTUiYeXGINMhHADtxFm8IfJ56gVxLilVHw==
X-Gm-Gg: AZFdTZd/RLblfD06AN/Fkz95HNvzgnJi7fp6KYmfRKx+Qr/8yJ8bptBA6qYP8Q3YSza
	/ZTO9eXojnZMaONsE1/qu8h5dCpwYipLtMMcowdhNOgmWESFNuwQ2pssF5gX7gFRSQwGgh6CeG5
	JmJOwUDwdxa2VY/2a+PGT/tAI+QSD0rSnG6RJ6PkFoARubjnB5QVQR6BjzpFN1zg7UbaeG14UxH
	X4ctN5B7YJ38BGQTkEGGBdrDehn0v1gr3fi+JyYzcfPGUDGQTHO47e784sePgNHJfbv7eGlHR19
	cT8nO5GZme0qDrTR3J7JqnS5E6HKI7ySSBrryyavpYfyE8G+PT5nJkZ+XIyEQLe56iqPdOmeZJr
	rD9LPIpxQ15fKt/AnqxkuaJh8TUTPse312KmZvuMbPpqvT7hcG66ZwtqWYybZgNNgql3+L9mZah
	8sdwTBN08ekOyKQO83NkLu1UuhwCXeqNPmstOss5HGIRPwDE62BoFlvne3fOEW1nY9GJjCbE71n
	frvzR1YwyytbY38ZO1SXfgE3XBTGZUqrAQbdko53LS8AXbFIqh/VTiANAcowHnztZKXzuuThX0A
	l9WUzuNciTI+pEgF7Lhm+tIW1r0GwbbJuLwjGbSkPNyFiKe72amQkkPqZD+B01ffracSbyxkW+6
	YO3Q0jlarFnYkqlLY5HI4OjqZ0OJ65xfUn1j4o51lVOgpt8R3evgqqLsGENuMTlhjHlSiAobN+1
	6uLQTg6d8mpf7ui4zKfUa7BPXLCg==
X-Received: by 2002:a05:6102:4189:b0:7c3:ac79:9b09 with SMTP id ada2fe7eead31-7d7395b0aeamr5934877137.30.1795456286587;
        Mon, 23 Nov 2026 09:51:26 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7f92680sm12795393137.5.2026.11.23.09.51.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:51:26 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 00/18] Channel Sounding and RAP fixes
Date: Mon, 23 Nov 2026 12:51:03 -0500
Message-ID: <20261123175125.3642617-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This series fixes the Ranging Profile Requester and Reflector setup
and RAS server issues found while running the RAP and RAS PTS tests
(Channel Sounding with a Reflector, peer-created configurations,
Ranging Data subscriptions, per-connection Ranging Counters), plus a
GATT database CCC state leak and a use-after-free in bluetoothctl.

v5:
- profiles/ranging: do not keep the STARTED state of a session whose
  disable is still outstanding when StartMeasurement() is called, so the
  new setup creates its configuration.
- shared/rap: subscribe a selected, non-disabled mode again on the next
  start when its subscription ended or was rejected.
- unit/test-rap: add a test for re-subscribing the selected mode.

v4:
- profiles/ranging: filter Procedure Enable Complete by connection and
  decode event handles before the lookup (also big-endian hosts).
- profiles/ranging: use the config ID chosen by the peer and clear the
  role, pending Security Enable and procedure when it is removed.
- profiles/ranging: serialize restarts with a session generation and by
  recognizing the report of a disable sent before the restart.
- profiles/ranging: honor the stopped session for Config Complete and
  Procedure Enable Complete, and defer procedure setup until both
  capability reads are in.
- profiles/ranging: stop a running Reflector procedure by removing the
  configuration, decide Reflector sessions from the negotiated role,
  ignore duration for Reflector and clean up on every way a session ends.
- shared/rap: wait for the RAS Features read before picking a mode, keep
  an explicit Disabled mode, retry rejected CCCD writes and arm the
  Real-time timeout when it is enabled mid-procedure.
- unit/test-rap: tests for the shared/rap changes.

v3:
- gatt-database: ignore device removal when the adapter has no GATT
  database (non-LE controllers).
- profiles/ranging: end an armed Reflector session when the remote
  procedure stops, so bluetoothctl and the daemon agree on the session.
- profiles/ranging: ignore Remote FAE completions of other links.
- profiles/ranging: also handle Encryption Change v2 and v3 events when
  deferring CS Security Enable.
- profiles/ranging: keep the setup state of a configuration the peer
  created before StartMeasurement() instead of resetting it to INIT.

v2:
- gatt-database: clear the cached state of both bearers of a dual-mode
  device when it is removed.
- shared/rap: keep the Ranging Data Ready and Overwritten counters per
  connection instead of resetting the adapter-wide state on detach.
- profiles/ranging: exclude armed Reflector sessions from the Active
  property.
- profiles/ranging: ignore Remote Supported Capabilities of unmapped
  handles, so one link cannot overwrite another's antenna limits.
- profiles/ranging: enter CS_STATE_INIT before the asynchronous
  capability reads, so a peer-created configuration is not rewound.
- unit/test-rap: add tests for the Requester Ranging Data subscriptions,
  the Real-time timeout and the per-connection counters.

Cheng Jiang (15):
  gatt-database: Drop stale device state for removed bonds
  shared/rap: Reset the readable Ranging Counters per connection
  shared/rap: Subscribe on-demand data with the requested transport
  shared/rap: Subscribe to Ranging Data when a measurement starts
  client/cs: Fix use-after-free in stop_measurement_reply
  shared/hci: Look up the connection handle on the right link
  profiles/ranging: Let the Reflector run the CS setup phase
  profiles/ranging: Let StartMeasurement() pick the Initiator for Both
  profiles/ranging: Take the CS role from Config Complete
  profiles/ranging: Act on a CS configuration created by the peer
  profiles/ranging: Keep a peer-driven setup from being rewound
  profiles/ranging: Defer CS Security Enable until the link is encrypted
  profiles/ranging: Choose the CS antenna configuration from both ends
  profiles/ranging: Do not start a procedure after StopMeasurement()
  shared/rap: Start the Real-time timeout when the procedure starts

Luiz Augusto von Dentz (3):
  profiles/ranging: Keep CS sessions apart from stale and unrelated
    events
  unit/test-rap: Add tests for Ranging Data subscription and counters
  shared/rap: Defer Ranging Data mode selection until Features is read

 client/cs.c                        |  40 +-
 doc/org.bluez.ChannelSounding1.rst |  25 +-
 lib/bluetooth/hci.h                |   1 +
 profiles/ranging/rap.c             |  90 +++-
 profiles/ranging/rap_hci.c         | 724 ++++++++++++++++++++++++-----
 src/device.c                       |   3 +
 src/gatt-database.c                |  34 ++
 src/gatt-database.h                |   2 +
 src/shared/hci.c                   |  12 +-
 src/shared/hci.h                   |   2 +-
 src/shared/rap.c                   | 212 ++++++++-
 src/shared/rap.h                   |  11 +-
 tools/hcitool.c                    |   3 -
 unit/test-rap.c                    | 629 +++++++++++++++++++++++--
 14 files changed, 1535 insertions(+), 253 deletions(-)

-- 
2.56.0

