Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522752;
	b=UqFTc1IGk8HeugaT+LsaFXTOylVsEHiCK2v1QRQBrObZMw2UkhGAXzDJBRP2TOSBctbi
	 Q/Wyc7QVBxb0OsuUgd9RBMIDmF/F6azv9S2ZDM9a5WjK9yPhvj32Jo9LGB29oVC4kpwJC
	 14FXOxbl8Q7a5rb6WCPfkSG57jWZ2yVOlg9A4fVV4cYe8LOOe/jJQHjWDNUk/u3+YxPis
	 YHj973JFbTdfTXYCWM9+bThe0DHafJn1Bl9Ar9+UHgWAfYzNG2cU/U3eO0TUemB437pv4
	 kzbamFYVBBtw7pHYf17nioPUpbldE8K7mzSYmNpb3qBuMYLpd0qJz8iz1OZt71fuvHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=BoWPJ6Ra62BSdI9zXE2Ryav2uJfWGkfy4/bK7EiTWyU=;
	b=TtUkpGuFN3kfEcwST6ZNxZ/6EbaCHIaBPQIYLi+kNAzN0dGdFqR67rkaFhR7jE9Qljh2
	 LNvGLi1kxmKoIMb4DTmgJkxpZcnTYhGHQUkGi5yKA88omAtBNuJ9+VVtRRlaj38r4/SlD
	 ZwwJM7Xoj49S/hZtlSqjhAQNj8G3QqU0ZC0Jn/aNXbsx6cteKsHbdogTbUhUyYWChiEqs
	 ocGgMjXp8D5Mo/5ycJnE3/OGUodlFmSThrkLfmHk40YquiFPKhYmTzQtCcLr4U1ykrVPA
	 idai9g+CnsotdZSY9yiWmDVH7/gA4ooZ0sHxTnQdiwkIrvaCXbNU9aFY0wfI57MBzwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=TTSD2Wrh;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF73F606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF73F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=TTSD2Wrh
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so38708255e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 04:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795522750; x=1796127550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BoWPJ6Ra62BSdI9zXE2Ryav2uJfWGkfy4/bK7EiTWyU=;
        b=TTSD2WrhnQM25b4wXKQ6bpdQnjgeFdRkBU4kcsEHP3k/w4F+nxdYQ274+vbub8mU9e
         aoBSwzfBgMEjevBELVp1QqRZyVmVIlGs6iuAvlMZQW3lD/+F7IYo3kzzl1SEHFj6xs2N
         q44FUoLm1nI6BHdvPZ6RlZGj56sM7LiHbtWVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522750; x=1796127550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BoWPJ6Ra62BSdI9zXE2Ryav2uJfWGkfy4/bK7EiTWyU=;
        b=se9pwLlKDt3x2Xk3wxUZT48myqOTY/xr3bnomdmFgB6qCzNJK75gXzKGKy0j3ROjac
         JS4p7UgrWNjcJiJzKMofrE9Xorlh+WjefbiS2IOlRvLlR2h6s/E/SjUmvm75Rtba+cBr
         HqS40ZmQcxFsloxNb1Hj8b+T3+PEqT5gVyMHbJOm9niXVhTbh21it7hNTlIi2l2dgkGa
         DVPCMgrD6U8Me714tkgbLR8xyv7rssm1WroiN395iYAk/V9P8bzhP2LhJFfSSywMEQxE
         BoZVKjPlWVt7bLPbpHdR2I7Y2lBLe0WUTqKIZi7O6Cs8u3NXwgtqkStykMM5kOlfDefM
         RWcQ==
X-Gm-Message-State: APuU4Z9WZ1V+MYwNbHV1n8IcelJWxDpqYShdtRJU+0WlIySZb610mrTJ
	bTRtm2IXBC4s4tiCqwshXXpTbGaoK6HRug24BSiDMGEfEydO+GZnNl6swSEJM2WsXbLozp5L0SQ
	3ZaGj
X-Gm-Gg: AZFdTZdYNgU/UnEIOBHOLRquHjXCPHlj8dkq2iNUsqvwhfFCaJbeK+JcX0Hijlyv/Fq
	g77gkmjpCPGUwcWMi/Q/DxlltbZvDStt9drw8wdHtCjQii9ub4yFx10JNOmGBTob8CtFufmyRem
	5dW6HD5AKvVd1aWBFoKB1Ta7YJRbznU3xeIPdNhj06/HmStChDuIheiai4vBtg6TVdf9gWOOptV
	SxeWdWEX6pouq2AxlRDg0fojMPufFT3PzamdrF0i4LrobEIY4kv+f0LSLfmL/NOn1qB+lS8NqUG
	2XueEItiktSRzFFw1ZICf5kz+AdgXKDvc7SRClapxGlI5jTKgpqCF8HKN1nKK9echOcG2hjWQGb
	Xoq6VYfzoy4ckn4jgZOsyccXIutd7fI+N+IaTuBBDQquThhNnKDRYrmQ59giso1fChl6w12TM8a
	69YaDnN7dTH9NFl6NIn+CJgsYSrxJzDouf4NgZXMF+lgI0eNLtsCXwhBE/hC7zVEbXvKzgb9Ue1
	sDD4b70MZ1mDbYdVbTZLYBboJw7iXTEwrBUdtp9du4CfugL+lyDbaN+IlTYJcpAdB62yIxuQxFJ
	oMcEiy+jklOMZEj2u8gXrW+KBiHH7K/6Ii9Eh/f7By7lTtjBjA==
X-Received: by 2002:a05:600c:1c11:b0:4a1:e57b:667c with SMTP id 5b1f17b1804b1-4bb8881c357mr330844505e9.26.1795522750004;
        Tue, 24 Nov 2026 04:19:10 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm391427775e9.8.2026.11.24.04.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:19:09 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v4 00/10] AVRCP browsing fixes
Date: Tue, 24 Nov 2026 13:18:54 +0100
Message-ID: <20261124121904.3267700-1-simon.mikuda@streamunlimited.com>
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

These fix AVRCP browsing, mostly in the controller role: the browsing
PDU length is not checked, the player list stops short of item
0xffffffff, two notifications go out in the wrong byte order, a player
addressed before it was listed is never browsed, Search in a folder
whose name has a space crashes bluetoothd, and listed Now Playing items
lose their Name and NumberOfItems. Each patch has its steps to
reproduce.

Changes in v4:
- Patches 6 and 9: shorter subjects, their titles were over CI's gitlint limit.

Simon Mikuda (10):
  avrcp: Fix not checking browsing PDU parameter length
  avrcp: Fix listing media players up to item 0xffffffff
  avrcp: Fix byte order of ADDRESSED_PLAYER_CHANGED notification
  avrcp: Fix byte order of TRACK_CHANGED identifier
  avrcp: Fix not browsing a player addressed before it was listed
  player: Fix crash on Search in a folder whose name has a space
  player: Fix missing Name of listed Now Playing items
  avrcp: Fix NumberOfItems set from a reply for another folder
  unit/test-media-player: Add test for stale NumberOfItems reply
  player: Fix Now Playing NumberOfItems when its content changes

 profiles/audio/avrcp.c   | 110 +++++++++++++++++++++++++++++----------
 profiles/audio/player.c  |  65 ++++++++++++++++++++---
 profiles/audio/player.h  |   1 +
 unit/test-media-player.c |  40 ++++++++++++--
 4 files changed, 179 insertions(+), 37 deletions(-)


base-commit: 1608f836188610aabeff5a3164169ebe0360e443
-- 
2.43.0

