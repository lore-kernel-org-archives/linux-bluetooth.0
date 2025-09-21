Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9251D54D8
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 19:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482189; cv=pass; b=U/kepIhZPHGAFyxNauedbBkjVWeWV3UClj2T8kOsq4mXQ19cRL/GPv860bZCdeN9t5krSBgQaKbn2WAvWutXSuYZ2CjEVSUb2RExrVCOIlACqOZ2CpJbtPC05g/h1WQhjI+2mHWhjVFwYA0L0gD+i2qCx5qOjPwMH0hB8BgWtGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482189; c=relaxed/simple;
	bh=Rcl0lSobJsebOelxc0E0tz3K6bWUQI8jvDHlqTx7RXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+dzfpTMT2X2mu5XW7danzAEpu8tmH1OnvqrQQDOeSma7jqg0qOcUKukDT/pZOODSkHojyk7m3QHct7AYROpDFR3d8ut/5Irkum7nHj/67NwlX1Psq/XbtSmxV3EtlmQXMozDmSYe0JK/nF6ywj4ExXjVBt17URiKBYs8RaMu0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=AMKdIA/N; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="AMKdIA/N"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cVGF308Knz49QMw;
	Sun, 21 Sep 2025 22:16:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1758482183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XRIhh1xr1wOcyYRVbNi7ajCuM1d3+qIvwGyRwxAPXQQ=;
	b=AMKdIA/NCaEd6rxdXUM/2feO0athSkZukgNPpJfTVaZyKgSFxlbD01Rmholzg45RgknUiM
	HqRMBfoPHnbt5F90BcqSK8DcsD0BbuycZvQ+SQ5beEidkTwUWdhECivrOl0ddrNTun0uZO
	Rp7ND8gxyuEZes91kCp8vPxLTG2TIu0SM0OVfDR7bDyO5ivVAMaZcUE4XmSkSYiaew2ot6
	1f5a3bbj/qIgIOHF9IJAYVyMAOmelGE8+VO+WvyQobbJob/5lduDwIMO6DMgZs0pZKME15
	FW6BvNBlqqSI7YeenKh0WFs9iokU7GBrfo751wQLhxH5oWME5rUWoxjcVmMO+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1758482183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XRIhh1xr1wOcyYRVbNi7ajCuM1d3+qIvwGyRwxAPXQQ=;
	b=c4YGwdbg/FlVrSXwN11kus3SW01FX7BYfut7jpQi0kxWTzauBxnYk0MkQrwAy5s1+7ze/c
	FAlwGdjuUJTN3wsOkYFAvfyuM2qSvCEiB0kMn0LDY1MsK9aFKbjjH21dgMviTJMOed4WXB
	XIUEcdus3RWh3M8f/Of6bMmaG78gs4hA8ajfeFthRITBZvQ7wEznnqd/WZF8eIyWT4J2jM
	S4kYr4M9DX+/+PyAXIRXvaSC14jcckrDqJg7YTLnNsn0BsFs6VgjgsSoScMJBVqS5r/mQz
	q2kRI1OZ4cOk7aTUAgdw4ZZIXhWZHAts7RO4aRq3nq1w06SZuG0ZD/GMC+tvGg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1758482183; a=rsa-sha256;
	cv=none;
	b=CdteWwzM/aPFeWwmR6XqqcPJ8Gt0nBokUL9w6kMvOBgjWov6F3ruUmK1/iItddNv6H3uGd
	PqIqYth347nFhizO5tti/IurGxib4qBMgd3Mpo5PAqI0CszILdXnSKPzKi3a1Lxe+TbEN/
	WJ1XTZhnI9QdbaNZ6ntHrX1FXGq6PnY135uIUFx+lXKC7gFoZ4IrreiWfWNFTLajJWIqs4
	jhUk9EhWomdorhp+/aqwF3qvKafb2h7O9BlS2Osiayq/Mp+rtigoLRH/J6SRryzO+ZJfv8
	MRjtqvUP94GguyWxiMO8DL+65r5DfxP5/L6PtE1Jr348zKvPufbewLThLhxcxA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 23/24] Bluetooth: hci_sync: fix locking in hci_disconnect_sync
Date: Sun, 21 Sep 2025 22:16:07 +0300
Message-ID: <4229c4f3fc77e4003a2a6e45463ac58a0e95c819.1758481869.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758481869.git.pav@iki.fi>
References: <cover.1758481869.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Caller of hci_disconnect_sync() shall hold hdev->lock.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_sync.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 0717d53c2e33..a07bf168594a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5581,10 +5581,7 @@ static int hci_disconnect_sync(struct hci_dev *hdev, struct hci_conn *conn,
 		/* This is a BIS connection, hci_conn_del will
 		 * do the necessary cleanup.
 		 */
-		hci_dev_lock(hdev);
 		hci_conn_failed(conn, reason);
-		hci_dev_unlock(hdev);
-
 		return 0;
 	}
 
-- 
2.51.0

