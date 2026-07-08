Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD4D426EAE
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783512735; cv=none; b=u/QdW0ia7pV77+CvdnT7HE2Lv7uUwmIrw+sdViXCf+FuxO/EJcammR8ZlpOodPMOGiS4PyuU7UxbgndXIPL5/XLcS02QvjCs8UGDONXGB6Dngd1sC8DPVQvYyOVH1LMtkUdYCI+0va5Cm8hSKq0j9dFe01s/HR0/ipn3o0Qdehc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783512735; c=relaxed/simple;
	bh=v9+JYGieDGep3Ll0kJlC0NlTP6VIlyeVt20LqpD1j30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UNh7+CT62TnM11cjA6HLEs/0TqEWM2sNuIJUwuniG1rP6zBKXlpdnuenWJqK+293MbPa+WBxZXbFPsfqF1IiV4t6xXpY0Pi6mHSe/39dv3mw3a1f2MMI/VwrYFR3PJxhuWXAp2zKJg5YTf/ilDBqh2qbX+Hlx9+5QE/mMNHBzPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rn4iR3qu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rn4iR3qu"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc6dd436c6so6000075ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 05:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783512733; x=1784117533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FNSX/r3PspWrHlM9J6B35qIZrhtVXjMHDa/pGuhyDBM=;
        b=Rn4iR3qukvaefvKUFNrzW40KvFg6AwOnHFsQha420SwMF4zgKv8iO36ZIFRAcdTIB1
         USEBY0w4YhBRHjlQYunmhsqRXwwADELU/KY5IUj9Zi4wmjeg4lC70oFvt7kDoHY1Z0yc
         o4uBUYpxzgbn8mKWQL2JqG2+vFbxOOodb9PoCpEW3gMYmtX+14CHio1QIZxJ9+mTUn5Z
         QRXBe4Ix/H6dIlP236ycR/fAQ+NRnZB+FbFkiMPB3E5581EtBU8LaO8wjfVDYLESvetP
         LhhVMaRYTdKtKrvqwMn6DTQgxE+PUTtK1qFMi93dPoaQ5MORX+Rryn8yR/ncBrYTIScV
         3ZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783512733; x=1784117533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FNSX/r3PspWrHlM9J6B35qIZrhtVXjMHDa/pGuhyDBM=;
        b=Ad/+W/8kqFE+xJPGfXRxXxuNZ5PCZFA4GRKefnVfsbZbdz+HXzQDauDfwNqc4pXtTR
         PtBq97ykZ3o3Q51lvKcL/FtI3IP0VXE6GA88FgYmgldMjl20N+FgyztDyyhtxDgbpi5+
         vjR94pklgy7purkwF+RuBhxlJkwkrj/NMz4k4j+RupAAis9N7KGDyK5BsuzSAjmwgO2u
         szY961+6A+pNQCin7LTb/ksNM4F/9JbAo63aO6g72CixFNxetJA7Le8KaAkZTyvmisM2
         ABwi+fJt0HxsulNiq1hRxxphlOeyQNpzU7GdiVcy527scL//Ws0FKWMvpmyUxLAtUe/t
         iNNg==
X-Forwarded-Encrypted: i=1; AHgh+Rrf/zswF3r/5FEiNuQvasGh86nyo4i97w0ojSufPgWDKePAws+ylcIQ3DuYRT3evBMtnqTfi2RVd+GFRu+NN/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCih1XKg6lV+eY6zkBg9anAHHLDZz45SAwllLT9Zp41Qjapp1d
	kc04/TYD7/ELtGnrginRwhRvk5OymWG5IcQMJCBpKObYUjKrLRvfgw3+Hw70YmbtCQCGnA==
X-Gm-Gg: AfdE7ckup77Fbnw1SOGXiMpjpMvQ8T8DAd1J2GJvnDO7T5K8nlSBW1oFcUIozvODleM
	VRLssG0YlkQtnzg8zUqotFeU9GI+loMa+S78IsJ9tDxl+G2td7ds9Ome5CrfW8CVF35lomDwjzj
	4wPv6S+ynyTQUBDT+l9HOQMNlXr3Y+VX+wIZByvZos6qQZOLKoD0iucQ2SJkOHVKBXpD9vbSalM
	RXdtynErdnZo20poyi9iC/hVUk1uAAgQtFXUAYtgQl4J80ujQ4Yl5aZrblIIx7GZ1BoO98fiiWV
	oMhguyBNVSvF4mAm3Cxnp0+3YS+IT23/pg/wptbOJHtaqGExJgd4TbUpeqG32FWShtIs/AuUQW8
	gSJp3vg325fnngwq54263vJeyxz8RoF2UzWrP6aPUWPIMnuG4m2XyEkLMaD4xL/yFsXMs5+zsaE
	kX4w==
X-Received: by 2002:a17:903:2441:b0:2c9:97a8:aff4 with SMTP id d9443c01a7336-2ccea58783amr23212025ad.45.1783512732976;
        Wed, 08 Jul 2026 05:12:12 -0700 (PDT)
Received: from lgs.. ([118.193.39.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d59e51sm27462695ad.76.2026.07.08.05.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 05:12:12 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] Bluetooth: ISO: check end fragment length before appending
Date: Wed,  8 Jul 2026 20:12:05 +0800
Message-ID: <20260708121205.756886-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ISO fragment reassembly keeps conn->rx_len as the remaining space in
conn->rx_skb.

The ISO_CONT path checks both that a reassembly is in progress and that
the incoming fragment does not exceed the remaining length before
appending it to conn->rx_skb. The ISO_END path only checks that a
reassembly is in progress.

A malformed ISO_END fragment can therefore be larger than the remaining
space in conn->rx_skb. In that case skb_put() advances past the end of
the reassembly buffer before the fragment is copied.

Reject oversized ISO_END fragments the same way ISO_CONT does, and drop
the partially reassembled frame.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 net/bluetooth/iso.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 793a481d7066..f5ca8db3c206 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2639,6 +2639,15 @@ int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb, u16 flags)
 			goto drop;
 		}
 
+		if (skb->len > conn->rx_len) {
+			BT_ERR("End fragment is too long (len %d, expected %d)",
+			       skb->len, conn->rx_len);
+			kfree_skb(conn->rx_skb);
+			conn->rx_skb = NULL;
+			conn->rx_len = 0;
+			goto drop;
+		}
+
 		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
 					  skb->len);
 		conn->rx_len -= skb->len;
-- 
2.43.0

