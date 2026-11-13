Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794546886;
	b=aRQAS/XP15I6Y8miDO5OwJCcbzNTvtnJJtfGRvf0cMft40kcFEMA522kSoHCPlaTqKel
	 Tm9Fm9tAWkqQguo8a03mPv7BhWoVRvkQhNoLhrWSH2L2JgRZICTwImFuErFvnpyp/4C9Y
	 bUCFqF8ZvWCUz8SdVS4R7kWkVC+s21ob84yUF968CUOqI5HWh/kaE/nkRs7S7XDRyZIww
	 ZJz52fb0dE25YvjAcaS6vvIVGZz6ixzEviVIpyNQ0jJZaWD4NT14A4nd/VJ4D4nNKL/7y
	 1SFSF85/VJboOxAysbEDqepbqi3rgw5haQuZw4mAJFPrUHqnkxWOrpp2YSAosV+3OUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794546886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Iyt1xj4PgkwqtzHmSTgaRb8N0vl31U5OQFAp1G9BpWQ=;
	b=C9CVRkcpFanvorin9zBcWLKx2/qiWcqPqBvld+8DyMvWhZveH/Kxvce/Z6pSGJJc/zSp
	 jFM0PJDY03MhKW9wo5XMfDh48b595OSU/pagOeGg942gz8A8n0ArTZyM/NbGFNxf5qEaZ
	 mZDz9Ee5dgi24/tH/YgpAW3S9D/8KwmqYsr4o5lMsloGVh+IRWVVYW28WCrBMhwDZVIN/
	 y9YURaQjrS1tnuIfdnUkRyRHsqgib4ssUMM+KwND4Z0hVxZx1Hdrx/2dUPImD12fGgXHB
	 4cNn49TSpkpCy+kHTRH03R4z3QJT6el4qqofE7aMgqlo4q7oqJ6b0zwFdEpjm1LZtvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=1NQKQegL;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544A8606A321
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 05:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 544A8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=1NQKQegL
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso265497eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 21:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794546885; x=1795151685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iyt1xj4PgkwqtzHmSTgaRb8N0vl31U5OQFAp1G9BpWQ=;
        b=1NQKQegLgM0BqnfAjzOR1WZDu8ZKzNCDv4BLfVLL7Jw5HOMXqNT+8Hq9oFFUFq2auG
         LSuu04PLHfpng4HVYRJmeJskQTP+dW/XeyPb+LMMPQUNNkchQWvg0Hs158ZTFyKzXetF
         81cNvKCGhA9oFfDjtC9S4RYueYbmfYHYVe+qjyFKlM0YNaiv9qNsZM59s1GiBafbSHee
         rElLYejdQlaUgCvBRzCTvoN4FzkM6Z+DW5i1T7uxaX3VBiVzaM+fsaa9TCtwjoFKAT5w
         9hwAjploFIrwhyf/yZz4STt0LxrRLokGEcN5zulb1RILNka0rNcWKz9O7DH/mbNnDsL0
         TU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546885; x=1795151685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iyt1xj4PgkwqtzHmSTgaRb8N0vl31U5OQFAp1G9BpWQ=;
        b=2NdVZqk868BNKzFLJyKBapqpXCONheDsY1uqo+z67eW6EVf7z41h7wZSVMl5M35B+r
         vfoZoDaXwZS43xqQqemU/AGNNc4ElSWcVhYk92DfBK7826cmhcS6a0yy3vevuqI3nrZn
         yBdvih9/crRr2yqrrdMb4SiY+29ilOUmDh2BQ7GkoWjzXhr7a4WjjRXEgggTLXJjsRvT
         fYXpWTcJ67r+a0QHRf4h5E0vwRv+Ici2V+hKTLomYxza9TDBPYMhwfA+EC4oRP+aI1av
         AndxiU7l3J8DV+Bx5iHNFptyM/E5Xq2NwSQj0sovzdR2b3v5lO/Cv9Gl19xVSZ667Lkp
         8Qpw==
