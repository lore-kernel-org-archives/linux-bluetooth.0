Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFFF395ACA
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788978533; cv=none; b=Hk2K6AWYvLNch5APOjrWVKQbgMp/5k7hCrZwNT+alTASYMdtHzmxrUJt2S3PfRawyza8efhhQV4p/t/Ao1GZiHBvJ2fv0mEQLGTXYDhxInk+5/hNcLYcr2CIZrEV32ZD1PAjvv3HKu9uxTNjyJp8zqoe9L16OoehWtbt3n45TbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788978533; c=relaxed/simple;
	bh=mYYL11incPr1u9wQPG2rIDEaRpGtoTfDIhGaeaEDnGE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=W6tUOnvp+zIzL0tZnr8l5mcy+IuVqxe/mmRG3vdTz+BbTr+HwGaU0csdrznPjUlInXbsoT2wMgntFPFd9VZxDKpfGjmfRhLldpxar8ZGoKNbpu73Uw5Yj6FvVFCJUUADLrZwFvYwI4x9dkxZojGJJjWLazyTL+fMNVrextxI6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loMVFSn+; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loMVFSn+"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c8319dd4a5so311454e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 11:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788978531; x=1789583331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dKztGZHJRwPWuWMWubTCpsQFjwYGHpsjbtcNZ5Xg5UQ=;
        b=loMVFSn+f5S+5buHRgAat/EkEJns+X0EOtW1hK/BXmCui2+FKwcIYapR+0quwDAwIm
         SiBGBaiyJubM0qE9tlYQkWiwfPx35rNlRdJ+pTJ2vsCL5O0tlDxZnDhxm+J/Wumm84py
         vnMNYfuNfh6LahBiMqL3FCLk//LgX+ZP0DZS97pJwtvjQQgKfORDXZE/ouuUp4mdS0hN
         B01vLcnzFsBtywgM96YNj3ryJi/ttTKL2uIc4zfVSVGNeZ4WZwi7YJAHXfxqISPTXUZp
         yC5D5eu6JVXgWNG5up37n9ED/fayOG2BJRwaX5vMqoAG9CG6UFLNB45uB8ndRpqFyJk0
         wrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788978531; x=1789583331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dKztGZHJRwPWuWMWubTCpsQFjwYGHpsjbtcNZ5Xg5UQ=;
        b=LQFtwKXeMWDiYfBLH/HFgPCCO41dcuCKnZNXOzruyxpZqOn2ggcdqx3GQmIwVMDv5I
         uIM2oFFQsXet+7khK7dC794Llq6eJT9cDNveHVKIf7XLOAzkdKMzeR4t3QhKbi+kH7An
         xMafj6FSRPMwRub+eGFGT95ksjxtTO9jNaLa4BuGXrQb27gPuw3ShCtL7zePTkej2TrF
         5Hhb+a01+FyttXNIzm6Ev/f2A8Ts+iAtPfZ3F/0nt+ZPbweoGOnSln3q8ofR/6p9dVhb
         Ukq174ya//tEfyXK19vPpzVz08ellrCUV1aPdw03vp0BCZmw+n5/CfiuppbHcdJ3HsIV
         UFkQ==
X-Gm-Message-State: AFuF++nDCMt+rm2XdYEuYqN0f5AOvXuPHOtpQFsXs7mM2KE71f18GIIj
	iWUmOgaEN+yjyLYO0+tx7/Je6y/JiDRETe9109QGIP2O4nNYKXvivr2q5R4v2xxF
X-Gm-Gg: AYBFou1ai32bqBT1IZL0+p+PWmdmZCFZ1k1a11SHHTUoTFB9JdLWXUNq9mvFdCjRri0
	D5h/x6kKlo+pxupIkBIwPyuEx6sBt6SSEllZU19Rby2MzOSiIHVeVkX0mEVpMvJ0eVRmjmmmths
	A41UeMVdL+YN85vX+rVRtu3F/Pz8dWm5ZOruG68k0mco3fwqJh3pN6rhsqrNFOd19D3wgkhyrEG
	P6kq7NY7BWWGkXP3C1EpIGIGByj8jec3X7vbPmOn5On6VkGbiPJvflLI0k8Jo68Mj+mX9VSX2sU
	1pzcUonilT+TfBZSrgMoMl2/QE/PiEjSXM1FbFWfU9pa3Uy1nFLseQAo4XcofGtXPxHjOxd9gCy
	Z5y/bEscNXNDDFLFXB7ZlPO7+qm3guyKdFq1ARpIhWsp+MGr/TpIJz3AFIr8KGGFygJR9vLNqjN
	TnKSomh79OKq0W73AjIXYKzW1FtOiKPMjlRInOhTEYgZH6uJxzNbnaHywjytdAlCMyWKX/hRu6v
	Gsggsmi1A5RuFGtAMtZFwrdNTZPA9me3/gEwE+cdMBaxO1satQ8tAXndJP1Se2LLw==
