Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A48E33AD85
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246003; cv=none; b=XRnw8tMAxX6i6Sol6qo00HoD+aqaECvEEwAUthVxXriU9ET5Vvx164Z3q10Oi1ZLg4rG8WKXk3mkS4CqNnybT96k8YOYmjHOtmMQVufwYyfrqvPZrUXjD5PYCSwjLYF1fI2RmRLZ/3XhqcHrslPk3gQsjH23+x9vOkl8C12s6hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246003; c=relaxed/simple;
	bh=EpNzryHPEiGsS8/eLlj2aFiU863WKxYEngUmLZTgUmM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MVAePF268DXSayMREJDCyzO28Xbosk1B6ZgvvkF81Q9xmFaM3mEBubpyCNdewZKYl4yMH0SDkw3HTN4SzISu2QC/MOkZLrSMDwduDQ7+/Pg++WkHf5y2M92ICXyDS4lcRdbH8Lw2ROVICV58tbu37ZItXikEa7G1p2kkHYGbI7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDFGKMbl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDFGKMbl"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b458ca2296so22972815ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 02:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776246001; x=1776850801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5MTAo1pQuUr8JOxp61jCXD+pEzmxX8+JTnJmhdjAu2s=;
        b=CDFGKMblOZp3LgjjYD8OP/RkeGmfT8odHcg7w6udU4M6RTB3aPps8kKFPpkMsn1TCd
         hcd+JzUUDPfTZIbYz/Bbn6GU24yDTDkwFd39gPN7rflMvUoQ+cDfjaJ3gZdFs/gXJmVJ
         itpm/W8jVe9oAqY4eCg3DbPFpBTkHOTtQRF91yLqKVAXhMSZSRAoKnmPxgO06KDizxhB
         Uymf7kphjm2so8oDyI7iNGu3YJNvlls4A6qaUjQDsYHDuzU3hGeFdBUAuRm59X8VzJ8u
         cqJscTmz1oaV8qnxMj+Pf5tp/t9924DWpN2lPPzdWEjRjOeESIeFvTOB9OAgc2UI7sHV
         RPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776246001; x=1776850801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MTAo1pQuUr8JOxp61jCXD+pEzmxX8+JTnJmhdjAu2s=;
        b=jkrNqLMlcRdwugrlj1vJZ/Q6JBTjCV2dHEYQ8mpbUk0ABmpyw/XljPjtD2Qm5GgzQx
         tJ7pmYZSmZiLFAtNTsEH4REmqv4TpCveWPX1nrGEwLWmlak6/rrP4pmKGi7YJ/T05FS7
         5F7nlp2JkN4buOsZCe8gOlnlwti+Ndt2o5N4dxk0GCG2PjM5FRgn/c6Pmj6+9xYN+uzz
         5NbTJr5N5fLZ4a7MtlJPaZo9xStMyN9ncfzz90d1GhY5NhJcq4W3lz5geXYjcL5lyJNI
         g4ESUwrR8Evtx2gcxG82lu4/E5AChdeeZ4dt5qvYimdtMguODPgvdKF2X+/gJJLoZ2Ya
         7l5Q==
X-Gm-Message-State: AOJu0YyYVs12e3CkIgVBZlU7Jxp3eAvlIRYWzW/A+voVwPo3ITlHbLs9
	qUBaCsQ0J1JNLOF2MlgFkfGTtezNK14E86HLQupgTX6zcAblihNHYSNRAM9zPg==
