Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813387;
	b=RaaZ0sWXyE8Gy0G6V+qXdZbQrjtUJuwqc0REiEm0P9nDVDvECl3wHH205E/42HdpGzip
	 0jR2SBwdBWteeNW6y+MYPTAkR/Id66+a19Jm5jFdELt+dd+9EQwp/Xw04yh5QkK4efiQJ
	 tC6erTi+P7CZp48TtM4L4A4XmGaf7NA31DZgRUPN3vEPWgDae42jGEBQmjhWph5icykqo
	 mPWYUC6ZwLYkujixTknQYPbCCAe67j7xytYh7UDe62IzskS1hvL3VRMA9Hgh8CD1ZV7Ev
	 V4wAeXcpItgXGDT+gsz5AhcQpT7XdR5UD1r3TQLkQ6M9HVT1ntpGOScQmaHBh5i8NQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=pT3USewkr6ZN1h/voCkI5hQ0kdKOEVQrNGUW2/UwP80=;
	b=KTGn+NWkmAJBCN5CEKFjIWQkcbZqW6+MqsOAzEfMmpzoADb0KqAmltpGj0BwL6Hem6U2
	 01qpC1DQ7q0LB1sB7X5w0Rr05VVGdEJs/dtwMNc+VjVZBXlcL8x0qbPOpiZxCIEPBnvtv
	 cnK517vfvEHZtU2xC0U7sdXfCHHK4TJkR1C+VqH88znhlTlr2nTTYKOgUn6l804k+N2WW
	 oBmp2hEtAFNcwKw01Qmh37Ybr7+A7dfiDC/UbyCe+3nG+CUI8Zo1jXjFKa4EBLHdfaVDD
	 xyhYXJB+IqZ4AGoYyYkiZ6hmY7577HGYrgb44klKdwNcStbeldRt2M6JH62AzQzKCqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=EUP67iVm;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660B5606A329
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 07:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 660B5606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=EUP67iVm
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso3747975c88.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 23:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794813386; x=1795418186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pT3USewkr6ZN1h/voCkI5hQ0kdKOEVQrNGUW2/UwP80=;
        b=EUP67iVmH+phTwONX+VMfn9GuK712jGtubW/+Eg19bROX7ltuFuaGIkLFt0tKlzfak
         cmKHr/F0MYFk2paFEZqiwSZLK4tqnY07tRzy08pwQwExkjgI1zr9K0wpr3n8usa+CQec
         Os7xekVZubnqLpyQveZRcLbHGdm6igoNO8160+7lexiteERM++7s2j0wg+iZbBSN8VRb
         2a4cSZbF5wNAYrI4UsffEiCBi4TLb7kQIPl8rqmIEqoz3lYJam3NaxEsH0vWoJp2hZ12
         cVN7BoC1Rhn7z5p/iNy1Ag5dPItomh8cezTMxwgCgV7FaQslIdE6eNYQjRHRI1HsSQ0L
         Hc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794813386; x=1795418186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pT3USewkr6ZN1h/voCkI5hQ0kdKOEVQrNGUW2/UwP80=;
        b=08cyDzoUfrPROk9BSG/jvzVfD/ovps0wZ2N+NOkUN7/7Xehv2xo6hYQAAzfRDZJLXt
         YkbkVEamccwK2QUXWHheFO5FIx5WrLZd0Xve8oaudnHVMKQ1Hz+DrVwuxiXGusPW6SdT
         jwufIarHOtSa+ma14ctzg8FOROdHsWQfawWGs2zIi0nNOoVV3ck0agiJmaqRESno1Lgj
         vVIF6z0uiet+gn8VcElu7UWNbLMuknYWyATsaqjMJF9GvLp0TZcvTwwe7QO7zzZLa4cK
         /c80VVOXiO15Cd0ERM62lk3nHhPWDZvIcH5k2T9rkYi1OQon1fXK9rotJ9PPS0Kgjo5E
         T/JQ==
X-Gm-Message-State: APuU4Z/JaQPZ5p3vLBNDQnmHLvVD5lNcQT/6+fHU2Gs88IfvBGbwruZQ
	N8DSq8szZK2JmgcvxXe9z9Mp5BQl8vMyS3UbxWLHEr5OWOFOol8XeAL9ocefkE1r7wbOKz5YT5R
	Z9DDiA5A=
