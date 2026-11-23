Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472614;
	b=A5xepxvJHxHX+AcoSEsfpBJlBWNZuAPqYcDpQeuatoiXUw0QzDQ/gIOc3BuLYtr4IrBG
	 km5v8hKJyj5FJ+bWQrHfqLDR+8SilWvwbAQ1xoCr4Quom8Ds7XG5IyEmsC6+eCDgmnYKA
	 q08ZLXYgBwLHJu6T+5hLlqfrPM4fHth+DQLVhV4Rn6yVNoeOa42YvFTL+Zk2cXsG5Ln/H
	 CINaNW8VHUyaXy4RHzibytIyxFW6p8dhh3s2V3dJiiQo5xpb2pBUWQig6bVM3yYYcDwqX
	 s5k4xiZO5u//5ajaaRwOJYABsbAILyeArMWn5YxIa7vRoctCvUQ01//UO2mxEeO6cEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zqkTt6F7nsuT6zPVTmD1WONSZhzN0HyCbLVeGgDIyCU=;
	b=OSjrzSPj21SGCFMvaBuUUJZoed2L3W04375S+g1m/uguIVCN2xzqwU+ogmBH4n91sj7V
	 /h78ie9uQMvSD4p4MLrytU4Yky04YuBI2au14lGV4oaAYArBno9bylGysHsxGhsLzP7aT
	 qrSy/pc/O4Mn1aQLm/Xzl0IXUXI1eBbHcBZCmq3oTupMpYKxskwJD9zGzoxkyqFd0VF/Q
	 EmdqIPymc4POsb1UlwOcY/Q2cO8r8DFvKeZ7MH+mfwCJ03F0y2LWRpaMr9KDjol2dj4cc
	 NQKfIrMrodZubvkMe/fqipI9kti/0k/RbE/lXQeNteVu16vWTgylBtIbwKzFDP4UYTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WpWuYJnX;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30190606A31E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 22:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30190606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WpWuYJnX
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-49083b985d2so244225f8f.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 14:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795472612; x=1796077412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zqkTt6F7nsuT6zPVTmD1WONSZhzN0HyCbLVeGgDIyCU=;
        b=WpWuYJnXhsj6G9IFLwwaF628JtwbZvnr5CJQHVzRsQvK4jS0bNcj6SZ8+bYORZlfJe
         WfQNyRv0ZmllwptEuYL2xsv1UFmK8TglZ2OgKxW3x0A5uWne9EXT1W6eyQYcbagAxxDI
         vcdzTIcvaTb2f522suvdZIug7manzEO0kZlRbCoTQqZil/tMq5m3hmICfM8104h8g8bm
         zu9htr2yGQRM/A5kQF5UjVYiKQdgUGCeGHJGazFFlGLPakgsZZZrnuYR5IPevWXak3LC
         eFzkUYiSSJ3/LjRlDx2nIxoIJ/9rWuEdIFPGv31whLP6/9KrVk0y9lQ4qQR1MQpo6nyy
         5Oyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795472612; x=1796077412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zqkTt6F7nsuT6zPVTmD1WONSZhzN0HyCbLVeGgDIyCU=;
        b=f2BCcdXzI8PRYBRpOixUwCokbRFFd30lTfdtvvuH5ofH4593KtgS0y1XoV27vcYD/k
         rrQSklLctQ7etPilJgMLUUGy5ln7CZ0A+qV96rFfkce7g43TdiyfhHMzFRuBbF2HMEBP
         xSoEN5kevbflqPJiVgrMP7FFzQoHbbZC+rBL5zlrC9eMJ9ENrVySAXaRYzGCeF5p8Yxz
         HTfp2h1SW3wOFZ+i/MMFtXdp9ITIT1Hnf/rE/jDLcrTZbjmOOvg2ImXHXYOkM4Mp8F68
         WZX8XwbjXjxy4n/FEaIshT504rszeSZ6NkTdK9YpbrC88NXqVprg8RcJciCrTJuaOZLt
         9okg==
X-Gm-Message-State: APuU4Z8pFDvp7jiX5JNP6+x5bigz2ePTyBRlXk0KOxCfmt2o9q0p+RIL
	fUAcCfOYxHPaEpd8blYL4jn5GX21O9Hu8hC3Y3osWPxgDO+l4KpyQUdI6lBk3Q==