X-Gm-Gg: AeBDietHViBLaRkWrk9/gVwdtiNRWmErMu0UHkkej8fwhAp72yb92+g1vIzDhLvkj7t
	lpnl+nqgtGDaOaW+SyJtBsHnGLI7F2NLLRrllik0zNFnS2G884yYNNhfbGdXpkl1hlo0DPf8t8I
	IQ6GqeIWQAiPyQzsuCYi1z4wWOZCiI0DTUpCVpXO9FP3QC9nHvYWnwa0/skx9nkRjS8DUImPCU0
	fAcbPRgtlRzov9neTJYEWbVw1JlWkJnTN/7POfzg4ud7LD25PU1dpFMTxNSHtP5Lj7Bfm7bzT0C
	MlDem5gND+g7MlvVfJN6TP762Lsvn+SqSXGo2BMvdG9bycFUW/edn4dEsts/WrKsIxTMsM5v2bG
	2cindwEiLU6QKP38aZVDLwQoHuNdZq8P8CoI9TR3PZ9bOpX8jXdRpmWqFn8S1BDiQES+mrRq48w
	6TiX23CsDNPPd9JolH9HU2Fi1WFPdGVdnpuB8IhUm/sHbZSGADG4P/oRs=
X-Received: by 2002:a17:903:3d07:b0:2b0:ac1e:9737 with SMTP id d9443c01a7336-2b2d597d19fmr213952075ad.12.1776246001166;
        Wed, 15 Apr 2026 02:40:01 -0700 (PDT)
Received: from localhost.localdomain ([218.253.131.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782b1174sm19638585ad.70.2026.04.15.02.39.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Apr 2026 02:40:00 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	Dudu Lu <phx0fer@gmail.com>
Subject: [PATCH] Bluetooth: bnep: fix incorrect length parsing in bnep_rx_frame() extension handling
Date: Wed, 15 Apr 2026 17:39:53 +0800
Message-Id: <20260415093953.39340-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bnep_rx_frame(), the BNEP_FILTER_NET_TYPE_SET and
BNEP_FILTER_MULTI_ADDR_SET extension header parsing has two bugs:

1) The 2-byte length field is read with *(u16 *)(skb->data + 1), which
   performs a native-endian read. The BNEP protocol specifies this field
   in big-endian (network byte order), and the same file correctly uses
   get_unaligned_be16() for the identical fields in
   bnep_ctrl_set_netfilter() and bnep_ctrl_set_mcfilter().

2) The length is multiplied by 2, but unlike BNEP_SETUP_CONN_REQ where
   the length byte counts UUID pairs (requiring * 2 for two UUIDs per
   entry), the filter extension length field already represents the total
   data size in bytes. This is confirmed by bnep_ctrl_set_netfilter()
   which reads the same field as a byte count and divides by 4 to get
   the number of filter entries.

   The bogus * 2 means skb_pull advances twice as far as it should,
   either dropping valid data from the next header or causing the pull
   to fail entirely when the doubled length exceeds the remaining skb.

Fix by splitting the pull into two steps: first use skb_pull_data() to
safely pull and validate the 3-byte fixed header (ctrl type + length),
then pull the variable-length data using the properly decoded length.

Fixes: bf8b9a9cb77b ("Bluetooth: bnep: Add support to extended headers of control frames")
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
 net/bluetooth/bnep/core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index d44987d4515c..853c8d7644b5 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -330,11 +330,18 @@ static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 				goto badframe;
 			break;
 		case BNEP_FILTER_MULTI_ADDR_SET:
-		case BNEP_FILTER_NET_TYPE_SET:
-			/* Pull: ctrl type (1 b), len (2 b), data (len bytes) */
-			if (!skb_pull(skb, 3 + *(u16 *)(skb->data + 1) * 2))
+		case BNEP_FILTER_NET_TYPE_SET: {
+			u8 *hdr;
+
+			/* Pull ctrl type (1 b) + len (2 b) */
+			hdr = skb_pull_data(skb, 3);
+			if (!hdr)
+				goto badframe;
+			/* Pull data (len bytes); length is big-endian */
+			if (!skb_pull(skb, get_unaligned_be16(&hdr[1])))
 				goto badframe;
 			break;
+		}
 		default:
 			kfree_skb(skb);
 			return 0;
-- 
2.39.3 (Apple Git-145)

