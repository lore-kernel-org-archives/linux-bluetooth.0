Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E443D565C
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778930107; cv=pass; b=fJpl1geUxG/BHBxJesTk6qaFrHnlSL8m/+8mPyQzxVhG6THmOFbYL/5AQJ8umvIz2NyVwRh9lT9H9iLT0aUfRoe2oQnW0NoCOtf94W4RMCFGsnWOLTFqGm7mcM7I4Qr+oynfms5EofDGnURnDx0G7t/yf+quzIK69ozMBVZ1654=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778930107; c=relaxed/simple;
	bh=/b+XCnstMSiY4F0NvsyaPBkal0eD6DykHg8gbbZ8p2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+26/CINQvN+C5/jwg79qqe1N88ZJJ0LwKDbEMhUExPITNTMwTwEK7pKQrJx5U2A4cpTIeSQuXlAyZmaJ62UFfxjlj8Vn6NaTU4VeklH2M38F98wz09sw5lFByYj1kygIaLI0zLOYBFzh0Emni3cguWuJ58n5FHvnSGsi5TZviU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=g9WeN6+M; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="g9WeN6+M"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gHhL93Q2Szyf6;
	Sat, 16 May 2026 14:14:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1778930097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QwtQdJBRkVd4WKYasO5cIGRPyQlCMolZPzSt++G6JJE=;
	b=g9WeN6+MWo/Psy3cavkjrCQUvi3uCvpCSG8qn6CVkt2LMxJ1P/bTSEGRhMRpex9yQ1buf9
	WDO+dCT79RFQj9Ke3RkK3Tz0bZzlvmjKg1xe80jWB+iBXobmYJezOfcURQyur9OH7helRj
	l0zLJ81Bvu0bEXZ9f2Yp6L/k2QSgVuw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1778930097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QwtQdJBRkVd4WKYasO5cIGRPyQlCMolZPzSt++G6JJE=;
	b=yFtahYXbEflIu9sqLQ5uodEbwcTzPKWk+ZhPTawhNiOvKo21gfTQp4he6f+rtgL073pV0V
	/BOxyFSa1/1t+3iZ3bTwgcVqADcv+bjbfNlM22GeAQmZd18zAsvY9ucwJfE15E6Eap7O0Z
	l9T2fxIqrfV9UGtqO1CTGDkstuuKdJA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778930097;
	b=byG4rtn3azJ98NrNzMeHT7i15SXC5GusrzyFQaW938sVgGXIdSKJVcL7pkKD/3jvGRKsEC
	f5yVFhYoBqwAAvV3WHMzPrETs4c9w1gCBYhIGIatuiMoevOk7aS5ZWYLjqOHH3UxzhMuIa
	toCYLBix3jNN5jMbbhvzg3raOliJpEQ=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 5/5] Bluetooth: enable context analysis
Date: Sat, 16 May 2026 14:14:37 +0300
Message-ID: <b2b359ff024e15038d5e7925ecba09e1ba9f14df.1778930064.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1778930064.git.pav@iki.fi>
References: <cover.1778930064.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable compiler context analysis for Bluetooth subsystem and drivers.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 drivers/bluetooth/Makefile | 2 ++
 net/bluetooth/Makefile     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index bafc26250b63..e6b1c1180d1d 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -50,3 +50,5 @@ hci_uart-$(CONFIG_BT_HCIUART_AG6XX)	+= hci_ag6xx.o
 hci_uart-$(CONFIG_BT_HCIUART_MRVL)	+= hci_mrvl.o
 hci_uart-$(CONFIG_BT_HCIUART_AML)	+= hci_aml.o
 hci_uart-objs				:= $(hci_uart-y)
+
+CONTEXT_ANALYSIS := y
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index 41049b280887..ff466ea97436 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -25,3 +25,5 @@ bluetooth-$(CONFIG_BT_MSFTEXT) += msft.o
 bluetooth-$(CONFIG_BT_AOSPEXT) += aosp.o
 bluetooth-$(CONFIG_BT_DEBUGFS) += hci_debugfs.o
 bluetooth-$(CONFIG_BT_SELFTEST) += selftest.o
+
+CONTEXT_ANALYSIS := y
-- 
2.54.0

