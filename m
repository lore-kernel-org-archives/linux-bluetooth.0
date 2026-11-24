Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534740;
	b=kEV6PTYKtayzGR3+lfUdRxrCe+1d2JkdPxQkU2A+In923TdaeK7oS0e6Z1Wn1f3J/1O6
	 bEPl23uPzwdv1FHkoMKo0tDwRw1wj0uMLtB/C9RAfGl1yek9u9zgIfcsOpQzjzKDzYNdH
	 B/3t9L9QpRtePFtMfH1g853NDQDn4ccz3RIi+PXsW4MymJNvEoLdBHgLzRmfFO8cKMzs/
	 xum3snyhW+L/PVMK9gBrIPtAd9C8LIL+s3kLvV8cn0Bzfoy4GQ2chh9Jiq6WrizRA5gdK
	 zA0vCYiD9fMwujjXpXzf3qlw1+lY/0qFMed/QLsGMywIEbVK8V+LeCVVdLbQEnBkDqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=JfmDcyE7YvE1jK1QkvlzFWvgbG+ha52Ix7N1HKTodLg=;
	b=YF2Gev6pj8RwKjG1SfAJ0ZFp9AMJryPaFr/CxlWuKXh4lWIb95CMKiH1CIvv1LykmKcN
	 tcrYNl2M47ed82/FlhKROOTs8L+TBk37YF0GtgfY9ZhuoDz6IamREqk8iSiUFvv/sSYkN
	 6fZlbwyD4OCtAAvQrvQjte32w0ocBnNBYv4zjXziN/0lbHr+ZHQAlTxVRjc+H9kGSLMCA
	 09nE9FqIWhPChTsvtGzTy8W+M/J/0pIJ2NGinihDFzhWeMWvmf0duX9SDXvUDa2tOJF8U
	 BcuFWjfUxO4CHaqidGh3Ke2knyjivhgu9zPq0MTQ8d33nK9tKcFj70zmh2dlWVoQqpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TCZtvfiU;
	arc=none smtp.remote-ip=209.85.222.54
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E2F606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5E2F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TCZtvfiU
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-99b49d6a5caso1326751241.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795534738; x=1796139538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JfmDcyE7YvE1jK1QkvlzFWvgbG+ha52Ix7N1HKTodLg=;
        b=TCZtvfiUAdCsebYZi0I6uFMoulxJx8WF/oxDUwBbo6rRSLGzHOICGL1xYVsVh8Tqtp
         Jqyr60v8Q21fqE054Cftl6+XaNMnAVNFdBYoBSzDEEUXFKyQ+uHNKM34v25uvmahwtm+
         j8abvTFJx6BD4c4QmksfxGZ/yNPls+D/htfkdWXX5HWRCWUstyq+mqthVzDlOpqqKz8t
         yFkkDarU2S6713c2oRroKk5OYncb8A8FrGO2X0stgFMaCHOv+0NVFrIzG3abua+gVpAp
         x0Vig1l9/NCwibYFkCCeRqZWM4tUn0dGjePKxOlRXrao9x6oWI7hzMAU+beMa26F/KPf
         Cg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534738; x=1796139538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JfmDcyE7YvE1jK1QkvlzFWvgbG+ha52Ix7N1HKTodLg=;
        b=pGGA4DiSsmfgNqo561zIG8UkpZHk6RoJ3O9/MjSLaoWmxS2Ch8QT1WH4NHOOrOeiVx
         l83a2hRZH+GSTfO1Cf1eR0ZApc+T7+PUr6//9Ir+39Iwlhu5i/n+jP1fwC8ejllWNap8
         l+JChKEqkxy+gr57xiXvI1JyP3Uh+eAVKeQ1Ip2ZCPxxc5Idx0T9nU2GFlteXsq8sMfx
         oFmvvhckA6jDJL3IrFVfd8JdBNZ++oqF5FMEkKc9CEc0LhHkZmTXO08m34hcLs4Kt9KK
         UhBsqOxxvB9/nrwFg/wQIem722aaH3FvVR57+pB631jSUHt47k8mktdRClLepffEgaWj
         FE1w==
