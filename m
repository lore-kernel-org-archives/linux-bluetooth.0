Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3332399350;
	Sun, 11 Oct 2026 20:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791751220; cv=pass; b=lNZH1fI2342Q4r97HTEs7NA98vTkPDfg7Sg2p5zsdA+IryWOwUkqXtqY9bcfwnR37JnsXrbIwtkAak2lYPX+mK+ZPtA0QxEUGgS4sxX19kSVOv3eFUnBW/KXqtRZXHODrF2uwqkyQ9B4UXgDajwZCV/ssiQOOTbYoPvcFeNRDDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791751220; c=relaxed/simple;
	bh=ukmD7UY1KgSgLwjS2bZUc38GrPhkrvEnwSnjkRobTaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LjKFli55upbYgHbl3CmV7ElVMHZOy69yYPd8rgpyOM+nJR4E7ukWHrHP95dxssF95u23Gzoh3af7w1a7MuhoyuJ9glKObRE6tLZpCh2LI93Ah+5fKrjse3lWL8R173y9cEdJn6tW8ebeAZqb+xqSZu++JoJTaeQ7k/rXpllT6Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=jUCuqW9x; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="jUCuqW9x"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4j2ssw0G5GzyVR;
	Sun, 11 Oct 2026 23:40:03 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1791751204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F9/cicXhU7qRiY69DYDGyomKdFf81NL+xVACvAlGoBE=;
	b=jUCuqW9xTCgqxTI2HdzScoiUstqiW4jMZkK62INT07mxMDjRRRrhqOQxclsYBMmnMZrlBc
	DuD8landjrfnXUEspQEjlm1XCnyE+kNtLtLSI7R0xfM3M/Yik4BUiJCoHnGeMhYHGwJli6
	RHwxxaUt6RSosf5WhtElUPXt4FYA/yk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1791751204;
	b=bjS0d9f+W3HQxZXldBlJIr2TRm099RT8AAq7vI0QmESK5QDWnopJVrKvDWN2DJFzaiABif
	K7x6tA22eMlAvH2PBeJpIReoNI5GUFdkraaZDv6cdPbYRdzJkykPWadYuwhon7QE1EUoYC
	rZLSALcNSpLZimIyA8lbKrLwvUxaLZs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1791751204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F9/cicXhU7qRiY69DYDGyomKdFf81NL+xVACvAlGoBE=;
	b=jfCZK++095IT0gMYI4KqPqETA25FUUa72ENv3Aaa4LrEbR6My3vtd3QQE9Qwt38MZDD63e
	AVCmAzLXLKnYKdgsSCG2csOVFKqv7ceKu2Lft9++bUIwBmPPxgIzESy1+ZyC9MAoZlG00e
	qO2g2nYNcV1MvJ0rT2rATscBNKQveVY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Indicate PAST RX ready to userspace
Date: Sun, 11 Oct 2026 23:39:53 +0300
Message-ID: <cover.1791750397.git.pav@iki.fi>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently there is the following race in BASS PAST:

1. Assistant: TX Add Source
2. Delegator user: RX Add Source, listen(), TX Bcast Rcv State Nfy
3a. Assistant: RX Bcast Rcv State Nfy, Send PAST
3b. Delegator kernel (hci_sync)
     - HCI_OP_LE_PAST_PARAMS queued -> Command Complete
     - start waiting for HCI_EV_LE_PAST_RECEIVED

Steps 3a and 3b are not ordered, so LE PAST may arrive when kernel or
controller is not ready to receive it.

This is why test_bass_past_transport_acquire functional test is flaky.

Solve this by new userspace API: listen() socket signals POLLOUT when
kernel is ready for PAST.

Userspace shall notify PAST ready only after that, fixed in separate
BlueZ patch series.  Also add related iso-tester tests + uAPI
documentation there.

This needed an extension to the HCI_REQ handling, to set POLLOUT only
after hci_sync has started waiting for the PA events.  Didn't see easy
ways to simplify this, without completely changing the
hci_connect_pa_sync() -> create_pa_complete() flow.

***

An alternative uAPI here could be to have listen() block until PAST
listener is ready. The time it blocks is however not well bounded if
hci_sync queue is stuck doing something else first. We probably want to
avoid stalls in bluetoothd, so went with async notification here.

***

Testing: test_bass_past_transport_acquire: 24/24 passed at -n 6
(pre-patch baseline: 6/24 failed). In --btvirt-debug delegator 0x205c
(LE Set PAST Parameters) is before assistant 0x205b (transfer) in every
run. Pre-patch failures show the inverse (0x205b first, or in same
btvirt instant).

Not tested on real hardware, only on the emulator.

LLM was used for triage + patch review + test writing.  Design and
implementation is mine.

Assisted-by: opencode:qwen3.8-flash-next opencode:gpt-6-sol

Pauli Virtanen (2):
  Bluetooth: hci_sync: add request wait hook for __hci_cmd_sync_sk
  Bluetooth: ISO: Signal BIS PAST ready to userspace via POLLOUT

 include/net/bluetooth/bluetooth.h |   2 +
 include/net/bluetooth/hci_sync.h  |  10 ++-
 net/bluetooth/hci_core.c          |   9 ++-
 net/bluetooth/hci_sync.c          | 109 ++++++++++++++++++++++++------
 net/bluetooth/iso.c               |  45 +++++++++++-
 5 files changed, 150 insertions(+), 25 deletions(-)

-- 
2.56.0

