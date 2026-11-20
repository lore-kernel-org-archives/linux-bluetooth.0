Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795156743;
	b=e2W0lQhy8f5uldZTJ2z5pRlDQuNq87X4uWCF0ZzeRbHFquCAT+eEt4gzaBnl5TIkex87
	 cWrknG/2eULP8aHiCSviHj8rhbbTpPFEAB51FDfqpWakzyi5LfoCP1D34470ui4ZTl4fH
	 2WW7IhsEhTGx4lfKglwUgkFFUSXqaClTe5KF69ExMfADdcSR5A7cFz2yZ2EzuhllEo8z+
	 Lc6fTzzSxmv6cGapoOb9WGOhMkiBZNPIsaF2km/rVG/qj4mjiLgAt3ysa7lVhkKf/PUIM
	 kCaSgwATr/rhk8LOFBI07UFGImhN/s54QtJKlsRNBpTSwefqfg7+40J3CtZUNLYNzqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795156743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Eqbh8DJ3EiUe6P8Md6ZsdpPrX8H5VSqTZGJU567L8y0=;
	b=LuWRp24TlHKZqwfBW4rM6h1hiSOUWljF4MZR2g+7iM/eixksbMfIlwoX/kgRawle6u3a
	 RpxqhYTcB200LW1m30ZX+TD4l9MV/cYUzWnCCkHvNWfPuUXMP7d432GH7azCMMEDAHbZ0
	 9qKEcFZk5VRJAAYPLRCxxlupPqEoEPkRnu/HgvuQ6uU4Pz5Oud5PkH0508jKVMjqLM/6I
	 /evLliMvMP8twBSw4/yi+vjiJk6pbgWFlTZVM+QGK5BlI7vn1Dl2PtpJquP6Tsk+1L2G0
	 2hsIr1Nw0sjgAPqJ4nS+TzYOhLOaOjW32gR5kLZu6LenS2J/2D7eZSL+gizpVU3sKpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zdqj9coL;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9008F606A320
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 06:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9008F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zdqj9coL
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-49d611f6938so7228f8f.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 22:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795156742; x=1795761542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Eqbh8DJ3EiUe6P8Md6ZsdpPrX8H5VSqTZGJU567L8y0=;
        b=zdqj9coLNFGUlVPrLOfS4W7odFTi08dtCcLIz4eePzIkZZv9Vr535pO31XEZtX487j
         +ksEec3rkJlQeoBTRdQedh5YmB4TibOeAidkOzYJUntXexzn8yhDGVhzVKX7u8qAGJUK
         AV3Od69SK4Rdt/OcjTU9iJM3K2jqtvzfBFV+y9JPLZRgkd/KSl3h3WF+kmkEoGI2Wlz6
         vkOuVhvq9i/aStgwF2XC+2vrSHqQQqUwOBOcyWVi8IL70OFbTPW3w1fLmcIA2ZvuENtd
         cx8eZM7iu6duOuVr4Np5iwvx7aV8dbzgI3voSoqO+wbk4k5/JBqPc3RRJNCvgFwQpIMe
         hB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795156742; x=1795761542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Eqbh8DJ3EiUe6P8Md6ZsdpPrX8H5VSqTZGJU567L8y0=;
        b=mVcN/uoCLfYn5vBW2rAmK/PdqIBTeHWlYjwZlD6cmyWNmo9+aJY4jSLpyQoGWZLA7z
         JdxljCDDrVOzgftvU9WcEo+s4aVUufQruRc4lfgzQipEP/RateaW8qPRFHaZwA5Ft6cQ
         8nDWarMl2MuDYQc9SK5DHQy1TkxseUQDmSS/Gkkzyk6PJVUP1/oSBZ6U6/4cb5JXygvp
         0pKYGugUht7GyzpiMlwLr0m1IVjzdEW6+3WZYTvXA5c6EjldUPW1PhtFfjkWAPONeZ8p
         Vg4WT1JnnzVuxJzhmEfYfa9V8rzNFP+uundNovJrd30LZOT5JKr9fxpq2CTliBevFrk9
         pNXg==
X-Gm-Message-State: APuU4Z8zn61ifpTtoJlYdprejB0wXP8XuSbMk3w2vFc0ZxLEks67xHsM
	t47neNagy2CcyjAGETADbBQNNxn5IjlklhttiadfzbN6tKG4o+WSs2DV3TIoMnKN
