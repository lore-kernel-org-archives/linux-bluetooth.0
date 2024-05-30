Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AE5839E3
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 May 2024 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081263; cv=none; b=FqFwtDXbrm8uuGFNMaWbfgYFF4DOgaEq5iNtiTDBPX9l9CDj1eMCCuSYxsV9QA+JRL6QuaHXmLWFA59hMgP6nX1JDCEFRQFPiBgj6V3Ran1HjMnr5JaFEs8SaGYwN/Hus70doopBjYgEJmDUB+5bei3PBhLe5A/yByb06/RRxm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081263; c=relaxed/simple;
	bh=ee2MtFQfQtU/kqb6rS+D2WqPs7QmF9VRRDIgJT6sSE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pokO8uSHx89xVeAwIeDl6wbyrJWmXyeSEVqIT1oBQGY8+jJZ+SIUm6VntfR8OJSLD4cH8Vl4KondpIlmlh3chqw+lObrZdx4+y4hre3bBEz62UOI+XjLt8X0EzU1yXZS6GgkUSWiJ3ep5iyTDKxGzBEtsbgzlJTpWKKAMYROE40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D1DAC2000A;
	Thu, 30 May 2024 15:00:58 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 4/9] rfkill: Avoid using a signed int for an unsigned variable
Date: Thu, 30 May 2024 16:57:58 +0200
Message-ID: <20240530150057.444585-5-hadess@hadess.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530150057.444585-1-hadess@hadess.net>
References: <20240530150057.444585-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: INTEGER_OVERFLOW (CWE-190): [#def37] [important]
bluez-5.76/src/rfkill.c:101:3: tainted_data_argument: The value "event" is considered tainted.
bluez-5.76/src/rfkill.c:105:3: tainted_data_argument: "event.idx" is considered tainted.
bluez-5.76/src/rfkill.c:105:3: underflow: The cast of "event.idx" to a signed type could result in a negative number.
103|			break;
104|
105|->		id = get_adapter_id_for_rfkill(event.idx);
106|
107|		if (index == id) {

Error: INTEGER_OVERFLOW (CWE-190): [#def38] [important]
bluez-5.76/src/rfkill.c:133:2: tainted_data_argument: The value "event" is considered tainted.
bluez-5.76/src/rfkill.c:143:2: tainted_data_argument: "event.idx" is considered tainted.
bluez-5.76/src/rfkill.c:157:2: underflow: The cast of "event.idx" to a signed type could result in a negative number.
155|		return TRUE;
156|
157|->	id = get_adapter_id_for_rfkill(event.idx);
158|	if (id < 0)
159|		return TRUE;
---
 src/rfkill.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/rfkill.c b/src/rfkill.c
index a0a50d9e45d9..8a0e48f01c4f 100644
--- a/src/rfkill.c
+++ b/src/rfkill.c
@@ -55,7 +55,7 @@ struct rfkill_event {
 };
 #define RFKILL_EVENT_SIZE_V1    8
 
-static int get_adapter_id_for_rfkill(int rfkill_id)
+static int get_adapter_id_for_rfkill(uint32_t rfkill_id)
 {
 	char sysname[PATH_MAX];
 	int namefd;
-- 
2.45.1

