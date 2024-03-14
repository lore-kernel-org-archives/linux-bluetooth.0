Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849D17443A
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440459; cv=pass; b=VXk1r2pjbyMwLKLADr5ssIKy80UniieI40EcyrSNHTr+II4X3cDxP8IJOHceSp2zQm/RQHiPQc+wMbrJNn7EKlVM69HB6kmfFqxsmDp4fpvaX+ioZ0X53UWIH4ujhJOH3mteeckqa88IT3t0xnLSrHOK+7VqtEqHImrmeEhFqts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440459; c=relaxed/simple;
	bh=rzlDmUURTppy7EEU64um4wKSZ2omHZ3vmQYHQGcw3f8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ui4bjzd59tiWbXYuqhDa9De+a6u0zg+9LB9OwE2oWKnKDklQxt+H9GSm6uzbmKrunHBwgZeI8rx53B/glDq4PUwMCrgbyV27OJ0OpEuUf4+vrVFspzqtE4nvlUQcsQD7EK2y37MDivWt8J48AgtUAoZA/oMBXzemels7XQDIpYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=qO/BaIMs; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="qO/BaIMs"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4TwbKW5VyKzyPB;
	Thu, 14 Mar 2024 20:20:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1710440448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6MkMVi9fVFQq+BaG05PwIckJ+EuTlCsvPtUcgq0Sx0U=;
	b=qO/BaIMstCc8KQfQsxITBto/k9OzemPpWXWo787q5LGnRtqqxlXyqWkVb5Pj06BydUEleZ
	W0zAD8RRwLlg6ATUSW5ChYhSUy/ucKcDKBj7/xyu2xRHPQh9MA/kMyMjrT3N5JAT3o7b33
	pQ7N8XQwftoyCXUCmLJb2GBwV8d53UY=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1710440448; a=rsa-sha256; cv=none;
	b=yFRHk3SH5OFYcHX8cGfTqPbdxMTDqgsQt8CuEjyXT+7Xf8dfhIdrfwzaR3Y4kufAeY8aFD
	K1ES5+OOVHn6UvYFJJZYtOu5VLnyObs0v4iY15xfzzLv+gd5357R2/GlStOSjREEnVSGBT
	S8WAqGRTTq4/8bLjvGAYZ9DSru4eKOI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1710440448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6MkMVi9fVFQq+BaG05PwIckJ+EuTlCsvPtUcgq0Sx0U=;
	b=qWEmhQHCBuUAe/ugHQoRht+aBAFlkNMYLKTWVIPPQiJaBZr0vmwVvi7mSHc6n5Gaw0/Jcn
	hvC3rwazJfUi+pmpPNmerDTKiiOVzKqzyTLKVpw9OXeYTUjzC4nNG0J+PnKTET437j6TNZ
	LgBVE0whKHgHzQfETy/PrqZjNX81tyQ=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 0/5] Bluetooth: add TX timestamping for ISO/SCO/L2CAP
Date: Thu, 14 Mar 2024 20:20:16 +0200
Message-ID: <cover.1710440392.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for TX timestamping in ISO/SCO/L2CAP sockets.

These patches allow fixing / working around controller(?) issue where
two ISO streams in same group get desynchronized. It also gives user
applications the best latency information as available to kernel.

Also add sockopt BT_NO_ERRQUEUE_POLL to optionally disable POLLERR
wakeup on TX timestamp arrival, which is mainly a nuisance in the use
case here.  The alternative to this seems be to deal with the POLLERR
wakeups in BlueZ side, but this seems hard as it's always enabled in
poll() flags so not clear if anything else than polling at regular
intervals can be done there.

Pipewire side:
https://gitlab.freedesktop.org/pvir/pipewire/-/commits/iso-ts-test2

With this change, https://github.com/bluez/bluez/issues/515 is more or
less fixed, and the sound server can figure out the total latency to
audio rendering (tx latency + transport latency + presentation delay).

For ISO, we can later use LE Read ISO TX Sync to provide hardware
timestamps, but this requires figuring out the sequence number
synchronization first.

v2:
- Rename *tx_comp* -> *tx*
- Add hci_send_conn_frame() and handle all link types
- Add SCO timestamping. Deal with no flow control -> no Num_Comp_* events
- Handle HCI_FLOW_CTL_MODE_BLOCK_BASED
- Add BT_NO_ERRQUEUE_POLL

Pauli Virtanen (5):
  Bluetooth: add support for skb TX timestamping
  Bluetooth: ISO: add TX timestamping
  Bluetooth: L2CAP: add TX timestamping
  Bluetooth: SCO: add TX timestamping
  Bluetooth: add BT_NO_ERRQUEUE_POLL socket option

 include/net/bluetooth/bluetooth.h |  10 ++-
 include/net/bluetooth/hci_core.h  |  12 ++++
 include/net/bluetooth/l2cap.h     |   3 +-
 net/bluetooth/6lowpan.c           |   2 +-
 net/bluetooth/af_bluetooth.c      |  72 ++++++++++++++++++-
 net/bluetooth/hci_conn.c          | 111 ++++++++++++++++++++++++++++++
 net/bluetooth/hci_core.c          |  19 +++--
 net/bluetooth/hci_event.c         |  11 ++-
 net/bluetooth/iso.c               |  32 ++++++---
 net/bluetooth/l2cap_core.c        |  11 ++-
 net/bluetooth/l2cap_sock.c        |  23 +++++--
 net/bluetooth/sco.c               |  27 ++++++--
 net/bluetooth/smp.c               |   2 +-
 13 files changed, 303 insertions(+), 32 deletions(-)

-- 
2.44.0

