Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485DA35A3A9
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 07:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783581611; cv=none; b=Z+nc8etJGpsNaJ2ZuxI1LMxAIzjXIqjGoNM+cwY5z6ylf4p9tnEOXQz7ghVdv/BTMegGL19lEWaOcnoM+wB6kIbFuPQCLj7NbhdmI8zy8hC6ZIahmwdqoeLOQ/687TtPO0gfszHvHnbYj+1AU9k/wN8KlT1leH6egCyNFvtRq+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783581611; c=relaxed/simple;
	bh=ttRt8kVTyY24QC4cVXRavjZuxhkwVLu5Bv6kaeorHic=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=p89BFBcAO6aCoAKBKJxh5lxr7TZXJ9qMZ1T53zxvxZgXSpsVjcEUmGcbz2SOYOj6sPvIMMBOWXvBnrX8+ugLX1t75u8/05ARVvelg/ppA/YjLpv9p/iuqNUibnb7NcnARVeFfm4EbLQhSm2befx/4Hoyp4t6xpX/UGIWwulxuE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=su0SrXNV; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="su0SrXNV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783581595; bh=jaHeTN2b3tilUe3vtWw7BcWd9HMPc++S15Dza8276nE=;
	h=From:To:Cc:Subject:Date;
	b=su0SrXNVo95jfaVYWMZ21XGJVVvHkIP7bXwIwi9ATX9hvSFDLFStd1awUBYAGN7Bh
	 5SzS3kD1QYwQTGDgO0l4RDJMXg2CWzFC2D9ZcItYgcueISTRabAmTfIMLkEQGDQePE
	 Hy9o159I12re+njZrzQtJfTBife76uUjiQVt4wjM=
Received: from caitao123456-pc.. ([116.128.244.169])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 4F5B1026; Thu, 09 Jul 2026 15:19:53 +0800
X-QQ-mid: xmsmtpt1783581593tqpq75geq
Message-ID: <tencent_3C5C860091EDE98DB4B649EA03E82587A607@qq.com>
X-QQ-XMAILINFO: NEMPemWw9FvgNmt5gANW5w4cexb2XzgqW43tfr9vRojXkUw0V9e/hee8wy09ka
	 fD7RYsDeuCiSISEMzJXbDuuOXJIuWsBETQJGlq2u66KPQKXmF95F5Z09H2GmhlGKz/yS5zsYG/gZ
	 VEsj3i7vApN6TyJ+W1WjH3QcqfBS/t6Z5NVGn9+/nrlLqcDSOKG6+6e1CYJE8xm/SYp+VeIjSfH2
	 ltfb6sZj+/kTwSr13iCxLTMwU0MHbFTmAqXPV4FXdwufkDLi9RBfi/jvPfoJe6P2L1qCEqJ+J8Ow
	 oWebc67VZnolTND54GCoEQwBxM5e4/q7c4bWiXxDXj/kNMWJsPkpCRt/eS367MlLZGhMzsWrl9et
	 VnA1Ox8FjuGEY1BseBszwYi20aNxRZYS7LGKyHwu7N8wXVlHAy2GotoCBTSA6Xopm1at2/Ef3/qD
	 diQ7F2QQtHO/7zntGERG7CXkU+KMQIH3XwwZM3+pT30aumeffrcxMSHDH2e85tqZm0pUpfgMwLs+
	 i8fN75jWj/iZc/juVQRxHoWFGKcdvqpeZ45EVJLyaU0iO8RVhwEBxKBie3RqfiSMB/Srx/PqmCJL
	 hZDq/MLnwrvtLPBqLn1AUaEAgsssd9xqmPoDFR3Hr27pI3hhBh0X1V8KROXm7/lMPO/LHcncYHqH
	 v+c57z0VQtA1PJWAI53nxQ+vl20pQtcbpxey81OZb1Oa3iQCSjGf3Fco8t5uUufTUCvfEmEPGzzv
	 Q2ub+wgnQBZv8tmwh5IbUVKulUBsnocK4bPqXQKXNSam1buIQjhfiQ0+r1znmgbRJcS038H7QV18
	 Db5dNwwPSXaWc7aNx0SmiNLALwktJmoFXJyQBkeL0ac3f+t+qxKU53EuvLXyePTSDcKOHCdn9AkB
	 SkomaZ/V/xAddUbBbr/W65V39LVcXigjFxn3FBq2zXAgqYu9e/Y41od3cLQM0DgAzaHvKUvUUqLM
	 6Ez6NF5jfzEqdm4hRrsHOZT9azR6/LNo4QS9TnLKDynVRRXvU7OuWCUvSsdvmiIacS1/NM3y4yte
	 i3n99z6BLnAiTHmHm51fsL/GRYbIU=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: caitao <294305068@qq.com>
To: linux-bluetooth@vger.kernel.org
Cc: caitao <caitao@kylinos.cn>
Subject: [PATCH] Bluetooth: MGMT: Add length check in confirm_name
Date: Thu,  9 Jul 2026 15:19:44 +0800
X-OQ-MSGID: <20260709071944.248934-1-294305068@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: caitao <caitao@kylinos.cn>

The confirm_name function did not validate the length of the incoming
data before accessing the mgmt_cp_confirm_name structure, which could
lead to out-of-bounds reads if a short packet was sent.

Add a length check at the beginning of the function to ensure the data
is at least sizeof(struct mgmt_cp_confirm_name). If the check fails,
return MGMT_STATUS_INVALID_PARAMS without accessing the invalid data.

Signed-off-by: caitao <caitao@kylinos.cn>
---
 net/bluetooth/mgmt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a0a491e5311e..aab8e64283aa 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6271,6 +6271,10 @@ static int confirm_name(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
+	if (len < sizeof(*cp))
+		return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_CONFIRM_NAME,
+					 MGMT_STATUS_INVALID_PARAMS, NULL, 0);
+
 	hci_dev_lock(hdev);
 
 	if (!hci_discovery_active(hdev)) {
-- 
2.43.0

