Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5498F191F79
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Apr 2025 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744132167; cv=none; b=Wpoln2tjtBKaq8navmM2EUz9bPPXBsVOcBFvD13pSfXPl/en1o7do5Kp3OJiVX7Mp5GG+waTZym9j+SJXuoMeZ0ezY0zJy1hUaJSERUo+pbfOK0OWxWOBjvihMQjGh8veREwE9uyLOMcea/sAoJBsFHI7YY3FBTop5wB9+xQMUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744132167; c=relaxed/simple;
	bh=ZRPOs4OyVdLvJgoPBz9mImQ0yjeWdDoWBxMf5ocjqaA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=tRH6Sud4qZVmAQkdheLJ95++F8+aGXLiz2X3V8/8wm+Wmtb6zIKPJ5kOJYxdQobVYWQyHpPZTggpfGH/yHN44Sw7U/MkdwFABx3yro5KnWnaQ9UWvSEoPwHB6CWjfzee5U/tTorF7YQbDHm+nPSHQL1hIRn0AYupdaHknJ6Pe/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lQt1CfW7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lQt1CfW7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744132163;
	bh=ZRPOs4OyVdLvJgoPBz9mImQ0yjeWdDoWBxMf5ocjqaA=;
	h=From:To:Subject:Date:From;
	b=lQt1CfW7a9Q9t8B8WRbzzc52VY5+c7EDc9vKw0+exZ1R/AZ6NuYoFIbG7EPUz6l/T
	 oK6xzkTv17uY4Uy0nPWHrcH//wEWegJb+SMRtaS638g66JD+nbjUijocTaTI3mUDRv
	 9BmKEmvyTpHth3IljzCIoXQdVdfaLiUZ/V5Y4XH2XAuvxmbc5GYYcWvd6rVBxGEzlv
	 +2Z5bHShdcJ52zlrdMmORFh13uxvHw5fcKn31sSg6KtyIkDLMQUhsilSybPRgSwrrL
	 5Q0SOEYtgXjghtYwiUOYeVHSOgo0hGlsRx/y3awr4W46LoaVisNVNAZD6F5tEZyVHk
	 EjYmkRmZ2if3Q==
Received: from fdanis-XPS-13-9370.. (2a02-8428-AF44-1001-7AB1-e161-9E1a-905c.rev.sfr.net [IPv6:2a02:8428:af44:1001:7ab1:e161:9e1a:905c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2F81C17E0F85
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Apr 2025 19:09:23 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: l2cap: Check encryption key size on incoming connection
Date: Tue,  8 Apr 2025 19:09:15 +0200
Message-ID: <20250408170915.623602-1-frederic.danis@collabora.com>
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

Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
---
 net/bluetooth/l2cap_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c7b66b2ea9f2..f2ab09582146 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3997,6 +3997,13 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 		goto response;
 	}
 
+	/* Check the encryption key size */
+	if (!l2cap_check_enc_key_size(conn->hcon)) {
+		conn->disc_reason = HCI_ERROR_AUTH_FAILURE;
+		result = L2CAP_CR_SEC_BLOCK;
+		goto response;
+	}
+
 	result = L2CAP_CR_NO_MEM;
 
 	/* Check for valid dynamic CID range (as per Erratum 3253) */
-- 
2.43.0

