Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFA2405C5B
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537752; cv=none; b=BEmv6RxJnxdcA/McHZNKudazv+XNjBwHFyzNhtYlFtkfxBbD+x4pqPlQuSJ1QxKXgxbTUWoikl+3Q9UFNEBQuKV5Ss+AhLxllZaRJsym/ZhZQvS+1apYuOFiN3lx0//jlGzdppsRQj1VpWSZFX/LeKouDnNX5ml+lj7yHUVJ3pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537752; c=relaxed/simple;
	bh=VGAjdfBEnTUl1mva6o9msf94i7marQlUeHSmYkHmYq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPO1MxOQMIFR29S//sHYCmLHPENbcD/Gc8g1CdoCFRSCOz93v1IyQXTNwzgkohRgxQfhNnm898rDr7TA/DaXYOK2+IU/MyDH2+q3BBEqnY+Q1xr4s6vml/WitbpFkchjb81+/H3WDtkNXh3fPM08U3LEdamHGAP0tJnbOodrc4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=W8DfFQoK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S2h6JWgw; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="W8DfFQoK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S2h6JWgw"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A98707A010F;
	Mon, 15 Jun 2026 11:35:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 15 Jun 2026 11:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1781537748; x=
	1781624148; bh=h0nVIc1sEebwSWFb8/6Rd0AOalhx+hEokGEFT5SCnsw=; b=W
	8DfFQoKS8krRwDxrzs3dRhzaYUQK+GYCnylSwwzX9z9h1t00I0Kfa2pZFmZG2T/C
	NGS+raE0UJZSXGA//e88Ttjm/h8Zi3ZbHcGUpInDCG5j4JkoR9gU4RNxTvOtBjB8
	BdoziOGr88DHxM2xFRC87F7A1s0OzmgJPw+i/UB1FhvfzoiXWQUqxn0Ejz4ZUXt4
	TVkGEgQP6CHSdNezTjuor8NvlNux+YzqyNGVUzyB8B249bXCqXYq+byqhfMDyuFI
	VZVaq4dhGUBn5fHAkZT71E3cbRmc5n35gZt8QJ/6fx5NMhtPqcIJosrGHvLHmPAz
	mNfQ5CPJG2al1X13JrksA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781537748; x=1781624148; bh=h
	0nVIc1sEebwSWFb8/6Rd0AOalhx+hEokGEFT5SCnsw=; b=S2h6JWgwrPcLp8kp9
	YL//KmsAtWnNKQAXp6t5OpkQPDIMAhcHwaX6G4w4s0gTje65Ml/PUbweFKSyxLNF
	syOLUAudpvktMGYx0wUWVlUL1nMWBNwx8hNO2Kbu+BtdqhSurw8AhTsFU7iSgjsH
	oFu24syLY6c7WD7WsXuM8eb23htpFc8RRN2qfD02B4B8Yy4EY8oxmjhWE89I5qut
	jzaWloFDX+AOuhqHleX4DLnhg3FB/YH1psyY7w5AIHoCvfAJMGaZo+AtX+GUn/T9
	E5ilfhQK7QMogIKcBG/YO+zgk1K+aEUvQDfA33qPNYb4i6BuSnVkJfnufzn4NC3X
	EOSBA==
X-ME-Sender: <xms:1Bswap47fM60eXZfcezcXSE4ySL8agaZV3vlDM2gCu4IXRvZeJ9P9w>
    <xme:1Bswatw8Sp1lUwb6_mpk9CWZorl2HpQTE-3p6apqu3pbhlXKKf5287OXoUBSWhBKP
    4nDON8UkHbhxDgaY6FKtK7id3Z5MN5uVtmzs1kmRT_yKbMr8fhGFJV->
