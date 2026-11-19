Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076197;
	b=CET6587xEwxTUKwvetqChnsfQzI6RsVLHAKn1WGjp7LcY9uU3YfwOAzld5/9e8eojaNI
	 xfsx47qoBYjLW8OEHdne9SA/nUc3TbRYTJ8sTGALg4gVozZm8UxvWfhryKJo7ywrfNCF0
	 ROedq60T3SDDgfXpKR3sNZTca35gmMPHKqKqiY0w/mg1fql65qKjJgVzn34YdRlEqJR08
	 7GGXL6lTO1vlScbgHwLj5nF0EUCvY7br+hBpL3384z1gfUFPWezCu1dnS1PwVuUqJn6lF
	 UAf44hLQUsbSjeoiwE1PT8ZhuYdT2Zh8QoaV+/RQbILtbs9aGOeslTZ79nPC/2r2lfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=RS2u/Csq2x+i0967lk4I7nwg+Wn91H1H1oYCNrsL7Vw=;
	b=kYBm64kzEtWR3hwiLvnfwnZvSlC8DblAoGua1mvmCrtykEQHx8BF/CjvYcNcFiJInuN2
	 TU5wqFqfhce8o5thI8EpC416c8B+QvRei+7cjhnbSFzKsh8be8k8ghh/R3rzju67i3eTx
	 /r4YEsDyEINfUwct2IVWaFrfF37X8ov9cU1OrFXXm90cXfHXl/C/27brfsUTQtoa2O07+
	 ZDPjYtlPpTSkN1lR+7vMQEQNtNdVfLLwFGKY1Jx6+ZraOY0XrqqQ0GNgGCPueDCDt8ePj
	 V/iNphNZ5UegTubn0uGsG6Zg3LdrKRgc6Vyyz69WOXCDpXS2AZJ23csCIGtYxNq1hjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lmQuBVHR;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6571C606A32C
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 08:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6571C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lmQuBVHR
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b88aab58fdso238407a12.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 00:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795076196; x=1795680996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RS2u/Csq2x+i0967lk4I7nwg+Wn91H1H1oYCNrsL7Vw=;
        b=lmQuBVHRVHh+0rhpZJk6O/VnZ/FvcDbCv86Lz5wHEp54hpSnPo632SFHZ3BCL1IJLg
         Ckm0Qo+s8cnE+bJbJj48+4waD/amu/hHQrjkJXW+fenwOSvE0mB8eTt0k8va9f60GZsR
         GxiaS+wfoAY2Rq13oNsPQJmZ3/xfehx0/RC8IMXEAOZrkNyUYYVYGnPlab+fVVEWbb5x
         o7fY7s4qCLyrmJJUzOqx9c29b55k5zE21oTRKn/byTQgUGDW82H5fVOAd5raiec8fKiw
         J7CwlTxisBDOFqfLP/N7Yf5TUCufEV4c2IoNGF3W1tsq+x14F6lvjXBmgU5CSFmB3a2y
         OFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795076196; x=1795680996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RS2u/Csq2x+i0967lk4I7nwg+Wn91H1H1oYCNrsL7Vw=;
        b=i+UWdU0Z5MipXbInPprSg69StSps+AISbimXyMcxDCfOpqZlD05jY5Hot96bKWjftK
         KPDjxoLnp4H6rWs4XGqfI6R7vv4N0LJSlYvAFPH/ZTaPy1DjAhWR9QRG9jVbGT6vGkzu
         QMTIf/yrBFs9fbQPP7/jUGYKut7+3t0sXeSSTOBqeN8Nh0vbtID2uYebcK2cX0x9nli9
         5PMt/Gt6KdkpCNUWLLRzA6L+BlQmVWR7U/mB6+BEg3XCbsPw6oQsddZT+Tl3+i2OkUaz
         8iDzV83ufJFWvC+7TrKg50FIODqyZQj9IF92Wz27i8AP/LBWH/fdHFNO+Y6+8eAG7Pmx
         e8+A==
X-Gm-Message-State: APuU4Z8Uae9OuAaSF1dB9l6G54areV1O3xHZ2DSP7Fzj9gvNCj/bxR6S
	3MQ13WeXyIHEttq9bhFODwahpMJjgFCQomtFGmJdFypP9RQzeaE/0Fdadb8bXTY8
