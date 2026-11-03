Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690876;
	b=fSl6JxDwKfNq/+Nq7t4Gn7zFH+U77X2QUDHP0F+o/ItTLTiiY0vCEnRGGwJqdatm4e3N
	 fFYuezfPozB+8yq0FHullCQEDMVWFZmVqLksYMauhIIUSsmkb6E2Emd9LptBHpDbI4YS/
	 9p9wzdD05AkrcURcqb0O7HbJtF42bziYIVAkcKLWeYZ4v28QmoQhs+cFtjpZz2wzHr5kD
	 atn1eowtYWNu7Ll92xqRoM3E5a6O9p8Gqk7SOqvGgoqQw+QsBCKA7TZuBEKZiGlJ3aVyj
	 lGoGFfsCAKyeQICTI60/ai5YrZz9/wu1rA+RrQ/NcPPMuRZVJUkq0fxZRWa5zYwc75Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Pui0xl1z7srKUgWrtjexZB8+SzgX8359yHK+0eMzsNs=;
	b=G4QqyQrbvJYzIV5psgB4+bCqT5Qgrmod03baNr7Rp/YdbggSJeKQ8kVw6aZtFrQO4htl
	 PKs7pOlhMoAEoPoIv4RYycjuKGaMTUu+/YJ+2RvWfOOH1E7HEIEet5pR4+9APtjDlFQpa
	 t4c+bZg+WM8f726NHdLwkFt/Vem1yPz7JjwmsoXi49KwqEF3l7QyHp0XUswIlN79wlNvv
	 AyXFcbi1w6jy67b+XqqMH+NIlSlojxZLb8AftUKHmAEoRmhC3dbardsjB64nrhaOECHdi
	 si3I/AysFFdksb/MrufphW6nWtdOzTgM0E02qembPiUvFybAzAl7M9Lz4k+BMDM2LnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=pzW5htSX;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8872606A324
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 07:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8872606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=pzW5htSX
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3550c917fd3so5291773eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 23:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1793690875; x=1794295675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pui0xl1z7srKUgWrtjexZB8+SzgX8359yHK+0eMzsNs=;
        b=pzW5htSXkxSBj2hYXAJG9BSYgt5E+FtPW4bIwBwjo+juCflMC5Q2zf46aDcvzLWYjg
         U0QYjK6/3OhhA+prYC+ZHyZJ1A6HhW/UfEByhqVBEpZSg5wySV/s12aLZDWCIRDsxfjA
         Ug7zZE02hyyGpasZ11nCW5oJob2gYZiIUOMwwdgyg6p5yVL8A7KPXuB8iB8W72RoK971
         4igw5UKGPfc5UbirdGw8aZ7vnXdYp3w8QnTimBLT9z+rzgcs+f9kj+bvAoBOdBPBhnCq
         fjnXz8mYLoZZSRwA/Xrn66tWbXz2SkcNNj1DmgB2SCq1ANrVtPDB+H8kWUTauvi+ZTbh
         5VEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793690875; x=1794295675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pui0xl1z7srKUgWrtjexZB8+SzgX8359yHK+0eMzsNs=;
        b=Tf5CS/1KyPTjalg6A+KdbDl3EsG2tRbif45Kj/m2m8CGpozJbUo1HQsJQc0+EHOlO7
         m1ToOFlSkACsp9lv82RhxEbTE/w2UXgTTpQSWHzWKrc0SDc2eLaF+2f34/HXVMWmdzVo
         P7yYBf2Va93/o+zdp8baiL7V58h2I9O3EZrs99MYQSVqRynqFHyAMCIvbBoaZSQMn5dS
         AihKJbPSQ59dKkhQtcshhBn+0X/uWfm3pTMMhE8yxk1b/P1qWcD8jNC37qW7APXu+cOu
         kpKep3lHF4wULbGbtBAvA95QU2tZggm49GUgee7XKgr3TQzYPoKv+LVGrhfj0NAHeqwg
         2Cuw==
X-Gm-Message-State: APuU4Z/I7vVa9CPuhQP8fQuFlCDd8wP7yB+OmMe+x9XnZ5OjRjWWd+q4
	TTWNuJe0k0aI9NGBpcKJ5ns+p1aiq5rltCmk0GFyQuv3VILxsR6Pi7NqM+xupt7IzfoJbeidPZM
	ybT3qzFw=