X-Gm-Gg: AZFdTZeTy/cVYGgLcElH4o62GCiu4X/12uQfqVYxDPEdB0RvpUJk/g1nb3S818Ef/9J
	YELh5R9y/JZmxdJQXhJ7fON6ySDGz/sd6qAPYHiDOsg76k/OboJTBrVfJzybbK3YK0u5pmCpPns
	LrTw7tCZKLwdw1A2XIFZmr3zZm+9i/Ws2qQvou1SrwPcrqa8ilBXczbjb7yYtKD1Gva+ySv4dbs
	v+JLDu2nvfGbUndee7YUkN7b+pefgJUqQVuYN+crSxkTkBs4gTPHFNP2NjaA3/zIHL/iFEgY7Ef
	8Z62yXdwTHfJLxOrt2liquE72lkmHw6V9un+IFA7tFXz3NXzLmwkYLd0rEYNMAsjfU/xcw4M76f
	w8OTVMizqrFMxthfNvbzuPxXhmkbADXU5AlcIeeFes43dBFC0Q+SboVx8TG86L7KJsRt5hiFiN3
	TyhEZx8dVi9yqS/3Huo/0uQoL4IkcsXyGJl7GOjgGvzfqvQAsj4gytpUQtsmxOPAwJaag1yH+ZO
	2jBCeZXdbni7rep3GH1mD+hBKDJmfeBdLjDWzYnicB9jg+hWDUT0ZT/tKv62h0JCvJfEh/Ughnk
	WPX0Xqb9ClC57LTENbzu9alKwswKWp84PCUFg9u+cBujClkW
X-Received: by 2002:a05:6000:2210:b0:4aa:8fc3:28fc with SMTP id ffacd0b85a97d-4abad0dedc8mr25847850f8f.1.1795472611950;
        Mon, 23 Nov 2026 14:23:31 -0800 (PST)
Received: from schinder.fritz.box ([2001:9e8:b398:6b00:c303:57b6:d70:952e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4abbd84e661sm23019015f8f.18.2026.11.23.14.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:23:31 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v2 0/6] monitor: Fix reads beyond advertising data
Date: Mon, 23 Nov 2026 23:23:09 +0100
Message-ID: <20261123222315.223450-1-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
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

print_eir() and the decoders it calls take advertising data, which a
remote device chooses. This series fixes six places where btmon reads
or writes beyond that data, or decodes it from the wrong place:

 - a Shortened Local Name, Complete Local Name or Broadcast Name of
   240 or more octets is copied beyond a buffer of 239 octets,
 - the Flags and the Security Manager OOB Flags are read from an AD
   structure which has no data,
 - an Unprovisioned Device Beacon of 18 octets is decoded although its
   OOB Information lacks an octet,
 - the Apple identifier is printed as a string which nothing
   terminates,
 - the Program Info metadata is printed without a limit to its
   length,
 - a Public Broadcast Announcement is reported as invalid when it is
   well formed, and decoded from uninitialised variables when it is
   too short.

Copilot found the first one in its review of "monitor: Decode Periodic
Advertising with Responses" v4, whose new decoders hand advertising
data to print_eir() as well. The bug is older than that series and
can be reached without it, e.g. by an LE Periodic Advertising Report,
so the fixes come as a series of their own. A v5 of the decoding
series will follow on top of it.

The others were found by feeding print_eir() one AD structure of every
type with every length up to 250 octets, in a buffer of exactly that
size with AddressSanitizer, and by review. The same test passes with
the series applied. The reads of patches 1 to 5 show there as
AddressSanitizer reports; patch 6 was tested with hand-made btsnoop
traces only.

For v2 the advertising data was also fuzzed with libFuzzer and
AddressSanitizer, part of the time with UndefinedBehaviorSanitizer as
well, as LE advertising data and as an Extended Inquiry Response.
Without the series it finds the reads of patches 1 to 5 within a
minute, the one of patch 5 through a Basic Audio Announcement. With
it, more than 200 million inputs, which run every line of
print_eir(), found nothing.

v2:
 - Add patch 5. Copilot found that the fix of the Public Broadcast
   Announcements, now patch 6, lets them reach the Program Info
   decoding, which reads beyond the string.
 - Rebase.

Roland Schober (6):
  monitor: Fix overflow of the name buffer in print_eir
  monitor: Fix reading Flags beyond empty AD structures
  monitor: Fix reading beyond a short Mesh Beacon
  monitor: Fix reading beyond the Apple manufacturer data
  shared/bap: Fix reading beyond the Program Info
  monitor: Fix decoding of Public Broadcast Announcements

 monitor/packet.c       | 29 ++++++++++++++++++-----------
 src/shared/bap-debug.c |  2 +-
 2 files changed, 19 insertions(+), 12 deletions(-)

-- 
2.47.3

