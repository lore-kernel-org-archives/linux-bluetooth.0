Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E365058AC4
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726157825; cv=none; b=udJb2bukGjW9mARuNMFwAnRxifLFK+XQeL8xpaPt3mg6G69/i0/ZPWaPt9U8xbZG7vPzP2TOXwZ44dCk6DGm3spepEn8xetyZ1KY0YSG27korr0BYAN3ImjmhiTHyO+HrWfVbiW61n0kW5Xlgl3+OLoq8sqpFrA1PJs24W3lcRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726157825; c=relaxed/simple;
	bh=DjR/kHNJ9MuLOvmsRInOuZUL7Som5WTY48tBkBZ+9rY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=d1BU6ebOVsdU7FwYWpHP53kEpC2cLDoKXwKI2m6STtte29q5IBfTAu0bKzWPQ8n7F/3lwloVrgdlQl3uyrWY6FO9b/MTstYX/Y5SroDw+f2Ob9OhHRLsiW0WP6R1QzNXvW+Md6BAXxCiA+cbvb6qElNN9DyZblsVyze08OSlVUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krE/q9D5; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krE/q9D5"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2781cb281abso557769fac.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 09:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726157822; x=1726762622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CtBZ/aKltu7xNGiLo/dKnrZSfLqmNZwghlrccGRYU3c=;
        b=krE/q9D5btQksBFuV3N8zryTiclDmcLHCZyEQ6p0MXn2CnWq2VMQP4e4qYOHNBGPa1
         YLkAjHS0LRvnAqPYeynbyRwK3t2sWwpxFkuRalPN0/9gKW/kbLgkIhNcJ7WogavKw8DU
         JQ4GE7vY71mbWW6PGsWj0tVkhKxUQd+wAqjlgNK+Xw0Pp7p/NdFtcPx8eWqEybOm929s
         7KTChxhMaicOQbz+bRAGjat2z1gHLRUfSwcC9MoI9WcSJwqvovWYkQ5f/D5jE/m+XJb+
         jUm4VW2SSoEsvBcxD9O0+OTESQHu/Gsp7x0pZ06L3GpSvsScJpAdWhzSBefuWajCBlxe
         wJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726157822; x=1726762622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CtBZ/aKltu7xNGiLo/dKnrZSfLqmNZwghlrccGRYU3c=;
        b=gdb+834v7S8gzbkcr36HnLC9MLNNM66VsEHds8kPiZBpmcQprGtHEnk1WZ9pP/BsVV
         sqhE7UQxVW8uInbpLP8GXmRbYeCLJEuPW1mULtCSX9c9WHeLW8QOkZBEM6Xq4omx0P2/
         TlqAcOOoKTkiTkiM/G3N6CPKc5wExCS6BfhcnbfTfUQ45GkesmbplvY1ZbarD02daXIa
         gdsb6aTbuk0iYHOqtfVHa80EwIHHifkD2yARdxwE9JuwCtOQrjBrvybGxhrN0vThB+Wg
         fmAW5JTax0wtgiFoI25syjhLnZ4dj0BVF8A/Io41YkmL1ufdZbyVj53m93Ddx5slcWLD
         JN8A==
X-Gm-Message-State: AOJu0YwrZYwNNq48d0aJVIUc8Qpy9XTfmbnyrKd0yDcF65+bIi0D2idt
	AnQoI4EYVxgnL3UXT7RHmwOEBP9ARr+SkvFeIFWYlrgkp/NeOVMtyFWOIw==
X-Google-Smtp-Source: AGHT+IEw5ml3+sm1LysAcTEmowOsemlfp//ur5CSEwDvhtsRVhbU8DKvneRZtDBp50ecUqOT/S7nYw==
X-Received: by 2002:a05:6870:c0d5:b0:278:209d:49c8 with SMTP id 586e51a60fabf-27c3f2c63bamr2550197fac.27.1726157822006;
        Thu, 12 Sep 2024 09:17:02 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-502f9a6fe19sm753105e0c.20.2024.09.12.09.17.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 09:17:01 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE
Date: Thu, 12 Sep 2024 12:17:00 -0400
Message-ID: <20240912161700.2976337-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This aligned BR/EDR JUST_WORKS method with LE which since 92516cd97fd4
("Bluetooth: Always request for user confirmation for Just Works")
always request user confirmation with confirm_hint set since the
likes of bluetoothd have dedicated policy around JUST_WORKS method
(e.g. main.conf:JustWorksRepairing).

Cc: stable@vger.kernel.org
Fixes: ba15a58b179e ("Bluetooth: Fix SSP acceptor just-works confirmation without MITM")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1c82dcdf6e8f..c93c76d455f7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5324,19 +5324,16 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	/* If no side requires MITM protection; auto-accept */
+	/* If no side requires MITM protection; use JUST_CFM method */
 	if ((!loc_mitm || conn->remote_cap == HCI_IO_NO_INPUT_OUTPUT) &&
 	    (!rem_mitm || conn->io_capability == HCI_IO_NO_INPUT_OUTPUT)) {
 
-		/* If we're not the initiators request authorization to
-		 * proceed from user space (mgmt_user_confirm with
-		 * confirm_hint set to 1). The exception is if neither
-		 * side had MITM or if the local IO capability is
-		 * NoInputNoOutput, in which case we do auto-accept
+		/* If we're not the initiator of request authorization and the
+		 * local IO capability is not NoInputNoOutput, use JUST_WORKS
+		 * method (mgmt_user_confirm with confirm_hint set to 1).
 		 */
 		if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags) &&
-		    conn->io_capability != HCI_IO_NO_INPUT_OUTPUT &&
-		    (loc_mitm || rem_mitm)) {
+		    conn->io_capability != HCI_IO_NO_INPUT_OUTPUT) {
 			bt_dev_dbg(hdev, "Confirming auto-accept as acceptor");
 			confirm_hint = 1;
 			goto confirm;
-- 
2.46.0

