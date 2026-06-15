Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A013F39CF
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529126; cv=none; b=dv4pLkYLEYxrs7gAalalfLZMkravj7YBvODUQMy1Bi5ysVlQRqchkq00xJBYjs05MnNh+icCX0DLaHxA60aUyZ20VfCVC1HYBeN7rf8+wJI/31OsTFO573ds0BAMOkR5wT5RFS+Ls3mhG+Z2Zam13NoQvZhbxbL70Sq5n9HpTh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529126; c=relaxed/simple;
	bh=uf9SKebbxxPheXVseMElRZWQAGdE+EVTIExQoPIC500=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwxIE5F0uNljP3T8/98A2f9VQD1IvM1mMVPHhF477udGnPVfzDQ9ghLrjEhWvI263zyq2B3WkK3/oZT43cyL1ZaYlPD5hEZBKkLN9wCyumd3M6pb9IS9lb2Z3PS+Jh1EzdacmaRKsxI8FLcBUytaV1DrQBHOs10T3dV36uKHxyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=NvWVf+42; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fZusRzig; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="NvWVf+42";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fZusRzig"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 69FAD7A00A3;
	Mon, 15 Jun 2026 09:12:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 15 Jun 2026 09:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1781529124; x=
	1781615524; bh=SOWezJ8+OHE1XHO/mRJwnKDiO+foSPUCXpB1IoLX9bc=; b=N
	vWVf+42FxJ6BE7ctpoHIn8/9UVxIjp12iaB31GtYY4L7Af4oBNBOrJ4VIc2Yedn0
	/lQaFztqu7//EP4D/zYrG7+v/78G/LDtYWxavQA8Gxo8i5SUJfsJMbMrsIOywSsf
	rn0Q+pPUr/9bXviu0yE4/onkjZ8Ctg0y1FS1Khc4T3HL/x87ZRkr+xusodv8A5EL
	l5NK1Akb2/e8MlVWF3tHuSyJgFO2iWD6tk22jR6Vy83ynnuZbdVz4mHDm1uH6YyE
	OR4WlNpSvDsYzgluKM/TaR6qq1IkaiSKQY/0y90Qhxk+TME+L0wFqS/5k9Do4FMi
	Khkdr9VK+94rMCFfSsxaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781529124; x=1781615524; bh=S
	OWezJ8+OHE1XHO/mRJwnKDiO+foSPUCXpB1IoLX9bc=; b=fZusRzigQz5LLmUn2
	4SuWLilN8ZAVG/V8sSE9amvGWmAgcy8g1H/rSMs7blx2SGtdT29KDfDFBgalDGcf
	y26wPJTSGITp99fotd/789AtIkFo32dvDWbL1FHprVtMKqi+pcTVY/2Drw3s4fiX
	5MJAGmXf0U7bmUFRN7soHBAq1w677NjyV6llYg6CWvGJQ8YZvi63oSV49OMcp+yZ
	yxq6bMPXp5ep/AqK3KygXQRZSgTlZ+sMYACCYoxUDB7bkCRVJCByrDkshnaN7f7r
	i3OA6yrgRyvshrFe13YyEYzuL9sU0y9sr3UKyCaJ/e8sHz2Cw9FoDNpkZgkWPD2c
	/t/8w==
X-ME-Sender: <xms:JPovamPn6jD-fbJ7GjOL-qhJfPZQ03j1JBnB1yPO77msPj68G89c4w>
    <xme:JPovar1dWCRABCfOdUZ5lw91BsEJ51G9T5QIjBqDSGvCobsbUw6XhvQE88NsVNBIZ
    FcmMXIoMYpOkOaYel6CDSSgjRfWeDsmr9wZ2bqIYUDxw43q5ArCgA>
X-ME-Received: <xmr:JPovallKJtHBfPZSeK6oJrrxS8UIplCaeoIOt-VK9FPX7Xcpixkx-0X1zsoFxIoFFlHAkEk>
X-ME-Proxy-Cause: dmFkZTGcywQuBnI/EhZ+3U4t6RfmP8IduYRhpbLsaLAxk5rKHXbwHT0XJG7a8H+FLtVRMZ
    wKx09+PAncitSOn5rP9mqkaRG4T/6CZWH/nB1MaBHUUdYwSpbVWz0qSZHIo3/9fjwFSFp4
    SmSER2rszvZvrnSGUb9gYrgj4wq2l3ceoioJv3FB6B6e9o5XMrjBtPjwHWNpD2sBCin17O
    vn+RJ+aztksDHvgP3fexkzWvJVYSPtXFqUorK8scl1ra/zcVyROxOBxg/JqyNLJnmjv4Jz
    6R8HanGliGrCu0IOgDipq0WbfRIkfIX1HIpl5TJhH8y1tcJ9JJZ+dHlRm/BOuKv9Kta5UO
    OZknf5axfZybtM8BK/xTKUiVfUSahs3xBSmzjQaA8SxueqQBJnpVx624CeazJUgIYmosx3
    1GtN6LPuAOl17uSAGJpTKnlW6jJGRE1b9q3rpO/hIANYCavKPcwl3KymWQvYGK2QyUNhvr
    GhV/n69iVKh3mLqKpHQvdguaWvUEWnm4jF6B4vTDpl3as+coGhBJa8z+rVGiIiouzRUiaT
    olJ7jkEUs6uv/4nMhiFS3TmGW9u+6ZCAaD8Z/NLXlp1mhlQYDnAmJdVyPfVM2RM9toHj6V
    l1bU1vgsYllpFg8FJu6Zf67KSkAk1yMJDuzQLOOT72mytgCIyqiM134ECVBA
X-ME-Proxy: <xmx:JPovaiXIxrFt2UxJid9y3rKmWqqoYzghB93IjjXQwVqmuxsLbAbatA>
    <xmx:JPovarsyphZbKnvFU2rApZzOoNEZ-BrKl3gbk8ic-eGexgDwFrph2A>
    <xmx:JPovalb1t-j7gQQYHrGsaCYop8pAnrm5-p0Z19lD5Ql8qZDCzKwdTg>
    <xmx:JPovaqUBQHKLTEylsimlil3Q_Y5g8AShjJ_a6gVmEEWcnOB6rDzJKg>
    <xmx:JPovar2HET7LHD7kSSeY4t6-oSv7pWjmq90UDwGvtoN70ZIcSbshEmM_>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 09:12:03 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Pauli Virtanen <pav@iki.fi>,
	XIAO WU <xiaowu.417@qq.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v5 2/2] Bluetooth: hci_sync: Remove unused hci_cmd_sync_dequeue_once()
Date: Mon, 15 Jun 2026 09:10:55 -0400
Message-ID: <20260615131131.1459372-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615131131.1459372-1-oss@fourdim.xyz>
References: <20260615131131.1459372-1-oss@fourdim.xyz>
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
index 06b87e9cd999..7410c640d4ff 100644
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

