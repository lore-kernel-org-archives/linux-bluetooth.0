Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF12E4F3902
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 18:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569103; cv=none; b=T+GUbfHGPX70w/gYyHkURo7PLs6GKZ5etg6/4SE/zoA6ZB3uVWfxVGPm3Bar7pfvfeOUV5zhEr6Nb+WBffbPCnt2Fy22i1Db61MLDozefI+mb+Biyfx+hPpJwXl+mQNAs1tKZ59tkIucwW6KG2EBxglIQ/4wF9vBsiLJ+rC1rls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569103; c=relaxed/simple;
	bh=6y0TYQUckiQaWO7N22e1/KoZnOig61s/tKTQIvY2OQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jCoHVuvo+VtKYiE8ZSAk0KwEuT16bElzFvEVe9CCNfUls/aQ1DD6Bk6iNFjAgprLKwNzJi+od+vPAxYtRIhoY8qV9Um2laDZr50xLMo6TxcaYIZV98YNk9WkPus8KYIlIvjLZcIJcFqyLZqSu2qoEFOVqysnPUGBzu+atWNqMoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=s1audmYX; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="s1audmYX"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1517bda04a0so1455c88.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 11:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1791569100; x=1792173900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PHAnJkAqfbITKZFz1iefdhNPcWyX9Hrx+dBmTAy4aWk=;
        b=s1audmYXL+weLSxqBTx659ZTIb/5D9agz9F6/mv4dI8zBYApyjs6D4pnlmV6BKGxla
         qIAly+BLHj0hKFaa/C7JSrDQKhwrsr/+S1+NZp01FfzheHERlY3crww1wI2BjKP3s3r4
         jH4o7pvMcsAv9wo+7gIF8U4QMHLjtvu3nlVg2Bd8AcphSIaGanIdVh4PYC/h7NXtsx5m
         evaRQoT+0Rk4af2ZyrJwqtbkgwM11RIZXA60bjozhxQYgFO694OJbxAp1a4fkc2wbTDh
         UXqtWaDJjJSEhaQ+zT0HXArhDJ2YI7+6Ci/GaXiVYgvtXvyac7WrS0ZGC9ChrhplR0n0
         ijQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791569100; x=1792173900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PHAnJkAqfbITKZFz1iefdhNPcWyX9Hrx+dBmTAy4aWk=;
        b=z/qqLi3pRsYw9gAnsJOq3UffDUd74EjWtEc6cYBun2fdWVxY545V/C5nIv3H8WKD2e
         hv+SASTuAfYE6Urz79T8dgcDI5RuKeVLioTVEtljHe0bJtTEPAGQ7c2hsxIFmokOdvam
         5yh7haFI2Rln3t3GnmsXrewBZERklNfREGeN/0kcLK7xBCZ2MUO3c23Afnv8XenKruzN
         AM/ywjSshlWtwdJcXI67pYZR9TbsUb4L3+YZdDZfyc68eFCrqELEvXFZbmDHGk8sMnuu
         kp0UqfaNTkBiCPPuas03rFuy/pHrLe0TI9QGAT+gOCmeodVruqQ4LDAKnefkUwm1K7oE
         Y4Xg==
X-Gm-Message-State: AFuF++lLK/yNMaGeMAsv2La++P53avylJUx1780zJFjdngpCg/58nJzT
	5uxVIpaUe1tHLeppqOn6+bGyaW2PaPQGPCiNPRstIXHhDj21whaky8coewckGrlht9QrlG87Xkj
	n8Lmc
X-Gm-Gg: AYBFou1DwoNnXKPkmnqdoZyTuSiS+Mt6U2UF46v4T0AXtm+PhfoSfobxrx4Tuo3RNnE
	0D8X1KnPkLLYNQo7D4YS5e3f63WFtM3TqmlBJdL6fscB8PBfJ2WIXn+ooFnM+hU9E6uLt0kSkPV
	wmtbNVLEQSnEJp3a5ikMjUJfjGuYKrSxFt9UyYh9/OZBaoBQZ4eKbb664WWGJjF+3b14adCJdTw
	7TO76EmknOUt2YN8IrlEcopdg59vo+NXEYbVx9LMFrNYVhLMd6y6ggyLQ8sz+QBOox1mkkW7+lK
	aY+RTC4T1H471+MYe2LibMnLOq2Bp0d1tcC8PwK/+r+0ddh1siySw94ec1dVhOeKG57CweWlkg3
	yjM5FpM3mXWyRKFSeHAWPzD4cX7J0WqatpZCURYC3X6Kc2N1b4T+pwjJNFBfSOeyosFsCK5BsMY
	IYtM6hYpcZCcxOzskF0gDjMW45cuMfk0xx6GqunKMZhFTzHADh5PXEHXGadupgWLjlGygQMsulc
	o6y8xCLIXtkIihk0RCEl/rTUAlzParNaNMneeYyZ8fVsOBE+/IziWe5fpljIITGz8Z5w53Ui+YM
	5vPOEK+6NNLGLeB+eCJ2t6J7qgWPZ3jnPyHlPHM=
X-Received: by 2002:a05:701b:2806:b0:151:2e62:fe6d with SMTP id a92af1059eb24-16a5bf3f985mr3411997c88.22.1791569099493;
        Fri, 09 Oct 2026 11:04:59 -0700 (PDT)
Received: from localhost.localdomain ([12.158.218.17])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a31f6be0sm16111163c88.13.2026.10.09.11.04.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Oct 2026 11:04:59 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v3 0/5] Add Role property to org.bluez.Bearer.LE1
Date: Fri,  9 Oct 2026 11:04:43 -0700
Message-ID: <20261009180448.29117-1-kevin@simpleble.org>
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

As a step towards marking the bearer interfaces stable, the series also
adds functional tests for them, test/functional/test_bearer.py,
described in doc/functional-bearer.rst. Two hosts connect or pair over
LE or BR/EDR, and each checks the bearer interfaces of the device
object it has for the other: Connect and Disconnect, Connected and the
Disconnected signal with its reason, Paired and Bonded, Connectable for
a connectable advertiser and for a broadcaster, and Role on both sides
of an LE connection.

The five tests take about 45 seconds and passed in five consecutive
runs, and the rest of test-functional still passes.

If these tests cover what you had in mind, I can follow up with a patch
marking the bearer interfaces stable.

Changes in v3:
- Add functional tests for the bearer interfaces, with their
  documentation (Luiz)

Changes in v2:
- Move the property from org.bluez.Device1 to org.bluez.Bearer.LE1, so
  it is clearly per connection (Luiz)
- State in the documentation that it says nothing about GATT roles
  (Luiz)

Kevin Dewald (5):
  org.bluez.Bearer: Add Role property
  bearer: Add Role property
  client: Print LE.Role in info
  doc: Add functional-bearer documentation
  test: functional: add bearer tests

 Makefile.am                    |   1 +
 client/main.c                  |   1 +
 doc/functional-bearer.rst      | 141 +++++++++++++++
 doc/functional-testing.rst     |   1 +
 doc/org.bluez.Bearer.LE.rst    |  24 +++
 src/bearer.c                   |  42 +++++
 src/device.c                   |   5 +
 src/device.h                   |   1 +
 test/functional/test_bearer.py | 302 +++++++++++++++++++++++++++++++++
 9 files changed, 518 insertions(+)
 create mode 100644 doc/functional-bearer.rst
 create mode 100644 test/functional/test_bearer.py

-- 
2.54.0 (Apple Git-157)

