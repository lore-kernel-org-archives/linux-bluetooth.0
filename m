Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795580240;
	b=msO9NvLwh/geLhRpPkf3DIBsmnK6Xpb716GK/tfbulpQNZoXQN7UVK96/GgjT0RV5JQQ
	 gsVKrmdSwql3BjowMVOhEfMFvZEh9c5iWa9D3r/Uusjfw5B2HrVjtDqA/+/WACOAxqvvR
	 h9yR9iFDjAjqCKuDQadanjwQl1K7fCrdX3AEXAkVftZuzqHCuWYEj4SyVPFetSKrHllYA
	 3lUb/aw72uvF9STMYxQfVda92KxCXT9z2Y835qFn+r1reQnSIZsFrD8IStfCJTGEN5Gfp
	 pYFR34ZNXT/akcu1rvH3wcuM+m1WL93YSY9Ev8W1ZVV2RWkrba7M6pheqjz/7PeP6hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795580240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9Hoeix2fPUg1Iw5AygvzA+UUEQZ5mvQm+K0uwQgZsM0=;
	b=TFPZN+lSmgf80VAOHe2AqGdSKw4m8nP/AArYR3FMzPCVyAYdiW7PTak/FG+oynjTWaPL
	 xeDA8dIpamJanN88bukJt8e9pBRzmB8YcaPyqpLq1RM/nGTJJrPVfIQTkf/O2eyeD0AW5
	 S/1SmqNHLZDPAsy7u+XeYppyCRV9ePMLkEhFPBCWjqPDWn/oGmoDJ/w/rNjContVvqrLE
	 TWxeouliVc6l4ua2/1l5cNUw8GLxDki4WWPaK+PY2RaieKf+sFuX0v9T9rmnSo0DJpDIx
	 HGEg0/UtwJnW02q95B5cmj1wnDsM33N0uVVPZGhVuggCEqSKbNb5MeqN2OAY0/obX4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pBaKUWYs;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BC8606A331
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 04:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49BC8606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pBaKUWYs
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a05b210703so2484259b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 20:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795580240; x=1796185040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Hoeix2fPUg1Iw5AygvzA+UUEQZ5mvQm+K0uwQgZsM0=;
        b=pBaKUWYsV+PoGWrLOowpUdesaGFODx0EQto7Jw8LPds3EDtptpYjL/0rc9WPfHFr87
         qwsvWIBoETfaKps1j1d3tII7onjlOP5bmiZ68BoXWEnPTiZVMr5urukV9gSIEf0dQBaN
         OMz82OHqhVmt5IaJfsusC3qMkqgm9ilTPWvykAcKPtJwO288tntTWTY3w9Jd1n89rbut
         R2ENZgJ1IoeUwu0bPfmauOYoO54GujUj8r/RLuBD8He76idHLLCp9wVww/sU5YNRFSQ/
         OgEvdIlTFG01niySu33uQxnyarnWf6+6QR6OCviZ5zWEgJLDQVthferEdRxEIORJ/MYm
         +iTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795580240; x=1796185040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Hoeix2fPUg1Iw5AygvzA+UUEQZ5mvQm+K0uwQgZsM0=;
        b=DU+IFvP3gAddf02Cba/6QJaGHUQLAsdtA6F/OUHh/AOaj2ZZKCHTQMMpv9yLzHTDhR
         MHjC6cWkQeBUDRAjSNi673Wf8uLmmT6DrnddNDUe2T/ksT91qDxLih2BtkCBABiIBr0V
         m1FTZ5zNGIYqU7X5X2pgGLk5uoc5Lj/HpHXmwt+uRp0MT6+LHpAFKnHEOSNcl+2WzCG8
         TRuRp6YSw+50UEGC7grxfB24MzlzEeZnsbFleU0EOOxb0Lj4q/DT3OtcOPHnevxiTSHu
         C4fSuQofkAvZCwQQc53F3LEliPUbF2UF6IDgjWrnJTC2NPX8fatrQP8IONEP/kwfzKLq
         opzw==
X-Gm-Message-State: APuU4Z+nQAUHa6TTMjCWaxEinVup9gfuYK4iejNr7SG+5BSYOEv5D4gq
	+pVlAo6QoWaHGVpbIs2dcfybp9KlG7g//vT/8xcYE69jacs0R7JryiTU0JkD6Q==
