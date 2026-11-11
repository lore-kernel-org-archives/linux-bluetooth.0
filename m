Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414335;
	b=psZ4uuP5FOXC5PPAK+AcCpdziWdIRDLH6BOLgwmTIhSdxcNaH/FcpPHO6mUTUD+/QJNa
	 zc9vmQKjL8wIxXXxKJAzsnjWquZbeifwdcHdAi1b8o2p+O8G05eQ0skGsZtT+fmYfx+fZ
	 a2l333AB6pMglEPO18HPw82yPaqLBYrx8X0dMaR5HNTXmIWzEOQwNxKHuSpdYZKDiNE/t
	 O8B3bDG+dOEzAGPaFZJKt+/Vx5ROcAO7Euayi7L7p6AEFjXNIuvjDZ/PNYp24oQ0uiSwR
	 +Mv0kxOxQjpaOiqWiFCbv3yAn15++WXsup9jIucuyr8AXWie5nkuM4ZCmi4TWmiiG+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=1irliHIJgX19A/1klA9tNsUdzs/fzpPEIqu1tBsZdjo=;
	b=zFZ1S9s5CIPUT/f5zgYxCWQansvg7tjU+VJobpC7dWhHplXl67FG7G0s5py8e3MTPvyq
	 gydNs9UZKEzuDLY2b6EwF6JthnP63lY3ggzFOKADjTy8TuGa3xL/Nt5JXkC3UVaiBR7cT
	 0uMKvqY5xuItu0s+YqJxT0ie7hZrWyGvNAq2UveU1Z5xFDkTWcO9dhTBILlmrIVoy9nTY
	 /jpaYFca1AnlWhRvFSE1DhIA8YSfYlDn+nNVXCEcCDhhgY12Pqyz47tUW6kQSgddSOC97
	 iwulX65pKi17QiTSFBbzKeX9Q012RpSOnaAEsrjeVpw1SYo48eTlPhuJ8iuS0kXhojg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Z/7lv4rN";
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C353606A326
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C353606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z/7lv4rN
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9906034086cso817047241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414334; x=1795019134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1irliHIJgX19A/1klA9tNsUdzs/fzpPEIqu1tBsZdjo=;
        b=Z/7lv4rNa7/yy9x0s42KLGNAFDdQR+/bY5Lq8U87JG+cvrNf5UblZmHXPR2sdiAPZ0
         QprxkQM9y2JtK0F8X8h/L8P7lzjGS1A+q0lIGjDbu4E5x7qqVWjZrBAPJs0G5YlF+2m/
         GxV+Vpa+pWoiH9pGzsYMWvXYKg9ev27DoEPgba9G0FWyFX8HDzMK6MgVeJJBUbegosNN
         WpwtXjLuMennENSfp4BadXZqe5HIqGkjyewGjJVuq5XxvZZky7rTqoLs5uab4xAlr+GM
         u+eiKzWsY90QKWqMjHNq8v/E9mEXu2xMLbK6bMhIehd1ns0HQpqCHBp5VYuYHVcGZwz/
         Sh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414334; x=1795019134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1irliHIJgX19A/1klA9tNsUdzs/fzpPEIqu1tBsZdjo=;
        b=QH0Wo9fvzyd7mVQcNAfo6sELacT11ybfvhEuw/vEyyRv8l4xH2/fy4I9Pa+534upl+
         ym+TwjkoTjjzQDYH+sPHEu8gMQtAoruTsNNq9yfPeRgKJmV8AwuoGFv1yKbstKQeI+q3
         Qyw/73w5a6VYjnUWqcHPXdgmH9MtGjT9qjwaX8bVknpV9rqegoxrPLGbwRxMHwrw11oe
         ztNnbMODB4P1vmGoYU0lgWrBF3EdL3spNwEQx+VEH0pASV52s+ZqRHrbXbiGlKPzUB6/
         ARanjzULwQ4yN4Avb3a0BfhCNxxHn5XtSjau7TlcLPTMgXp1wWsiVWM9irFeLJ+BZRzR
         ogUw==
