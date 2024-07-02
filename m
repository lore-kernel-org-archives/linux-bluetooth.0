Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3321B5831
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930287; cv=none; b=mQCd2HWYi/IaSN5NvzkqYQEs3GujPJsWW6HFUsbMQrERwH1o3qzus+P4NGm5rF7I0d7aHWXt8ULlPRVrFTM7m+cEjdeCEkUHQ+FqTn+P0Fz6rCrS3QzYW77vP0axB6C6ttoakKbwE0vbUco3fDI2ZAJ+yZmYpJRbo/ikX6PQiRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930287; c=relaxed/simple;
	bh=ib/BkXoy0+vwgqUindMB+HL0wQHRNyQmquiFjwvdr24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+We+CB1Wew8VheA/awzzb0BaVZ8FVaKehIWaheomIUHr8plUu1Hz9Izj7QgIZRpfFCjO485cOPQTlb2gUQCM1WWJI5jTkG1hZmH5EfuWJcGudmgTvpUiP3wcYNtUw+cCNMYGmrcQvE7lRccfYTfrbRagrVXts796qOYMZq4Je0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 51D9C240006;
	Tue,  2 Jul 2024 14:24:38 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ resend 3/9] mesh: Avoid accessing array out-of-bounds
Date: Tue,  2 Jul 2024 16:23:35 +0200
Message-ID: <20240702142436.833138-4-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702142436.833138-1-hadess@hadess.net>
References: <20240702142436.833138-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

We would boundary check the expected_pdu_size array based on the value
of type, but would still access it out-of-bounds for the debug message.
Split off the invalid type check into its own message to avoid this.

Error: OVERRUN (CWE-119): [#def23] [important]
bluez-5.76/mesh/prov-initiator.c:676:2: cond_at_least: Checking "type >= 10UL" implies that "type" is at least 10 on the true branch.
bluez-5.76/mesh/prov-initiator.c:678:3: overrun-local: Overrunning array "expected_pdu_size" of 10 2-byte elements at element index 10 (byte offset 21) using index "type" (which evaluates to 10).
676|	if (type >= L_ARRAY_SIZE(expected_pdu_size) ||
677|					len != expected_pdu_size[type]) {
678|->		l_error("Expected PDU size %d, Got %d (type: %2.2x)",
679|			expected_pdu_size[type], len, type);
680|		fail_code[1] = PROV_ERR_INVALID_FORMAT;
---
 mesh/prov-initiator.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index 653f3ae3e1c2..e353d23865ef 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -673,8 +673,13 @@ static void int_prov_rx(void *user_data, const void *dptr, uint16_t len)
 		goto failure;
 	}
 
-	if (type >= L_ARRAY_SIZE(expected_pdu_size) ||
-					len != expected_pdu_size[type]) {
+	if (type >= L_ARRAY_SIZE(expected_pdu_size)) {
+		l_error("Invalid PDU type %2.2x", type);
+		fail_code[1] = PROV_ERR_INVALID_FORMAT;
+		goto failure;
+	}
+
+	if (len != expected_pdu_size[type]) {
 		l_error("Expected PDU size %d, Got %d (type: %2.2x)",
 			expected_pdu_size[type], len, type);
 		fail_code[1] = PROV_ERR_INVALID_FORMAT;
-- 
2.45.2

