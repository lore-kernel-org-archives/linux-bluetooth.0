Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453776;
	b=m4/U0Gbgg1DufAFq0OTMGTmMoAw9FN42DEVk87vPQ1FQx8nK4qCLjClUuj0xBrDrAQ5J
	 yBuWN7su+leiRaXo1EzzrRy5ICdGwsae3OQCuzmw3dpWV/2LW8iWvIHokkkUdl9juWSFj
	 08UlD6zud51OIEiGQLmLxhlORxMm7SU8szikB0xq5T3Zb0HmXs6I2H1rRCX2lrC4eSihD
	 510vW///Ldf/l28C1MAeTOM4OJRR5osOv1wVLrN5uQSYpXEm8iLtTWZcStyxa0EbQ3BzJ
	 IPBGLQ1Mwnf/p2N96CGmT8d+VmiVlMvJk5osJ3i/iBBy/nOJuIJaClbSafw1EWK8XvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lYcWBtF0P4+BbFVl3+oR7cq3E+c4nBPObSvfvYMFafo=;
	b=mPEriPc0GR/7oECAP10+3DjM22ATO1CaE1lojzhYGCfs/bTimO2qw/ytr81Pau5Ya0TM
	 G2EcsTl/qWirM9vVDcSONxjPHEXEwHxOcV43NlcdKaM70fTF/WWDnTyumby4hz9c7wr6O
	 z1hYrHmKkIcHmTl8eGajb5glLFW9Smi1RRQZy9f3SJbUr7v/iwK5YExWKrTG8zONigGl2
	 iRCaloPbRyjW/HulhJi5KekAYAeTgiTbuWqe/iXTY0FSSnxTJNbw3h5ZsFgxonrk8RpaA
	 N6+JTNvFaOslnZcc0jbULPIkT8X95V+rfiimvCWHqTkxnW8eAL4+yaQuJifgAvaoJGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=znwsGPWu;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB3B606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 03:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFB3B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=znwsGPWu
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1931ff67a29so6876324c88.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 19:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794453775; x=1795058575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lYcWBtF0P4+BbFVl3+oR7cq3E+c4nBPObSvfvYMFafo=;
        b=znwsGPWuFtsXlCna4u5Y5WKs8fq0Hob5und5OnHf8G81I/JUSm1ncI59KDUHEi8IVE
         Kdu9t0EZeZqaxOZHUUkfL1FJNEjURxrFUUJyxR6NvrV35WaADws/YvcwbsoqtJkdR60g
         nn4z1gNvoCN2J7ozUhIIKpAkmkG+IJeETw2qoNB/ZsePBPyVeSag7ZwumgqzOEk4lfHK
         HC9qkggC1x5Scld4KBt/ESRjXHDYZySrOXzbLqaIfndwJlQ8TtVnyqf6swi1cheCbGCo
         Yzo76zSpwvbb24xpNAx0r/MeFlYrE6EBR75f/ELNoBcXHmL+NsBi83jVIwrjsC7lU9w1
         Ez6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794453775; x=1795058575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lYcWBtF0P4+BbFVl3+oR7cq3E+c4nBPObSvfvYMFafo=;
        b=TTYzSAtzhh+2ddS6kB2o3NnrCiqQ9s66YiujhIzXYyyQzGI3Ia5BTNLNbYLkkK5Apa
         H4qRVPDoW78Iwv3VVtyrtkXYRrwMe3NWSG+/i/DeefTEXSYN3Pk5kRhQMhuhlJC88fAu
         VUGX3SEiBQVJOiesNALxilt515hgi8Wciho2stMjvCoxNSzRSNcnwnJrV2YhUxz6UK54
         yz7sTdD8g4/anaU9bvIpK8t7j3+F8CEFETaUk+p86LN5FSAycQsMa1Kd1et6Ab0jzi0+
         zoLlNgtWsZ8LmiF8shdR8Iv8xP4vGPuEyTQOSriZ03KUe0ptq6ljDWDZVEcLNPRwjJHO
         UqdQ==
X-Gm-Message-State: APuU4Z/LIr1KUxmrhqUAS65V6UwefeA8IMw3KOIdeq619sB7dJmE71mV
	+GjkC//dhg26do2LW73eP/9ZxtLlEoji1wc/mwnlNPYboAXSQBKUixzhQPmV3yiaQhCbYruCmOm
	VDlA7ybY=