X-Gm-Gg: AZFdTZememXpceH96zC29oaZZGADX+lKGA5EuuN5J40Sjs1+7IXkesxfjcVe6VaIyXt
	FT7DLaUzHOwAMLPdbF7BTwcbwzNBgT27NJYqylzGKzsSEzw7NUfJwGVocGfU+86WCNlCqxGsZFU
	PhYKSWCSePU1/XnlRqhskENx0Jg7N7lf68KxkNL4iZTBZypEgBhybFAM8NEL0IED3zzCwSTQSrC
	RS8EEiWr7OLvhScHdWAK0hZYzbNr53Usm95vGjXIxOpCT2S92VCuY22vOdRNSLDjuzZqIWee0Zy
	VbJxefC8wM6wd7so+10zWp4TFQAoiVJbWn+XQBA25xenVgqFLQJzL1mVMwPpkSq89cgZkDwbqjZ
	A52yIULBwVIia4REez67xpbkgInYa5mFcaWLXyxSLkf3P4tXU6KhqV5jLUpWNvr2xEiXALi7Yn/
	xKPwiwFGpEAtmtBO7eFkj4g0+pDsfTxthmW4g/8IvVVSH6hYvZCd4WeCYWFpxadFR90qPrUMAxB
	vA5A9IjE0o/HtBIBqroi2X3la1qbyn8ORP+nTH+yBUxbfRKf0+k133+UDyArKy9+2sj17kLVoqc
	8UaB6grTMKqZOSzbKS8pf7qPvwjf434imCd58GFWfFn3+hVobnThN/Xc
X-Received: by 2002:a05:6000:4a15:b0:4a6:9f2f:4151 with SMTP id ffacd0b85a97d-4aba57e9972mr3275568f8f.0.1795156741524;
        Thu, 19 Nov 2026 22:39:01 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf630esm3685607f8f.16.2026.11.19.22.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:39:01 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v4 00/10] monitor: Decode Periodic Advertising with Responses
Date: Fri, 20 Nov 2026 07:38:46 +0100
Message-ID: <20261120063856.16585-1-rolandschober1968@gmail.com>
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

Patches 1 to 7 fix existing decoders which the new ones use or which
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
   accuracy as a BR/EDR one,
 - the Sync_Handle of two events and the properties of LE Set Periodic
   Advertising Parameters were printed without byte order conversion.

Patch 8 splits the LE Periodic Advertising Report decoding into
helpers without changing its output, so that patch 10 can share it.

Patch 9 decodes the five commands and patch 10 the six events,
including the [v2] variants of existing events.

Testing: I have no controller with PAwR support at hand yet. The
commands were sent with hcitool to a controller which rejects them, so
that btmon decodes what the host sent, and the events and the
successful command responses were decoded from hand-made btsnoop
traces. Every command and event of these traces was also fed to the
decoders cut to every length, in a buffer of exactly that size, with
AddressSanitizer, which found no read beyond a packet. The output for
well formed packets of the existing decoders was compared with the
current tree. I have no big-endian host either: the byte order was
checked with a btmon whose little-endian conversions swap, on traces
with the fields of more than one octet reversed, which has to print
the same as the normal btmon on the normal traces.

v4:
 - Add patch 7, and convert the Sync_Handle and the properties in the
   new decoders as well. Copilot found two of these places, the test
   described above two more.
 - The fix of the LE Extended Create Connection PHY decoding no longer
   adds a size to a void pointer, which CodeQL reported.

v3:
 - Add the fixes of the advertising handle, of the TX power and CTE
   type and of LE PAST Received, and print these fields the same way
   in the new decoders.
 - LE Periodic Advertising Report fix: also report octets beyond
   Data_Length.
 - LE Extended Create Connection fix: report extra PHY parameter
   blocks, and do not report the remaining PHYs as unknown after a
   truncated block.
 - Commands: reuse the [v1] decoder for LE Set Periodic Advertising
   Parameters [v2], print 0x00 subevent timings as none, check
   Response_Data_Length, and match LE Extended Create Connection [v2]
   with the events which complete it.
 - Events: Data_Status 0xff keeps its reserved meaning in the [v1]
   LE Periodic Advertising Report, LE Enhanced Connection Complete [v2]
   is matched with the command which started the connection.
 - Commands and events: report a subevent data command or a response
   report with fewer entries than announced.

v2:
 - Add the fixes of the LE Periodic Advertising Report Data_Length
   and of the LE Extended Create Connection PHY blocks. The two
   problems Copilot found in v1 were in the [v2] decoders, but they
   came from the [v1] decoders they reuse, so they are fixed there.
 - The patch which splits the LE Periodic Advertising Report decoding
   keeps the new Data_Length check in the shared helper.

Roland Schober (10):
  monitor: Fix handle decoding of status_handle_rsp
  monitor: Fix data length of LE PA Report decoding
  monitor: Fix PHY decoding of LE Ext Create Connection
  monitor: Fix advertising handle of LE PA commands
  monitor: Fix TX power and CTE Type of LE PA Report
  monitor: Fix LE PAST Received decoding
  monitor: Fix byte order of LE PA Sync Handle and Properties
  monitor: Split LE PA Report decoding into helpers
  monitor: Add PAwR HCI commands decoding
  monitor: Add PAwR HCI events decoding

 monitor/analyze.c |   1 +
 monitor/bt.h      | 174 ++++++++++++++
 monitor/packet.c  | 590 +++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 711 insertions(+), 54 deletions(-)

-- 
2.47.3

