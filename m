Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520416;
	b=hFT6SZsDGKPhM5kvJcyAr6QK+tDyi4+rVy5LNyR8/S2ZNydw4auUhOHlW54X93qafWlC
	 5SM2ogQlrl4y3KKC67lK8XVpRh3OFSLywh0jiO21m6h5iXw1FYeHgV/Lxprnxz3urT4u5
	 PAq6MOuaAMrHTRUNnI2rLPqcinQFAIVJmJwbvOFhNb4L00OMLbEv2+buc/Q8HU6m0a0k+
	 8AWR9PVJzhtPJk7lDbKmHMoH1R/vKZpdWIDpgROTYN9ABvRNaPzYzzAef5J6A9hJklZwI
	 J6Di5PUOEpowXb27veluFWnFpxKWGkROP22ehD2KdNhXMTFvI/NdkekoNOvGLH0MWTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=repa4hp/LZZuu6VCFIADamXYleK2K4V5dwOc9ov38SI=;
	b=o2ot0GE9RdRViCMsGh1din3w9NY0sgu07NYHEZsFMArWEsBGb9MLuoBoaSfxjQw+Qbfq
	 psebB7NMh/3UzseQaqWB2GnhT2PQVc/PtBt9QSz9ql4zsPKsN7GRRPFoPuEeYUmiwBa59
	 +L9f5nCSrXTDyj4Gzg4DRE+laFpEhK6efiwqazRnnwHdQJjc8bQX6kjFdu8TD687cDKfp
	 BCqhrWr5KC4mUHF/fOTfgnd4BYkdA/NeS24L+0K4efs29usmwWQXYSUNnocEaekIfx8Cw
	 PdZOu4rXqT6AFlc7bMSJi4yAFHU+X0cxPviS+EBYjJfs7Prcx0KgeT63JW15zmQZrew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=boORlZ2p;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1685606A322
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 11:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1685606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=boORlZ2p
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so34991935e9.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 03:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795520414; x=1796125214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=repa4hp/LZZuu6VCFIADamXYleK2K4V5dwOc9ov38SI=;
        b=boORlZ2pzRl+o+knN9S6deKr0/aQBDiy7bHphg2lwgdOYMYnrhS83StzCM75lErG8P
         tmhRRn/qZgEyNVOtGy5N597eynpTtHGE7qTsZi+LiB08dHUImq/cC5pGogZtM/ilMmxd
         4CNQ9tzNLDDgC0JRmSqlLCr7jnFzd2ym7w6b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795520414; x=1796125214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=repa4hp/LZZuu6VCFIADamXYleK2K4V5dwOc9ov38SI=;
        b=Go4yOEq3oO4v1cAkvW1UHmOTFFqgB3q9UmZYbMs5UIKwi38+keuXcuN5qYn1wE9cpY
         nSZ3sOaVesqvHeBk5jeFd4t1dgsO2KR1uSrRz0xlKRnqoIO+rTfucWCIZJSErQwYQZdK
         9l0eJPwlPyshSXMTzeM78/ZEX5oJ1OszhmSJvoHJgRsAt07rQ9nFjOFivba3hoVBHUh8
         9glodIN91v8aXxKSs41EX11fBO8wsmeJoqMtFYGfki7zxYYhNppeG/AzgFNv0w74wjnc
         6I9ZDqk6HBl5lyvzcTkdzCWRjuFMMU/bKwjNOp70vH9stqyUSGdZ9OxhdqOqfth9g2Rv
         3A2w==
X-Gm-Message-State: APuU4Z8QaspF+rqpzJ+Q293aL7T6/uRHKXaRkhh83uupnQrqE+1seFYA
	HBONCsP50BIgTatVn1YwMNc3G/I3YVtUxZTBVzyhJFjRetaDQQplvm5+gfMFf8K5EZ9xLiYWmAh
	NHXKw
