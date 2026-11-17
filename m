Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794939717;
	b=EriF3ujYwGVWd4bIhErjDJpg09s001JJh7TnjJskeSi7xUETksEtCXYaRNWVOSuYhQp6
	 VsrFsGgg0Zb9IKKAUEOL22aQPpJOBDPbo9dt1q+sRtrte/ydsxtjn0gCwUr0jAsecseWm
	 g5o48M1YIL0/CfIQO09CCqin+te4w0ZNnPxnpH+KtXvza3zTMuVJHV4QCXDltFby148tg
	 e+g/zQPzNbmjms2i+1eTMWWqidsaA3p56O5aMn0lrwfdQoquX/5BmhCWM1uNLnymGvdeV
	 s4I2mepTZjXz7sy4B8641xLQ5M3mJJNZHX4J3zngzoAW8H25Ai/uNrlbQWpnNagr3dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794939717;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GWggf8m+bNG/8sCBEQuiaKlegpZe+NkILiMyJhHArGA=;
	b=gsOO+k6vwY/yytqYIToaXU4fdyX7JS3QRvG5DurmcnaIgsxSIQVwL40l6xl7qcWlixjC
	 b2BGm7qxB8YpSt0xxK1BBKrYsP3xu3bS7prk5YFVlapPJPqbXuOQoqfdyQgh0EyJWM/m4
	 s8jwIh6yIgk+ErI3zOMjgTLpVfghfnEUCVqH99Z1t2fA4KPJZNTWfe1t1wVYa1Lb6csWx
	 Hlddq+bo92rBAI1nydNazH8Rpix708gGdhIBBQ058jr8Kqz2AJmH5+LQUEzhjQdCCJp92
	 DkbS95u7jkAqTvw6Ik+zKYXQuceaVF1gcBeFoWU0fYUkFowNYIZbCU706zv4FUSUiyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=yoaWqy+U;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A8606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 529A8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=yoaWqy+U
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-38190551625so345447eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 10:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794939716; x=1795544516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GWggf8m+bNG/8sCBEQuiaKlegpZe+NkILiMyJhHArGA=;
        b=yoaWqy+UnE5Rv3N2Z8MxZPfk2CzdYSp0rkSzbhsYeRSzCS4GOG+tTevELuPBRIPLg5
         5oQPebwiBp4HYLJPMVrit6IwQjjWDPp6ynjej+1DaEA8pGYN97ymQeKPbxs3vP/URGIA
         T0i7bTT7qr9kRvtq3SqENaIP8XYfEtVmeqxhLf+jIOgihXMl9uIeJbHIJWjrKyKMKV1O
         XJVmadUYQ6OG3EIl84PMg8Shigos4M/8HBx952jIuwfGBTuz/uUApmDbItOJHbtg1WI1
         zZzcXUeiDq6VlviJfP0gqh/TSjVrNKu3tlpJwICg6ngltXmUBE/btHxm8XtG6md+ilIh
         LcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794939716; x=1795544516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GWggf8m+bNG/8sCBEQuiaKlegpZe+NkILiMyJhHArGA=;
        b=AairnWuk4VSotuSSylrQKCghG3f/JHdW3hNI9+mVqQo/LX1ZtiokdZSNbWHDqIsVUh
         nI0E/Rn62jwdy62EIE+iRvQlR0hw0IWKeNxEr50LY96er/qWcQ/BqvcyFnCyyG4sbj7m
         lN3jwdMqT/RPnVM/3rojT/C5pGlLl2m3kMjhj3MM0e5yCApaQ3R1IYZBuLQyX7jn+EfE
         2yUBaaoGHRKhtK/TZtecj/EdCS8l576r63qR1wCCNEyw3pvsYGe7Wl0ZVP3ni0WJAiOt
         9RfsKvqrMgiaI1A9jDfz/Z2N4OB1eDAy1CtcUnQIr3IaYemNBovSN07d8ojl8X5NKMiq
         a7XQ==
X-Gm-Message-State: APuU4Z+iTEtiy0b6cVGkZXm7CvPQ28lp0En7qMGCiKb3poWTflO5485/
	S6DxE0Jer1WgJo362Fo32tw6PmdwQzikeE7h71t0C78Wq5UTP81+coRn1yfbEmE2VgVocPyk1D+
	XVyb1/48=
