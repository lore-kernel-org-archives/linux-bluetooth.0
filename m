Received: from mail.discnull.de (mail.discnull.de [46.224.56.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C4637F324
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.224.56.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263487; cv=none; b=ZuIhtYLM+h4rCi//lqy8O7r09yaeEBvnFfV40sZNUlx4mJ/ALywptywo/0gk2mYIczBrWrbMnoSiNr3EBi+uMCkIijVYgG2KrFcdJ0YBJssy242n3H0DiIAiCQzKqFjgpNSEMJU9Iwe56fHx0pf9YrJSEPXg+kObt9Y2IbCUtQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263487; c=relaxed/simple;
	bh=MwEUxDSojaDn0RX2XQhZ5sCsCOWOefIfXqDbx7kRwnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BeG7vIQcQ3Cu6OqrKaWAPkLGF1BW9wEvBhm88jdGATikxJMwb+FL7C6gHUE/L/MsN2/yzKoENdiRpbtSx0tRHDD/yuia5wqTjVkeVCv7K5XGAhpv/N8p9A8gNoxw+/X3nl4LLtEYrvJl3IHIZYZFWkINAZYui2JqBrvsbhqJi3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=discnull.de; spf=pass smtp.mailfrom=discnull.de; dkim=pass (2048-bit key) header.d=discnull.de header.i=@discnull.de header.b=a/ta7Ib2; arc=none smtp.client-ip=46.224.56.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=discnull.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=discnull.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=discnull.de header.i=@discnull.de header.b="a/ta7Ib2"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D5337D788;
	Thu, 24 Sep 2026 17:17:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=discnull.de; s=dkim;
	t=1790263077; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=naHLF/wLcjXpWw+CnvExbwft0Nu0WxHdtrxakZ/dc88=;
	b=a/ta7Ib2+hdZEOqYTpLJoIPBTxR9NhxPINTP8rABIs/trvivAgwHnXdbuAy0AsIoMnMNjd
	71o9VyUHGaX3LnsyOYSz0mhnLM9WaDV+5DjZqo+HLBsfUA7Ej94xt5t5Ck0STvrouE5rC9
	2xc+ZnP334EiYxof17rOg6KFANVs8hK9I0xVLtNaZ3YkFCpR+dP1ZNyLGUtz1d+Y74JUa5
	efSVb4HBR3d2f59zqXjBZAestFuMXjHso98/SqtzxrjT/GO/PmPYcqKoNJ9M4Upq2G9UWf
	eW7iK8JgxPzsi0bBOng2ChpeCYiNzNy3AYMy6iLRgi5qcGDq+HleQwjRQBxxLQ==
From: Alexander Sarmanow <as@discnull.de>
To: linux-bluetooth@vger.kernel.org
Cc: Alexander Sarmanow <as@discnull.de>
Subject: [PATCH BlueZ 1/2] doc/org.bluez.LEAdvertisement: Add broadcast name
Date: Thu, 24 Sep 2026 17:17:19 +0200
Message-Id: <20260924151720.1769259-2-as@discnull.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260924151720.1769259-1-as@discnull.de>
References: <20260924151720.1769259-1-as@discnull.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

---
 doc/org.bluez.LEAdvertisement.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/org.bluez.LEAdvertisement.rst b/doc/org.bluez.LEAdvertisement.rst
index dbfc5f0bc..33646ef8b 100644
--- a/doc/org.bluez.LEAdvertisement.rst
+++ b/doc/org.bluez.LEAdvertisement.rst
@@ -172,6 +172,13 @@ fit into the packet it will be truncated.
 If this property is available 'local-name' cannot be present in the
 **Includes**.
 
+string BroadcastName [readonly, optional]
+`````````````````````````````````````
+
+Broadcast name to be used in the advertising report. If the string is shorter
+than 4 chars an error will be returned. If it is longer than 32 chars it will
+be truncated.
+
 uint16 Appearance [readonly, optional]
 ``````````````````````````````````````
 
-- 
2.30.2