X-Gm-Gg: AZFdTZeCc4/Xv/KsI0U1GDColQivOmAVCp2cHmixCGM9wyR7dCrdZSriQiXd6nwxNFc
	OFTUVaI55MstZyu+U2tgz4xibDw9DDW7QVblzCrHjh4BYzkWKcaWlN3ubalpI4tcFf1XYZNrWkg
	O5dHGU6/OxuxESRy0pBJrMqTMR1vOsOp1ik0c6Ceqx6SJQzBnyvzGmmLCT0fNmF2BDG3ERzkDI7
	4o72PGsfi5S2CsbAhG7FGN3RB2TR5u5HJMpOjJbx/FOdp9QaZdUdYvGpKcAQVTPNppEMo2IuTn2
	hog6kZyuuXFfnRgfXPv4BPTBcFbCgrS+5BsVQ8RpJYLyYJUMpN2lS0wCGTueMuvX5jOH79fKbiO
	9o1bT2ZLy/iNUfxxrNh6Mn8nLxQG+z22P9o3YCa70UIhAjF706UhKVhwzsGUQTYR1CpPne4Z1X7
	oIyVDBTSAtDXQyhvL4QtJtiN7OWfFnIzxuYcQ4bqPUKMT39SN3nqGgTsuy3m9ODXk5NQ2iZMo77
	iQUMJIMm4QB8msCdj3jiKzQzyM7Ri/ldJz5D9kBzicgMoMmjYUBJv0IKrswIBBfznH/sCaNnGE+
	wFuKkJW41SZ7ysSHV8JQFheXhejCT3Ikf8EGVGfz37rHGw+ydM4=
X-Received: by 2002:a05:6a20:b40a:b0:3e3:37ff:3797 with SMTP id adf61e73a8af0-4014bc4bcddmr14804407637.45.1795580239501;
        Tue, 24 Nov 2026 20:17:19 -0800 (PST)
Received: from fedora.tail791dd8.ts.net ([2601:1c0:4300:57a:5830:187:53e3:add2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87343f726sm8503875b3a.36.2026.11.24.20.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:17:19 -0800 (PST)
From: Dylan MacKenzie <ecstaticmorse@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dylan MacKenzie <ecstaticmorse@gmail.com>
Subject: [PATCH BlueZ v2 0/2] input: Do not re-page HID devices that disconnected on purpose
Date: Tue, 24 Nov 2026 20:17:12 -0800
Message-ID: <20261125041714.2691802-1-ecstaticmorse@gmail.com>
X-Mailer: git-send-email 2.56.1
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

The input plugin re-pages a HID device after its connection is closed
even when the link was terminated on purpose, which takes devices that
can be bonded to several hosts, e.g. earbuds, away from the host they
just switched to. Details are in patch 2.

Patch 1 keeps the reason of the last disconnection in the per-bearer
state of the device, patch 2 uses it to skip the reconnection when the
link was terminated by the remote device or by the local host. The
reason is checked both before the reconnection timer is started and
every time it fires, and a timer still pending from an earlier link
loss is cancelled when the connection is then closed on purpose. Link
loss keeps being handled as before.

I tested with Pixel Buds Pro 2 with these changes applied on top of 5.87.
They no longer reconnect to my Linux laptop after I connect them to my
phone.

According to Claude:

    One behaviour change to be aware of: the kernel reports Remote Device
    Terminated Connection due to Power Off (0x15) as
    MGMT_DEV_DISCONN_REMOTE as well, so a device with ReconnectMode "host"
    that announces it is powering off is no longer paged if it comes back
    within 3 minutes.

Hopefully a maintainer can evaluate the correctness/significance of
this.

Changes in v2:
- Check the disconnect reason every time the timer fires as well as
  before starting it, so a device that was lost, came back and then
  left on purpose before the next attempt is not paged by the timer
  started for the earlier loss.
- Cancel a timer still pending from an earlier link loss when the
  connection is then closed on purpose.

The v1 problem was found by the AI review (Copilot) of the GitHub mirror
of this series, bluez/bluez#2864 and seems legit. It suggested
cancelling the pending timer where the reason was already checked. More
robust is to check the condition twice, once before registering a timer
and once when the timer fires.


Dylan MacKenzie (2):
  device: Add btd_device_get_disconnect_reason
  input/device: Only auto-reconnect on link loss

 profiles/input/device.c | 34 +++++++++++++++++++++++++++++++++-
 src/device.c            |  7 +++++++
 src/device.h            |  1 +
 3 files changed, 41 insertions(+), 1 deletion(-)

-- 
2.56.1

