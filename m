Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D70B366567;
	Sat, 25 Apr 2026 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139514; cv=none; b=RBFDxINoJfFqJnk158FlK/7LG7OEQzqjj9UuTxtipQJzNb4rV7PGsAbq+wnNXgwj6WS23bQQB0AXZmMnNz8RxWaCg4w9KQv3XfTq1zHLxvG/jg0VzoPLpBTlqRWl0JQN+bt5vXbf/6L0+O9tx9pQ8CFOeKQAirYy8329Gxj9s+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139514; c=relaxed/simple;
	bh=NJ4CXGtNFrnVIfmTsL0iFhI9M4m7YyHy8/qoL+OrRko=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=psUrmtOI04D5IUhDBsKgnjrFnpCJMSfPaISVEBXJgcpOeziIe9T4jvotKi7MlK9bMQX+Ce0z4USoBQdf/pZkknwGDUfhNTatwz6R1uv8Itjy3cC1rETGO9QlA1WNrvL6wso1jhiI/42XJfnsSNbvQykMhTZ7n0zwMNiBG4hzdm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=UgsbAnZH; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="UgsbAnZH"
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4g2y7r6pl0z9wQv;
	Sat, 25 Apr 2026 17:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1777139513; bh=fM1QivoU4Q2STfob2ImPJdCG1JPNbfhfq8W+dfHiRug=;
	h=Date:From:To:Cc:Subject:From;
	b=UgsbAnZHi6XcNBcgJd0edpUGvv51riBtGVMXJTpoqr609zVMGK2lY2eLYhtEX3ZFT
	 hEgimhh8YyW1H4fvQEUsKsq6nm9Gdb1UctSqLvL20KjgTq+Ry+1fYSaRqEg7QACNlq
	 5YPTPvv33rXdaBB2BeTeBedO+H8+aVBrR1bzSBTw=
X-Riseup-User-ID: 2EB11BC4F80DB82562E512980901E4792C51124C965778157B05C7090BDD1BF3
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4g2y7q59xyz23Nx;
	Sat, 25 Apr 2026 17:51:51 +0000 (UTC)
Date: Sat, 25 Apr 2026 18:51:42 +0100
From: Alonso Garrigues <agarrigues@riseup.net>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btrtl: fix uninitialized scalar value
Message-ID: <aez_LiwkX9oS_Nty@lal>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

There is a path where the variable is read uninitialized:
If the opcode switch case is RTL_PATCH_SECURITY_HEADER and key_id is
not set, the if statement condition immediately following the switch
checks an uninitialized rc

Signed-off-by: Alonso Garrigues <agarrigues@riseup.net>
---
 drivers/bluetooth/btrtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 62f9d4df3a4f..aa0d5af26b5f 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -543,7 +543,7 @@ static int rtlbt_parse_firmware_v2(struct hci_dev *hdev,
 				   unsigned char **_buf)
 {
 	struct rtl_epatch_header_v2 *hdr;
-	int rc;
+	int rc = 0;
 	u8 key_id;
 	u32 num_sections;
 	struct rtl_section *section;
-- 
2.53.0

