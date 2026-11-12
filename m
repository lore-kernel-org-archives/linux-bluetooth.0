Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505212;
	b=IktqFkp1O5bQbhZz2Az+EQsRQRkKoT9quYS6ggN1Fe9ESBG889rmTMbSENSFampNvJEX
	 cWOFMNEtRyMZVOaUvW6Aj8ouwsjy5qx6vJbAwmoxpBB9OcL08h9XxEOE1BaMzVVvF6TZP
	 YfA+YHwW6ai4DqOHZFzEOmx2Bf5TZCbjUEdZQJ0p2jBsBPfrayOFfaoTGvKVdkNZm+rxN
	 aYwddkJSI0EgK6s6Jjy9z9eoBDW8jurDfcLbxl5zZaE3wSWhV7SNr/jlEbxUMe0AnoQmA
	 S8c5/1Krz7u5kBhYonG2kXsO7UjAnFmnqrhyZypIp5p1cvDqRH2woDdapTIXcXANa3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lLQdfgeqULRj1K8u7kXxvQg1DOBuxPk1hfiAuddDRzI=;
	b=zBKiwKAMNJMA3BfysjkN4iHPQrGTcLijhCumGSPfhUX8n4UKndp3UD4Z1QHHbbGQuvAJ
	 1TxE3ubqRQCq3tWncqrc2kMOgsM4fAOpGwKy+5i5fZ8IAXhufl5/46lpK9p7r6UANmvnF
	 DjKGlPRTPL+LfVSLTlMw7G5GsrzfrzeHrUmDTfEHHehTzWS/C5ukVIfGWHudelff9ggeQ
	 7gAANESkwxsSFUfeSPQhnOm+un13w4ce/yxpM8CGv8o9jW4Cbqx3i/W6n0pMgU4yP4Sa3
	 NQ9sYEYKBgCZbQzXZ4iS1tePVJr304KKfKHLgBhH3Z23W5hMPEvivLBYx5+m2Nz9cdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=sqYUajyP;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6C7606A8B2
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 17:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C6C7606A8B2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=sqYUajyP
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1931ff67a29so8901044c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 09:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794505211; x=1795110011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lLQdfgeqULRj1K8u7kXxvQg1DOBuxPk1hfiAuddDRzI=;
        b=sqYUajyPLor2ddPfMc9XD0HYt/UBP/3tcyYMzcoUJ1JaCEdcQjLes4ygzCl7ZVpcAM
         auzN8wA12uXeLzYjfo1e29oKw7q0x2Iqbri4T2tnQNA9jaBkLniUPTMTgX1evi1D4GUG
         MrkWk6RRl5vuAcPM/Zmrf/IaqOD6ZCRUCByzL3389XcIjV18/ThjgmImh9Vbme2eUsKo
         scmdwdFsPJXkD832bzBjkxhKkvr6joe+G8W3rQgPjaaH9ILLLwyzVVzLxUL2b6hh8+FX
         OMVErz4pEsyyy1hCMlD7ObZ/6dBfoElzUGZhsLvwncAY5d7FJXNnkPFGFoEAif90Jqjx
         bGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794505211; x=1795110011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lLQdfgeqULRj1K8u7kXxvQg1DOBuxPk1hfiAuddDRzI=;
        b=z8/YqKGncXeWPVD/4zRP9uAHcOrU4g3/hck9Nlq5OJFZHJepyJBTJ9anUiVGJraNiR
         060BwYBIBUHAq7iVRf7s3csUyxM+iriIHoxOKXQgFaEbYcpm71sdyzRmiXp1nEuZGLYT
         42rfBMFkPjxNzCIeFxTQkjKyoSaizirQ/ZdhlWETxpakvDLmLFehydeyCMJ1d0l7ex2T
         ZK7ixOvgfOEJBy63BFsz2xxS3o4JsFC36YPvIRXTvA8ejITl5agb3U9ySPsMst4IWAQ8
         M1lnig4U83ididEz8No8Je0pOKusqUFAvLvV/cChIGFDYF1hyRzazbe4Wr2hvpzHw+rh
         GxYg==
X-Gm-Message-State: APuU4Z9Zy6UB30uyvkUFySgxEUy5pXHRkz1B/kKQWp8mByJpGPKpEwDz
	o3MkbRoe/BVSih9ajN4DEIZE4GlKiwFUrs9c9rVX6xzhdNshCykzmqSdMr/mFOsb/bQ8k3M9JOQ
	SS9L0YnI=