X-Gm-Gg: AYBFou1gCFDRFjGfDh/WE+MzNaBJIBiE8GHGV8jUkb2pAtG5jI6g3XeV/xsCYC9PJ1q
	1TO/G1OAEXUA5a6K+3d0tEhM5/KQ27T10xj94n+G5+PfTYqr+9wPr90OEjjDvCLMAojkdeiP8na
	32Jsvhv8SgW4K8wihvRUIOicLbOHz6vO3/NmZ7Q5SeooXQ3zs3ZrdGq9kqJD9df/U9NZEp9gtRH
	X4ZR/4kysEAJmGrKiJg8vPvnHGix2VJ+ym1Gyo5aBQXP1OZ9CznRQuBaNrRA3/D5oKO0UiinuqU
	SjZ2eKYwwD8OIqv8BnssU8Q4Q+2CjpiftZ+EQj9xYIO8Yn/fRaYMQ5Hh2/xNnIxvW4dXwQCEDsR
	BeFo1be+u38I9fLemZ8QLjZgtTJN0ZLIXKkLBSn25SEjSJ700J7zz/FmUP3e7wGqSqwbxT1zmSw
	0R+cfIdQ9mAcDBOhea3H/Sb9BYMtYu3bROMgLV6zxEU0zUo5brbbS1jPIPcbjEFNc5F/LFpejRa
	mzs0Z3vzuiLRzdrwwC4aYB1G9ORYL4NwMIEyf+FOoHbKDtNeivjxZs3ebvBkkHFLvbX/NPPshpr
	aDeZSjZQf9ozqdxdiRnJSi53itZvHXBUluV1X5QDFecOLrgnN7udR9JH1ruyij56L5egDmQ59xm
	u7jD28VkEnW6YY02cvwtAD3l25M9fvxBebaeZjun0GJ+MW15CjYgjAwF6HRWRoFbwqqVI3rs=
X-Received: by 2002:a05:7023:a41:b0:183:e993:7901 with SMTP id a92af1059eb24-1b5030abd48mr8868421c88.17.1794813386087;
        Sun, 15 Nov 2026 23:16:26 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm40571430c88.9.2026.11.15.23.16.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 23:16:25 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v4 0/4] Bearer.LE1: Add ReadRSSI
Date: Sun, 15 Nov 2026 23:16:17 -0800
Message-ID: <20261116071622.35355-1-kevin@simpleble.org>
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

Changes in v4, from the automated review of v3 [2]:
- Don't cancel a Get Connection Information request that is still
  pending when the bearer is destroyed. The kernel replies to it
  anyway, and shared/mgmt would take that reply for the reply to the
  next request. The request now has its own state, freed by a destroy
  callback btd_adapter_get_conn_info takes, and
  btd_adapter_cancel_request is removed.
- Allocate the queue of pending calls with the request, so it does not
  leak if the bearer interface fails to register.

Changes in v3, from the review of v2 [3]:
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
-49 dBm; without it, the method was not exported.

The v3 issue was reproduced with three emulated hosts and an emulator
that answers Read RSSI after 1.5 seconds: host0 reads the RSSI of
host1, host1 powers off, host0 removes it and then reads the RSSI of
host2. With v3 that read got the RSSI of host1, and its own reply
was dropped; with v4 it got the RSSI of host2. The reproducer is not
included as it needs the delay in the emulator, but I can send it if
it is useful.

[1] https://lore.kernel.org/linux-bluetooth/20261112032250.37687-1-kevin@simpleble.org/
[2] https://github.com/bluez/bluez/pull/2825
[3] https://lore.kernel.org/linux-bluetooth/20261113051438.75230-1-kevin@simpleble.org/

Kevin Dewald (4):
  org.bluez.Bearer: Add ReadRSSI method
  adapter: Add btd_adapter_get_conn_info
  bearer: Add ReadRSSI method
  test: functional: add bearer ReadRSSI test

 doc/org.bluez.Bearer.LE.rst    |  19 +++++
 src/adapter.c                  |  18 +++++
 src/adapter.h                  |   7 ++
 src/bearer.c                   | 132 ++++++++++++++++++++++++++++++++-
 test/functional/test_bearer.py |  58 +++++++++++++++
 5 files changed, 232 insertions(+), 2 deletions(-)


base-commit: 20ffd285b58facfd1f2478d159a5f941b09d5be1
-- 
2.54.0 (Apple Git-157)