X-Gm-Gg: AYBFou0ewD9V59IokJRzkruIZulIx/JB0/W7TVLe5KlpNEO3ti7wmLk9AZrPCgxAzb3
	wAMgQ8nP3eRmBA722u0z49TVcvIs1hmAFkltddPHS4xPexv/SQnSwhuwPeSjvwoLCtJ+5Ya2l9f
	cQNLoY9fJk8zhQhRTeTAuUzCMjBUnXQHjfKvhGz9fNJ2JZGZeodjRJr1izikAXL710hGL12H7YN
	Z03zyg2mclpUxLhOdxSeS8tpLn1YX22jO4smkP2spdHWvE+UC+Lq2UXzFTqvUrAz5gf4awDHzao
	UZ9C67aA8fGekdaKc+J25rBD7NUTu1n7PXYb5N87g8YlkYq1aeWgzu7kLy7DHuDb96c0KbjaAf4
	eQ9ZteN3hrAbJw9MmZpeAF9z5mcHuk1pxbH0LrKdYXD9NXIqRSpAzbJQUBGOgbq1k2bqfTW+Qe6
	ZPxSt5Hc/puKOLqtu5tFQmwGK8z0qYbbOY8TACcuWbhbf28TrFZdrrtpE4GqBU0XqtrAt/S2zgm
	EBV+bDAHmlsQV4temqAx9nBf/FjtZR/Hp/RcdTgq9F9b3m1+hHQZj+aYwHl5h+9smau77BUipH7
	YA0HZSv00LNkw22G8UnQ/bQ3leQ9yLKEuvs=
X-Received: by 2002:a05:6402:90d:b0:6b7:dace:635d with SMTP id 4fb4d7f45d1cf-6b8877d94d8mr5212946a12.0.1795076195699;
        Thu, 19 Nov 2026 00:16:35 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b88a22e143sm2229580a12.29.2026.11.19.00.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 00:16:35 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v3 0/9] monitor: Decode Periodic Advertising with Responses
Date: Thu, 19 Nov 2026 09:16:12 +0100
Message-ID: <20261119081621.112623-1-rolandschober1968@gmail.com>
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

This series teaches btmon the HCI commands and events of Periodic
Advertising with Responses (PAwR, Bluetooth 5.4). Until now they were
only listed by name in the opcode table and the events were printed as
unknown.

It is meant as the first step towards supporting the PAwR advertiser
role in the kernel and in BlueZ, which is what an access point of the
Electronic Shelf Label profile needs: being able to read the traces
comes before changing anything else.

Patches 1 to 6 fix existing decoders which the new ones use or which
were found on the way:
 - the Connection_Handle returned by the Periodic Advertising Sync
   Transfer commands and by LE Remove ISO Data Path was read as one
   octet,
 - LE Periodic Advertising Report trusted Data_Length and
   LE Extended Create Connection trusted the number of PHY parameter
   blocks, so truncated packets made them decode octets outside the
   packet,
 - the LE Set Periodic Advertising commands printed the advertising
   handle as a connection handle,
 - LE Periodic Advertising Report printed an unavailable TX power as
   127 dBm and named the AoD CTE type with 1 us slots AoA,
 - LE PAST Received printed the handle twice and decoded the clock
   accuracy as a BR/EDR one.

Patch 7 splits the LE Periodic Advertising Report decoding into
helpers without changing its output, so that patch 9 can share it.

Patch 8 decodes the five commands and patch 9 the six events,
including the [v2] variants of existing events.

Testing: I have no controller with PAwR support at hand yet. The
commands were sent with hcitool to a controller which rejects them, so
that btmon decodes what the host sent, and the events and the
successful command responses were decoded from hand-made btsnoop
traces. Every command and event of these traces was also fed to the
decoders cut to every length, in a buffer of exactly that size, with
AddressSanitizer, which found no read beyond a packet. The output for
well formed packets of the existing decoders was compared with the
current tree.

v3:
 - Add patches 4, 5 and 6, and print the advertising handle, the TX
   power and the CTE type the same way in the new decoders.
 - Patch 2: also report octets beyond Data_Length.
 - Patch 3: report extra PHY parameter blocks, and do not report the
   remaining PHYs as unknown after a truncated block.
 - Patch 8: reuse the [v1] decoder for LE Set Periodic Advertising
   Parameters [v2], print 0x00 subevent timings as none, check
   Response_Data_Length, and match LE Extended Create Connection [v2]
   with the events which complete it.
 - Patch 9: Data_Status 0xff keeps its reserved meaning in the [v1]
   LE Periodic Advertising Report, LE Enhanced Connection Complete [v2]
   is matched with the command which started the connection.
 - Patches 8 and 9: report a subevent data command or a response
   report with fewer entries than announced.

v2:
 - Add patches 2 and 3. The two problems Copilot found in v1 were in
   the [v2] decoders, but they came from the [v1] decoders they reuse,
   so they are fixed there.
 - The patch which splits the LE Periodic Advertising Report decoding
   keeps the new Data_Length check in the shared helper.

Roland Schober (9):
  monitor: Fix handle decoding of status_handle_rsp
  monitor: Fix data length of LE PA Report decoding
  monitor: Fix PHY decoding of LE Ext Create Connection
  monitor: Fix advertising handle of LE PA commands
  monitor: Fix TX power and CTE Type of LE PA Report
  monitor: Fix LE PAST Received decoding
  monitor: Split LE PA Report decoding into helpers
  monitor: Add PAwR HCI commands decoding
  monitor: Add PAwR HCI events decoding

 monitor/analyze.c |   1 +
 monitor/bt.h      | 174 ++++++++++++++
 monitor/packet.c  | 585 +++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 708 insertions(+), 52 deletions(-)

-- 
2.47.3

