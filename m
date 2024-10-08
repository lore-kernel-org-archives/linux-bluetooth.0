Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CB0DF71
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Oct 2024 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728402015; cv=none; b=m3RVhz3jbb+ecFc5EaWI+AzEzeDRZp/ax7QARkgdEJSkJSTAGLJhgF7H/Id4XBipLhivuhN9mFzxL7q63gboz2Luchsc4rAEeduAfrFEXLiNP2+eXRWc60Aaq0RncfQFzB05ickshYNqBEOAjhU3LMmmDMA9VY9Pexe8GvZ0R5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728402015; c=relaxed/simple;
	bh=9ogav7tvCq3mr4R4Qtr3XDeaG07xIixxnGkZK9Lejfc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WP/h+vgx11d5unpu/6RRYy1FAMwgRy2YTUlPCT2Q2H7zx1cL44P3QYE96jdKbuHURyiGpzmGliiTO/B1qHTeBY7qbY36Wz1/jLGLwi4CtUgjsmdoNi1q/Hhy7sj2vJsI7pWLSJ03tk2L2/s+80+PuA9HdBHBplb+j/yKEoOo3Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJNw6bIw; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJNw6bIw"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-710e489860bso2994564a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Oct 2024 08:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728402011; x=1729006811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=13TgSGIvfwmAijIF7qwuCiqdeSBpqVT2dwtZm/OOmqQ=;
        b=NJNw6bIwt7dRHKAZXK0CC10TcLeNVpT5IdiOjqs4yshYWEc2GaWRhcdJH6unYpefdA
         bMuMZe4mYHKe0UteHMORd9m/LTSBuuxt8U/X6h25Q8RWReahr3tLPuK8JafXB0I4mxAc
         FFGOHKfzK+ETWN++fgah3+ETv1gV2DMtfQl48i/M3E9xxTK2eqOiRKlrrp2/vqqyGftW
         ltgZ/2CnmQzbpQcoilTlyNrTiS/OFYHhcB4G8zMtpEDybEpfIUx0dyqFjWr/TbmsHJhe
         M8jZJ/BaoS790JpbabCef/yrtoBxpC+A12PbXPe7a896G+E0fVi3UVF+yJkFBDw3k5qu
         CFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728402011; x=1729006811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13TgSGIvfwmAijIF7qwuCiqdeSBpqVT2dwtZm/OOmqQ=;
        b=pwug6B7cMZtCcGc9sTvob1u7Nib74+vDP5Dvcg6WBR+EuqWAgDOwRZqYQFlF3XixaG
         6ltbnldweoIvWkW1WOX1dRIzqHcvdF4OJDR3wSTZPdnp9hYgVaf0UXiIF2iBljZzqSxZ
         6RZNdLN44PoDS7vmoIplXRdVoLSNUNXweau8el6k1C0+SNcQ2WZWf0qvFtnzqJY02Lrc
         nDY5FvygNEun+I10OMuN6jJOv81o+G3DS4AzLMZDKHG0/2FEaJsCssHBdgF7RhBxCkxh
         Jn+aESlp+kj886w710E2YcrOkLNd8nU5ixN85BwudJubZQytgV7KvODSNX5V5hJ789en
         BZWQ==
X-Gm-Message-State: AOJu0YwGM7uVCmJqmTjkvfz2ZaUHTGsyLPOez4MuWgE6yJRIy1uG5KQa
	v8SRdSfTXpBG+nLYxqbBIAV2gkureu4yR4TzRzAlgBYV4A3E7vbkXon0rw==
X-Google-Smtp-Source: AGHT+IHe5ZEvdZCs/MHd7yonW58DwHbP9LMwo8NG/VlmNDiEc6oKaZPqcZrNFwWSiR+JwKhk+hOgvQ==
X-Received: by 2002:a05:6830:3c8f:b0:703:6a50:9097 with SMTP id 46e09a7af769-7154e837169mr15591194a34.8.1728402011508;
        Tue, 08 Oct 2024 08:40:11 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-84f95e3f19asm374840241.8.2024.10.08.08.40.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 08:40:09 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/2] Bluetooth: hci_core: Fix not checking skb length on hci_scodata_packet
Date: Tue,  8 Oct 2024 11:40:05 -0400
Message-ID: <20241008154005.595169-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241008154005.595169-1-luiz.dentz@gmail.com>
References: <20241008154005.595169-1-luiz.dentz@gmail.com>
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
index d5f917076e0e..462522098129 100644
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
+	bt_dev_dbg(hdev, "%s len %d handle 0x%4.4x flags 0x%4.4x", skb->len,
+		   handle, flags);
 
 	hdev->stat.sco_rx++;
 
@@ -3837,6 +3841,7 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 				       handle);
 	}
 
+drop:
 	kfree_skb(skb);
 }
 
-- 
2.46.1

