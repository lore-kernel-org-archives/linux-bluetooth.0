Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FDB2F5491
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752686081; cv=none; b=qbzkD3wddQAPg7iadxjEWxwX7I4eduxV3NxWPq6AalKQ+hYGHqKdShNbCOgG0QjkPFc/NahV594kuA5mCtGW4YiT1/I/t4LozBnmsqqRmXxrUwstzk5gwDS5BF5LKYR1ZHllerNBQF16zfGsK+pVUPZPTZ6RKp3e44cpQUaD0Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752686081; c=relaxed/simple;
	bh=ejJgDd8MpCT57JoOWrwTBC5xvD/+ns3FTHgTDYirhEk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H5veBPzo7g6aw6dJ/d/AG0vUnkz/6VqxXvtdmWnWxV44+kyC+JQJQZp7vLSQjaGuCJEXsEzoA0xgZfx386kM4eCmXI8jANG4u5kssOLLJL3fmk6XN+Nmygb65pZ9+OE5ZDOjP/b3MhFuLjt+M+tc7A1Izl/zHtgBL9BvRhgu+rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=OnWenuOc; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="OnWenuOc"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7490702fc7cso137045b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 10:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1752686078; x=1753290878; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qeBNGJJp3kyBdCsSWxsDFjNHn9eObMtgXl0SO4K/NyY=;
        b=OnWenuOcBJ+NscU+EouZSxVEFtZHWBfZh2cjjxJ4qpSGYLLwT2xCaa+vm/dNTPqoCg
         yZ9R7RKOdwG043L9gWHTCye0Y8JgC/0tuqcF2UOzQEJJtp6bA7K5RgajdBKar93MCkQ8
         KTZTdLrMxVb4/vs5HXdGIKep5LTLnv0+Sq3ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752686078; x=1753290878;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qeBNGJJp3kyBdCsSWxsDFjNHn9eObMtgXl0SO4K/NyY=;
        b=GBYRj6Xu4kYJY0qm1f8q+sfWJp9wMHcjvwYr78OxMHF0aKdetw1p4zbMuqlYOhfI2O
         +A9zuMwdA5JDDGkVYysGBdFsyQPDkX7wfXn3S0balRbbSBmdbVTn+iIXekQ3Esu+2r/F
         ldgo0Ilb0Nas2srIC8rmWI8xBNye4TLiLzPIEoX4nyPh4v2BYMVCf0IfwPAJWvd2Rwok
         MZMW4edRi0NNyhg7Ugj7CdX2Js/ag04OC247dar3l2xbCELsCIDmllcurixQrdZUmWtL
         VqMNPQDQbql5/ro9RF68XTTgQeSkNrCKYCAJv1GXHNWxFWH6WNvoaSeePjzrNJ3fTrpk
         08LA==
X-Gm-Message-State: AOJu0YxcMLryOLkAd5hkFLmmE5CHGSzcsrC6mn9vok4YcgpqEs51ynFe
	n+6bkX8xJyolgFkjYwukKSClTtdOHVWyXL8M05lC1iWDW0uovGIhCUi/Cn1mqDNFvZcMA71g7qr
	QuvFeMzUeFg==
X-Gm-Gg: ASbGncukhZeli7gTy4reTyVJZ5TLvBW5mDTdwX4yQiY30Ww0RJGRrpZKnCL5HvFW11T
	38SKhLoN8cQDb9/amwSHK9PFOSbvZWOijLsnI9IcUcLk+oRITffkvjv8fs69eCgr40mnv7llOYZ
	S2jZNv4qBd5kBOtqdDURDeapV75iBlodWvsD3/CHFiMbTtwfj3QOGoN+Mq3P+bx97TQitqiOv/L
	ISRx6ctLgC2VAQjjJhi8uvLNOBD92dYfcB2a49fs7rUCIQJHj4Ad9G4WBpNrKnDdxAh40A9qhHp
	+qNfV2TAnH6987ap6lsBGlcdFgJU3vJiIbNIV0szsfzeDT+MoP1HELisojOUcy09PshS8Q3lkps
	ux38ByPIESzyKLN7BUtkiETVIuCGh/Zg=