X-Gm-Message-State: APuU4Z8VHNQgH3O+ar/KXZtDDNwrJpFT+wjLeKjxMVoVbi3oiRAazi/y
	nzAhCmzaaO6hamp26wXBoemgqXaxu2LFhGb73RIUHLd8lHWAoM6XBefHhXpOjA==
X-Gm-Gg: AYBFou12lrGS90+Yu31GduODGCV/1xdRiOPP+zT9ddZ//TIBjUti54Ctf9gceQSO+zm
	Q8rHlEfzu/DESrzGifzN5AHF+ctiUIRU81Ko7mrqIu8u8jerIsYdTyck8U0ZHE+fsItuMDuavwO
	3d/XaggBxByEOZVNmdp/2IFm7aiqM82gTHtZb4Q69AYz7ZK1uCjwfCaJ/hwxnGhzpTIF7lkL5tw
	U8EimcV5KfCK/jYJoDHQ1H7OOioG46f5XUElGY3qw8sKyQJZVYbtH8oqjVtv04eKvA+VK075990
	RO3D/z6FwqHiqsMaHHkaHO11pyImdPQ3t8S/lB61sjUCwl7Eojot2hBMqpU00DtmwzH0eavmi+z
	IqUX6fxLZm/L2hbz4zPgfPL8ylGBEnzpX83XZpvqo/u+OHnPZmCRoYNmztUxlDoXVDlzkrUeLZS
	OusvnrXoFwXlVtpMZZaL3Jz7nH/G9DHdQRTPScSxsMWICSHZ84sRGm4G/Abqgzw8v3+JENHXC3F
	V+Pl+4msC4M07NLeM9WBrcaAV/V9MiBRgw/0JpJwkGyS3Xr86hptQAe6OnurwypnaVBQqwO9KGH
	O/C5RGx4ztFDP70AsJEWKR/7NYVzJ8YrT3/rQ9ybkHaaIfsqfi6zWkT6cn6+vN/Nfw8iQN7TTTl
	Afi5kRjcpfh3aisW77cglZzQVA74dMWtQLHut3QQsyW4e7MY2TRA1D6bfu3axRKqWzj1wkVm7HA
	eJKaU=
X-Received: by 2002:a05:6102:f10:b0:7cc:ccb:ce5a with SMTP id ada2fe7eead31-7d505805529mr990650137.28.1794414333997;
        Wed, 11 Nov 2026 08:25:33 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200004e7sm4269659241.3.2026.11.11.08.25.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:25:32 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/4] shared/bap: Don't disconnect a CIS still used by another ASE
Date: Wed, 11 Nov 2026 11:25:11 -0500
Message-ID: <cover.1794414122.git.luiz.von.dentz@intel.com>
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

A remote initiator, e.g. a phone in a voice call, may enable the Source
ASE of a CIS shared with a Sink ASE and then switch to the Sink ASE
alone. The acceptor disconnected the CIS when the Source ASE detached
from it, although the linked Sink ASE was still configured for it, and
as the initiator does not request the CIS again, the Sink ASE was left
enabled without a CIS and the voice stayed silent.

Keep the CIS while another ASE is still configured for it. Unit tests
cover releasing an ASE of a CIS kept by its link, of a shared CIS and
switching the direction, and a functional test counts the CIS the
acceptor is asked to accept.

v2: Also tell the streams using the CIS of a linked stream when it is
    lost, not only the ones that hold it themselves.

Luiz Augusto von Dentz (4):
  shared/bap: Don't disconnect a CIS still configured for a link
  unit/test-bap: Add tests for a CIS shared by two ASEs
  doc/functional-bap: Document switching the direction of a CIS
  test: functional: Cover switching the direction of a CIS

 doc/functional-bap.rst      |  37 ++++++
 src/shared/bap.c            |  84 +++++++++----
 test/functional/test_bap.py |  68 +++++++++++
 unit/test-bap.c             | 227 ++++++++++++++++++++++++++++++++++++
 4 files changed, 391 insertions(+), 25 deletions(-)

-- 
2.56.0

