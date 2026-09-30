Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4E336F905
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800244; cv=none; b=XHASG7T8GRumvBwxI9ydTavhB360Gth1ZVhl/ZcaXszp5X3jeeU3rUEmJwm2UJZ8Otei0VLnjcnIfIWBj7YU+9LWZZBwGi/k+o0YelNE41o9D7gh07Auo3YCwwZA2Usbr1CLybBDFuHvzyIpSTPO1FZj0MC9skCytOSZJH250RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800244; c=relaxed/simple;
	bh=ACqg3ynhFbTQNXDHu+qGF8WLqGwqH8igc53rQCdQ/fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+TfAj9k78Jo2FRiRahp6R51licG381uKs7lYKJllguKd5Iwc6yIBbZTrJfMlbytdwOZAIIEwXexR8h1hSdovzzDga6/GusKK59tfX01+Qj/qtNX0rDJ6tNIpvI2nM4hVOHxDKNsouImrb+NdzqTrJ/umYGKypm+b+8dmfNCLkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=OP+GMW7H; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="OP+GMW7H"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34ca54bfc48so1409692eec.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 13:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1790800241; x=1791405041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5S0nbx9hhQH9ECTJKblRf5Umi3ZkP+lfM5kXccGZOoI=;
        b=OP+GMW7HcPoX54a9/7soMgrJzHeebW9Lw3xbS5BcenefIDspBDMRSfeUBYpBJBu+cB
         xpBfnKMzOA8ZLmfmqK3+zkGY/nyq4QiRxKKuZJywwuB/5r7ty1PNyXxGedYTU5UlU2BA
         WU8md1ucQ1LOU8cNYzWkdTcpsSkeWBKPA1vvcJEayN66HRhJU+EAnCNOIcCX7aymwq+y
         KI/kOWLft+11rR3ZYbPplyKmvv80e8LhazeQWpULhV3BiSIrH38TpRwuVARyOYtBAZ7l
         JHXXD8YzFKeuJPJS1+lQ5gpgnsdAZaAWRR0kxAsYocj4pHWMDZE2sZ67HmtsSGcTO2r1
         E6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790800241; x=1791405041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5S0nbx9hhQH9ECTJKblRf5Umi3ZkP+lfM5kXccGZOoI=;
        b=MtHV8vsghg9volLyE4mP93rpgKtEFscYjo6x1ggeZeIwzOVDufvXqzPtTvdktE88wJ
         ++AqFQSPywXR1dx9Vd8z6jA+5CiwdIvH7iRQm9N4EEoCIaQ+t92oxcz/tnKDP2fljsrX
         FocAjBasmtkq4p0f8gQRWfYTSByia7N9a20zt/hPJmM9pF/D7GunFpv3Bm5rLRRG9n93
         WmzRYqQL7fkByjB9+FvdwyvqGPw0Wz6OYLCPK1hY4zLXjtEMpnyOtBIP4+BDcs0fB+2B
         6uFprlF5M5mtg1sAu3Z9DoLq6tkcgVnkqoWW/ni7+er4YfWBiZhUD2Gcyn6qjBFSe2hn
         45dw==
X-Gm-Message-State: AFq9FYJNssQSC2sphKXYka3EYMrpm0JMkXg5XyJbOlWaDVe5vvsBU+lG
	UwTo9g18+w86M9S7ojiDXiSUbKv2FJRtEIKBtPXJxG6Qn1EMsv2uaiOP+BKp9aEFc2wrJ24wNa1
	PM8GMk+8=
