Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB0C24EF6E
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744188796; cv=none; b=EGVpgWcLfCtmwx0IWDn/EPov7j0aQ3lLy1WZqp1lLs95JBURro576i4XVUZsFUc8nQ5VWz/m0h3Kmio4U8gtl5+rTNyYR5dD6tqN5tNaIiZwlX5Dk/L696CMFauZCg8I84H9kYysYzTtyfMcIvm2Z91tmva0m/u1ZK88FRjiDRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744188796; c=relaxed/simple;
	bh=wBj7WheaVAnoDAk6p7D4t0UxlTqoltEN5U90hi3NeuY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=GELrfipyKAlB16iRgUuLkNqSWHOtcpxv2QTt+qWzgz5fG1QTEJPox/eGjHH6uJYeGNR4YfKBzr3FyyopoS4CzqkQgG25fjyw0YoVZx9kO+EoGg4qu1aYXMHvD4+zsSrlCjADWURlboIodNFvvkz4XgscUNmMXAN3Ye7DzW3af6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fxYD13+c; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fxYD13+c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744188792;
	bh=wBj7WheaVAnoDAk6p7D4t0UxlTqoltEN5U90hi3NeuY=;
	h=From:To:Subject:Date:From;
	b=fxYD13+c7soS1aJUSveJbFnBZ1I4/9egFaD00QveWcfk4xGW0n+HamFRdvui8xsB3
	 tZ1iNsKwbIyaYmmuSzySJGkmvzcszQVtk/GFSKG0mwJghdI5ONH0qlg4bwkqh5R6GJ
	 EpFQS6XOyrAd9vRXoXBaIw5ZQYfpnP4B8iAeyQz0ySOqlPK96w8uGzFDT9nb1tFQL7
	 Zh9V6IxH0mYBGUSZDjKZJHB+wa35yCNFYBqqu1SXXI22i/g8PI9DH2xKnYDzhyjMaK
	 5+fFsXGeWliebHONx8+fssv7HN1lDzl2ZGvb2uDLpM2m7PCIZ5vbRc09lvpKuAucMX
	 9jW4jMTXIw61g==
Received: from fdanis-XPS-13-9370.. (2a02-8428-af44-1001-E94a-4D6F-4e0e-F8bb.rev.sfr.net [IPv6:2a02:8428:af44:1001:e94a:4d6f:4e0e:f8bb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DD12017E0657
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 10:53:11 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: l2cap: Check encryption key size on incoming connection
Date: Wed,  9 Apr 2025 10:53:06 +0200
Message-ID: <20250409085307.635819-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This is required for passing GAP/SEC/SEM/BI-04-C PTS test case:
  Security Mode 4 Level 4, Responder - Invalid Encryption Key Size
  - 128 bit

This tests the security key with size from 1 to 15 bytes while the
Security Mode 4 Level 4 requests 16 bytes key size.

Currently PTS fails with the following logs:
- expected:Connection Response:
    Code: [3 (0x03)] Code
    Identifier: (lt)WildCard: Exists(gt)
    Length: [8 (0x0008)]
    Destination CID: (lt)WildCard: Exists(gt)
    Source CID: [64 (0x0040)]
    Result: [3 (0x0003)] Connection refused - Security block
    Status: (lt)WildCard: Exists(gt),
but received:Connection Response:
    Code: [3 (0x03)] Code
    Identifier: [1 (0x01)]
    Length: [8 (0x0008)]
    Destination CID: [64 (0x0040)]
    Source CID: [64 (0x0040)]
    Result: [0 (0x0000)] Connection Successful
    Status: [0 (0x0000)] No further information available

And HCI logs:
< HCI Command: Read Encrypti.. (0x05|0x0008) plen 2
        Handle: 14 Address: 00:1B:DC:F2:24:10 (Vencer Co., Ltd.)
> HCI Event: Command Complete (0x0e) plen 7
      Read Encryption Key Size (0x05|0x0008) ncmd 1
        Status: Success (0x00)
        Handle: 14 Address: 00:1B:DC:F2:24:10 (Vencer Co., Ltd.)
        Key size: 7
> ACL Data RX: Handle 14 flags 0x02 dlen 12
      L2CAP: Connection Request (0x02) ident 1 len 4
        PSM: 4097 (0x1001)
        Source CID: 64
< ACL Data TX: Handle 14 flags 0x00 dlen 16
      L2CAP: Connection Response (0x03) ident 1 len 8
        Destination CID: 64
        Source CID: 64
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)

Fixes: 288c06973daa ("Bluetooth: Enforce key size of 16 bytes on FIPS level")
Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
---
v1->v2: Incorporate check into ACL security check test

 net/bluetooth/l2cap_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c7b66b2ea9f2..f1c4b8bd7a8b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3991,7 +3991,8 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 
 	/* Check if the ACL is secure enough (if not SDP) */
 	if (psm != cpu_to_le16(L2CAP_PSM_SDP) &&
-	    !hci_conn_check_link_mode(conn->hcon)) {
+	    (!hci_conn_check_link_mode(conn->hcon) ||
+	    !l2cap_check_enc_key_size(conn->hcon))) {
 		conn->disc_reason = HCI_ERROR_AUTH_FAILURE;
 		result = L2CAP_CR_SEC_BLOCK;
 		goto response;
-- 
2.43.0

