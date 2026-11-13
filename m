Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590626;
	b=2u8ZTDGRKfTM5x4/jMc2dS/pilANPlC+9E3FpTOEjLbjNU7Ej7DUdG50fxw8Z/5cpNIu
	 KRXKrnP4xrNeFrlQAC2ux3aDnJU7HjIPawB9BfKGJqoEdXyWBiQlKxEo1Q9I7odvkbN+e
	 fKTyvD3Y7lgxocZMuK0iOPcRuTEfE5LiK3LHxRwnyT7FMrgvXYFfgy4d9yZQcldTINRBa
	 cTxe8vXJs12DlB5Es4HK+x9HKMw5/bBiS52Y0LIXarGZgssmUFncXpZUQfS0j3Xj49xdq
	 8xhwFuKASkSWT9U10qymr35dOCZgcCeCIrop5PcFz9P/jC7LkpqGDF7so/cVPxf+xsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=z2i00Y9Zme22TmJM6IOcCBBaOHggND3SnqOgexgmQmg=;
	b=gM+WZHVNGpJkV4gEFkohjb9lzadIU+1cWqNyJszjVAoq/Q7tSmj2EGjIRWYHBFVePpSW
	 6tDFwc8bzQQHQQEc36y4G7T6m7+eDppsMVrm6KfSeoDjLFzwr2cTdKmzYd1s+tLsL2lJJ
	 5i46oc9HepZF2CMkkwmd4ce7u40LBqnb0fkOifW1LeZt/YGgD+YnCY3XhgKUwd40hQwVQ
	 xzfkG8PX0ke4JqjU/FNFfbJyOgkIHG8K/NNpt25jzhVRowJDZMzADxZgjpPyNUXI6c968
	 YD3I5wD6y6G9uREpgcHIywakaToBkn/5qO9ebsi/+7cDpfXqCELvmt9e+wjcnzSOE6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b="Aaoj/bgO";
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38FF6075E0F
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 17:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D38FF6075E0F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=Aaoj/bgO
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36dbde64409so1876066eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 09:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794590624; x=1795195424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z2i00Y9Zme22TmJM6IOcCBBaOHggND3SnqOgexgmQmg=;
        b=Aaoj/bgOkvGNyOxdntKtDancGyS+Xg05M8YVM95cBAU2xoPPJMeaeC5BsEL9pXlcwW
         N/3sHXB+WHiHzYW+iQniw4v5kq/ucq9+B0QjbXL9ir6QvwnccKM8qaarXlbtIKgH2Jd7
         nlEBwM6HMdeRRRIx3qkPgpKuH/mcKBVlbOd40jnkRb4Kk3AVRea9VpVRih48ah9pUam3
         t+QJvBqLA6SJPQkApS1CLysJrp/sV7gOIpBkkp8cl6o6Ybt4zq8cb3RDk+GPJY69tQY5
         StgBkFBIY3hcxU4FJqHgkEEm4ab4XvoeKbbcqdCyGhP3Xd3nrtyXFEKLE8Jb5WgxlxPk
         Mh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590624; x=1795195424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z2i00Y9Zme22TmJM6IOcCBBaOHggND3SnqOgexgmQmg=;
        b=jR48VVd2h1jfa2t1x16/F/YEpf1blh/U43Bq2IbkUBQqNSuqPK2rSumzclCJJ1D/E0
         YRJT69FLtfY2sEovaZvDbsT7CXdtE80OSdtHKiHXAmzQJPDRj4YE/41F+nX6HraNsDVL
         TApznDakfuoOSVrwjdXhYyMlonrTUSEFm+NSCT53zlxxLVglpMnfaT5WcDsrSE5HSHnz
         NqbWMX1NX4x7KcjGgL7emx60wIkimq5We0+0Fd+bTt3x02fnZ7Qp4qW/1Y2K4NBFRMgq
         py8gTxlNm5WE8eohuCgaclXKEhjMboljv4Y9oijuXUli7nwFeTlWf2KDQXNZKp4HJFoZ
         4qfg==