X-Gm-Gg: AYBFou1b2DGtuZWRku9zuIf3z9wtTRePbclWNI2hKAoO21ELbYEaZRWXOiMmx2TRX9S
	PdCOyczMtLaJksZRh+gnnPAYWSOpt9O7LZzodiE2WfovRnc0KdLIa77YNVlYxv8rWoAghBOL+L4
	7b6Ax+jJmJJgrDrhK5JWdp0NUjwruh5BUtw0cHF6aQvgcYKxQO4zlRbT2fM/yGXECUNgYCDTHKW
	U7s8+Ps6H5PKRvKdRWZSM/hazSFLi1VorCwr9oDw7untzhCzv+jSprXI9o9Wct0Xd3EwG004Q0K
	YVLpZKyrH6z1ZuZyoXnT6A0Zbcmb2sXqhaF7N+nwNbbDSGxqo//1ihJG/a9rFiZa7mmFs1uJpSa
	WsCgQyKZ61RBj2JZOUgXUVpFaeFBLOH5vN9gvqi6WDVpg62ql0o8CX2PZ3iImqGn5T9+4vBN0Zh
	eXASKLg4Sm0afqRGxg6dLTX386VZbG3IBp8xAGRuNN0bb331YuBVWxDtoyJ0xZGu3ZCzMkcITVy
	wesHeN+wO9GKVR/6v68F/FXQBU1LX0PZ+WySBon3ceGSAIf3NWruNUkcTaO2YJXMwG/Ln19P5r8
	VJAhtsZludFJGXGjE8Jp//BZGEsnGmXrlnC4bG0a6T2dhB0YbijkIUK6sZqeWZsZq9rhQ9GcTLb
	X8FICHP+n+F/CnAUuJJ3VbFVNJXmCDUpxc+V2BtlcAEcPRsswCwyPYB3hKJpJQjoV0dZti2k=
X-Received: by 2002:a05:7022:296:20b0:163:3bcd:e5e6 with SMTP id a92af1059eb24-1ac5b0279b4mr17552588c88.24.1793690874531;
        Mon, 02 Nov 2026 23:27:54 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1aed79b3dfcsm42437988c88.12.2026.11.02.23.27.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 23:27:54 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 0/5] Add LE connection parameters to org.bluez.Bearer.LE1
Date: Mon,  2 Nov 2026 23:27:44 -0800
Message-ID: <20261103072749.50979-1-kevin@simpleble.org>
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

Applications have no way to know the parameters of an LE connection:
the interval, peripheral latency and supervision timeout. They decide
how fast data can move and how quickly a lost link is noticed, so
applications that need them end up reading them from HCI traffic.

This adds Interval, Latency, SupervisionTimeout and Subrate properties
to org.bluez.Bearer.LE1, filled from the MGMT Connection Subrate event,
which bluetoothd already registers but only logs. With "Bluetooth: MGMT:
Send Connection Subrate on LE connection and update", now in
bluetooth-next, the kernel sends that event when an LE connection is
established and after each LE Connection Update, not only on LE
Connection Rate Change.

The properties are only present while connected over LE. Interval is in
microseconds, as with Shorter Connection Intervals it is no longer a
multiple of 1.25 ms, and SupervisionTimeout is in milliseconds. They are
not marked experimental, since the tests come with them, but I can mark
them so if you prefer. There is no command to read the parameters, so
when bluetoothd starts while a device is already connected over LE, the
properties only appear once the parameters change.

The two new functional tests check that both hosts report the
parameters once connected, follow a connection update the peripheral
asks for, and drop them on disconnection. On bluetooth-next the bearer
tests pass in 3 of 3 runs; without the kernel patch the new tests fail.
make check and the functional tests using HoG, btmgmt, bluetoothctl or
the agent pass.

Kevin Dewald (5):
  doc/mgmt: Document Connection Subrate for LE connections and updates
  org.bluez.Bearer: Add connection parameter properties
  bearer: Add connection parameter properties
  client: Print LE connection parameters in info
  test: functional: add bearer connection parameter tests

 client/main.c                  |   5 ++
 doc/functional-bearer.rst      |  43 ++++++++++++
 doc/mgmt-protocol.rst          |   8 ++-
 doc/org.bluez.Bearer.LE.rst    |  38 ++++++++++
 src/adapter.c                  |  12 ++++
 src/bearer.c                   | 122 +++++++++++++++++++++++++++++++++
 src/bearer.h                   |   3 +
 src/device.c                   |   8 +++
 src/device.h                   |   3 +
 test/functional/test_bearer.py |  78 +++++++++++++++++++++
 10 files changed, 319 insertions(+), 1 deletion(-)


base-commit: 14bd6ab65f4a647302edbd6df27f6faa91bee8a8
-- 
2.54.0 (Apple Git-157)