X-Google-Smtp-Source: AGHT+IElKGgfKxTCBTWr/+7lLox2k9YVASZ6P5GjrsMkDgEwyDJzGJJ5DL7tt1YTGHSHLU2xgMgjcg==
X-Received: by 2002:a05:6a00:92a7:b0:74d:f997:1b45 with SMTP id d2e1a72fcca58-756e81a0b16mr7184541b3a.8.1752686078431;
        Wed, 16 Jul 2025 10:14:38 -0700 (PDT)
Received: from localhost ([101.127.220.50])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b3e66e96464sm5253647a12.19.2025.07.16.10.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 10:14:37 -0700 (PDT)
Date: Thu, 17 Jul 2025 01:14:36 +0800
From: Chris Down <chris@chrisdown.name>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com,
	Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Subject: [PATCH] Bluetooth: hci_event: Mask data status from LE ext adv
 reports
Message-ID: <aHfd_H6c9MheDoQP@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.14 (516568dc) (2025-02-20)

The Event_Type field in an LE Extended Advertising Report uses bits 5
and 6 for data status (e.g. fragmentation), not the PDU type itself.

The ext_evt_type_to_legacy() function fails to mask these status bits
before evaluation. This causes valid advertisements with status bits set
(e.g. a fragmented non-connectable advertisement, which ends up showing
as PDU type 0x40) to be misclassified as unknown and subsequently
dropped. This is okay for most checks which use bitwise AND on the
relevant event type bits, but it doesn't work for non-connectable types,
which are checked with '== LE_EXT_ADV_NON_CONN_IND' (that is, zero).

This patch introduces a PDU type mask to ensure only the relevant bits
are evaluated, allowing for the correct translation of all valid
extended advertising packets.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: linux-bluetooth@vger.kernel.org
---
 net/bluetooth/hci_event.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c0eb03e5cbf8..077c93b5fae0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6237,10 +6237,14 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
+#define LE_EXT_ADV_DATA_STATUS_MASK GENMASK(6, 5)
+
 static u8 ext_evt_type_to_legacy(struct hci_dev *hdev, u16 evt_type)
 {
-	if (evt_type & LE_EXT_ADV_LEGACY_PDU) {
-		switch (evt_type) {
+	u16 pdu_type = evt_type & ~LE_EXT_ADV_DATA_STATUS_MASK;
+
+	if (pdu_type & LE_EXT_ADV_LEGACY_PDU) {
+		switch (pdu_type) {
 		case LE_LEGACY_ADV_IND:
 			return LE_ADV_IND;
 		case LE_LEGACY_ADV_DIRECT_IND:
@@ -6257,21 +6261,21 @@ static u8 ext_evt_type_to_legacy(struct hci_dev *hdev, u16 evt_type)
 		goto invalid;
 	}
 
-	if (evt_type & LE_EXT_ADV_CONN_IND) {
-		if (evt_type & LE_EXT_ADV_DIRECT_IND)
+	if (pdu_type & LE_EXT_ADV_CONN_IND) {
+		if (pdu_type & LE_EXT_ADV_DIRECT_IND)
 			return LE_ADV_DIRECT_IND;
 
 		return LE_ADV_IND;
 	}
 
-	if (evt_type & LE_EXT_ADV_SCAN_RSP)
+	if (pdu_type & LE_EXT_ADV_SCAN_RSP)
 		return LE_ADV_SCAN_RSP;
 
-	if (evt_type & LE_EXT_ADV_SCAN_IND)
+	if (pdu_type & LE_EXT_ADV_SCAN_IND)
 		return LE_ADV_SCAN_IND;
 
-	if (evt_type == LE_EXT_ADV_NON_CONN_IND ||
-	    evt_type & LE_EXT_ADV_DIRECT_IND)
+	if (pdu_type == LE_EXT_ADV_NON_CONN_IND ||
+	    pdu_type & LE_EXT_ADV_DIRECT_IND)
 		return LE_ADV_NONCONN_IND;
 
 invalid:
-- 
2.49.0

