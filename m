Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795345058;
	b=xZT+MjRTk0NDWSoXKBnkd8P292qdTGtmAzoCDWQOiL0BuSl2X1awOsLCXPcyGvP0b7BG
	 VbdLFoj5QCboCnVMvzgl/l9bjaW/KTTIpDLZ6Kv3imoF7akaL+zquLvWyCywLi9p8DE4q
	 KKt4kZYxJnzQngTQrXtjD7zSundlVyXJiX3SP862g9yI/sb2zzWLY0zBfluZi/bTj/5n5
	 2Z+6OEEj+Q8WSk5Odf6RU9R15sqD4TbVLyPLDn6Iw8zHOFUUAR7T12aluPDl2asn/TBqd
	 Z3jp2huACFBZ+jB1+55b7n+gICSxZ9LXwvC/+Rk0Hse4Vee5XbKPixLAEOT1g80FVSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795345058;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=BFtP0ak6B2k15SIbBzafbABIFbGObDd32KiZPLlW6A8=;
	b=febKrp7FTJZ3nx05vfBqEji3VA+H24hLX1/ta0028M+CVW3g/67UwphOtcEr6lXm5ytR
	 VCD+kGKQhMbCJa5oemx9T3P3RPKip5BVO6NIa7w48dPRj8K5tNDROBdvIQwGUw1Pnxfya
	 sMKnRAK1NOaLDgAiCqoolkRw4HsvwV7RMVM1wtmhKpnqAo8slEz/jmWJs9baHTI3tzy9r
	 yIRg8oGSO1T9S2+hC9/t2bKa/O5XpNk/FMZqY0s9Rj+SwRsDZGo4SPg5nLKviQya8n9ry
	 v+x22l3zCtkS7d4lbWUcuJ7G2RuqJqWalacK98aZ3Ekmm/egGodzYhi6poK8sh35UPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=hUYqRGAA;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9557F606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9557F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=hUYqRGAA
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb77a462c6so25292765e9.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 02:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795345056; x=1795949856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BFtP0ak6B2k15SIbBzafbABIFbGObDd32KiZPLlW6A8=;
        b=hUYqRGAAappRYmXSAnXOdvWUHx+xbG29ACWOciX+PrhOOZHl3F8VBoS5VX/VhSb/aq
         MBQEyB8E73bvLN5zJD59xJhXE1XQYnrZboEdXdxJs81Yky0x9KUbsWlqFlU6hwNM9omU
         ONiw7ZiYdOQtiOg1GYwJ1aD2OF88jS3q24hvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795345056; x=1795949856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BFtP0ak6B2k15SIbBzafbABIFbGObDd32KiZPLlW6A8=;
        b=j5Y0xxnJQmn7FJvL7n+P72hMnXFqVeKrcFls/6Fia++bZXJSr8Lww8g4SV1h37+sah
         yi/uJfbMpNJwS8/UmKMOd44/0TshiOeY4oX6zLj61Spt/bKutnICTV4m7BX9Rg2Sj+nw
         JLmuIHtjZDl6eJzt+VunaX4mJ53MZeoqqMhjujW9jlqo5RYuKHcO5MZ58AbLFTx/Zz7E
         8QNiuCdD1CbOkhDktivOC4Fc2J8kpO3mDxdRMtsseqgOrJegLjPBd/QSBbbA6ioXa7mX
         Woq/4BGxADhBPR7Ap4ixxUq1nTXdQoLgFT9YuwuKmUZsLDNCnwb3taJw+zWljfNsZsTQ
         jgHg==
X-Gm-Message-State: APuU4Z8gW60ufdDh9H2SvZdHr2k4cOsIOf3L89hl/GvtL4gLaQJnsFI0
	W24irvYbmeRw10u4AlZD2/NcXc/EyDY36FCMi7yFXO5u6AnwSh3KiDAMOgsKSkJSH2H16kAIUr2
	A5fh6
