Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772492627EC
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760039941; cv=none; b=gF0/UA0WtLKKQTTYSBkJrBRgJax+3NkqSOYqmog8sIgIo7ls9mtFrqeg/URWOATgWQe4t9TG0mQ8yogO8zS8c7GDZO3kFBk353rmOekb7ymbCstwcKP/ZiJYTap1rIsxLR+yIT/RcCtnhB9yZspe6R/03dY+3rxSVUxprG0yVvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760039941; c=relaxed/simple;
	bh=qh1Ck5XNx/JSzkctQFKberJjeHoW7DyqY5m+jPcyFwQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPJwhMJFs/TEaFWyL5xkFjkfsNf8/NKHKdcBsp7C1Uke1iQRvM4sV9g9TIvJ1I/ljauUSQrTW1GdrCxpkCpwo+FZcYs5aYHURZXhMu2LeYNY5q+t8YJ4H2n1J1DrLjhwRoqrWk6G7bTMXR0SKqLSCSprQnsEyNUQsPm/SD0IJCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QSjb4X9H; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QSjb4X9H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760039929;
	bh=qh1Ck5XNx/JSzkctQFKberJjeHoW7DyqY5m+jPcyFwQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QSjb4X9HQgDBg346TsD6aS8NyuoTPDyJe67NFSZWdryFHg9ydmXNYQtQhadvUeXce
	 OmPFqqs3MCP8z5RdF7ZCsW9ISwdwMJ/oUm3aKaYxRw0Z0NVODCM+mfgdoP66+oNOF3
	 lrFk6imhPtiHiJQlk6hQdE9m5dF/7qmNW7QrJupc6FcR4CTLqzLrlXoz2OqDuq1HQh
	 87tiZHc+h/zlWYsVCrIcTNdU8xOYoLJaKtYOf+jRMqgAXQhuLae64mcBXR63TdaDRZ
	 eMVLBsFt+8rx7hYbEfDFRz6Er7rCgPYGHKa7lR58xT7FI5aGPKCqHHn9QYUXslXwCE
	 NU2GvD2ACK6KA==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-aB6e-1eE8-0e0E-15d0.rev.sfr.net [IPv6:2a02:8428:af44:1001:ab6e:1ee8:e0e:15d0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9FA3F17E13A5
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 21:58:49 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 6/6] unit/test-hfp: Add incoming call interrupted test
Date: Thu,  9 Oct 2025 21:58:42 +0200
Message-ID: <20251009195842.776231-6-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009195842.776231-1-frederic.danis@collabora.com>
References: <20251009195842.776231-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This add the following test:
- /HFP/HF/CIT/BV-01-C
  Verify that HF responds as expected when a normal incoming call
  process is interrupted from the remote party.
---
 unit/test-hfp.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 2d8f4396d..3973df5cf 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -930,7 +930,8 @@ static void hf_call_added(uint id, enum hfp_call_status status,
 	if (tester_use_debug())
 		tester_debug("call %d added: status %u", id, status);
 
-	if (g_str_equal(test_name, "/HFP/HF/CLI/BV-01-C") ||
+	if (g_str_equal(test_name, "/HFP/HF/CIT/BV-01-C") ||
+		g_str_equal(test_name, "/HFP/HF/CLI/BV-01-C") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-01-C") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-02-C") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-03-C") ||
@@ -1339,6 +1340,20 @@ int main(int argc, char *argv[])
 			MINIMAL_SLC_SESSION('0', '0', '0', '0'),
 			data_end());
 
+	/* Incoming call interrupted - HF */
+	define_hf_test("/HFP/HF/CIT/BV-01-C", test_hf_session,
+			NULL, test_hf_session_done,
+			MINIMAL_SLC_SESSION('1', '0', '0', '0'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', 'R', 'I', 'N', 'G', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'I', 'P', ':',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', ',', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '0', '\r', '\n'),
+			data_end());
+
 	/* Calling Line Identification - HF */
 	define_hf_test("/HFP/HF/CLI/BV-01-C", test_hf_session,
 			NULL, test_hf_session_done,
-- 
2.43.0

