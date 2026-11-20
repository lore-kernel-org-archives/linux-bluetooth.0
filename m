Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193715;
	b=TDZU7z4yrOlzdPMnE3KzI8loZ55mR+WbORb3adruMBCj7TEyF3U8jJCvU8LACA8unTiL
	 tDQuxQQplrmW6VOTu+kSi17slXTXuShsSRw2CynnXa0WxruNmRxFktvdyNAcjSbHEXG2E
	 CYdrkox7MXCMvFZPB04bSnguC0QErhc4I6X8/6opBHvYPKNqh6m0Tj4036zbxYE9Ya9va
	 UFacaG0V/yZuF7jIgA+HHusFNJZhaOx0mHQHNIVPCOp7JnzsEa7JitRq0OkHi7g9ElCZ/
	 /O93ZBOUrx9NS4/hNr98R2liLJ0oWh9KyLL8854BxdAM19ZhggvZERJ8IgHG+ManjZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ElO73yNjCIzAA6t3svuJRavPK3fg+4ryODBQrYhgIuM=;
	b=mn7JDbwG15+Mm2eCUAKblH9FQvgyZdqljzPRKAlwHNPTgh0qCouwL4Swie+1+H46naLE
	 0pE6O42eeGJHKP7BHfayBLUE9Vzdiwo49gjMwcqjGW22XALYgsmY2sxvZ+lsDu/l1hOTm
	 vEwDJqgzZVj2rcwf5MNi+rFlrTYJoCQvNMDPv7nqlraoOetVxj1O9JH6LVWg87oDcxjMk
	 uREcPbXWNsxIepDxuTy9DbF7yN/7Jjd1/snsN7SQfc7kGUBNy+t/L0DLpE1gfffX3QZjZ
	 BRPyED76vyc+j+wJ99YVQsmuj3FBBSnuVJiNOo2TuZ4XO8BT2/vkza5OVQjGa0jc+dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="l3wov/tw";
	arc=none smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C48C606A335
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 16:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C48C606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l3wov/tw
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-99e0b348a05so325526241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 08:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193713; x=1795798513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ElO73yNjCIzAA6t3svuJRavPK3fg+4ryODBQrYhgIuM=;
        b=l3wov/twgJAM3vkIo3r9gi8OkteC1bDl8mDiltog0ddlp14CT+EOo6jkk2JHjtxGBB
         a1NF7bffl67PrtrxYUthX56a0axEKfNTJH1jsVjXBxjy8FqCoccO6XpssmQIM53radHl
         umDbQB/KZlSOwTEpzdAZsj//Fu/ZievzqnrAoxv9BppH8Nb4jc/DZRxMWyz9SFMDvw8z
         65noUxQN/ZiKffdp3WNka96LT/QUItGeyiiFwJvy/MPneWFonvMwxICWhc9l0Cw4+98E
         llv7MioZ+35TAJ+SsTu9v6FuMR1HSHVJo2QscGatzalIE123m3kIQM8q7kBxdogzbG+X
         ivhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193713; x=1795798513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ElO73yNjCIzAA6t3svuJRavPK3fg+4ryODBQrYhgIuM=;
        b=XiVRl7/Fz4LR4w6RQ2/EKV0dql7HaGisuWyvd5wzB6mxEy94HyuuT2VcGdtKxcugBW
         L9wggWRPPr1JZyTFmg3VRhMUxSQoP49MZXn6jAYA51t4EbPPVLhdIJmN+Us/n5jeIxgE
         dsEBP9U/8bVVCaaaxYEXBxiPBsAbVnvOYYTXHYoqj6eVXGwguRzRrQ0zCZdi+XFaSG54
         p10Ao9NJ1m7mM76YopZ4esHbQBMrpC2nQucod2kRlbUJW2UVHIt7CK9lp7SFfgj8wrpg
         eDVBF2El//MTkkgra8WaLjaUt9WPcOtC8HluO98e3hQbiVub2iADxNNBLoKpaYEF3Tjr
         Es0w==
X-Gm-Message-State: APuU4Z/pVxnCF1x0KY++VAFY/Pzrberdismu3bFhpf0vkoNeKQOI+iWn
	qTaYHCj2pmqGeZqqMviPTopew+3/Auq3fbiR5SzLGpObHiyqQs/hR1evrvMLa0NN
X-Gm-Gg: AZFdTZdwG9XltXvTko9iyuk7PSHaDaD1qthm1WcXrEDLgzPAi6B7o514ibXzm5mgcbM
	LN0FOwLR7aJJfBymIp4UXWWNX3axT59CuUbJQM7nrzLfX+xLtVzrn3EpKwsBJSOgjz6IVoI8Q5E
	bLpNGSz9CXemi/JwtuFideJ182joUpeY882aUjykOTzR5wcYrvEsCxn6OZwG6PlHEfekr8fCKOD
	TjHstLkP2phEiJE4ZmMvI1d+B1UUpegsYJN7vmzgP+rfTRhbrTnTC0z9/zrMW/YzE9rncu0TJMX
	tsT58FFId9slCPCcAIR+D6r2awL2IGugBCJNuEZx5nrxkZepwDhjtF3jlTjuCDLclXqFtRWS7sq
	m/5noffvUOtgRlGuT+Inp2uZXvmZQGAwBQ56Uo/5oiHjqj1AlwbyfhRJvRjjC1M3AgGqLpZCaIm
	yliX4i5Eh4oRrZEieud2ehxii71p9liXi2DHqH+8Zl0/yLjNHFsJae29/bCyg4NQwmA9EQZ35PR
	UZbPOKjVxKNQ3Z1m289xjUDDJYAs332X5MmDdP/MQRKQ0mRwJ9AV1X1LUcLLJ5GyDgwej1tHWCo
	vED9i5dogfDKMNAqsFu7+ohI2uwWledgkWESXujwJ6bP35hT8+1d0jcqml7tv34dv/dPKC7J/Z/
	ojVKYjNQD7wqoKk3FKReblnF8w9awqBchShfmjfK/x7sqefzuwa5c6LQ6v6EM4qrvhLIJzYgO8H
	xy1rU=
X-Received: by 2002:a05:6102:448b:b0:7cb:288a:b66d with SMTP id ada2fe7eead31-7d739424abemr1721011137.20.1795193712972;
        Fri, 20 Nov 2026 08:55:12 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6df8a28dsm3486193241.4.2026.11.20.08.55.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:55:12 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 00/18] Channel Sounding and RAP fixes
Date: Fri, 20 Nov 2026 11:54:50 -0500
Message-ID: <20261120165510.1858959-1-luiz.dentz@gmail.com>
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
 profiles/ranging/rap_hci.c         | 721 +++++++++++++++++++++++------
 src/device.c                       |   3 +
 src/gatt-database.c                |  34 ++
 src/gatt-database.h                |   2 +
 src/shared/hci.c                   |  12 +-
 src/shared/hci.h                   |   2 +-
 src/shared/rap.c                   | 190 +++++++-
 src/shared/rap.h                   |  11 +-
 tools/hcitool.c                    |   3 -
 unit/test-rap.c                    | 604 ++++++++++++++++++++++--
 14 files changed, 1485 insertions(+), 253 deletions(-)

-- 
2.56.0