X-Received: by 2002:a05:6122:341c:b0:5bc:42be:f758 with SMTP id 71dfb90a1353d-5c833669be9mr2460956e0c.3.1788978530451;
        Wed, 09 Sep 2026 11:28:50 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c81c506f31sm5399388e0c.11.2026.09.09.11.28.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:28:49 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 00/10] monitor: Reference request frames on responses
Date: Wed,  9 Sep 2026 14:28:30 -0400
Message-ID: <20260909182840.1289776-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

A trace shows every request and every response, but nothing ties the two
together. Finding the request a response belongs to means scrolling back
through the trace matching identifiers by eye, and the time the other side
took to answer is only visible by comparing timestamps by hand.

This series makes a response name the frame that carried its request, and
how long the response took to arrive:

  < HCI Command: LE Set Random Address (0x08|0x0005) plen 6 #76 [hci0] 3.175055
          Address: 00:11:22:33:44:55 (Non-Resolvable)
  > HCI Event: Command Complete (0x0e) plen 4               #77 [hci0] 3.175394
        LE Set Random Address (0x08|0x0005) ncmd 1 #76 (0.339 msec)
          Status: Success (0x00)

Patches 1 and 2 cover the commands answered by a Command Complete or a
Command Status.

Patches 3 and 4 cover the commands that are only acknowledged by a Command
Status and complete much later through a separate event, which is where
the delay is often seconds rather than microseconds:

  > HCI Event: Connect Complete (0x03) plen 11              #27 [hci0] 6.178055
          Request: #12 (3003.000 msec)
          Status: Success (0x00)

Several of these may be outstanding towards different devices at once and
need not complete in order, so they are matched on the connection handle
or the remote address rather than on the opcode alone.

Patches 5 and 6 report command latency in analyze mode, along with the
number of commands that were never answered at all:

  Command latency: 0-215 msec (~55 msec +/- 70 msec)
  Commands without response: 3

Commands completing through a later event are measured up to their
acknowledgement only, since a Create Connection waiting three seconds for
its Connect Complete is waiting on the remote device rather than on the
controller, and folding that in would swamp both the average and the
deviation.

Patches 7 to 10 extend the same idea to the protocols carried over ACL,
each of which pairs a request with its response through an identifier of
its own:

  L2CAP: Connection Response (0x03) ident 1 len 8 #2 (1.000 msec)
  ATT: Error Response (0x01) len 4 #6 (45.500 msec)
  SDP: Service Search Response (0x03) tid 5 len 5 #8 (12.400 msec)
  AVCTP Control: Response: type 0x00 label 7 PID 0x110e #12 (23.100 msec)

None of these layers had access to a timestamp or a frame number, as
neither is passed down from the HCI decoding. Rather than thread both
through every protocol handler, the packet being decoded is recorded and
picked up in l2cap_frame_init(), which every frame passes through.

Requests there are keyed on the channel rather than on the CID, because a
CID names the receiving end and so differs between the two directions of
the same channel.

Nothing is printed when the request was not captured, so attaching to a
system that is already running produces no extra output until a complete
transaction has been seen. No existing line is removed or reordered, and
only the deferred case adds a line of its own.

Setup Synchronous Connection, LE Create CIS and SMP are deliberately left
out. The first reports the ACL handle in the command but the new
synchronous handle in the event, the second produces one event per CIS,
and the third has no transaction identifier, so none of them can be
matched this way without being wrong.

Luiz Augusto von Dentz (10):
  monitor: Reference the request frame on command responses
  doc/btmon: Document the request reference on command responses
  monitor: Resolve commands completed by a later event
  doc/btmon: Document the deferred command references
  monitor: Report command latency in analyze mode
  doc/btmon: Document the command latency statistics
  monitor: Add request tracking for the protocols above HCI
  monitor/att: Reference the request frame on responses
  monitor: Reference the request frame on SDP, AVDTP and AVCTP responses
  doc/btmon: Document the protocol request references

 doc/btmon.rst     | 111 ++++++++++-
 monitor/analyze.c |  99 ++++++++++
 monitor/att.c     |  69 ++++++-
 monitor/avctp.c   |  24 ++-
 monitor/avdtp.c   |  24 ++-
 monitor/l2cap.c   |  76 +++++++-
 monitor/l2cap.h   |   8 +
 monitor/packet.c  | 467 +++++++++++++++++++++++++++++++++++++++++++++-
 monitor/packet.h  |  14 ++
 monitor/sdp.c     |  21 ++-
 10 files changed, 891 insertions(+), 22 deletions(-)

-- 
2.55.0

