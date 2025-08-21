Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B2C2EC546
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784049; cv=none; b=fbQ7xTdeVwXu+e23riRSauVxefKFkbYXsIiPSTJjR6UO5I+InC12K92yaH7SJ2MTP6W+nFiozHx1Y5o3GMa6Id3gDSKzrv4hWUW5rLeSYNgsjC8pwGS91gYNvJVwYgnFYFabjFGVXXQIVZX1TQyJtDEzBZ6ZNKXPTjhCVzPEW04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784049; c=relaxed/simple;
	bh=NFRuNF1cm67+To8ZpQQQLiZLHWPG+qppOP/UfjRvYE4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TqzhL0CEXyV7mWSLKjB46syX6sk4c8dDAmYOYrerqSwH+/DnkuEBGJN2iC7MIFI5xIi9opTR14oXXS/6POyZ02/DYIxIejqs9sjyc8S+iBMDzev10AbrQMHPvvpQcwMFURp5crgTs72M6mpqGjvgaVeXrwPjo85yYy+5Qn+HGGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAiNPc/b; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAiNPc/b"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-53b17552198so346699e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 06:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755784046; x=1756388846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=P+aaI1tuoNCrilCnn2lOXfOE8OZfMFQ/64T2ujbfwOM=;
        b=jAiNPc/b4eerZUxrqG9dX/gvgQ8/2R1dbuM1vJkvurDwPEvyZ8SlYW9OVycdqzdRB2
         +G9DYoo5gTXKEVT60XAkyC5DNI1Oy468cM2bACNCSOHIwvQOSxsFznVRXbAfLfDIueRr
         MsGVzloiiBopT7GTxR/mDOGsH4lLzrtbEtz2Regdhcl1nFuFvw2rXlqIAiPp5Ad40ejC
         Q3bJhHwjRvuYaHCcIVyxsgBwS5WCYRnxvFBn8oKUbSzBHYVys5ZAJSGowq4pKHtuZReX
         cJgtuKwzMIq2gzZBRypRSocW5xEylurNj7qcdomY4MzP7lCYcRiDgGfXcv6zLesExfD4
         DKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755784046; x=1756388846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+aaI1tuoNCrilCnn2lOXfOE8OZfMFQ/64T2ujbfwOM=;
        b=QdbeMLFS78hXz//dExXmEKlxQdObzRbgs1qVVzvviI4JNft1DKKsvcODg92srcG9tZ
         iWqksrIYIx59F5pv/h58Gn2fU2024aHvFNf3oPh3YW4EdSVx3pjzYl1YSLQyiSPQGt6d
         tyAdDK3L4iZy/fWGiNO6Ips06N7XDiz84oiP/ZtL0Zp6jTj/CYCIpXtbRZrwsLyBbZyi
         daAjGfLgROCi5QzeMln6pvF5hIe/eSLcvdtup50xZLkni9DJ5i+T1ecKCrMQ6EkHKQGi
         3CZtmvrAVfXhOh0QRVkwf1UogzJ/dac2Pajg9mhAZQYfBLdyt+kOKj2fjOHokkBM6kjM
         tLiQ==
X-Gm-Message-State: AOJu0YyGR2NkIV2GDMlt2/yZKF8Aal8/aI1Z8xcHXyUXCBsooj3NhaPr
	/4v30tIr9Zmwt/C+Qyxgqj2icPqq3jSY0SSJVV9x+0ruTXVjJkxvCsioB9fT5RQJ
X-Gm-Gg: ASbGnctO+W+gj1Hhz+0R9dEfsCLjRKgkaoSXxCQL643urZvQ+zIt2bpkBs5cD2SAjl4
	YpRO1wd/UCY5RtI8th4swSOCxKwgaskPUed1Z8AZ4s1BYii22SAvmEEWSFDdFvDBadC9YROIwqx
	p2YQDMbt1gY/jMAy2TTOzhUvf37mYIFDPmieLMAcnFZg91MJWFGgWNIiwTgTKnB126dfCUNfASo
	R0/XCOi6rIpixVnST0YfPKNiNyUwOMnq9zw9/GyhgkdSK3MgUSJV57yneOX0xN1NIGTlz6tTuUE
	leG7vy0LdkZjA1+fc/VBMviOX/nOe7rWtI55Ve0qJsu8zCO7Iy85yrtVPV5joxQF6vsZdKcTiuA
	iV0OIIpPpXlrb8eIvUcytVMJXYVY4y1vZyRVlxT+PfdBPqwUWbFYroZdQAXq71uX1
X-Google-Smtp-Source: AGHT+IFlCdVp6/XNY0dXbwKMg4G70NbKI8m5bNbSkJz3KIVvJh2a0U4CfERJwLhBR3UO4revw9fekg==
X-Received: by 2002:a05:6122:1d0e:b0:535:aea0:7a2f with SMTP id 71dfb90a1353d-53c7d844a00mr755620e0c.4.1755784045974;
        Thu, 21 Aug 2025 06:47:25 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bed9fd5sm3732434e0c.18.2025.08.21.06.47.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:47:23 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_event: Detect if HCI_EV_NUM_COMP_PKTS is unbalanced
Date: Thu, 21 Aug 2025 09:47:14 -0400
Message-ID: <20250821134714.2032684-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to detect if HCI_EV_NUM_COMP_PKTS contain an unbalanced
(more than currently considered outstanding) number of packets otherwise
it could cause the hcon->sent to underflow and loop around breaking the
tracking of the outstanding packets pending acknowledgment.

Fixes: f42809185896 ("Bluetooth: Simplify num_comp_pkts_evt function")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 512041c68062..dc946c5b59d8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4414,7 +4414,17 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 		if (!conn)
 			continue;
 
-		conn->sent -= count;
+		/* Check if there is really enough packets outstanding before
+		 * attempting to decrease the sent counter otherwise it could
+		 * underflow..
+		 */
+		if (conn->sent >= count) {
+			conn->sent -= count;
+		} else {
+			bt_dev_warn(hdev, "hcon %p sent %u < count %u",
+				    conn, conn->sent, count);
+			conn->sent = 0;
+		}
 
 		for (i = 0; i < count; ++i)
 			hci_conn_tx_dequeue(conn);
-- 
2.50.1

