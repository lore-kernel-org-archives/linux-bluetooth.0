Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E8D380FC1;
	Sun,  5 Jul 2026 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783262886; cv=pass; b=HLISZjGvZEVgdJAeF1sQSgiPdUNaWgQFDDafzRwPbwJBpAdwxwCNrsHRck5pM4QMeVt3bWBfDYv4FckJNtUWkqkLsPmczc6SdM/fnmaXYe1VFGzE9+r71GHTuz6Cpf0kfqKFWYZFLWRlJS1S9D4OyLSW5f+r7LjHwjYOxI63Lo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783262886; c=relaxed/simple;
	bh=Zn3sF555OJvB2YKDU4kg86m09lW+Uq6636bYDOVgwPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AMv0+1UZrJCNu0t3m4RnTdDFofjDHBQXPnhd6w3Munv80Nzkm8ZJQHdCuixFloE+T574p9nIOeBgGPjVhlJXJM09sV33Tg+jvLJTiiglh6RxfdJNvRpK+r7UStHw4090Dp2bEbBKRMahs3pvf+A1M/N4WKRTkEg3InmXKahPT8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=D3JMEHxH; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=eQ3Ej86R; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="D3JMEHxH";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="eQ3Ej86R"
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4gtVhp419Qz49Q9L;
	Sun, 05 Jul 2026 17:47:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1783262874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nxDyjwXQeuHh1BCL+KF8xBwNSvysqwEjZKFgIX1kcQI=;
	b=D3JMEHxHySHxwrV05UX40Jep5a2IWasXDRwFQGSLQFeWXF0ixqPcSKk5D8klQ3yywtyFWM
	LRGrv8D+5dO7HlgB11heBNeamK7tFeuzDY/i1/rOurZaKaDkdDJDJhTz7Efk/WjrimdF53
	EY5dlXpfpyDWzrlwtRb5BYcFwOjVne4MlUjPKQiAl8vWJx3QPKu+C8GLdYLnMZ9HVb4Gcl
	4O3euHOGVxtlHrQ/cotoDLcea0AHuiP2B8+PPFfegduPvSxES5NbyNmwJSTHdX7DnzJev5
	XvsJZmZKpMUIhMTCGEHWYO4f9rBVlcGXIOmY+DGCYqs+5KYesomreOKPXIoXgQ==
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gtVhc2SdwzyPv;
	Sun, 05 Jul 2026 17:47:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1783262865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nxDyjwXQeuHh1BCL+KF8xBwNSvysqwEjZKFgIX1kcQI=;
	b=eQ3Ej86Rw3mm5MxZ9QIW3jATByOYLpLc8nuXKhCiU34Y3ag3MchKwM/OYCJDVcCMQEnFXa
	5tNQBfAOIvjkz6crRBT+6qPSEGeBgXQASKs6KH4cPRm331UhCXZFaghaDOQehy6zETTgti
	eeDuEyVoste9BRQXImZ6+y4AdQ9H/qU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1783262865;
	b=QBtR5cBLVIXS9qTCroMXmZyjbkgZa0bFzEghU530HsJEf0kaH4S2cm6z3Bhpk55yJhV8oq
	uEhFu4g9RlR09lEvrSsUzh5aeJzS5k7YDYY47yBe9XFzsalbW+PhN1LQ+pRBaQ+bkRitZV
	CYfR4WgXxOzafzm4U9AnNIMjW7qCSGo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1783262865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nxDyjwXQeuHh1BCL+KF8xBwNSvysqwEjZKFgIX1kcQI=;
	b=f7XlC5M6+dIlpxitutc0d4HD6G7xixTRcwD9XQscfcGY8TM9hh6pWvxT9t0R3Gy5oB3xOb
	7oy79s4Bc87CIGqlWOZrBZkfHvHgWWAXqu8/4lmFYL0HQ7dLlNxZPfiwBw6gjf2ygLSjrl
	L+FldKnwOOHoEKDX+aaf2mD8mofuQwk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Bluetooth: fix hci_conn lookup RCU usage + holding refcounts
Date: Sun,  5 Jul 2026 17:47:35 +0300
Message-ID: <cover.1783262689.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resending parts of
https://lore.kernel.org/linux-bluetooth/cover.1762100290.git.pav@iki.fi/
plus additional hci_conn_params usage fix.

Pauli Virtanen (4):
  Bluetooth: hci_sync: extend conn_hash lookup RCU critical sections
  Bluetooth: mgmt: fix RCU use in unpair_device/disconnect_sync
  Bluetooth: mgmt: hold reference for hci_conn in mgmt_pending_cmds
  Bluetooth: hci_sync: hold hdev->lock for hci_conn_params lookups

 net/bluetooth/hci_sync.c | 61 ++++++++++++++++++++++++++++++++++++----
 net/bluetooth/mgmt.c     | 42 ++++++++++++++++++++++++---
 2 files changed, 93 insertions(+), 10 deletions(-)

-- 
2.55.0

