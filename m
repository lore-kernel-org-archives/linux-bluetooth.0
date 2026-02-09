Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B720326B76A;
	Mon,  9 Feb 2026 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770657123; cv=none; b=WcDYwpSVNUWKc8JyLqCViMiHqnyS2RMtpcPqwIYW6MsppF8uZ+xtys9EVx3y9TjmRg0vmeVVFAQAKvppPaKkj1cen+5FFgIC9SGiH3D0YrdGrc1Bw5VlejsrV6pdC5LbPvS50s7Y0IgqxqjX94eFJupptZYtjzitQAXC7+Iz8I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770657123; c=relaxed/simple;
	bh=1xmUxqA+93Q0FC+aGEqty8BrRuD6hhnDA6X5oJ6DldU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NbQHhv/ppmezFJORpBqJgzfLjL/2XaZZAn+fIm4+cTOAaSuhcZgnO7YFI2leurY4ckodVyDiAblChBtuA0A7bPJiSQ6+N5/njzWKPQgyjA1ecxQvOiUZIroIVL6canFivFJkXui8l7mdZOZczoFYFHzs13cM5RA99iiVRbdI/GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=akWoicpC; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="akWoicpC"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 32C3210DDF3;
	Mon,  9 Feb 2026 18:11:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1770657119; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=mGdQRH6e8x0xmVkDADushw9MWpThoZGEcIK40/q3O/M=;
	b=akWoicpCsGtyOgILNFqw1OoyaEsIqn0cj21eIWIcLaiA5m0c4JwJf+pAZDDIhjKcsso49A
	RcCQMtByurz2gvRCdvKA74AzGPEpHn89bwK8L+fM2hCL1zUSVhDtHBCJU/Dh2tk0PG9psv
	2Z8SBFWuc5blnx2eMA9h7oXosqwa+yrLXz3iOui1D3vwG1+x7F5ODQRySUIWDEwQ+G3YBS
	ab/pZidL5+C8c0kAnWRWyN9p3+W663+0mrm2jhFkr/OgeKW74wp0hIcwdFN+DInTN750kz
	v5c5L5g+lffImS5z1DIEQLT1CDdsnD9UKQ5kzZnAyxiAXv0ZMEgUp+V3oQS2/w==
From: Marek Vasut <marex@nabladev.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btbcm: Add entry for BCM4343A2 UART Bluetooth
Date: Mon,  9 Feb 2026 18:11:48 +0100
Message-ID: <20260209171158.22641-1-marex@nabladev.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This patch adds the device ID for the BCM4343A2 module, found e.g.
in the muRata 1YN WiFi+BT combined device. The required firmware
file is named 'BCM4343A2.hcd'.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: kernel@dh-electronics.com
Cc: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/bluetooth/btbcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 3a3a56ddbb06d..93368ef56ddc5 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -507,6 +507,7 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x6119, "BCM4345C0"	},	/* 003.001.025 */
 	{ 0x6606, "BCM4345C5"	},	/* 003.006.006 */
 	{ 0x230f, "BCM4356A2"	},	/* 001.003.015 */
+	{ 0x2310, "BCM4343A2"	},	/* 001.003.016 */
 	{ 0x220e, "BCM20702A1"  },	/* 001.002.014 */
 	{ 0x420d, "BCM4349B1"	},	/* 002.002.013 */
 	{ 0x420e, "BCM4349B1"	},	/* 002.002.014 */
-- 
2.51.0

