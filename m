Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A053C2799
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281098; cv=none; b=dqpwyPrVU+uC1PluTPaKIsj8ZGU07b9dGOl/ztLQUCBPUXMBV8voyH7UOZ8YPwr+TgtBE3NvxfM7tPYqkEPjXe0idXApE3gTHhxPyi9mCQq3NhebdUNb+UULQTIB8/thh/arFyTP6PA4BJfSjIVqd0qAETwYkTNx0FF/EcsvT0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281098; c=relaxed/simple;
	bh=LZBHKgP17FsCPDiK9GP4kyJMCaN/Qqqx9z2iKkNiYIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YfZY97H8u+ZAop4b2dz4GX/1QbblJn760/IUQWgEZj0/S55dYlzxMT1hMfYgQ1dY5U+XW0kmqMFx1l2zjkpbwniOiu6m/qitogH+SnEek+qHEC6/VfRsS7329Tr2ez4ipqbNhxR6ESxaOsxOiQ+MqTH5f6/bEE4HOTtj0NXOHV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=ZtVKOVVH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LQ500IFN; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="ZtVKOVVH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LQ500IFN"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2E9AB7A0187;
	Fri, 12 Jun 2026 12:18:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 12 Jun 2026 12:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1781281096; x=
	1781367496; bh=KhEkMu0bTAeC8l1SmsC5WmWgV3y2ojNxKYUzRpg/pyw=; b=Z
	tVKOVVHcHOAna9aZkZ34bqimDTTcZpc2CazpJPdUsJ/0dEt6d26oxwDn3up7KDI5
	UAbtGWM63EMWuJyLElHikkIbDXVaS9GMCRr9PNKN8PzEVNmEbngvV5gTKZNVa316
	efUxmhMe1jQoZhf9Ol6zK8YS2nqK9UEWTGafROs9/Jjl/M8pYXRFbaKHaQytOOXN
	ZqKl7OBKjG1X9HK6JWxRUiRdbwDhR0KFNzsRMraNKlmdZtElXmwjtAiFNgTOURUP
	0zZwvFV5IV/ueOmKupILUQxZ5ZMZSbKcz3NYjWy96zCEHN0RBryUeaMOK6X1/dJj
	v7UfNxeyaSchiC8JVgIOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781281096; x=1781367496; bh=K
	hEkMu0bTAeC8l1SmsC5WmWgV3y2ojNxKYUzRpg/pyw=; b=LQ500IFNjKvHGIqsL
	1ZogsFcCTiLVznDloaUBevRv6RoHFgtGfPS+LNIds4UZNdrWOG7RQV9hTIuTxYMD
	upWu7I/NskH/kM6S4JMZ3vVQ9NOrew3U7rp7rKhHWtMAUoMf/64sSCqfCs7hkJ7V
	8VIFITs/DcNalbSe8imDo0CO3S4+TY8TIxIUzR8uRAizP9sE7t26yTRvRrnRcJJ5
	Y9sEjzQgh1zn66xL7mhrs86DmiN3nQfg245vQtxYp7bg941IWHUpZXlcNXR9pjvB
	ppo/xL+Vqk3ZlS8QD8tX1zSS0ylIdfpDBwrXK2IeOpMblLctqy2qK2BWNuhhwMbk
	5QkRQ==
X-ME-Sender: <xms:RzEsagpArN2D14HeOfbC9j5aCyVWPp0oOrbo0fPm73kTeF9RAoWNEg>
    <xme:RzEsatoARzylm6XwPjwduJ27a8-UJew2TmrJ0DJMQgHhFtjO508hZSPBmus3XSuKd
    OcbaCXW184dKv-UwN9_AnGu-eyO4Q7hhWPpbeJgD9RLoxb_T-klIwU>
X-ME-Received: <xmr:RzEsaqNG4beljMpNKub6vNe-3eEffIZbKuV3w4S0U4tqiRwDMaCKxaLWuu6fcnTogjZJINg>
X-ME-Proxy-Cause: dmFkZTGWTxCa9Rh1z212Nd6RSkJ6Ib3eogbyEc1gu3eJlCjHmjoJQve45MIAupD+YHgzbd
    G5cSXrOciQA4fqvSBZJVrN/qW6yHQQ9WhFKECVOhF4XH89jA3hBTlA5WtRjJYyOWmNXxWg
    fPc0frj5Dllk4EK9RZrjJxQwJHnEv7obuDKimbfsaP+c2ErXk8RWH5tykkVjXcPPiWHuF9
    dLFGiDe9GejsiWzk/bzWIcTulAVvRZhU9f5Y9flyoQD/YmMZykdyl6VXeVcURmzww9iAw+
    AlIga30KJ9/Rr7mruPU9vpAJDKUR1hTY8BP/tpTnMO+G+eWu8HQIve3qCSU8QHzC21XhAc
    RB9Hp4xPF5aYmnW6w3hNLBKeP4guOPHaJwRvnjZYsviSehSe+1fd0Hwm0AP3IZOfJx2r36
    1heaj7rFj9fBW/VF/6Os72EkyI2GelvET9H1b29RcGjYEBJ9P2jl2l9z+Sd+UeABvQblpq
    JeNIzrTE3U6gI1oBEEYWJ8Mct0nZApmtQzc7WrZ3qnjvFjNN2lYmVmdAQO+5dMsGXOBKmT
    hvc/Jo8p6bLETlEux6L34+JQ2eQr3IURqqH7PkILuIjm6AeYI40IM0OuaHkItmPORAT/zf
    zdG8bAiSnWqTm4FBD8gsHFz1HUJRdEtzmHFztjiYPrAcF9xE2xJV4DQIapRA
X-ME-Proxy: <xmx:RzEsamyTxQG0VeR0oAeSikz1y-jYgRNGfcl1HPoGTb3w1dxF3osDKA>
    <xmx:RzEsarsCZIDXIidixPBI8yzuqpIkUSLGjedzuwjjMKaoT5gV5HvX-w>
    <xmx:RzEsan55A4JShfzL_lxZbYnD45aRWFD7xxMrGnEq9CKtFQynBy79-w>
    <xmx:RzEsaiQCtUaERzRxmsnbDXItJJw8FCSar_8hu8YXsiH5ob3oip10XQ>
    <xmx:SDEsaofVRBMzrPzyppoerITXqRBZs-aPApAhtOXh1rBJDyPoK8vii5E6>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 12:18:15 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v4 2/2] Bluetooth: hci_sync: Remove unused hci_cmd_sync_dequeue_once()
Date: Fri, 12 Jun 2026 12:16:10 -0400
Message-ID: <20260612161753.3140707-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612161753.3140707-1-oss@fourdim.xyz>
References: <20260612161753.3140707-1-oss@fourdim.xyz>
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
index 5a6ffdb84c88..0e44489c5309 100644
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

