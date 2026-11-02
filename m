Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656501;
	b=Q5uxoE5YSNJAREX9AJoGXu4FQDQlTOP3Lsw8xSHL6rTEawj1BGrk+LbU3EaZDrpQ4cbp
	 UK0npPzYFVha9zVvC/qX7Ji0fQPD89j84LstNBsLWG95uW6xyKSVSxNwuTbE2x6CV/LW7
	 62/L3XS/vQ1v6FWBVZq5cJHUuBOZUmhqW9mgIgZ7YDncDJjO+VdE4JcF1b9F/Ez6b7url
	 L0pm0aFcdGhbVbyqnU/YTuX27/3mdsxsdEsA/h4oohYrDWwe9l7B/ox8wXi2G24L2AVov
	 wRKpHribqNSXr8GyNJyV8WPOXxOMYQ04C/PLjhrboomHniYOJ0OA/xP4M207UN1+3rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656501;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=g+UsAn/ald9LdimUJXag7AX4efSpc/9TAbioHt+NEho=;
	b=QGWQsWEvfaewtg1ThiQ6f1QrORSzkPV0gcozgiVRFqolMoYmfNGfj2+8j9AOT93i7Wn1
	 oi5ALF4Hgcwcx0aoHlnkbvYUm2BzDnS/BjOOcNNuGJe3N5X3jJWy297xsjBRCSB9NOo0i
	 CPrfBIP1JxcpvkKLnTQFcf4Z2Y6sz6ScFEVHW8IiciOwN5bw+59my+Sl0KuqMLA/2PmeC
	 S3ztJ9cZdXRW71EAMVIhrPvQlnXzzCh2kj151O2n8L6UZ8nJA2YohFseu5Ic+aYWGyF7c
	 wMTpostZ6yvYQ+/BIos0Mrtj6UsDRU/VJvBMwiqIhXIuTsZn1GIZ1fEsl8u74nskErQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rXs6z+qa;
	arc=none smtp.remote-ip=209.85.217.54
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ECE606A324
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 21:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39ECE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rXs6z+qa
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7ccb2ffe333so2159201137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 13:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793656500; x=1794261300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g+UsAn/ald9LdimUJXag7AX4efSpc/9TAbioHt+NEho=;
        b=rXs6z+qaaR6ltWn+f9UvNfdQyniRiD4GcEyT52y1j6KnjdA+vUnwiRJqzh2yGweeZN
         vUZxmrFyyjBXw6WiTUH98aBJp5ADmuFY49dTnTi5f2ThRRpPV0HxIEKwk8y2CAFhUjWt
         vLvpuI5UODTrQoOtedTp1O6SDYr6n0cC6vyy1cwiFnmPZ56aHDKZv2Ps1XN0QP5pE+Hz
         eUv0ruagpPPz2KtRIwqvPkJRlpmahtwzI5V0mnPZBT7lszUduQ0nyv0vaLZLPUTfv9pH
         DLdgFiHii4P5AsDNNX9aHh6ubPEeAOWJGj1RkKiQuTqy4n2Tzzn/wAgXPSQpPfWaVklb
         K4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793656500; x=1794261300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g+UsAn/ald9LdimUJXag7AX4efSpc/9TAbioHt+NEho=;
        b=Bo80h8nEjW9hQKndaJOkwAc9a0BPYOK9NwKFPBkhGTTOVKeXgD9+Xb+0EenQPYg1Me
         HV5ZOAS42LWlZGw4wuh8sSMgtXH88hZAPmDchM9BLODb+MhHujxb7Bbe2PCVUo5MvdGx
         C6hgA/prp2ViqFKE3Q4ILCaZqIuzgclB7KWFkuGm032q/cCbXTziDTws0cSyKpO576ns
         Z2sssjubcJa6E98VMejGcabHlvzDtlG0I4xM34mgezFB5/Lcv0vCulbNczTHl/mzzXJ9
         tA1K5kYFPv0aVEZYlXHtuM2LPCzqE42CQl14NrvTJithafVrK1Mr5OQpluTXlJ0db7OM
         gcDA==
X-Gm-Message-State: APuU4Z9LZHPkRh2MLZrEWhEP1UPjyTzBgr00C24F/ArgZ75ILG8MR3fN
	Bqd721D7cbt6E805pta5J8jTQBAFuSCLCDUKQ0agrKxGwxFwJxhM3uA9aCZVo/zV
