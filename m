Received: from mailrelay5-3.pub.mailoutpod2-cph3.one.com (mailrelay5-3.pub.mailoutpod2-cph3.one.com [46.30.212.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA9145B0B
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 22:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037652; cv=none; b=ZbXqZRJJMI6oUNZDG7PecQZElDcejMhbMwYwxGI3spdT9hvZTWbrofubNZF96Py8+OWP23sKp1mcdO9BJAjartfNCoGUzvqFbaoSR/xXbWlz6bYiX35a3Hhcm+0/VPjSKlM+Y61TmI1QLT3DtH72Ubh1mJrng9hAHo/EBC1p6bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037652; c=relaxed/simple;
	bh=hXvuhQCg+pal0PEfT/KJvBc6uTd/UHGdoA2Yw6jXbo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmLVpISKMbDn6sQmOhhZYRRciFsnjz24UsLK2XuGENjcgFKVbeZKA2ZqgKO2NtCrYYH1ffj+tZjmS21VME1DA92mhxdV06WxuYqDjpxoMyopjpuvsS1grcoYl/HnXcuCviMaXz1eOFXVgIW+wzyfFJvIOwhN72UeYRYOGUkffxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tjernlund.se; spf=none smtp.mailfrom=tjernlund.se; dkim=pass (2048-bit key) header.d=tjernlund.se header.i=@tjernlund.se header.b=bSTWUdlA; dkim=permerror (0-bit key) header.d=tjernlund.se header.i=@tjernlund.se header.b=41Paexex; arc=none smtp.client-ip=46.30.212.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tjernlund.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tjernlund.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tjernlund.se header.i=@tjernlund.se header.b="bSTWUdlA";
	dkim=permerror (0-bit key) header.d=tjernlund.se header.i=@tjernlund.se header.b="41Paexex"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=tjernlund.se; s=rsa2;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=mCTdpSzOvGDrUmn68PrPpeE2TSGF4mtxsZVOm7PmRxA=;
	b=bSTWUdlA8k33Dm3hzZHR24b5PYhXC5pL2iKhZeMPzjnDlpctsndfRlTCXqOWXpDTdsrpI4XURBmj8
	 u2EAShG0uNVjTT0TDqPE6mE5He2Den0rz2vSGErlBohQsPL8yZ8l5QZleSS6EfX6yq9iHtWgQSKDP1
	 B9Ih8A1SYAUjcsaAoD7lE5WLxp77wqSVWx3EyAUnuukTOI9VxEeo3B6CoVa+rtwukq1E8X6YWdCwZX
	 cqvMxGmELAgT9ViBtUTKYD8dSaUUl7j0jrJYe4gt3gzZxHQD5c20GZo4igN4J7wAwgGFm9mQx0iEhp
	 NLuqAtynG7WzqRKIBXS7d/4ihY6HXhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=tjernlund.se; s=ed2;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=mCTdpSzOvGDrUmn68PrPpeE2TSGF4mtxsZVOm7PmRxA=;
	b=41PaexexB3zYcPml9z4gNNMHuZX2EJ1/TvbLRWBDM0pGIa+eIEzMN1cdcGqf76GtNFZis1l9m+STH
	 qo4wIknAQ==
X-HalOne-ID: f72e3f57-cc54-11ee-92fd-657a30c718c6
Received: from jocke (c188-149-162-176.bredband.tele2.se [188.149.162.176])
	by mailrelay5.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id f72e3f57-cc54-11ee-92fd-657a30c718c6;
	Thu, 15 Feb 2024 22:52:59 +0000 (UTC)
Received: by jocke (sSMTP sendmail emulation); Thu, 15 Feb 2024 23:52:59 +0100
From: tjernlund@tjernlund.se
To: linux-bluetooth@vger.kernel.org
Cc: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Subject: [PATCH 4/4] CUPS lives in libexecdir
Date: Thu, 15 Feb 2024 23:52:15 +0100
Message-ID: <20240215225249.16242-4-Joakim.Tjernlund@infinera.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215225249.16242-1-Joakim.Tjernlund@infinera.com>
References: <20240215225249.16242-1-Joakim.Tjernlund@infinera.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
---
 Makefile.tools | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.tools b/Makefile.tools
index 044342e29..b785ebea8 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -538,7 +538,7 @@ endif
 endif
 
 if CUPS
-cupsdir = $(libdir)/cups/backend
+cupsdir = $(libexecdir)/cups/backend
 
 cups_PROGRAMS = profiles/cups/bluetooth
 
-- 
2.43.0

