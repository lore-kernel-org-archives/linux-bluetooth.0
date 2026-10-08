Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5419369D71
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791480610; cv=none; b=uOiLe+ispmrdaBmNUiXspz6/suQlQqDfqvREJf2tN1j8j9931kEoyzxrUGt2BR68CLwluNtxylaGiXu8tIa4UjmI7ZgEsOqiRFaaGSMahq0eNyfOXmz6FAI2emJoCOYDjqVBYfp3zVgaOzcKC4xP7wK3KhoudoBnqe+jmPmOBzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791480610; c=relaxed/simple;
	bh=UawvJfbBAAmOzyHNaN0szieO9awboadF2zY2ff+0uWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=beLZL4AEK9zjjowDidAcwsCF95tOU8bfOyavYKCV6g0e9xaBVy/ZOs5a8480WoYZFbXTIKClyjAFxwTzEtvu1To+M18jPZWik/Yy/59PcHnn62BOfW/liykTWX24x4Ht/LrpffYbhRsGn7fM1pa1TD7e7dppI/bZ6U6YKCZRvg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=VrLAsUNH; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="VrLAsUNH"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3515f9a5d25so904083eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 10:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1791480608; x=1792085408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MZ1HIpxbVgo/mCPvYtz4Kiob4ySZV+NEvjoT/Djg5cI=;
        b=VrLAsUNHlkX5E6G70frUdsgEwtrNriugx70BajxxlII+vKGCMOey9CVEV2dEK9dofB
         O9taQYo+I2TMJWBmTCQpvIQROkjVjKEdB5GCllSv8aHRSMr3sBwVn/YooEF6vDMZePdm
         mdufr5H5PRXAP850aS+mVergdix2P5fPoW0DLNOY7zk1UfbMDGFLtF0+u6wEBL8qSWFl
         /AUqlEnKXqn3x1aMoscNzxydRW8qrWRGvrTTsEKre0QTPyooiJ/ik1256DbhoWUt8bW0
         9On6nOXc42irM6twMXf2fgWSgk92VFi6Txfef9Tas9P76GWoNh7Ewg3sdUB4743GIi9L
         w3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791480608; x=1792085408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MZ1HIpxbVgo/mCPvYtz4Kiob4ySZV+NEvjoT/Djg5cI=;
        b=Rqaw354QUkmviY3vaLPFleb9nnlK53tYJECKRegcVe9pM7DDuDe82n+wjlzlrSVq01
         pWSTsT2dURu6ydFY8ehtxafGQhSzFlbeI5zBfJ/CdrZS3vI6X8Xooq2g73T8/2xsis+y
         OmsZU24ktuH0LhbqQJl+DvbbzHC0qxWiAPMMrdXXmCMK8A7ZzSGgx+tTSE3P+ayQpSPQ
         zc9ecNu318sSbBqoAY5XPd20SdSr4Yg3RroFHwXfOn9wzqH3fA+CFKHGn3Je6NiRM/2S
         5ag2B1xCoLOJGP1mU61/zRlVlF8zZk95VnztJhiKX7Bp0u3KfFJ2oHmxN1dM7SLoGkGl
         IVFA==
X-Gm-Message-State: AFq9FYJBqUoNDRE3PEbTvwAAmySCSHmuTbD1CQKWleiwEnJSXSI6EkIv
	vDp5TDaS0Ynr3A5OC6zv4Z1CibRaEoTsXTtvLXJmM5GWH9q9qqE8UaRVqYKahT+py4+pVez9BpF
	K12Sp
X-Gm-Gg: AYBFou3vRRntKuyMYGQRl4X41cPBKZVMfQPneD87XxhB+uysv73Q3y9xnkl1ODh2JGN
	rT6MXwaXqMBydQlSmtPFejzq7a7IJQu6LYn8hCOumXSZCao+ExGvL0mcMdLz8SsGxVv3lLOIOd/
	hxE56kEAJKYy/9d9QTV+zsDVdGFj5c5a1qQypXVXG0HGaUcHIyp2R5Ol1h+nMzCeZiB1J33zTeK
	Bhfc+7WyA1UQTIB0Sir8XEtNPYQICaMQBkn2EsBHlC4aAD0gY5EnMJPsCcjfuzrH7bSZ4fasXdm
	1QSSQ0yoEL/z7blBkDssEvKQJcxXeVKtdnDGf/eb19Xdx21/UhP3nVdtL5n22/uZBdMxkp9dV7g
	Zo2B1OIFh4PKWuSomhN4H18xmXf0/qR7NZdYFQAX/jnDFd+tLZANW537zjnNQLQLqRyZ5quqQFm
	LeI1PXBGt23/KA1SFwQTU6a1GSFh8I0ld+wD+3cqdLc/QlU/LaILjAB/2PGEC5WVPDADqLa5v0t
	eP3XfzRGxROsc7NfZ7ruYy5Z5p8L7Dco0K69wacl4436QK2sNYmu05RJvTGNUzJiu2b+iRroXlu
	7JyYMcDozLIxmNj7zfhFhAEBT/5IGQV2tm3PZIsl
X-Received: by 2002:a05:7301:901:b0:34d:de2e:1fca with SMTP id 5a478bee46e88-3535f39613bmr57697eec.21.1791480605638;
        Thu, 08 Oct 2026 10:30:05 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3535f385672sm41804eec.0.2026.10.08.10.30.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 10:30:05 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v2 0/3] Add Role property to org.bluez.Bearer.LE1
Date: Thu,  8 Oct 2026 10:29:57 -0700
Message-ID: <20261008173000.3615-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Applications acting as a peripheral, or in both roles, cannot tell
whether a connected device is a central that connected to the adapter
or a peripheral the adapter connected to. When several applications
share the adapter, a device object can appear because of any of them,
so the order of events does not answer it either.

bluetoothd already tracks this per bearer from the Device Connected
event. This series exposes it as a Role property on
org.bluez.Bearer.LE1, "central" or "peripheral", present only while
the device is connected over LE, and prints it as LE.Role in
bluetoothctl info. The documentation states that it is the link layer
role and says nothing about GATT client and server roles.

Like the rest of the bearer interfaces, the property is experimental,
so applications only see it when bluetoothd runs with -E, which few
systems do. Is there a plan to promote the bearer interfaces, or some
of their properties, to stable? I would be glad to help with whatever
that needs.

Tested with two btvirt controllers, where the advertising side reports
the other as "central" and the connecting side reports it as
"peripheral", and with a real adapter connecting to an nRF52840. The
property goes away when the connection does.

Changes in v2:
- Move the property from org.bluez.Device1 to org.bluez.Bearer.LE1, so
  it is clearly per connection (Luiz)
- State in the documentation that it says nothing about GATT roles
  (Luiz)

Kevin Dewald (3):
  org.bluez.Bearer: Add Role property
  bearer: Add Role property
  client: Print LE.Role in info

 client/main.c               |  1 +
 doc/org.bluez.Bearer.LE.rst | 24 +++++++++++++++++++++
 src/bearer.c                | 42 +++++++++++++++++++++++++++++++++++++
 src/device.c                |  5 +++++
 src/device.h                |  1 +
 5 files changed, 73 insertions(+)

-- 
2.54.0 (Apple Git-157)