X-Gm-Gg: AYBFou3ssO72Q9kVnnzcvN2J4e51ao1Fal8M1pnL3S7UBc+de98+7z0fiju4W6H2qY+
	pg1vO4yGoFTcnJBQJC/TGpsoXb/zhKPc5VC8vZN8AGdkaMwWJQxUalLcUrXjcSDErKBXPNtJC/3
	AagswjwD3xEaAfhjc9RbVSy05JJx4SRsHwYPnCgpY2oW9MSHfuzhrGD/c8Moa0+Tv3BuqKkKRap
	oN2NJO2Eq8aUFSbo6RELb0LZyjmFnBwLGTca1HEDrYqZ69xJ3vuFS8BsqEaiGl9yag5suJUr278
	/BIe22JaJH8ilIRRt2Hz4J5D/KcpGvKkEoBk0oWaGBEJ8URN3ikFjCluzBFuZcCkK979ZQfL89K
	lzmWwpStia1KQVN2fGp/aldhO1FsELInYRCq1V1V+d0gVjy+tYZtjRBRNb2xOZ+gS1Jn2P52h3n
	asMromV4+n0LGTKZk0Xlg5tSWM9+I3nsux00Htw6vgMscve5IbZ6CbL9L4a/ygKGdrQKop9gI18
	P44rOH6520t5RxYjskmkU5h4gJxqnyuhM2kpF6t3KYSiezg//g8GPH14KwLwcB+8pcOuQmKIvNV
	Y6+cfNPGelcwaqGbkMa0YUDLoUDIx9r8EnDxBEt7u/PZPSWlY7BKWWAs5QU3YI80ubLIzPKHUvK
	iKZHQAe0pBG6VTplgT6B6NiKB0FoZKczXgTROXcsv7n6CssWZak20zLN7mCHXxDqUUCSoffSqhP
	xjm8Q+uDwnmJqfCNHuf3bTQXp0
X-Received: by 2002:a05:6102:a4f:b0:7cc:94e0:ad23 with SMTP id ada2fe7eead31-7d072d4a990mr4993602137.31.1793656500132;
        Mon, 02 Nov 2026 13:55:00 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d07738ebf2sm11066184137.1.2026.11.02.13.54.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:54:58 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/6] Fix linked transports of an ASE not enabled yet
Date: Mon,  2 Nov 2026 16:54:51 -0500
Message-ID: <20261102215457.2553416-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When acting as an acceptor, a remote initiator may enable only one ASE of
a bidirectional CIS first, e.g. a phone in a voice call enabling the
Source ASE of a headset before its Sink ASE. Once the CIS is established,
the transport of the Sink ASE, still in QoS Configured, was set pending
along with its link, so an audio server would acquire it and either get
NotAuthorized, failing the working link as well, or have it made active
through the link while its ASE is not enabled.

Likewise, once both ASEs were acquired on their own, disabling one of
them set the transport of the other idle and disabled its ASE as well,
stopping the other direction.

The first patches add a functional test reproducing this, using the
Desynchronized property of an initiator in testing mode to enable and
disable each ASE separately, and the last ones fix it by only updating
the state and owner of a link once its ASE is enabled when acting as a
server, and by leaving links acquired on their own, or desynchronized,
alone when a transport is released.

This depends on "test: functional: wait for BAP transports to be
configured", which bluetoothctl needs before it can acquire the
transports of the test.

Changes in v2:
 - test: functional: Cover enabling one ASE of a bidirectional CIS:
   drive the tests through bluetoothctl (transport.desync, acquire,
   release and show) rather than calling the D-Bus methods directly,
   so the sequence can be reproduced by hand with the same script.
   This also fixes the tests failing on setup with a NameError, as v1
   used a test helper without declaring the dependency above.
 - client/scripts: Add bap-duplex-lc3.bt: describe how to enable and
   disable each direction on its own with bluetoothctl.
 - doc/functional-bap: Document the duplex unicast test cases: list the
   bluetoothctl commands in the steps.
 - No changes to the other patches.

Luiz Augusto von Dentz (6):
  client/scripts: Add bap-duplex-lc3.bt
  doc/functional-bap: Document the duplex unicast test cases
  test: functional: Cover enabling one ASE of a bidirectional CIS
  shared/bap: Add bt_bap_stream_is_client
  transport: Don't set linked transports pending before they are enabled
  transport: Don't disable desynchronized links on release

 client/scripts/bap-duplex-lc3.bt |  53 +++++++++++
 doc/functional-bap.rst           | 112 +++++++++++++++++++++++
 profiles/audio/transport.c       |  95 +++++++++++++++++++-
 src/shared/bap.c                 |   8 ++
 src/shared/bap.h                 |   2 +
 test/functional/test_bap.py      | 147 +++++++++++++++++++++++++++++++
 6 files changed, 414 insertions(+), 3 deletions(-)
 create mode 100644 client/scripts/bap-duplex-lc3.bt

-- 
2.56.0

