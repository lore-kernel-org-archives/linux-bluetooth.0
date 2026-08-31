Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0185F3E49C0
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170390; cv=none; b=Mg0K+1QipuQfRhXXelz2Myb3ls+7uNmrXyhANH53fEFZlajbHHiEArl2EyJ04oLT6lsDTB1l22NGSQ+fPze5d1lb/EWN2AV3XCkf2yu5uxkOb4FsKfR8mU2OD8dD+9s79fxgUeY6LRUntNUwtNaXqSxrXElbLt1Znqbs9cvHxFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170390; c=relaxed/simple;
	bh=lKg7QWSQkaKWdhrt/8jU5HFtGKDAfOSrr1yOX51qu/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLjz7CoSbujCNN1hh+FhYVLKZJZcqa+kq8FDQlB0dDzwppOH35E2F+i9AzO5QVJZw6qJI3oloxk4U3j4IEqhx4Dox3T7SUN1tNV+nV92pRSCFBuW8F3Uht6ux/e8QzCMQ2rvIOB4Jyk/dDrWV7J1OGhU6vaoPhcCaxNQBF8sUAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnYTqLXW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnYTqLXW"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc891373e0so28138055ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 02:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788170388; x=1788775188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+g24sLj9lBZO0873hmeHK2aiHPKKlVEYPXZG2TjfcJg=;
        b=bnYTqLXWwZI2aBS1Er2KsJK7pD1DHlD2vczNkNlliDYvx9v+S9WsdrzJ88h3Y/ZgDT
         IvwMiPGlAADNsHqgA0llcTccFIqjnyNJ8z4xlTRVB9Ko9RbFe0cqTGqvIoXT+kHPwCGe
         4PSY+RJWxjr9x1U9+lxyQRhDEuHvlWdWnDQBJqfcAMG/eVBJR6UT+Nxpdsqk5W0KcdGb
         fWEvH84Qs/okWOpa1B4wuohrCUOsSJ3DeZ9ySKxf6TK3tnfAd5XStWGjcZhr1P35FicA
         nkLKmFQ67Xuqp85OVfprJUhfK7tIUobPHZ6vNYPJnDYSnAtw3hC8spd/zNi3WyN7w8ZH
         EMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788170388; x=1788775188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+g24sLj9lBZO0873hmeHK2aiHPKKlVEYPXZG2TjfcJg=;
        b=fO1c8b26vBuq/TXTSgHNEkd/HK3QAAE/qTBfl4rIbkCcSZuNWSEbIEdgXO7Emzo0G6
         fHnItxAAbOnP0ltEFZGx5LeFHD1Cpepm7v+EgJ6JDei1uxIyr2JKmYbzf6OOgDIV2gVy
         OERkrKKqIpMqU+Rtd4pmZEHJowdV+mJH2neGURJ3nDdTdlCRDkvuYd8esF1Mk0TlSimr
         Bzlq9mWqrMG613uv26HztaGFWQNs5c/Qc9/Y4aRoN6ofFMml26tY7wmMFqTVLqvp5Yly
         sQRxqOZoXySXGLykuONMVGPMoNMPt/cZ/IAXXGPTZNpgW6E85unf5/+P5Xck7AE7ZcvX
         4+8g==
X-Gm-Message-State: AFuF++kz3XPZVu2KrjnnCtlTeT2xY8MR+L82Esde21pcLJx0ATRTr3YQ
	0dArFirby5PFf0ubhWR29lPNZmNQXyoPHigSYE91CFSWiSzz7dNOaVQjeEs1qCx1
X-Gm-Gg: AR+sD12p5U+foqGYMacr97/gFQAR+OGaff6NCXyl8ZlzsDRf4LVN0uAqyp3LCkRohG4
	/ozmXm/rClfdzpkXinv0eTAILk54lZ0FdPkMI3fzEu4SZft/nnCr1vqMexydyDvyQ3KvquHNloB
	hS5tkx/vxl0Rpkj/rAI2lVQlCt1OA9q0ouKrYPZtRpjZ8W+d7XZaa6/FvLnU3C1Db3GRtXw8NM2
	exOu+5SYjHyyiqmU+OYF+ZlraTYcb/iQWuHEV/KQjYreZZCcURmO09V1c3e3uECPglznWio/cTw
	wVAm7yLY6D+cXvs5YEstevhkk8P4rQkvXGSK1BZQuG2GvHceIEiNFjyZ7J8wjlwGXEqRK2WLsXw
	cdUPK3FYKZ7/HUwo8TbcPjJFBe1mrB0HA0WXl11/Apm7dIcBAbk17EaY0SwU/Mf8MUY72UZOmRz
	T57DE7EwG+IMm7Y+8B3AiWD8yTZTMTg2VEAh01oVaQljjk3jhSTsB1tpWFahx7XSf/AIyoqMTda
	ml2f/01uarRcdSXwQroWymm4/5PJ41zlfn+ak24JPYbiN0inyT34tipGMuaEOW8loBaH5YATJgL
	Ii2sCQV8UbjGWT5LBpwjVSzwd5l8SzkPTKWQ/WYpX9EOsWzOOToDRam7WJhWh/9EUOigQrfUZjL
	ZYjYYBhJlBqQF3rSj93mniWAEIILEmJa3w0jQnOdo50BehOY=
X-Received: by 2002:a17:902:ec82:b0:2d6:3c2f:6a4 with SMTP id d9443c01a7336-2d74df293c5mr315489125ad.13.1788170388180;
        Mon, 31 Aug 2026 02:59:48 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d759640becsm32270775ad.36.2026.08.31.02.59.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 02:59:47 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	ali@iusegentoo.com,
	kiraank@gmail.com,
	kiran.k@intel.com,
	ravishankar.srivatsa@intel.com,
	amit.k.bag@intel.com,
	Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Subject: [PATCH v3 3/3] Bluetooth: btintel: propagate version TLV parsing errors
Date: Mon, 31 Aug 2026 15:44:23 +0545
Message-ID: <20260831095923.18830-4-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260831095923.18830-1-acharyalaxman8848@gmail.com>
References: <20260814171503.42684-1-acharyalaxman8848@gmail.com>
 <20260831095923.18830-1-acharyalaxman8848@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btintel_read_version_tlv() ignores the parser return value, so setup
continues with partially initialized version data after a malformed TLV
causes parsing to stop.

Return the parser error to the caller so an invalid response fails setup
instead of being treated as successful. Keep this behavioral change
separate from the bounds checks so it can be reverted independently if
an existing controller sends malformed data.

Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Reviewed-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 drivers/bluetooth/btintel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 887170534..964d2de30 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -723,6 +723,7 @@ static int btintel_read_version_tlv(struct hci_dev *hdev,
 {
 	struct sk_buff *skb;
 	const u8 param[1] = { 0xFF };
+	int err;
 
 	if (!version)
 		return -EINVAL;
@@ -741,10 +742,10 @@ static int btintel_read_version_tlv(struct hci_dev *hdev,
 		return -EIO;
 	}
 
-	btintel_parse_version_tlv(hdev, version, skb);
+	err = btintel_parse_version_tlv(hdev, version, skb);
 
 	kfree_skb(skb);
-	return 0;
+	return err;
 }
 
 /* ------- REGMAP IBT SUPPORT ------- */
-- 
2.51.2

