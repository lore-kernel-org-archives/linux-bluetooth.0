Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE3E3AC0F
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Mar 2024 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709410072; cv=pass; b=ARpDx8xnt5C+tCM6e6cf8byn+JmZhaxgS7tO/0ih0CE1p1jU6GVZQWM817i9eDgT35gStVmsBqso5ic5iUhJyog+/0qNAscCcPMN6kS7jaCpbQ9fwkq4pldYbU4/XVAleWnffxhfHGaSfbyfhH1wBg4apKQpboKSJFlXjJ+JAcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709410072; c=relaxed/simple;
	bh=psFKxsMfU1g0ogncJi0o+QZ9IC7wMORshlA6722Sdk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L2SLBK9I+dWRVFZvILQPbTXyj4XqmadcZrlu9fX6W7ae3ZDPkkt4Q3cod8SytZ+LM03vQV9CEzzz4ZyDikDE0TWeB8ZKPgDavkhDXufLZWWhKuepzFepQnnwda1rVxUxGlYgY+SNJgzXURJaRxffwukApX+itX6LzPLY0lvEvGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=enytfx8N; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="enytfx8N"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4TnGGV0vmGzyxR;
	Sat,  2 Mar 2024 22:07:44 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1709410066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QN6myTiIcoyY+Z1fB22n/nBwEMBaqmYdHkyPQAuU8qs=;
	b=enytfx8NlPQNPpWzBYVvJKdQKLpC73fWWKS3sN1b021nWEIsVxSmAMT6nhf6xskeZSWi65
	8d/I+r/45wfbfKoG2YV1FNg4QQQEs6F6Po9+8WzTRbkBv4pF0HjXJspEeCgQL2QKu1kqzL
	ea7VHX0emvhgIYHJlQ7SnoPkvUezc+w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1709410066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QN6myTiIcoyY+Z1fB22n/nBwEMBaqmYdHkyPQAuU8qs=;
	b=eyYht/qiNYk2wRs6EZV/gmTjKaXq6PhDga/KQJUOQj8s6J5qon0nJveLsKPOYnJTmSGCLN
	/EAAKcfWVNMzH6u9V0RSdGYk9TPZZdJnoN1NuQSsrmMntT5lJWO4omgENIEW+ru7JXck5Q
	0Tvu5QKxiAQyYCFRcF+Iu/BHtsBwNKc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1709410066; a=rsa-sha256; cv=none;
	b=Aa+sGyCWTc+VOj92e4Bmpv2ejjRfUAZSckKJOhvpE2ooWprk8Xb0VhGj7W6/kmA116AnlB
	MbqatV0N8Bi12w1ljIkBC5zXsFCJY+d+aMk7XNFKy/GmTYPzZ/bFh6BJfImjD4WYY7v38L
	r8eSUjDEW8nfI8o5aDHfOV1pUrgD+e4=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 0/3] Bluetooth: add TX timestamping for ISO and L2CAP
Date: Sat,  2 Mar 2024 22:07:35 +0200
Message-ID: <cover.1709409547.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for TX timestamping in ISO/L2CAP sockets.

These patches allow fixing / working around controller(?) issue where
two ISO streams in same group get desynchronized.  Having accurate
knowledge of the packet queue lengths, user application can drop packets
if it detects the ISO streams are not in sync.

For using this for audio, BlueZ needs to be changed to not
unconditionally terminate connections on POLLERR.  It currently thinks
the TX timestamp POLLERR is an error, and closes the audio channel.  For
BAP, BlueZ only closes the fd in this case so it accidentally works
there, but for A2DP it is more thorough in tearing down the connection.

Pipewire side:
https://gitlab.freedesktop.org/pvir/pipewire/-/commits/iso-ts-test2

With this change, https://github.com/bluez/bluez/issues/515 is more or
less fixed, and the sound server can figure out the total latency to
audio rendering (tx latency + transport latency + presentation delay).

For ISO, we can later use LE Read ISO TX Sync to provide hardware
timestamps, but this requires figuring out the sequence number
synchronization first.

Pauli Virtanen (3):
  Bluetooth: add support for skb TX timestamping
  Bluetooth: ISO: add TX timestamping
  Bluetooth: L2CAP: add TX timestamping

 include/net/bluetooth/bluetooth.h |  1 +
 include/net/bluetooth/hci_core.h  | 12 +++++
 include/net/bluetooth/l2cap.h     |  3 +-
 net/bluetooth/6lowpan.c           |  2 +-
 net/bluetooth/hci_conn.c          | 78 +++++++++++++++++++++++++++++++
 net/bluetooth/hci_core.c          |  5 ++
 net/bluetooth/hci_event.c         |  4 ++
 net/bluetooth/iso.c               | 24 ++++++++--
 net/bluetooth/l2cap_core.c        | 11 ++++-
 net/bluetooth/l2cap_sock.c        | 15 +++++-
 net/bluetooth/smp.c               |  2 +-
 11 files changed, 148 insertions(+), 9 deletions(-)

-- 
2.44.0