X-Gm-Gg: AYBFou03r0sAFChashp6pBy9uGTWBLdyCRAOPhVBlwDn0YyhdsvA/AgcrxKGs18A3Ww
	6mQCazG5/yNKQw72cZnUTGww7TTInWs6bn842IOOKE9WTLb/u2jtTokhwzoqmMtTcrMf2g2orgi
	pRyYFD75K/9CGFbWB5KlPiuCcmAxRLih+tJdWs3sIjRcmyoT4hWThYOUYUd11/Q4NMKkrMOuAjP
	g+PZjsJ7ksUMkWyKhdlndIZljZWMgFfkQajVr2IjbDMEPSv9C8lful0w4IHw7mu/PmLDddsmdYX
	Hxd4sfUijp6PDHBBC+oyeoCEkMOy/uhPypKXq1XfGHZsC+vLPKHo29YacgYJQVAPJ0W68aqZvlz
	nybpDT+G0O21317uhfNQqF+5YwYZviFJQuIPKPKOgUBY7datt0fUO1lDStltb9M1LUrMPceu9m/
	sedNRchT9GlmYMRMXo6BeiWz3zoNKNA83I9FXi4cbi2Wm2U6Xbpap07W1A2QLh9yKNn/67vQ/d+
	D/RxpHtVLH4iHkGG7ZUbrhObh+rYcuEQgs+S8Hau/t3c2iM+zln3UQtN8hu958XyHm7jZh06zIZ
	JTUL5XM+uFZxgdEyDL9rzxqVevxYgIK5E2xc6NiL
X-Received: by 2002:a05:7301:1522:b0:33c:19bc:d8d2 with SMTP id 5a478bee46e88-34cdd0af6c7mr2498917eec.31.1790800241307;
        Wed, 30 Sep 2026 13:30:41 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db0c89a80sm1210616eec.2.2026.09.30.13.30.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 13:30:40 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/3] Add Connectable property to org.bluez.Device
Date: Wed, 30 Sep 2026 13:30:31 -0700
Message-ID: <20260930203031.89180-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CABBYNZKebai0bQZ4Z_0+P6LwWN=-jniRMN0vctYTD0TC=y36cw@mail.gmail.com>
References: <CABBYNZKebai0bQZ4Z_0+P6LwWN=-jniRMN0vctYTD0TC=y36cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luiz,

On Wed, Sep 30, 2026, Luiz Augusto von Dentz wrote:
> This is already exposed via AdvertisingFlags:
>
> https://github.com/bluez/bluez/blob/master/doc/org.bluez.Device.rst#arraybyte-advertisingflags-readonly
>
> bluetoothctl does already gray the devices that are not considered
> discoverable, see:
>
> commit 815f779aa8e477e399b78f03c0ea0e75f0270c4a

AdvertisingFlags is the Flags AD type, which tells whether a device is
discoverable, not whether it accepts connections. GAP defines the two
modes separately: connectability comes from the advertising PDU type,
which the kernel reports on its own as MGMT_DEV_FOUND_NOT_CONNECTABLE.
bluetoothd already relies on that flag, to skip non-connectable reports
when auto-connecting and to drop temporary non-connectable devices when
discovery stops, but doesn't expose it.

The two often disagree. Beacons commonly send ADV_NONCONN_IND with
Flags 0x06 (e.g. the 02 01 06 prefix of iBeacon), so bluetoothctl shows
them as discoverable although they can't be connected to. A device that
is connectable but not discoverable can send ADV_IND with Flags 0x04
and is grayed out although it accepts connections.

I checked this on an nRF52840 that keeps the same advertising data,
starting with 02 01 06, and only changes the PDU type:

  PDU               AdvertisingFlags  Device Found flags  Connectable
  ADV_IND           0x06              0x00000000          true
  ADV_SCAN_IND      0x06              0x00000004          false
  ADV_NONCONN_IND   0x06              0x00000004          false

The use case is cross-platform code: Android (ScanResult.isConnectable),
Core Bluetooth (CBAdvertisementDataIsConnectable) and Windows
(BluetoothLEAdvertisementReceivedEventArgs.IsConnectable) all report
this, and exposing it would let applications rely on it on Linux too.

I'm happy to mark it experimental, or rework it if you'd prefer a
different shape.

Kevin