X-Gm-Gg: AZFdTZe9pf8D9HBwY9ZlhajG7M7iHKRf/RL1vlvlD6H6kOSKYSDDWmZoiUJvYe2m2tW
	/9BYOBIDMVeLfWkznrBCHP4PW66hXqrUE1nWJMwse3srKviOmzxwTvhaeFpkTNluT3iG5WDOtk4
	SJyhwfQ+rA2c8Y+TrHuziIXdnv39TJrXfDm7iDn0ZyxxRlmbBOlV3WDg8suPj/NLisS/h8icQ1J
	/u8Y2mnn9dDWGFJLfO1uFmqeq46/dMXbR5ITPGHK7IUFbSqg0378V87BzMNdmOHVmpzASGbrz8Y
	TCQFv9u5o7WM5yFfzXpvHo378DyhlC4U/MMD/h+C100MEyqqtrT3KVD7ODmcaJD0M0kp71DxOKQ
	hQD+LyLdVjSu02j41uqK5d6goOMyIhMSLd+c7d8LggawO+cDk8NkiiiJilxVF467WsRN1doOwak
	oiRopwcKt6DotQ2Q1CQKHyPKpdwkj0NUspB8lTKMknRF6rb2907p+43TKc1zEJrtWFw+PvdCGRE
	ozLO4BL1UCVgMeWwH5UVft1YeOU667bzTzOHAT/cx4Pg3j71PYmXOBdcaFOVp9fC/LjBIc7+DUE
	bl0yeKcYs6C+c9mejggwO/W8X9x04pjW/b572M/jihBdXYAG/w5a0r8lVGByfDxdk1uG8sM=
X-Received: by 2002:a05:600c:154c:b0:4bb:6a78:7c42 with SMTP id 5b1f17b1804b1-4bb887c3428mr185411235e9.1.1795345055903;
        Sun, 22 Nov 2026 02:57:35 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399e2esm300138965e9.7.2026.11.22.02.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:57:35 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 0/8] AVRCP browsing fixes, and browsing and cover art in the target role
Date: Sun, 22 Nov 2026 11:57:23 +0100
Message-ID: <20261122105731.799090-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

Patches 1-11 fix the AVRCP browsing code, mostly in the controller
role: the browsing PDU parameter length is not checked against the
bytes received, the media player list cannot be read up to item
0xffffffff, ADDRESSED_PLAYER_CHANGED and TRACK_CHANGED are sent in the
wrong byte order, a player addressed before it was listed is never
browsed, Search in a folder whose name has a space crashes bluetoothd,
and listed Now Playing items lose their Name and NumberOfItems. Each
patch has its reproduction steps and the logs it showed. A unit test
and a functional test (with its documentation) cover two of them.

Patches 12-13 prepare avctp to answer a browsing command later, from a
D-Bus reply.

Patches 14-22 add browsing in the target role: a local player
registered with org.bluez.Media1.RegisterPlayer can expose a folder
tree (org.bluez.MediaFolder1 and org.bluez.MediaItem1 on the
application's objects), which a remote controller browses, and cover
art, offered in the target record for a player that registers an
ObexPort. Documentation, the D-Bus
policy and a functional test come with them.

Testing: every patch builds in maintainer mode (-Werror, ASan/UBSan)
and the unit tests CI maps to these files pass (make check). The series
was developed and tried against phones and other BlueZ controllers on
an earlier base (2026-10-12); rebased on this one it was build- and
unit-tested only, and the functional tests (test/test-functional) were
not run for this version. Valgrind, scan-build and distcheck were not
run.

Not included: the GetTotalNumberOfItems parameter length fix of the
earlier version, as a80671987 ("avrcp: Fix GetTotalNumberOfItems
command encoding") fixed the same thing.

AI assistance: Claude (claude-opus-5-5) was used for analysis, code,
tests and the commit messages; every patch carries Assisted-by.

Simon Mikuda (8):
  avrcp: Fix not checking browsing PDU parameter length
  avrcp: Fix listing media players up to item 0xffffffff
  avrcp: Fix byte order of ADDRESSED_PLAYER_CHANGED notification
  avrcp: Fix byte order of TRACK_CHANGED identifier
  avrcp: Fix not browsing a player addressed before it was listed
  player: Fix crash on Search in a folder with a space in its name
  player: Fix missing Name of listed Now Playing items
  player: Fix NumberOfItems of Now Playing after its content changed

 profiles/audio/avrcp.c  | 35 +++++++++++++++++-----
 profiles/audio/player.c | 66 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 90 insertions(+), 11 deletions(-)


base-commit: 1adfe662efeff12997df9ddd0960dbd0de9c8ea7
-- 
2.43.0

