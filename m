Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D832FD7D3
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Mar 2026 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774791792; cv=pass; b=ltQ3Qv/Q9w85fd5//1QqyUTl2kUeHW5O4VOmIZ5Q6QFeRy2//Pn9eXO/SZPaJaSmooO1fAJg/YAS1y1lgJMNBCj9aSkCEzbcxLTCZpVWs3BUw2YEb5KTTmIpzy2h9o3mky9UqhrTq1yIAm3DoI5XNG6+ZVy28/iamimjowmJVTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774791792; c=relaxed/simple;
	bh=7RnhzQXIDmaxtiexQte8hKVzTthM1n0Yj57COwSg7jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TECWYrVkKfCO4MbcZtaP2ld1Ht+wgFPDWyEt/e6nqoSZJxG5aEAOoSWkbDTaVWERcTZ2LHOSThHa5ypBuPuEWgguqMxAv1V3IAEH80E8IOGXphHvBgxcGyunPq4P5T1cwaRg7Y81E5BzpfCKZJ8e+ROb51wVXZDQGRKMTTUNdbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=H7G41g/b; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="H7G41g/b"
Received: from monolith.lan (unknown [IPv6:2a02:6ea0:1508:6::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fkFvK32mHzyZ3;
	Sun, 29 Mar 2026 16:43:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774791789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oqNvQfPIEMtbUNjQ7t3IB6tyvfcfsMI1x7yMKNA9euc=;
	b=H7G41g/bwBAw4ZRBpOk/dyVUSJHztBcQciVCOQQs+IG8/APsxP4Rjl3QAkohKNO1RBECWd
	QrNwUiUoLzhqGFIpLk/ffVK6vEJmFpsc1Pvv+Kk6k43OLROTCNuZAy21oEgrwi4vVL5epj
	JCvtTFIOcl5TPl1WGx7xnpNA8lrKVtc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774791789;
	b=FZy6zOarmThtmbHP/q4lzm4Ss3r/j3gIEE8VCEGtPH9Wl/z0umyXXgxYJQoCWifedCammv
	FN6jfeFwS2B5kXvq0bLXvzpy55tdgI3XxrIju6YOs5I668T4te5Ab0vpT5tWJ4sWHbEZr2
	wK+hh2GQPMbzeEiKk8ZgyYEDw9cZnuU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774791789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oqNvQfPIEMtbUNjQ7t3IB6tyvfcfsMI1x7yMKNA9euc=;
	b=DvBML/qcqZDW465d779gcOYisxltts8q+bUew3Tg0O2t1a1bWGc8GqWskxwkbUWIoOJIAN
	aqcf5ovQVz34toL5okdC8j/FlspcbgmOsb3Wr1m0yeqgSQFtY2BS/NQjLvkv/rSAczCWVy
	pAU1uEx6vNLUdDf2xOxrr/2BYpj/+nY=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH] Bluetooth: hci_sync: fix refcounting in le_read_features_complete
Date: Sun, 29 Mar 2026 16:43:00 +0300
Message-ID: <4677ae5da08686a59e6d7d9f12cf19f3ff2b0e31.1774787570.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <089f435fb4668921bb416a3d60fa0f232456e054.1774791296.git.pav@iki.fi>
References: <089f435fb4668921bb416a3d60fa0f232456e054.1774791296.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_conn refcount acquired in hci_le_read_remote_features() must be
unconditionally released in the destructor, or it leaks.  The destructor
is always called if hci_cmd_sync_queue_once() returned with success.

Fix the destructor le_read_features_complete() to always release the
refcount.

Fixes: 60562bebb651 ("Bluetooth: hci_sync: Fix UAF in le_read_features_complete")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    This probably should be fixup in bluetooth-next/master if it wasn't
    pulled yet

 net/bluetooth/hci_sync.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 91d0252ae661..92f87761468b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7390,9 +7390,6 @@ static void le_read_features_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "err %d", err);
 
-	if (err == -ECANCELED)
-		return;
-
 	hci_conn_put(conn);
 }
 
-- 
2.53.0