X-ME-Received: <xmr:1BswaowkLDGdgGNqV4MxPcYNVzugab7L9LusaeXB7wRepjdwS-8-OMSVQNOi-T1qgqpFuyo>
X-ME-Proxy-Cause: dmFkZTFTmZP9HVjvt/nPkc+97j07Sz3Waeg45tErepInKmn+4j/2aUWc+YLWZfU8BsbgWb
    YnttoV8uAlXBpmpfx9J9XWEPg4Qgm3395uypJGKbIXFKdma9DISgBGGecW/UipHZ5ZBJW2
    JLJD/U+QWUe6J04u11l+RVPjkBJpWSAoIo9eotnGF2286smNGPUDThJgbiFv3Eq4w7o+q9
    aiqeN8YHKRJk2oDGpiOFKqPyhfzyf9A501q+ztTBsPSkohh6Af4kv3qvlJivYqSxY05w/r
    gfHDjAXxqpt1jWJDzvRxvkLhNIfeut17YYC8AXKwNOvSw0sdO2vkUOUfiynB4Bv6E1knW9
    Mdfzc3pVnH4EYYCgw4nFuA8QqO7zSbi3Fd/dAgc2/AsccIa5lGTXUWP7DInvxXOMdkNact
    TDaIwC2cLjPOHuYhd6w1tOhlA220bb957p1a6o7V9Dz4CrGjPUapg+Au3Xo4i2vJ6lFyMU
    0EaGPOKWYL9ck0FygtrpqeY2FE411AVyVfiysWLjqjPjSBKbmXzRTRCtSoH3BMVXWBfhVI
    HxdBUHc2bd6umifWJh9JZpEO2l965D60xkLKvG0ErIyB8/qRxcIC8b7dc/ToLwd2gVrcop
    /N89HdHiz4nvAmn+ZBnEdTXuRJNnbCSHFcNlaKlViPGw6Wx9KuaJBINuGqZw
X-ME-Proxy: <xmx:1BswatyBUjcBXdSZVNQiqkchsE4nte6JoapazmqyOGATTm6K9M7r4A>
    <xmx:1BswaqavsmIPEfXLV4Ddq9qJHm-JZ3weLUn_DCsqpUZJk-McpamK3A>
    <xmx:1BswamVH6HRjN9LWTxibqT9h80fnMduxP_ZoJzZjrTa4oqCp0uYP3Q>
    <xmx:1BswaghsYDSi2iKKk74VqLOfHa3PAqkM1IX7U1Qaxyc3fhvYWzcbRw>
    <xmx:1BswajyP_7S4ZksucK9vwJ4ShqqKB7wALCUkif5QIgype8mOJXSgfeF0>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 11:35:48 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Pauli Virtanen <pav@iki.fi>,
	XIAO WU <xiaowu.417@qq.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v6 2/2] Bluetooth: hci_sync: Remove unused hci_cmd_sync_dequeue_once()
Date: Mon, 15 Jun 2026 11:33:06 -0400
Message-ID: <20260615153527.1583705-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615153527.1583705-1-oss@fourdim.xyz>
References: <20260615153527.1583705-1-oss@fourdim.xyz>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_cmd_sync_dequeue_once() had a single in-tree caller,
hci_cancel_connect_sync(), which now holds cmd_sync_work_lock across the
in-flight create flag test and the dequeue and so open-codes the lookup
and cancel under that lock. That leaves the exported
hci_cmd_sync_dequeue_once() with no in-tree user, so remove it along with
its declaration.

Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 include/net/bluetooth/hci_sync.h |  3 ---
 net/bluetooth/hci_sync.c         | 26 --------------------------
 2 files changed, 29 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 73e494b2591d..818e62d9fe9e 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -84,9 +84,6 @@ void hci_cmd_sync_cancel_entry(struct hci_dev *hdev,
 			       struct hci_cmd_sync_work_entry *entry);
 bool hci_cmd_sync_dequeue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 			  void *data, hci_cmd_sync_work_destroy_t destroy);
-bool hci_cmd_sync_dequeue_once(struct hci_dev *hdev,
-			      hci_cmd_sync_work_func_t func, void *data,
-			      hci_cmd_sync_work_destroy_t destroy);
 
 int hci_update_eir_sync(struct hci_dev *hdev);
 int hci_update_class_sync(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a3df69bdec1e..753198b401ac 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -860,32 +860,6 @@ void hci_cmd_sync_cancel_entry(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL(hci_cmd_sync_cancel_entry);
 
-/* Dequeue one HCI command entry:
- *
- * - Lookup and cancel first entry that matches.
- */
-bool hci_cmd_sync_dequeue_once(struct hci_dev *hdev,
-			       hci_cmd_sync_work_func_t func,
-			       void *data, hci_cmd_sync_work_destroy_t destroy)
-{
-	struct hci_cmd_sync_work_entry *entry;
-
-	mutex_lock(&hdev->cmd_sync_work_lock);
-
-	entry = _hci_cmd_sync_lookup_entry(hdev, func, data, destroy);
-	if (!entry) {
-		mutex_unlock(&hdev->cmd_sync_work_lock);
-		return false;
-	}
-
-	_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
-
-	mutex_unlock(&hdev->cmd_sync_work_lock);
-
-	return true;
-}
-EXPORT_SYMBOL(hci_cmd_sync_dequeue_once);
-
 /* Dequeue HCI command entry:
  *
  * - Lookup and cancel any entry that matches by function callback or data or
-- 
2.54.0