X-Gm-Message-State: APuU4Z9Bm+6aFop+70Gudx3h8c02qkfff/tRbZsaM5X6bWBLMtg/1rWB
	FsUQQmQqzDlQ4hxpOPYXk2cLQF4ZovcfsOHf+wlMq/uDCwvBQ/ceb0Z/3vuJKg==
X-Gm-Gg: AZFdTZerqXjZpYozDaf93C2F85dad3iNb04Fyy5QXTpxHQIMBn/fULGiEbIxi62C6mW
	DxVrx/wiLus9G9pYG9KrTBPwWVYqSLIv/02yammp7/si9JULWAYMnW3+1RcpDvShOC5m58gAKwj
	khrFQobXFJEZYvtFGujnFmWmyVJcnRPBq3ZUFkkIgk+gWmO7TzrWgACCXbHlA7sIHlsmSnQxPmw
	Q7WmnNhjBbNDmdmGOOxbRqOx/9IbQrYpO6/qvBdgTq4MlZmoZwL08GYkCk5TYhXx4luArOXIc5b
	z7WWTQl4MncVumzo1FN5sfXpOgBMqFJKcC+FTTfvkB0faViIIntErHXyhxhCkAfDPKulSe1OqV2
	0nqYABl3ZUWf+AdPuaQBa62JerYe9vZXCTiW49fWLpaEvN8r223m56KrGRLrhUCuRNxuh+003lM
	hcMfMWqtVXOH9qC79dVaG3tAn+bcDnSWk8X87SBhpAyWMuBsywRmuZxjN64cRGJm88ux6PahtzX
	7bUf6dtx9TCWSa1Cr3uNI+TtMieAUwrYdHRwNm4m4+UMH8pB+pNB1mVgEEdKzW0LqCNOgpSz0ac
	xOxK/fdQVCmZtE7UG0FqC77YfKgyL2DMZuuMaUz4C7Vy5a/KL5979Eokrad6i0QmpldWoJi4l04
	PYWuVDiK5AyntHjr5qgD9SebzwbUaxjI+Rpro4K/d/drQkVgQQsW1pZpu81rbliVhZFf60Ef75F
	vwXvE=
X-Received: by 2002:a05:6122:4686:b0:5c0:fb8d:9993 with SMTP id 71dfb90a1353d-5ee8ad1091bmr7822329e0c.0.1795534738527;
        Tue, 24 Nov 2026 07:38:58 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5564a9sm14343463e0c.5.2026.11.24.07.38.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:38:58 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 00/18] Channel Sounding and RAP fixes
Date: Tue, 24 Nov 2026 10:38:37 -0500
Message-ID: <20261124153856.216054-1-luiz.dentz@gmail.com>
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

v6:
- profiles/ranging: process the report of a disable sent before a restart
  before the state guard of Procedure Enable Complete, so it is not left
  to swallow the next session's.
- profiles/ranging: keep a deferred procedure setup across
  StartMeasurement() instead of discarding it.
- shared/rap: remember an explicit mode selection only once it took
  effect.
- shared/rap: make only the missing On-demand registrations when
  subscribing again, so a retry does not register the others twice.
- unit/test-rap: tests for both.

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
 profiles/ranging/rap_hci.c         | 733 +++++++++++++++++++++++------
 src/device.c                       |   3 +
 src/gatt-database.c                |  34 ++
 src/gatt-database.h                |   2 +
 src/shared/hci.c                   |  12 +-
 src/shared/hci.h                   |   2 +-
 src/shared/rap.c                   | 243 ++++++++--
 src/shared/rap.h                   |  11 +-
 tools/hcitool.c                    |   3 -
 unit/test-rap.c                    | 676 ++++++++++++++++++++++++--
 14 files changed, 1606 insertions(+), 269 deletions(-)

-- 
2.56.0

