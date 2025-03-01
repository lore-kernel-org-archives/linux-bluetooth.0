Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0652DBA3D
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Mar 2025 06:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740810210; cv=none; b=YPUAO1cWdHB9KpZCWd2ZbDUlkNwkkpn18kKOaHX/NiiW5mawrxxg1mLpHiGhRzvWmo9rVvIh7VgZvMn6IefT416i+j18NiAgJXxp5nL0V2Uz6qf4XUn0zJ5tBcWOi1Z1PAlyDVB9AOlgJU0pPaqqrpOPfBUJ9gj1Gwu8fYSrhMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740810210; c=relaxed/simple;
	bh=QeEqO4yiQMLs/GnfE+GG2gH9OMnt4U9v+98XtvTggR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUCx4kxft1iHFKsyQomMSwJH1k+T5um3e1+PhrwHOxgu/cyRd0xfsrNHZKIhI4dtAfG0IPUlQChyUf5xy5hxziE+g3yaavQerM0fROA7PzBU6lput2BJBpsyRoBu9fweDCxo+hG1sC1fNJNIyPzJVYnTo+agctAviP8hgPhKUvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdG0LO31; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdG0LO31"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2feaca4e99cso3863411a91.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 22:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740810207; x=1741415007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vb+dZpUDMgfx4Cp+gq/ZavxuS0GQG+fpzIM7WZgVodk=;
        b=GdG0LO315C6BHlVOLcT5KsSQ+L7gXkJm7M2DSICRJelTFfs5lmNLBOI6HYxbd3hl11
         6eK9Stbj9OksDytkoHEdyp/L3X4tyJinm9YRJSRXOvzRjnaJlWsdVTlcBB01kqpQMeUD
         Pr88AGMDUFamiBXShoZxfHOsjmKm46YQfAGqxdLcGMxeV69ZZQre/LOG7fbEfq6C4rdJ
         IF9JR3/TnrE1dVcJ99H/hyJ7VaZ3GVD/kp9hwHbul6JPB43w33oROkre1qFvDB3Z1qQ5
         ejF4KvYpyajGRKJDVouifj+nf4kPfiSnZ2UJD8i5UmIRFBbFmv0aY1hL+ing9f0Nr7Ek
         Fw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740810207; x=1741415007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vb+dZpUDMgfx4Cp+gq/ZavxuS0GQG+fpzIM7WZgVodk=;
        b=YgwX2EtgPqBAXj4j390iRq5Y8T82Wq/VVLeUQs8czJ5QFaXGvvr7pJgnlyoohTky2A
         nPZdJrIJiGYUHF+zwP7WLMo0r6J90SEPoZ1sM8oxJR5uytI5M91KGeRMWAfhLgOvrRlY
         0tMyn6kaNUmsVXS8htrZZfYwzsQOo9AgDes4DUb4klcPOmBfRi3FMsHNjxRtCGvZ5srG
         gV8hsHY5mo1T8MdClc794FN3xGmlNidNggoz5RCYvcyxlbiV3Sv5dm/ZGZYvGDszzkz0
         AT2lE9uB1LO1iz299c8LkGQWhFulnjkI9vbHQR6yUPhUEjKdtfQsCz468u7x4VjHjnqF
         MWWQ==
X-Gm-Message-State: AOJu0Yy+ZSj341YgwjIqd8NFGY+U2PQFhSgn6bG4vEfUh2WwEcPSbDqW
	Dbl/Zzlwnri8EmYFKQnWQGGCmC6V6TpSh8GM5H30NTl6E+pDw2Qcvu5ledAU
X-Gm-Gg: ASbGncu7RJsv/GKmTGQG2bujx6wVUTim8ZWgmsGo3Mvo3II3/HxU2paq50eQws3KFIo
	ovOd4eYpGJQXJjnulv3k7KtgirgH+P5QglENNKw/+C0sHm0QGf4IJZpYJWGfLlUYuW5+jJztFPj
	Mh4lXZjiRunu0waiPUciTZJPleGgDQDQaiSkBxWNigyq3hD77QvKTScPZM97/7McCQ/mWdcKXPW
	YUCJen+Yog5c87UTWkSUZojvEdWOxP0s7IIb+b5S+4SlH+oOtg2702H5lATH1wlEEaAo/4vR9by
	HxJz07mH1EpN/nBCOAgAQlQvQZnNzn4QSSno6V4uqCZbxZN/UhRSa6hkNIz3J2k+DqTDNu7ZfiJ
	SWyi0YbgWgbJQRN40QwJSYR1pMDaTIw==
X-Google-Smtp-Source: AGHT+IHLg/pg8IO3lM4FU9mda1JAev7cg7X9xWdq8s+EOwL4wlRSGGnsH3vUfBJ3JwotoRCmNmA76g==
X-Received: by 2002:a17:90b:1845:b0:2fe:6942:370e with SMTP id 98e67ed59e1d1-2febab2ff84mr10655331a91.7.1740810207364;
        Fri, 28 Feb 2025 22:23:27 -0800 (PST)
Received: from localhost.localdomain (168-228-202-55.static.sumicity.net.br. [168.228.202.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe8284f121sm7014625a91.47.2025.02.28.22.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 22:23:26 -0800 (PST)
From: Pedro Nishiyama <nishiyama.pedro@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Pedro Nishiyama <nishiyama.pedro@gmail.com>
Subject: [PATCH V4 2/4] Bluetooth: Add quirk for broken READ_PAGE_SCAN_TYPE
Date: Sat,  1 Mar 2025 03:22:59 -0300
Message-ID: <20250301062301.18029-3-nishiyama.pedro@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250301062301.18029-1-nishiyama.pedro@gmail.com>
References: <20250301062301.18029-1-nishiyama.pedro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some fake controllers cannot be initialized because they return a smaller 
report than expected for READ_PAGE_SCAN_TYPE.

Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
---
 include/net/bluetooth/hci.h | 8 ++++++++
 net/bluetooth/hci_sync.c    | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 6886962eca78..b99818df8ee7 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -362,6 +362,14 @@ enum {
 	 * This quirk must be set before hci_register_dev is called.
 	 */
 	HCI_QUIRK_BROKEN_READ_VOICE_SETTING,
+
+	/* When this quirk is set, the HCI_OP_READ_PAGE_SCAN_TYPE command is
+	 * skipped. This is required for a subset of the CSR controller clones
+	 * which erroneously claim to support it.
+	 *
+	 * This quirk must be set before hci_register_dev is called.
+	 */
+	HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
 };
 
 /* HCI device flags */
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 0c6a85abba2c..cf60a8da943a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4132,7 +4132,8 @@ static int hci_read_page_scan_type_sync(struct hci_dev *hdev)
 	 * support the Read Page Scan Type command. Check support for
 	 * this command in the bit mask of supported commands.
 	 */
-	if (!(hdev->commands[13] & 0x01))
+	if (!(hdev->commands[13] & 0x01) ||
+	    test_bit(HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE, &hdev->quirks))
 		return 0;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_READ_PAGE_SCAN_TYPE,
-- 
2.48.1