X-Gm-Gg: AZFdTZde8xxcFXInhZcmSabjZT/Xc197oX0tCySQ7eDikkHnmLNzvwlW4Qo88XqqICl
	C0cna7ooTnKnXPQmOZ4P3XuZiJrWlq91xTBhiLR0PnVy22Ie2GXwcCWb88r4KKOo6vSs5GCnaYz
	GoFeM8UYNKbDh4CfH8gTdaJjdtHlqpqGen0wMDazrJwSHhAYt+75KG61pv49jrTu/DcEw93eskY
	YOFxv758Gk5y3mZZz72WSAeRIZRO1BVjcSSNNvmJ79jRswbY75SgjAn5Cs1tiN4jw4JyqCpzfXO
	jtyizkz/tpszvJiEOZPciDbyFPLZExYRzLuc6PaQgu7JNVSkj1eiCwfRofv5gBRbpA7BnZiyjxY
	crxCRsxRygn+X16QIIgjGFQGQCoQ6DTSeQ4KWmFNuxzL5hdn7rq4tfpQOztoBXXjUf6Kme5ov3K
	jdvaoZ+vP0QYhdy9OjzdT8X3TDWjOCBrpeimUB1lRsTdSLeWUQ+0t3aZiCaS//ziGy+DSWkvf9h
	dVpK7ljlZe8WKX4A9ig/bjMMwFh/mvFrGDgK/D92QYIkSJUl4mUShTF0V/5zseHtbJ//RLnVhTK
	1F34ZslGWT5aCUl50TdFLtCZVeMG6zKYUShWj9YHHyf8/7vN+Q==
X-Received: by 2002:a05:600c:1389:b0:4bb:7347:d5c0 with SMTP id 5b1f17b1804b1-4bb88826937mr268281595e9.9.1795520413951;
        Tue, 24 Nov 2026 03:40:13 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a9846sm506581225e9.11.2026.11.24.03.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 03:40:13 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH v2 2/3] Bluetooth: hci_conn: Terminate a BIG before its periodic advertising
Date: Tue, 24 Nov 2026 12:40:09 +0100
Message-ID: <20261124114010.1696510-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124114010.1696510-1-simon.mikuda@streamunlimited.com>
References: <20261124114010.1696510-1-simon.mikuda@streamunlimited.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Dzik <michal.dzik@streamunlimited.com>

terminate_big_sync() disables the periodic advertising of a broadcast
source and removes its advertising set first, and only then terminates
the BIG: the same order in which they are created rather than the
reverse. Every BIG has an associated periodic advertising train, which
carries its BIGInfo ([Vol 6] Part B, Section 4.4.6.9), and the BIG
exists until the controller reports HCI_LE_Terminate_BIG_Complete
([Vol 4] Part E, Section 7.8.105), so removing the set first leaves a
BIG without its train.

Steps to reproduce, with btmon running: open an ISO socket for a BIS
with BT_ISO_QOS and BT_ISO_BASE, connect() it, which creates a BIG
with that one BIS, and close() it 3 s later.

A Synaptics SYN43756 controller, with a 6.18.2 based vendor kernel,
answers LE Terminate BIG with a Command Status, then sends 2690 vendor
events instead of LE Terminate BIG Complete and answers no command
after that, in 5 of 5 runs:

  < HCI Command: LE Set Periodic Advertising Enable (0x08|0x0040)
          Periodic advertising: Disabled (0x00)
  > HCI Event: Command Complete (0x0e) plen 4
          Status: Success (0x00)
  < HCI Command: LE Set Extended Advertising Enable (0x08|0x0039)
          Extended advertising: Disabled (0x00)
  > HCI Event: Command Complete (0x0e) plen 4
          Status: Success (0x00)
  < HCI Command: LE Remove Advertising Set (0x08|0x003c)
  > HCI Event: Command Complete (0x0e) plen 4
          Status: Success (0x00)
  < HCI Command: LE Terminate Broadcast Isochronous Group (0x08|0x006a)
          BIG Handle: 0x01
  > HCI Event: Command Status (0x0f) plen 4
          Status: Success (0x00)
  > HCI Event: Vendor (0xff) plen 244

