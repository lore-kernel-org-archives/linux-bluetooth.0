Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7C52F83A3
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014159; cv=none; b=bOQIm4/gbnrIyciqMhlofRrQ+S2t21GY38BzGMvHkmkgNpstLDU8+Bk3Qqav9kH0WyFM6sxv6fhJ8srmGlhEVyyyUZd1QjgfsZ9wEOOSZstr1q1Sftv3bStRL+2XfPqnTUB9M6f67+BxTa2eFkzHVm12bNp0tigBCkE9kA7ULW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014159; c=relaxed/simple;
	bh=855Qind7QvrvKD+mW0Ookel389NpAyTZuOhhPTH7n2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGh6kPHCNga35H7ni6w+DzfzUiOxVaTGVCloTu7CrW7/zcwNn6uj+uaM1gvbXi2qoRFL/1b8oMTK6RoBWtERic4HhXXimsi+H1vlvQxAf02NFAWRM/XDnUQjRP13TRbAKDLzWCttJqG+x9OinIu1e0Sq7g7XbZmaatpoyV+QC3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=c/ULglZi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="c/ULglZi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755014154;
	bh=855Qind7QvrvKD+mW0Ookel389NpAyTZuOhhPTH7n2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c/ULglZiNLG1eAaakaGqR7VnaeHOyQ7/oz0EzzajjFJS/ssoZaauUW4eeLKw3cqcD
	 RacMz+uDSC0MplnEp9q6gbblEsTkAHC8oY7+HJGU0JHyY2WAIngTctDuNFDMA8RZAz
	 J4+tfi7EbKcSGV3zUuVuUjn+3oQjDfgB6wM5UNMFZCDjwLUcY4BAkRo09rSO5KSM2y
	 VKxetzfNIJk2SgtpL7tPRj5N+Ozi8bp+nz187swjPk2Sr8H2B4LTkmmG3x344aaYoX
	 AhDuiCJM/nuU3QsXh7UByjxtnGO+jeXHBzqhnYoRgiYhh84mGTqp0ghdE0d91Pj6Mi
	 sC++VOxdU5BUw==
Received: from ryuzaki (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 489C317E053B;
	Tue, 12 Aug 2025 17:55:54 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH v2 1/2] Bluetooth: hci_event: Treat UNKNOWN_CONN_ID on disconnect as success
Date: Tue, 12 Aug 2025 17:55:26 +0200
Message-ID: <20250812155527.995119-2-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812155527.995119-1-ludovico.denittis@collabora.com>
References: <20250812155527.995119-1-ludovico.denittis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the host sends an HCI_OP_DISCONNECT command, the controller may
respond with the status HCI_ERROR_UNKNOWN_CONN_ID (0x02). E.g. this can
happen on resume from suspend, if the link was terminated by the remote
device before the event mask was correctly set.

This is a btmon snippet that shows the issue:
```
> ACL Data RX: Handle 3 flags 0x02 dlen 12
      L2CAP: Disconnection Request (0x06) ident 5 len 4
        Destination CID: 65
        Source CID: 72
< ACL Data TX: Handle 3 flags 0x00 dlen 12
      L2CAP: Disconnection Response (0x07) ident 5 len 4
        Destination CID: 65
        Source CID: 72
> ACL Data RX: Handle 3 flags 0x02 dlen 12
      L2CAP: Disconnection Request (0x06) ident 6 len 4
        Destination CID: 64
        Source CID: 71
< ACL Data TX: Handle 3 flags 0x00 dlen 12
      L2CAP: Disconnection Response (0x07) ident 6 len 4
        Destination CID: 64
        Source CID: 71
< HCI Command: Set Event Mask (0x03|0x0001) plen 8
        Mask: 0x3dbff807fffbffff
          Inquiry Complete
          Inquiry Result
          Connection Complete
          Connection Request
          Disconnection Complete
          Authentication Complete
[...]
< HCI Command: Disconnect (0x01|0x0006) plen 3
        Handle: 3 Address: 78:20:A5:4A:DF:28 (Nintendo Co.,Ltd)
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4
      Disconnect (0x01|0x0006) ncmd 1
        Status: Unknown Connection Identifier (0x02)
```

Currently, the hci_cs_disconnect function treats any non-zero status
as a command failure. This can be misleading because the connection is
indeed being terminated and the controller is confirming that is has no
knowledge of that connection handle. Meaning that the initial request of
disconnecting a device should be treated as done.

With this change we allow the function to proceed, following the success
path, which correctly calls `mgmt_device_disconnected` and ensures a
consistent state.

Link: https://github.com/bluez/bluez/issues/1226
Signed-off-by: Ludovico de Nittis <ludovico.denittis@collabora.com>
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fe7cdd67a..6c67dfa13 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2703,7 +2703,7 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 	if (!conn)
 		goto unlock;
 
-	if (status) {
+	if (status && status != HCI_ERROR_UNKNOWN_CONN_ID) {
 		mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
 				       conn->dst_type, status);
 
-- 
2.50.1

