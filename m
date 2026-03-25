Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335ED336886
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 19:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465677; cv=pass; b=aJ9cjkcZ6/pq9CO2EcFN23s195FOMe+kE8DqAPyaJbnikoEZmJKw6PxWLkej4RFJhLjNfV8D6x8wtjkQPKt/4M5+jclzwyMBfLFmappkYBlU3uyA+vtYcW4d9toa8OAM6hZkB3Tmwbs2nJ6uASgUykaxYrU3tScFH8AraFJLYKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465677; c=relaxed/simple;
	bh=F1njCfpYcZV0IigAKS8csthKq58S91KNurAYJlQp11g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWNt0w0knbLEAqN3oKOM589XBCIX5X8/JPcwYmpBnnkQo+touX/dC9ICLBcwzKKDqEkKQl2KBgBV1pWDBBEMgH90cYuY0NvargyPzWPb1j07HNPCtvY5pByicR4d5FexQZ3qEaZKt5zGZrEpuvNY7j3xrDpM/juotR0VMfXK9iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=k7J1XnbA; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="k7J1XnbA"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:f410::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fgxHt0rn7zyvd;
	Wed, 25 Mar 2026 21:07:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774465674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJvInfzRzvoKl6QQcBIcVPlGAC/fNrzATALrJWBwQqI=;
	b=k7J1XnbABQXKW0U584t3thQ2nxqn2eZ/+94BMC4bARRTYcOfJCVDrCdTn5xciPn5N1GoQh
	Qu3Lv1dV1VGbIsHCcGFdNFm6GTiHYvvjkZV6uD7IOAsSUpYU8KtQiOhKlEk97MndxzfF3G
	qWyQB1Qs0xTMitVSmNEQZsLIm7cU6oU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774465674;
	b=wPs7tLTNHmnCmj/xX90cYo1H6hNECq9CnCqIywIEFl64qyRWjKTXAGUvh6vmC1ygBxbwO1
	bRyN94e7EpUPbgMbbSw6UbCrqpeWL90kk4vlqH6qh29Lala3YS36zAS8xSNVGxAAEYq3Df
	Is9mXozThDqqiveGxFfSJWdqrNgMUC0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774465674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJvInfzRzvoKl6QQcBIcVPlGAC/fNrzATALrJWBwQqI=;
	b=V1hGnORv2j5ubo66BiCDbKxvjq6iqL8soSv3q5qbw84NGDarYloY9tj+j3Y3wkQ98vVNpS
	WiQ1Q+Pag9w7e/JxnIESUqjYwtE0fu9+Sgcu9SFiGvDD7F40YU3kt9oxhEyfIpeOrVqZ80
	38kgyafB3wCnRDePlXpI2chZAHxITIo=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 4/4] Bluetooth: hci_sync: call destroy in hci_cmd_sync_run if immediate
Date: Wed, 25 Mar 2026 21:07:46 +0200
Message-ID: <7c2f4b0872802b48a73b165bcab3261bd33f0334.1774465559.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <f7ccb4a4f9e462a6c1c1ddba8dd1cdcc9456944b.1774465559.git.pav@iki.fi>
References: <f7ccb4a4f9e462a6c1c1ddba8dd1cdcc9456944b.1774465559.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_cmd_sync_run() may run the work immediately if called from existing
sync work (otherwise it queues a new sync work). In this case it fails
to call the destroy() function.

On immediate run, make it behave same way as if item was queued
successfully: call destroy, and return 0.

The only callsite is hci_abort_conn() via hci_cmd_sync_run_once(), and
this changes its return value. However, its return value is not used
except as the return value for hci_disconnect(), and nothing uses the
return value of hci_disconnect(). Hence there should be no behavior
change anywhere.

Fixes: c898f6d7b093b ("Bluetooth: hci_sync: Introduce hci_cmd_sync_run/hci_cmd_sync_run_once")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2: no code changes -- previous patch split into two, add Fixes:

 net/bluetooth/hci_sync.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e82c44e053df..47d902310b19 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -801,8 +801,15 @@ int hci_cmd_sync_run(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 		return -ENETDOWN;
 
 	/* If on cmd_sync_work then run immediately otherwise queue */
-	if (current_work() == &hdev->cmd_sync_work)
-		return func(hdev, data);
+	if (current_work() == &hdev->cmd_sync_work) {
+		int err;
+
+		err = func(hdev, data);
+		if (destroy)
+			destroy(hdev, data, err);
+
+		return 0;
+	}
 
 	return hci_cmd_sync_submit(hdev, func, data, destroy);
 }
-- 
2.53.0