X-Gm-Message-State: APuU4Z+lvAjB241hCZtJdNQJL1IMLSR1cCY+v7dhB+Z8ovapLYNaub9y
	rsQKaWTWxeaJ/sxrd5Tof5Ri/wuvetyn/NzuO8PULmhM8J67JmQ6+6m1Pr9HBkd5xcSlXGQ8a24
	FK0PqhUABwA==
X-Gm-Gg: AYBFou2tx1cwMz1YqVYjyZ43/UPx0vQ8jR1xCz8yu+ifQm8+wEnqFJ6AnOGkUjYMT98
	wMzZQyB10dfeWbYGLTSvgOHezSRej6LRFesypapfCzsKEFW5Zh3QzaV8HsYd4QgEDohktYyWWWG
	UYCb+Q1cuKOwctbex86U6JuWcJbaDilr4kbsZ4bzbBlr4W0mAyFkxo/6p0r6CcdBxW9/QWOrUF7
	o2i9eIQPP3WQxxrZMVmMS0iZKTaDCe7zaeBtoa5h9RZv4aWkr5t0QgQOBLzvj85vMITibiLNcKM
	9bH3pRTQ8UVwUJ5v62SDikfwjGHOxB8gzVRJlmyGBwaf6hn4U51WDr+Cnp/rxmbQWEka5+5Za4w
	Dvka98I19tU74azeg6Q3ncwUrGRYzFSByOipnTTOQKZLVAc6nM/FroRKDhFHX/L5S5671RIZ6tA
	IcSH1m5+LT6DCre+fcSM4q7KU6MNoqiXL6EDBOts/ecEa0jX0bFxk4f/Hugsib7gy4+i0pEQjnw
	GkEmzIB+i2MwYD2olifD7yRpxVNhoKtXJ1Ew/NuYtNONcCUpNUmROyulrExV2pJmOZu3ZDBEvq9
	KjKJHXnkhFmv/rBfXw8nsTnZ48l2qMPGdlrPxvdZ8FqkbuPVxAaVhVRRGIFfR+wXlkg2x/Ev+Qe
	y+1bOyro/vFy8d3leq2LaF6kqRauN9KF8WwNdFsx2tpZ5GH9aGW5EyCyprXTfdp1kPdgDC0Rvt6
	nwIFGXurnsfyA5+4ZK
X-Received: by 2002:a05:7022:1205:b0:168:3243:c937 with SMTP id a92af1059eb24-1b5030ecd8emr2757490c88.16.1794590623767;
        Fri, 13 Nov 2026 09:23:43 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316e008sm8151800c88.6.2026.11.13.09.23.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 09:23:43 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v3 0/4] Bearer.LE1: Add ReadRSSI
Date: Fri, 13 Nov 2026 09:23:35 -0800
Message-ID: <20261113172339.54683-1-kevin@simpleble.org>
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

Changes in v3, from the review of v2 [2]:
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

Tested with the functional test on bluetooth-next 3f425f95ba39, also
with a bluetoothd that answers NotReady to the first two reads, and on
an RTL8761BU connected to an nRF52840. With -T, ReadRSSI returned
-48 dBm; without it, the method was not exported.

[1] https://lore.kernel.org/linux-bluetooth/20261112032250.37687-1-kevin@simpleble.org/
[2] https://lore.kernel.org/linux-bluetooth/20261113051438.75230-1-kevin@simpleble.org/

Kevin Dewald (4):
  org.bluez.Bearer: Add ReadRSSI method
  adapter: Add btd_adapter_get_conn_info
  bearer: Add ReadRSSI method
  test: functional: add bearer ReadRSSI test

 doc/org.bluez.Bearer.LE.rst    |  19 ++++++
 src/adapter.c                  |  22 +++++++
 src/adapter.h                  |   7 +++
 src/bearer.c                   | 111 ++++++++++++++++++++++++++++++++-
 test/functional/test_bearer.py |  58 +++++++++++++++++
 5 files changed, 215 insertions(+), 2 deletions(-)


base-commit: 20ffd285b58facfd1f2478d159a5f941b09d5be1
-- 
2.54.0 (Apple Git-157)