X-Gm-Gg: AYBFou2cD2qIqw+vAXbXe6TDTcWBA0qJA0ogwhUuCVkhVvdtYMvSBq+pm4L2evfhNwJ
	EZLhwI6I8KchHC9efMgwgCE+zHr5m+niaM7uAMNK0nA+YumJBqf9VQF16CmS0GFzYHT4xt2Ottd
	3A8GWisaJ+4kCRpLOxAKBg+oz5QwLQctDIb/bqdJFWGzy7vuJ2XmHC69TELgdWEt77eOPrqjg0G
	sIwQrm5k3V0100oFurifbH+nsFFivhK4/HOaUkQTy11l68wAUgDXDBnAzZu1yYIrM9wqryeB3KQ
	xaUEcJ4hUOVOnOjjWfOeRwEQatI3w6iyXa0HkdwoDwwrhKubrzNUy7Lmwl4efEKxhhYE4gAVAo6
	Rmdk82P+fOLnHKRgicBeX54j+tWr7u8XXQW3lfLr9VOUz1WN2OoY9rBJrYH1KwgL7o8iCHvqEta
	a926EQtsQRVfxhGCnoM731VCjkR+5tbg+gMtF5pboiX+Awp6wCXYzD7/9AL6P8pXKgH1kxcWMj0
	bPPhU50FAHry8PTK3gJi5s/Q4YuD6ueFIQj9TbNnNtvkazjCKb07+UoRQYw8Nj3UkLYJLX41laI
	tSFofU+B9ymQ/ALur3sMieetgGZt//pDw9g9PfUtXvpOYwpvYFUbMXBPO2+DOKcclhyK/KmpjQP
	EBME1IP4YR/W+P4XpX9gPSDivbFG9rmemMS1TO49xgN0wAwEU5Umk/ogLr/gYotW8aImOc6A=
X-Received: by 2002:a05:701b:450d:20b0:181:ccdd:ed2a with SMTP id a92af1059eb24-1b50315f88bmr193566c88.43.1794505210493;
        Thu, 12 Nov 2026 09:40:10 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm702743c88.9.2026.11.12.09.40.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 09:40:10 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Kevin Dewald <kevin@simpleble.org>
Subject: Re: [RFC PATCH BlueZ 0/4] Bearer.LE1: Add ReadRSSI
Date: Thu, 12 Nov 2026 09:40:06 -0800
Message-ID: <20261112174006.98288-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CABBYNZLiwCUAUCnVDYqWdjv5m4sFA=pKX8JAeFU1OXq-6LN7vQ@mail.gmail.com>
References: <20261112032250.37687-1-kevin@simpleble.org> <CABBYNZLiwCUAUCnVDYqWdjv5m4sFA=pKX8JAeFU1OXq-6LN7vQ@mail.gmail.com>
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

Hi Luiz,

On Thu, Nov 12, 2026 at 8:07 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> That still a poll in my book, not bluetoothd directly but I bet
> application will start to just poll it on their own.

They will, and Get Connection Information was designed for that: the
kernel caches the values for a random 1 to 3 seconds "to avoid client
trying to guess when to poll again". Applications that need the value
poll today anyway, as root through mgmt [1] or with raw HCI sockets
that bypass bluetoothd and the cache. Blueman still reads it through
libbluetooth for its signal bars, which only works on BR/EDR [2].

> Well the reported values are vendor dependent, so I'm not sure how
> much it would help since you can't use a measurement of link
> degradation in a generic manner, it needs hardware details to go
> along. We need a clear motivation for why this would be useful apart
> from just covering what other OSes might have since they may use a
> vendor command, or in Apple's case, probably deal with an exclusive
> vendor which makes things a lot more simpler.

For LE the spec fixes the value: Read RSSI returns the absolute
received signal strength in dBm to +/-6 dB accuracy (Vol 4, Part E,
7.5.4), the same unit as the advertising RSSI in Device1.RSSI. BR/EDR
is the one relative to the golden range, which is why the method is
only on Bearer.LE1. Android's readRemoteRssi sends the standard Read
RSSI command, and BlueZ's own Android port implemented it with Get
Connection Information.

What the value gives that a threshold event can't:

- Choosing between links. A device in range of several gateways should
  stay connected to the one with the best link, and a hub with
  redundant sensors should read from the strongest. That needs numbers
  that can be compared, not a crossing per link.
- Diagnostics. Logging the RSSI next to throughput and packet loss is
  how support tells a weak link from a firmware bug, after the fact.
- Production test. Test stations connect to every unit and check its
  RSSI against a reference unit, to catch a bad antenna or enclosure.
- Trends. An application streaming data can see the RSSI falling and
  lower its rate before the link drops, instead of finding out from a
  threshold picked in advance.

> Which means every btmon trace will now grow just with RSSI reports, I
> mean I could live with an event generated if RSSI drops below a
> certain threshold, not a command and event, every 2 seconds.

Only while an application reads it. A threshold event needs the same
Read RSSI every 2 seconds underneath, as the RSSI Monitor RFC did in
2011, unless the controller monitors it itself: LE Path Loss
Monitoring, which also needs LE Power Control on the peripheral, or
the MSFT extension's LE connection RSSI monitor, which the kernel does
not use yet.

BlueZ already has both for advertising: Device1.RSSI for the value and
AdvertisementMonitor1 for thresholds. ReadRSSI is the value half for
connections, and I'm happy to add thresholds on top where the
controller can monitor the link itself.

[1] https://lore.kernel.org/linux-bluetooth/aa77c035-d2aa-f227-bfcd-358b5f063b21@labapart.com/
[2] https://github.com/blueman-project/blueman/pull/1642

--
Kevin
