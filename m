Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E43A5E09A
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 20:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709150642; cv=pass; b=cL0434zXdPL+JPvs9OMCLrwxNS3QuOhyCHPBOWsprySwV4PpRUhriRJ2+YGNM/yHei4Rpc6fQMUqtrBMwoIzq4LVMJ9nCO86YKeofYCUrLn1EhfxMAJyKr/BGvyJsx5czeyUC4zRJurCZCElzCPdzw0az9uEd9/onEJdPo3R610=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709150642; c=relaxed/simple;
	bh=iAQ9LFqWYtIT8nPN25AlTpXV0qfnN+SfOt494IAaJyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vp3W71O/a7LXPw6ckgXwYRvL7tZy6GS1DxvieBwgNlK5N0VFJX/a+77hVCnybprEYIHtnnGRXT6xHO7qx/X8BX7SPyfCJmNS7IeM+Zb16ntnr/QF3U4aSRV49QGXRpWI8nBNCVxlSbpwV0joE5hKsLeUQL47LOX6SJy3G16aVt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=MWrqZJ0i; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="MWrqZJ0i"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4TlQKS2p75zySM;
	Wed, 28 Feb 2024 22:03:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1709150637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H7BObFnH+0nNNvg59Glf5G4tUhFrpqy4SlbztSUmr30=;
	b=MWrqZJ0iM9M/xfS2AQVm+W1h7hYPnHGFpVUAU13vfv0V6JesZiH7y6bdk9A1i1DBNGGPv+
	PJBR+k328w7GI5ODVAf4Z6GX4PSdYuyEAx8jO+HHLw6UVzgrZoNO5GxxDgRmJsWI6VvM94
	6AewSP5zlMJTvPlSNt4Bkmy63YyGfTM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1709150637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H7BObFnH+0nNNvg59Glf5G4tUhFrpqy4SlbztSUmr30=;
	b=HZesbeuBatqnoXdRP64uwQOHy0TJgyGOhX+tz56wW2ZKNEe4kvi5+dfdRpNvM0m9C6sFNd
	BX/buTJuc8g5sJPnSF5jB2+N3i/N/Fe/6hoj+B0aeU208WDCIaLDqQ+mR375aBHX465yfB
	3tyMzRZkdn0FR6OIVW2zc2igC7L2y9c=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1709150637; a=rsa-sha256; cv=none;
	b=TO7wzvLbGgTDB67viVISF2FNvuVxDf2egoZlgcilSMfehDczl6OkjMRDN+8jXrctzKnBKH
	CLw46DbWThWp1F2i/qCxMVn15/ozMRzDrrGGD4T6jMQDk9zvCyG2Oy7ZDPAgCZASyjPY4+
	by/U086wE0lp5ozq54jLJ360qgLNrKU=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 0/3] Bluetooth: add transmission latency tracking for ISO & L2CAP
Date: Wed, 28 Feb 2024 22:03:38 +0200
Message-ID: <cover.1709150574.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ISO/L2CAP socket ioctl() BTGETTXINFO which informs the user how long
it took the kernel and controller to complete their sendmsg(), and how
many sendmsg() are in socket and controller queues.

This currently provides information of the latest packet only, in
principle there could be a ringbuffer containing few latest packets, not
clear if that would be useful.

These patches allow fixing / working around controller(?) issue where
two ISO streams in same group get desynchronized.  Having accurate
knowledge of the packet queue lengths, user application can drop packets
if it detects the ISO streams are not in sync.

Pipewire side:
https://gitlab.freedesktop.org/pvir/pipewire/-/commits/iso-ts-test

With this change, https://github.com/bluez/bluez/issues/515 is more or
less fixed, and the sound server can figure out the total latency to
audio rendering (tx latency + transport latency + presentation delay).

For ISO, this can be changed to use LE Read ISO TX Sync, when the clock
and sequence number synchronization issues there are figured out, and a
quirk is added for controllers with nonfunctional implementation.

For the L2CAP latency, I'll need to think a bit more what is the audio
use case. Motivation was that AVDTP delay report values appear to be off
by ~0..40 ms compared to observed audio latency and this amount can vary
per connection and time, so not explained by unaccounted code
algorithmic delays etc. Currently it's not clear if there is relation to
TX side latency, so it may be down to receiver side implementation.

This needs a bit more work to figure out, but the L2CAP patch is anyway
here.  Due to the possible fragmentation in ISO sendmsg(), it seems we
anyway need the tx_info_queue thing and can't easily do it by counting
packets, and L2CAP required part is small addition on top of that.

TBD: iso-tester / l2cap-tester tests

Pauli Virtanen (3):
  Bluetooth: add transmission latency tracking for ISO and ACL
  Bluetooth: ISO: add new ioctl() for reading tx latency
  Bluetooth: L2CAP: add new ioctl() for reading tx latency

 include/net/bluetooth/bluetooth.h |  39 +++++++++++
 include/net/bluetooth/hci_core.h  |  30 ++++++++
 net/bluetooth/hci_conn.c          | 110 +++++++++++++++++++++++++++++-
 net/bluetooth/hci_core.c          |  14 ++++
 net/bluetooth/hci_event.c         |  66 ++++++++++++++++++
 net/bluetooth/iso.c               |  58 ++++++++++++++--
 net/bluetooth/l2cap_core.c        |  12 ++++
 net/bluetooth/l2cap_sock.c        |  50 +++++++++++++-
 8 files changed, 372 insertions(+), 7 deletions(-)

-- 
2.44.0