X-Gm-Gg: AYBFou0FYy4ec1cXlDQ/qdcK3SJK9EypSqz4f5pK9c5hYykXNFtEtqxQb/tXfroKMyZ
	yIV4acEw8jwDaoTKspHw6YVYW9bLJeg3btzo4rNEtCuLWepgC7vH9RGpAV8Md5nhDAxf3ev59kO
	1XSXDrPNvcm1yL2gPmMlVWpSqBcgm2fJEwjhygI1O4jgpnTRQUqJQU8I01RAj85D1AKrncVNDLd
	wvFC0QDR3h3RaAh2SacR9G+NW/CkrMc/tsgjvg6f81SQhELZyV+Tahunczp7ytdcXB8TVDBdzKS
	PBvRqILZ5DK/Wgs3KGDd/S0Uukj9GJUkLHhJNY7Rmxpmz2rSsBbL++QRBZO4iU2BcDk+FoCCKPJ
	0/HpNsx07wogP9e3R4gn5XWUbUkQ4yI9hcUy/o+47dsnEYXvyurvORkQlp8cTwOTjpAV9a8oQnG
	0vYjf1uAwTMtmJ/Q++FrwRjnC1gPNeFFXXXhGmEOv4j4t90mR1C06NhhwuubvVTMk3LTRo2kZDd
	3xrH7Unp7mkYzJYINpsErgrhcMroqbW9u5TSV/ttE1l88jN0ZjurbEak8hz7Yw5HN+5Q9zZpm6S
	VW8DZLsKSSK1YeWMQsr8dDPj3nhYqJGxedmdwnS1Z+W4Ngh0TZpYJ7C8QxV83XVyYLPzOGuGXnV
	aZP9cMIxN5WIXjVluZo7jYPdMVkIfXWRTjeuPe8F67pJkZeQCXkI7JjnhSynsYhesIDoJIMI=
X-Received: by 2002:a05:693c:65c5:b0:369:fc93:eda5 with SMTP id 5a478bee46e88-37686950cffmr4946529eec.39.1794453774638;
        Wed, 11 Nov 2026 19:22:54 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe2ff5dsm21340765eec.5.2026.11.11.19.22.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 19:22:54 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [RFC PATCH BlueZ 0/4] Bearer.LE1: Add ReadRSSI
Date: Wed, 11 Nov 2026 19:22:46 -0800
Message-ID: <20261112032250.37687-1-kevin@simpleble.org>
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

Device1.RSSI only covers inquiry and advertising, so once a device is
connected and no longer advertising, there is no way to follow its
signal strength over D-Bus. Applications want it to warn about a link
that is getting weak before it drops. Android (readRemoteRssi) and iOS
and macOS (readRSSI) offer it, and the kernel has Get Connection
Information for it, which only btmgmt uses today.

This adds ReadRSSI to Bearer.LE1. It is a method rather than a property,
so bluetoothd does not poll: each call sends Get Connection Information,
which the kernel answers from the controller or with the value it read
in the last 1 to 3 seconds.

This was proposed in 2014 as ConnectionRSSI with Start and
StopConnectionMonitor on Device1 [1], and you found raw RSSI too low
level and suggested a normalized link quality instead. I went with the
raw value because it is what the other platforms expose, and what
applications compare with the advertising RSSI that Device1.RSSI already
gives in dBm. A normalized value depends on the controller and antenna,
and it can be derived from dBm but not the other way round. If you would
rather have a quality value, or the TX power from Get Connection
Information as well, I can rework it.

The kernel reports a connection as soon as it is established, but
refuses Get Connection Information until it has read the remote
features. A ReadRSSI made right after Connect returns therefore fails
with NotReady for a few tens of milliseconds. Letting get_conn_info()
accept BT_CONFIG would avoid that, and I can send that to the kernel
separately if you agree.

I tested it with the functional test in patch 4 on bluetooth-next
3f425f95ba39, and on real hardware: an RTL8761BU connected to an
nRF52840 with a random static address. ReadRSSI returned -50 to -52 dBm
while the advertising RSSI was -50 dBm, and the kernel sent HCI Read
RSSI about every 2 seconds however often ReadRSSI was called.

I left out a bluetoothctl command and can add one if you want it.

[1] https://lore.kernel.org/linux-bluetooth/1401177171-19994-2-git-send-email-andrzej.kaczmarek@tieto.com/

Kevin Dewald (4):
  org.bluez.Bearer: Add ReadRSSI method
  adapter: Add btd_adapter_get_conn_info
  bearer: Add ReadRSSI method
  test: functional: add bearer ReadRSSI test

 doc/org.bluez.Bearer.LE.rst    |  17 +++++
 src/adapter.c                  |  22 +++++++
 src/adapter.h                  |   7 +++
 src/bearer.c                   | 110 ++++++++++++++++++++++++++++++++-
 test/functional/test_bearer.py |  23 +++++++
 5 files changed, 177 insertions(+), 2 deletions(-)


base-commit: 9659adb6819d7e0284d0d2ba226a3894423d8db4
-- 
2.54.0 (Apple Git-157)