The Zephyr controller (on an nRF54L15), with a 7.3-rc2 based kernel,
does not remove the advertising set of a BIG, in 5 of 5 runs:

  < HCI Command: LE Remove Advertising Set (0x08|0x003c)
  > HCI Event: Command Complete (0x0e) plen 4
          Status: Command Disallowed (0x0c)
  < HCI Command: LE Terminate Broadcast Isochronous Group (0x08|0x006a)

  Bluetooth: hci1: Opcode 0x203c failed: -16

It terminates the BIG, but the advertising set stays in the controller
and as an advertising instance in the host.

Terminate the BIG first, and make hci_le_terminate_big_sync() wait for
HCI_LE_Terminate_BIG_Complete, as hci_disconnect_sync() waits for
HCI_Disconnection_Complete, before the advertising is disabled and
removed. A controller that does not send the event delays the teardown
by HCI_CMD_TIMEOUT, after which the advertising is disabled and removed
as before. hci_iso_term_big_sync(), which terminates a BIG created after
its BISes were closed, waits for the event too. The wait is in the
cmd_sync work, so the teardown of one BIG cannot interleave with the
creation of the next one on the same advertising set.

With that, both controllers send LE Terminate BIG Complete, and the
periodic advertising is disabled, the advertising disabled and the set
removed after it, all with Success, in 5 of 5 runs with each.

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Signed-off-by: Michal Dzik <michal.dzik@streamunlimited.com>
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 include/net/bluetooth/hci.h |  2 ++
 net/bluetooth/hci_conn.c    | 17 +++++++++++------
 net/bluetooth/hci_sync.c    |  9 +++++++--
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index efb85c781e4e..7dd968ca25ec 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -3335,6 +3335,8 @@ struct hci_evt_le_create_big_complete {
 	__le16  bis_handle[];
 } __packed;
 
+#define HCI_EVT_LE_TERM_BIG_COMPLETE	0x1c
+
 #define HCI_EVT_LE_BIG_SYNC_ESTABLISHED 0x1d
 struct hci_evt_le_big_sync_established {
 	__u8    status;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 9fa8dab2520e..5b7526a85442 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -769,18 +769,23 @@ static void bis_list(struct hci_conn *conn, void *data)
 static int terminate_big_sync(struct hci_dev *hdev, void *data)
 {
 	struct iso_list_data *d = data;
+	int err = 0;
 
 	bt_dev_dbg(hdev, "big 0x%2.2x bis 0x%2.2x", d->big, d->bis);
 
+	/* Only terminate BIG if it has been created. Terminate it before the
+	 * periodic advertising that carries its BIGInfo, in the reverse order
+	 * of creating them: some controllers fail to terminate a BIG whose
+	 * advertising set has already been removed.
+	 */
+	if (d->big_term)
+		err = hci_le_terminate_big_sync(hdev, d->big,
+						HCI_ERROR_LOCAL_HOST_TERM);
+
 	hci_disable_per_advertising_sync(hdev, d->bis);
 	hci_remove_ext_adv_instance_sync(hdev, d->bis, NULL);
 
-	/* Only terminate BIG if it has been created */
-	if (!d->big_term)
-		return 0;
-
-	return hci_le_terminate_big_sync(hdev, d->big,
-					 HCI_ERROR_LOCAL_HOST_TERM);
+	return err;
 }
 
 static void terminate_big_destroy(struct hci_dev *hdev, void *data, int err)
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 2e88af51b8f3..83e59ba2a45b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2320,8 +2320,13 @@ int hci_le_terminate_big_sync(struct hci_dev *hdev, u8 handle, u8 reason)
 	cp.handle = handle;
 	cp.reason = reason;
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_TERM_BIG,
-				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	/* Wait for HCI_LE_Terminate_BIG_Complete, so the periodic advertising
+	 * of the BIG is not disabled while the BIG is still being terminated.
+	 */
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_TERM_BIG,
+					sizeof(cp), &cp,
+					HCI_EVT_LE_TERM_BIG_COMPLETE,
+					HCI_CMD_TIMEOUT, NULL);
 }
 
 int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
-- 
2.43.0

