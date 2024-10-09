Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652941E0E16
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Oct 2024 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495727; cv=none; b=mX7ciQx3kQ3iH0jvwRxfv9QaO6k0an01MxD1U9e/SD822f7cZ/NuW9QQaVv/SdnKgXfhgvUy47HcfF3c+qG57JqOHF4OY8LPT5DiZ1ELJa/YDf6e07fHbRQX6YCspE4dsPok1WSEtjOXxGGEhICpsaL1xbBGENB3KKxrccE69XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495727; c=relaxed/simple;
	bh=mKRaqqrTDqsjJiGT5HqYOVAvwqO16cHV5uyotgYW5ww=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZrjPkfm2Iv8KW9lQvHSNd8UdEkBUk8jjMIo5jQAZW7ADzRCX5WCpkLYDDR4ooxYl/tloGt6XnxkW35nrOraa05hbvZJTv650nqG3ftD8Lu9QhGKlkbY/c3ZSFHdmZHpZ+BymadDAHdALRr+dvA+bT9cjBzL+1T8tC4RqEOVdV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwm03hC0; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwm03hC0"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e2908e8d45eso451648276.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Oct 2024 10:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728495725; x=1729100525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYNUEVyY6t3O86bI0XZXWo8P5jtZ/LYl1bjt0nJaaBQ=;
        b=lwm03hC0Z7KtKH7tlR6262SSkuZCgrA30gUh+SvYtV34C9oo7tXgL+GjCcZ1c+TrbQ
         AQtKOaUVThso+VC7uteSQXzhFLkMMVr/UUpAxBDkvot+g9Ew2MOvUVG2rRZuzcmjtivF
         uwWoEZMGBTmHdSCj5ulVkQgXGqlkQOumIP+ArzTKdyZxsbVW76WDVJzoe4z2qbMTMMqf
         nV9geZgdtS7XzHY07fcLxWCKFZ+XGzEblql8hISAmff5yCYpBUcMQmBdl2L5H0W1zB95
         J2vBtb4ApkgzSVIzaoaYFifTRzXYPrl2EHjj6HRTdHk+CZwUGjM+a+TD6rVa5S4cSDqx
         9S2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728495725; x=1729100525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYNUEVyY6t3O86bI0XZXWo8P5jtZ/LYl1bjt0nJaaBQ=;
        b=AC/+P7bhK3PenyOvZzTqBggS0qM6I8JmjU10y3qVJpVb+mPDUCtDffr+DED3pmn2YF
         dSRuuMOZEITI82tr9pyQN0p3GgCcwQNZG3c7OnXP/C5GD2K+vNj78MokRlNZQJy9kkRl
         98fXSMNtO62XbssNwzzwcuPdj40EmULeo2CheBKaBVIJkh3RfvNBiVOLjON95GRc2BOL
         ZfKKaLqI3AIReHA28wH8ad0zQ1JipjSbK0Wy7EO9mMblh213if98VkJ9m6kJ38sxsMeQ
         kwXZ9NbWakEeS7a/jEoKPilfMOBttucwpfc0P5LbH6l7Q+sYs/N3so7RVduETnRFXxi2
         Mbcw==
X-Gm-Message-State: AOJu0YwH3jn35bo0dJyyB1OoagC42nr7ZlX4rmulNQau+mUidd0+t2gL
	bjtOpr8SRPU/HvOJx+KxfaylBZKO9us7qP2OOrVTVW0dgZ64pzK86cOoWWDs
X-Google-Smtp-Source: AGHT+IGo3kECjQ6tEDcHTOMp+fHt9kwSsyPd8ZyHIQyJywQhQ5wMPo6jRgcTHlVYgSelE3oF01cnGg==
X-Received: by 2002:a05:6902:c03:b0:e28:eaed:3244 with SMTP id 3f1490d57ef6-e28fe420229mr2090403276.55.1728495724593;
        Wed, 09 Oct 2024 10:42:04 -0700 (PDT)
Received: from lvondent-mobl5.safetynetaccess.com ([50.204.57.18])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e28a5c3755fsm1850405276.17.2024.10.09.10.42.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:42:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: hci_core: Fix not checking skb length on hci_scodata_packet
Date: Wed,  9 Oct 2024 13:41:59 -0400
Message-ID: <20241009174159.15658-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009174159.15658-1-luiz.dentz@gmail.com>
References: <20241009174159.15658-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes not checking if skb really contains an SCO header otherwise
the code may attempt to access some uninitilized/invalid memory past the
valid skb->data.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d5f917076e0e..779c4aeaef22 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3808,18 +3808,22 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 /* SCO data packet */
 static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_sco_hdr *hdr = (void *) skb->data;
+	struct hci_sco_hdr *hdr;
 	struct hci_conn *conn;
 	__u16 handle, flags;
 
-	skb_pull(skb, HCI_SCO_HDR_SIZE);
+	hdr = skb_pull_data(skb, sizeof(*hdr));
+	if (!hdr) {
+		bt_dev_err(hdev, "SCO packet too small");
+		goto drop;
+	}
 
 	handle = __le16_to_cpu(hdr->handle);
 	flags  = hci_flags(handle);
 	handle = hci_handle(handle);
 
-	BT_DBG("%s len %d handle 0x%4.4x flags 0x%4.4x", hdev->name, skb->len,
-	       handle, flags);
+	bt_dev_dbg(hdev, "len %d handle 0x%4.4x flags 0x%4.4x", skb->len,
+		   handle, flags);
 
 	hdev->stat.sco_rx++;
 
@@ -3837,6 +3841,7 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 				       handle);
 	}
 
+drop:
 	kfree_skb(skb);
 }
 
-- 
2.46.2