X-Gm-Gg: AZFdTZdXKBacfsacpPYcBLcARFN7d4dGG/I60Gywq63zDIqAlty4KH6Ip9wMIg6XosH
	gi4qWJWOY60RVib2zKYUPUK68FZV5Lz1b2IDyba76TQELadyq+33rGqb+S381IeLqgQEsDNqEJT
	MNFzuqQ5j2a/tmB7jAxr1we2b36SC724JILvWA79u/E9dlv76BmDB4coZIGJY7axIT3EDDtP8oO
	ETzDL0mcCE+u8uJcMfBXBqH7SWQTM5yWWMuAc5mJBPT5dj1kOlNjd+NVjhgPlcQ7hCE+U5sKP2j
	IQPXshi+TAmA41VB+0csTkryFyklbBclTLxicU5oOlsg1+mGP6BehSlx8kcBgucOfowNvLkvT3i
	gh5edRrRTA3vUfOocmT0wLcUiAUiI2zXc4lMstrcjkhx4DJzpOkQGskcCREU6DLD09/Wl2Unw1E
	nchVJrh/kAhMqhWzCR9pKTZ/5mHJ+7kenIJp8/RshefFCwhtIyi2NXaFJVmsVtNEfAmmp7eQ+du
	11tTXea0K90avHeHClNttOcFxD5kLb4L3Jkq54wd+vdPDqY8pkblemt0Vjdu2Aspzb58W0rd4p/
	LTXP+t/di8p/rgKVZKSwDHBdeRorTPnW2/kmqdiEA+7lx4IYGyVqArlIpbu/mpLzu66377Saml5
	JHUfEH3o+Cy0G5ehSTezWs9+TTvaZUierNrN7NHwKiu8KEU0/LsQyjujb75XnTc23cX3TqOY=
X-Received: by 2002:a05:7300:dc05:b0:381:6ecf:5389 with SMTP id 5a478bee46e88-38281cf6a20mr322165eec.41.1794939716155;
        Tue, 17 Nov 2026 10:21:56 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-380d5135221sm10503213eec.24.2026.11.17.10.21.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 10:21:55 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v5 0/4] Bearer.LE1: Add ReadRSSI
Date: Tue, 17 Nov 2026 10:21:47 -0800
Message-ID: <20261117182151.73722-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
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

This adds ReadRSSI to Bearer.LE1 as a testing method, for diagnostics
and production testing, as discussed on v1 [1]. It is only available
when D-Bus testing interfaces are enabled, with bluetoothd -T or
Testing = true in main.conf.

Each call sends Get Connection Information, which the kernel answers
from the controller or with the value it read in the last 1 to 3
seconds. A call made right after Connect returns fails with NotReady
until the kernel has read the remote features.

Changes in v5, from the automated review of v4 [2]:
- When the bearer is destroyed, fail the ReadRSSI calls still waiting
  for the reply with NotConnected, rather than leaving them to time out.
- Rebase on master.

Changes in v4, from the automated review of v3 [3]:
- Don't cancel a Get Connection Information request that is still
  pending when the bearer is destroyed. The kernel replies to it
  anyway, and shared/mgmt would take that reply for the reply to the
  next request. The request now has its own state, freed by a destroy
  callback btd_adapter_get_conn_info takes, and
  btd_adapter_cancel_request is removed.
- Allocate the queue of pending calls with the request, so it does not
  leak if the bearer interface fails to register.

Changes in v3, from the review of v2 [4]:
- Retry ReadRSSI in the functional test while it fails with NotReady.
- Check that the RSSI is between -127 and 20 dBm instead of the -1 dBm
  of the emulated controller, so the test also passes with real
  controllers.

Changes in v2:
- Make ReadRSSI a testing method and mark it [testing] in the
  documentation.
- Enable testing interfaces on one host in the functional test, and
  check that the other host does not export ReadRSSI.
- Rebase on master.

Tested with the functional test on bluetooth-next 3f425f95ba39, and on
an RTL8761BU connected to an nRF52840: with -T, ReadRSSI returned
-42 dBm; without it, the method was not exported.

A request pending when the bearer is destroyed was tested with three
emulated hosts and an emulator that answers Read RSSI after 1.5
seconds: host0 reads the RSSI of host1, host1 powers off, host0
removes it and then reads the RSSI of host2. With v5 the read of host1
failed with NotConnected when host1 was removed, and the read of host2
got the RSSI of host2. With v4 the read of host1 got no reply until
its D-Bus timeout, and with v3 the read of host2 got the RSSI of
host1. The test is not included as it needs the delay in the emulator,
but I can send it if it is useful.

[1] https://lore.kernel.org/linux-bluetooth/20261112032250.37687-1-kevin@simpleble.org/
[2] https://github.com/bluez/bluez/pull/2832
[3] https://github.com/bluez/bluez/pull/2825
[4] https://lore.kernel.org/linux-bluetooth/20261113051438.75230-1-kevin@simpleble.org/

Kevin Dewald (4):
  org.bluez.Bearer: Add ReadRSSI method
  adapter: Add btd_adapter_get_conn_info
  bearer: Add ReadRSSI method
  test: functional: add bearer ReadRSSI test

 doc/org.bluez.Bearer.LE.rst    |  19 +++++
 src/adapter.c                  |  18 +++++
 src/adapter.h                  |   7 ++
 src/bearer.c                   | 142 ++++++++++++++++++++++++++++++++-
 test/functional/test_bearer.py |  58 ++++++++++++++
 5 files changed, 242 insertions(+), 2 deletions(-)


base-commit: 923d95d0c2fb001b545fa8a8b2e3a8a9bf0dbabf
-- 
2.54.0 (Apple Git-157)

