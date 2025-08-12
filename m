Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBADE2F83B4
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014160; cv=none; b=gE/gofCco10Y6o7yu0XFRuUmAXqvWRhY0fHKEx7nBRFLdh8vppst6Mq8XIq+aorKN3qD7kvXWT8CwGCjluzlfCnKR69YkrsTdsP1XLPwsjnN4d0GN3VhsXE0qLWhUrIsdjDVZIpIZLrG1Bwom97e7qqBpIOcebVc3mEPOJdLduw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014160; c=relaxed/simple;
	bh=2mgPIfWcc6HWeukWuHZxdnPEYEYtd84JzGdf21lBf6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l19dIL9EBl3xPEPugKY3guH5WuSwZGK3lSLs0M+DIgvVqgDv5GU7bcBZeWd06jSyMCuUjEgaw2YBa5pBsicJMxT5jj6MrNEEjQaI40H9S2QnM3IWd0EyCbyIq9gvDIIVB/gzxoglr05e/cSVodZKjhNROWMcgOJcmReis1z960I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TUvMf+Nm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TUvMf+Nm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755014157;
	bh=2mgPIfWcc6HWeukWuHZxdnPEYEYtd84JzGdf21lBf6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TUvMf+NmubJOirGztjPX2yfYHgnAH5PtlITCAH6hJDejuU9a+t3FTu7LF60YCNk6F
	 SkvM/FT/A3mfpP7U8I4/SWBmnpisaFSE6TDxAVQqBllkUyg8F+QaGW/A8hZjM2AtpN
	 IOxK5lRwaG8f7xjpixtfNAmCC0c/ttxkC+d/d7oY2SyC0tbwvufcUo0D5JILVxOT7J
	 s15+djB6ZVCM2HGlfGL0fUlg7emKv1qVd10FojROCmqy8wkZVAa+nTngxwq6YNUurq
	 r8DqPLPGIr5jsVuYjmT58l+mvqfALlDNsje5Ymz86fe2B4p594zhh5WqXThvwAimw+
	 gVufeXsPGK2lQ==
Received: from ryuzaki (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C872317E055D;
	Tue, 12 Aug 2025 17:55:56 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH v2 2/2] Bluetooth: hci_event: Mark connection as closed during suspend disconnect
Date: Tue, 12 Aug 2025 17:55:27 +0200
Message-ID: <20250812155527.995119-3-ludovico.denittis@collabora.com>
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

When suspending, the disconnect command for an active Bluetooth
connection could be issued, but the corresponding
`HCI_EV_DISCONN_COMPLETE` event might not be received before the system
completes the suspend process. This can lead to an inconsistent state.

On resume, the controller may auto-accept reconnections from the same
device (due to suspend event filters), but these new connections are
rejected by the kernel which still has connection objects from before
suspend. Resulting in errors like:
```
kernel: Bluetooth: hci0: ACL packet for unknown connection handle 1
kernel: Bluetooth: hci0: Ignoring HCI_Connection_Complete for existing
connection
```

This is a btmon snippet that shows the issue:
```
< HCI Command: Disconnect (0x01|0x0006) plen 3
        Handle: 1 Address: 78:20:A5:4A:DF:28 (Nintendo Co.,Ltd)
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4
      Disconnect (0x01|0x0006) ncmd 2
        Status: Success (0x00)
[...]
// Host suspends with the event filter set for the device
// On resume, the device tries to reconnect with a new handle

> HCI Event: Connect Complete (0x03) plen 11
        Status: Success (0x00)
        Handle: 2
        Address: 78:20:A5:4A:DF:28 (Nintendo Co.,Ltd)

// Kernel ignores this event because there is an existing connection
with
// handle 1
```

By explicitly setting the connection state to BT_CLOSED we can ensure a
consistent state, even if we don't receive the disconnect complete event
in time.

Link: https://github.com/bluez/bluez/issues/1226
Signed-off-by: Ludovico de Nittis <ludovico.denittis@collabora.com>
---
 net/bluetooth/hci_event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6c67dfa13..ce0ff06f2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2718,6 +2718,12 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 		goto done;
 	}
 
+	/* During suspend, mark connection as closed immediately
+	 * since we might not receive HCI_EV_DISCONN_COMPLETE
+	 */
+	if (hdev->suspended)
+		conn->state = BT_CLOSED;
+
 	mgmt_conn = test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags);
 
 	if (conn->type == ACL_LINK) {
-- 
2.50.1

