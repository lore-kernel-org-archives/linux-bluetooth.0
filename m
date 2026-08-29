Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A09214812;
	Sat, 29 Aug 2026 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013256; cv=pass; b=ruOVprUo+p7kB+qbw6D6WZdGvoEfAph5yHc1o8emv3VWMRmQANWfXyVEg178yaz3GGL+KyQ1jqWekm73E7B23WQAPswohUc5FPBKZXN3ass785zHnokKd1BNe7o0omEAQzyCFO6Q6x9zUJvrvVjx3r2qx79sxP/rOcv4e9JDIHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013256; c=relaxed/simple;
	bh=vfcO2HIVDpXsRGWJyk9fcRHKGyejb1nTdiagSFbANT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E05tLSp15cga9wFQcO8N+XDAI1tRCe2CDHeh/ZoMwk5kc3XD6yFS1X1pALgDt115uHO9vF+o2MiRXq9yNwarJmJ6sjW3x50fYJrT8muCnQm6zfp5Tn3t95zqRnQBgh6SosBIAercTF/isgcuM4nmi5Q8VoSRSRI59Mq3j/0Cgsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=eOHc0+fv; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="eOHc0+fv"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:e011::d701])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXHTz1Jc7zyWl;
	Sat, 29 Aug 2026 17:20:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788013240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tQulovXJaLSdm6tYD7cO44sRjje+qD1MhZ55tnYtBFI=;
	b=eOHc0+fvq1j0kMSRhNv1wfcnwfZ2Eek7GUWlnWVN/JNjt9rm+6peUFMZ3IBnutvcjSgYzB
	8T0TTZcBKnUr7frS2gsi6Nka92sD/l+PTg0thAGfLhM5gSB6W/odTuW8Iygak7XQb5iJ/B
	h8ceJnoOzbc3HcntopnahNLg4oamBLI=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788013240;
	b=pEZMdvmzCmpOCzyY6zkvGwhItaHGKg2ITeCFjnUpfw9yFWy/2wqXAaMSXdh0ahZD6z6cxw
	Xgf/16RyVLuplPlekV87e5Q1r/ch6F9VWd56wnPs0lI6JxUx9E/TkD3cqtnePYOo/+WUmv
	299ZALOsAxIE6Z2RSaEkhlN58aFCHlw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788013240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tQulovXJaLSdm6tYD7cO44sRjje+qD1MhZ55tnYtBFI=;
	b=Zm31CWLFi+5d8TE9xp5Ej2fzzTp7AcVlOzvHDfwHGTrZhfPAwqYaCo7NZt+4fzMhKlEmdK
	LXAs1rtUfw3ba9vruMcL8mKsc0/NIi+Ft7H7jfBYC/DojXi8mzEFXuTLVIG5DHYww1fxlE
	7vrxMKw2gIjDtseOfD3ms4LKZdh+vWY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	oss@fourdim.xyz,
	error27@gmail.com,
	elver@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/16] Bluetooth: L2CAP: fix and annotate l2cap_conn::chan_l locking
Date: Sat, 29 Aug 2026 17:19:55 +0300
Message-ID: <cover.1788013041.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intent in current code is that:

- l2cap_conn::chan_l read/write is guarded by l2cap_conn::lock

- l2cap_chan_del called with held l2cap_chan::lock (l2cap_sock.c uses
  this)

This is currently not done right in several code paths.

This series fixes the locking vs. the above, and adds context analysis
annotations to make more sure it is systematic.

The last three patches fix some miscellaneous locking related issues.

Mostly straightforward, but two more complicated parts:

- race condition in acquiring l2cap_conn::lock & l2cap_chan::lock

- __l2cap_ecred_conn_rsp_defer(chan) may l2cap_chan_del other l2cap_chan

To deal with these, this series adds

- l2cap_chan_lock_conn / l2cap_chan_unlock_conn
- l2cap_chan_close_unlocked
- l2cap_chan_try_sibling_lock-
- new nesting rule for l2cap_conn::lock

The context analysis annotations for l2cap_chan_close() declare via
context_unsafe() that __must_hold(&chan->conn->lock) even if chan->conn
is NULL. This is OK for the current static locking analysis, doesn't
affect code generation.  It could be cleaner by adding separate
l2cap_chan_del() variant assuming chan->conn == NULL, but playing loose
here avoids such duplication.

LLM tools were used for patch review, catching some some corner cases
before sending this series out. No code / commit messages are generated
by them.

Finding the bugs here is mostly based on adding the context analysis
annotations which make it obvious where appropriate locks are missing.

Assisted-by: gpt-5.6 deepseek-4-flash

Pauli Virtanen (16):
  Bluetooth: L2CAP: take chan->lock for l2cap_chan_add/ready/del
  Bluetooth: L2CAP: add l2cap_chan_close_unlocked() and locking helpers
  Bluetooth: L2CAP: fix race condition in l2cap_sock_shutdown()
  Bluetooth: 6lowpan: use l2cap_chan_close_unlocked()
  Bluetooth: L2CAP: remove unused l2cap_chan_close()
  Bluetooth: 6lowpan: avoid concurrent peer_del() in
    bt_6lowpan_disconnect
  Bluetooth: L2CAP: hold conn->lock for __l2cap_ecred_conn_rsp_defer
  Bluetooth: L2CAP: hold l2cap_conn::lock in l2cap_connect_cfm()
  Bluetooth: L2CAP: add annotations for l2cap_chan list locking
  Bluetooth: L2CAP: take lock for l2cap_chan_del in
    l2cap_ecred_rsp_defer
  Bluetooth: L2CAP: hold chan in l2cap_ecred_conn_rsp()
  Bluetooth: L2CAP: annotate locking for l2cap_chan_del()
  Bluetooth: L2CAP: annotate locking for l2cap_ops callbacks
  Bluetooth: L2CAP: make concurrent l2cap_set_timer() refcounting safe
  Bluetooth: L2CAP: remove conditional locking from l2cap_connect()
  Bluetooth: L2CAP: refuse __l2cap_chan_add if chan already has conn

 include/net/bluetooth/l2cap.h | 100 ++++++++-----
 net/bluetooth/6lowpan.c       |  44 +++---
 net/bluetooth/l2cap_core.c    | 257 +++++++++++++++++++++++++++++++---
 net/bluetooth/l2cap_sock.c    |  95 +++++++------
 4 files changed, 384 insertions(+), 112 deletions(-)

-- 
2.55.0