X-Gm-Message-State: APuU4Z/7WA91aYorqHsOPoI+XFVtxsDrReubtUI5rVLqA9qYSEE8ZVM7
	AVqqGvuKq+Yn1zYp43YfosmbjdfMLCxKTKyOzOHm0T6c6H9HE6W/KjvbKh4N9JsEDmr7O2ml6PE
	PMnLzSV8=
X-Gm-Gg: AYBFou0n48GCBtaMeBTs/Z+BHhtAW+/c7hnC054+3EYu/qSHuoIz8znzqFaa8KTTELn
	vwMmAQWVNmluvzNOUKeilszAnNc9p5JA6fLgWfif4Ea/BbkI4mBUMxVy3I3LAFO3UgUeWXLYbx3
	45v/d7xgYFElVekTvaxDttWmyIFgUZ86V38NRcDhFgm7OQVRQd7hwY6bzH5faT4iJeHY9K5qzlF
	lN2+Bv7f4GfkvhqqSf+RDlZu1M6WtddpHu3G+x44hCI3yJT94bWNEwaei+JKhpTpXraYy062Dx8
	msMN80f3y6rjMN1Z//kL4mOumsPM/+S5yzMroYYbl7t1fbAvKj5M3vKOPJPtPbjVx7mDfS/91ne
	n2R2te4hkpbWs+Q9yfM36AFUjM8AeTQWgvqwvJPQbQ1VCsv4Gqeu8crA6vnmd4ZmD2q6B4/7DR5
	VieIR0a6phvXSrgXW2XkmHJnGNBrptY6nOGOGVIi0RcPMskuvy2+fxVMgLaKx7RSD/WkTsdjAB6
	uwh05nNmnYohBZS/8RZLmdg/y4HoHtNzM8BCJtftA4lrINMv+4hrMN+UOrd4ynQLWt6EFhNyrUt
	2ofwBp/qWIL9ayvZcJonERSwuABuM5Mw79IMrjvfFSwn1PDPN+glUguyTma09Z5YtlEIY6PQZFH
	VxfN5oY6wa0ElndNZ9GrcmWiyXdboR8fWo137IuWQKAr2vt6JJMWP6JEqSTZivzOvYRBji3c=
X-Received: by 2002:a05:693c:88c3:10b0:36e:4aaf:6c7b with SMTP id 5a478bee46e88-3796740c786mr1242232eec.39.1794546885161;
        Thu, 12 Nov 2026 21:14:45 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955a1c5c2sm3597550eec.14.2026.11.12.21.14.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 21:14:44 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v2 0/4] Bearer.LE1: Add ReadRSSI
Date: Thu, 12 Nov 2026 21:14:34 -0800
Message-ID: <20261113051438.75230-1-kevin@simpleble.org>
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

Changes in v2:
- Make ReadRSSI a testing method and mark it [testing] in the
  documentation.
- Enable testing interfaces on one host in the functional test, and
  check that the other host does not export ReadRSSI.
- Rebase on master.

Tested with the functional test on bluetooth-next 3f425f95ba39, and on
an RTL8761BU connected to an nRF52840. With -T, ReadRSSI returned
-48 dBm; without it, the method was not exported.

[1] https://lore.kernel.org/linux-bluetooth/20261112032250.37687-1-kevin@simpleble.org/

Kevin Dewald (4):
  org.bluez.Bearer: Add ReadRSSI method
  adapter: Add btd_adapter_get_conn_info
  bearer: Add ReadRSSI method
  test: functional: add bearer ReadRSSI test

 doc/org.bluez.Bearer.LE.rst    |  19 ++++++
 src/adapter.c                  |  22 +++++++
 src/adapter.h                  |   7 +++
 src/bearer.c                   | 111 ++++++++++++++++++++++++++++++++-
 test/functional/test_bearer.py |  42 +++++++++++++
 5 files changed, 199 insertions(+), 2 deletions(-)


base-commit: 20ffd285b58facfd1f2478d159a5f941b09d5be1
-- 
2.54.0 (Apple Git-157)

