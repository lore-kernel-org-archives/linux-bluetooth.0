Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794947252;
	b=po1WBo1UbV0k38xOMeMMbKzO57/0lWu/X+Seea8F8OkYGbq3UHS8jEx+1/0mZoNYAmDn
	 e9K0CaqccDBqOhA5h09m7IHHZGPD5R600b9aeYxZNwB9bRiDeVcZ0m/hDSIcbTqBJFLSF
	 SWtC4bDFXq+N2ZMYV6Vftwe3BhQucTaEATOWS7DSZyV8J3EtO5w2phGyNO8WwvXK9Z6N5
	 ch6yrkHs3hh5+NF7Q8BiW2oxQtMpbCiKgFIZHGyKStrrcA7Jf56jma34hGrrw+XOp1whP
	 QC8AoXhPK0Ql3G3L9y403MjkNjBnPevGPhybyfLC1nkRkySbtv7OQGAavo1q5Y09QEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xlii55PJlBK9f4JtEmyFOBZI3GfQrEGvE6w7xWesQCA=;
	b=oAqnB+QemClJvE4c9S58Ggxe7I2msUQHkBq9ExgDuVnjy7TcdjwOw0xOyymxtjIp+BXU
	 96G3HZcz4QKnhmxsAIRyIkF4oAroeB457OBxF6sshCiaEqgjySGg4vWz7VedS0/ajBnCI
	 98aW0Gbbu77fAYIbao8W4aW9gY9yPNNJpv/62AOlIv5hVxgBvY+YyOYXetsfnTD+s+yvf
	 Nl160nQaew+jRycQ1/w6Dv9kYvGEluwyqZIer7bEQVEE6SmTjM1lXEKTZYR/1Zh6KxZWD
	 PNlpEI70DIyv6AfVMHcrPQpEsS7LvWj3Ei5XAtAdchvcP/JM0tV6aiTmQh88+/qQSqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xmousse.com;
	spf=none smtp.mailfrom=xmousse.com;
	dkim=pass header.d=xmousse-com.20260707.gappssmtp.com header.i=@xmousse-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Riq1XDiZ;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED817606A32C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 20:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED817606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xmousse.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xmousse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xmousse-com.20260707.gappssmtp.com header.i=@xmousse-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Riq1XDiZ
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-49412eb1474so93201f8f.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 12:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xmousse-com.20260707.gappssmtp.com; s=20260707; t=1794947250; x=1795552050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xlii55PJlBK9f4JtEmyFOBZI3GfQrEGvE6w7xWesQCA=;
        b=Riq1XDiZLm7MbwbVecxvibtHqUujYcVP6kH63Iqkf3JG0rtZI+x1J3ZmsXppsR4AhX
         4nzE0tCg3u7qdOJM9Xr8Pau6QuogEqETzuNMLN3D+ILWYQWfa5wmNLWl2bEPIsA0iEQH
         lmyPtSfpfm8J2CrdmDlt19pHG8Q6yLZfgps0DMDNe96G2SpsGGaaPuic0/11tet1MFKB
         K0TLJT75/Qx42psIiH+7yXgOfoY7Oa4XtHDEs7PsAqQ29eTEBHye19XGiPma3O3YgEIJ
         Txv+RrFSomWuxTxgZdsUmbUyRRZ3ClGhKZwYtUKlb2qSHDhz80fwFEelzDPJmZ/CMA0n
         /wUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794947250; x=1795552050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xlii55PJlBK9f4JtEmyFOBZI3GfQrEGvE6w7xWesQCA=;
        b=JWLBMxOugJwLuD0y+43pNAdGHnwcK8o+2q5jTSsO2DMs+T5SKFJ3dKloiYJUGhV43p
         I0pLtxlw6yutV204rW1ASeSJUj6Ma0qpLWIdj0DuENl6RnaxOVn9V3uk4QJovW2NPeHM
         5vPJkyW6zV+fW/k+4PVZZqkcwMd3Rr9J5ypDD0ZudvXocf4UDRpyl+IsaK78F60G/zhw
         Q04MMq1VvWVreO5D4sh6XUnB+xoNfgMyi/usrrnYvfUtZs2G9q2DMj8epvGdphe07e3u
         Tq4R1IO6fZmTeV/T7o/0WU13wci+bu1E+Ic5mrZM4w4zLWBb1okmDFYhIdQJyIU4DkEA
         W3Rw==
X-Gm-Message-State: APuU4Z/Ck4N5CHYE/dQYvHmkiVeKB0u57ssKzUPzhBlTchPbNtWuXJe7
	uRk3C3Sc9RGtE73cIi5MVSXewVgGdUoZoM98QQWM56W5cboMRNV7ENtuD45BtULh8mXztB1Iq7e
	BkM21o+U13ZiR
X-Gm-Gg: AYBFou1lavojAL3o0mPzFcTk1YTeAIumXYMVqqSrbeuc6CuZLzQ001doJB1Gq/Tqj4H
	k49m45P7slEH1iZ0rYJVkLmlEp2XHIlJ4dRK7a1t4RPaG2m/F2tKEiSwvSYOzB/JKlLV1q4GPLY
	ZzxctPxKpLB7llyN2bDltb4azyScLhVqnSuEy17AicGDTc8ci3Jjzc0eow+kpQqx3H31b9E4A4P
	m/Uwjk/HTm2o67gkIJ2ZFun7dj+WudKf18NlRjWApJeHilECD/VzF6bv16DtELwypNNdjMJyw9G
	qm88895s1Cqa1OnLNOts9VKiRf+lOFOkdrMFPkjMAew1HQ1o3EJCQeHZ3xemDa0Xmpw8pylkcsA
	QesBimxcfUINLZfLBLC1kheqUhTM5OSd40UhuuMfVr69czT8DzYq3W10J1TS7gT52VfNWvJO4gf
	52+k7sObczmx5iMAWArHP2XQe/nQId5Wzw9nF74zr//hCFJdTbTDjMgxnL3uyuFwLos7AZmq19d
	hxoqo9hCMk52a7ZipkFZRHsbqZhvSHx8RznkiRFNN6adDm1M4yl7/NnGX5SDIDhf3f1n0J3fdFk
	JbGHDnRltpZYRohOrPeab1yqmV5FXmt2wRhivoyo+Q==
X-Received: by 2002:a05:600c:1553:b0:4a2:677:ad8e with SMTP id 5b1f17b1804b1-4bb7da48319mr4867065e9.34.1794947250237;
        Tue, 17 Nov 2026 12:27:30 -0800 (PST)
Received: from peacock.. ([187.15.172.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7ad9430asm70271675e9.15.2026.11.17.12.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:27:29 -0800 (PST)
From: Ofir Mano <ofir@xmousse.com>
To: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Ofir Mano <ofir@xmousse.com>
Subject: [PATCH] Bluetooth: add passive-discovery quirk for Intel 9460/9560
Date: Tue, 17 Nov 2026 20:22:38 +0000
Message-ID: <20261117202632.49924-2-ofir@xmousse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117202632.49924-1-ofir@xmousse.com>
References: <20261117202632.49924-1-ofir@xmousse.com>
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

Some Intel 9460/9560 (8087:0aaa) controllers stop reporting connectable
advertisers after the first active-scan SCAN_REQ/SCAN_RSP exchange, and
do not report them again until the controller is reset.

With WebAuthn hybrid (caBLE) this is fatal: the phone advertises a
connectable ADV_IND carrying the FIDO service data, the controller
reports it once, and every later operation times out even though the
phone keeps advertising.  btmon shows the controller emits no
advertising report at all on failing attempts, i.e. the loss is before
the kernel's report path.

The same controller and firmware build work on Windows, which uses
passive scanning for discovery; Linux uses active scanning and hits the
controller state.

Add HCI_QUIRK_PASSIVE_DISCOVERY and set it for 8087:0aaa.  When set,
discovery requests LE_SCAN_PASSIVE, and process_adv_report() delivers
passive reports during DISCOVERY_FINDING -- the existing passive filter
would otherwise drop them before they reach userspace.  Other controllers
are unchanged.

Trade-off: on affected controllers, scan-response-only data (device
names, service UUIDs carried only in the SCAN_RSP) is not available
during discovery.  This matches how the vendor stack drives the same
hardware.

Tested on Intel 9460/9560 (8087:0aaa), firmware 169 (2024-08-13):
  - before: first hybrid operation succeeds, subsequent ones fail until
    a controller reset;
  - after: ~1 failure(timeout) in 18 consecutive operations.

Link: https://bbs.archlinux.org/viewtopic.php?id=298396
Link: https://discussion.fedoraproject.org/t/intel-bluetooth-wont-scan-ble-device-works-on-windows-blank-scan-on-linux/196326
Link: https://issues.chromium.org/issues/41485480
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2267051

Signed-off-by: Ofir Mano <ofir@xmousse.com>
---
 drivers/bluetooth/btusb.c   |  7 ++++++-
 include/net/bluetooth/hci.h | 15 +++++++++++++++
 net/bluetooth/hci_event.c   |  9 ++++++++-
 net/bluetooth/hci_sync.c    |  6 +++++-
 4 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a6ab059..f7e3018 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -69,6 +69,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_ACTIONS_SEMI		BIT(27)
 #define BTUSB_BARROT			BIT(28)
 #define BTUSB_BROKEN_EXT_SCAN		BIT(29)
+#define BTUSB_INTEL_PASSIVE_DISCOVERY	BIT(30)
 
 static const struct usb_device_id btusb_table[] = {
 	/*
@@ -517,7 +518,8 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_COMBINED },
 	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
 						     BTUSB_INTEL_BROKEN_SHUTDOWN_LED },
-	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_COMBINED },
+	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_COMBINED |
+						     BTUSB_INTEL_PASSIVE_DISCOVERY },
 
 	/* Other Intel Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x8087, 0xe0, 0x01, 0x01),
@@ -4356,6 +4358,9 @@ static int btusb_probe(struct usb_interface *intf,
 
 		if (id->driver_info & BTUSB_INTEL_BROKEN_SHUTDOWN_LED)
 			btintel_set_flag(hdev, INTEL_BROKEN_SHUTDOWN_LED);
+
+		if (id->driver_info & BTUSB_INTEL_PASSIVE_DISCOVERY)
+			hci_set_quirk(hdev, HCI_QUIRK_PASSIVE_DISCOVERY);
 	}
 
 	if (id->driver_info & BTUSB_MARVELL)
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 50f0eef..94c36c6 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -340,6 +340,21 @@ enum {
 	 */
 	HCI_QUIRK_BROKEN_LE_CODED,
 
+	/*
+	 * When this quirk is set, LE discovery uses passive scanning.
+	 *
+	 * Some Intel controllers stop reporting connectable advertisers after
+	 * the first active-scan SCAN_REQ/SCAN_RSP exchange, until the
+	 * controller is reset. This breaks caBLE (WebAuthn hybrid) passkeys:
+	 * the connectable advertisement is reported once and then never
+	 * again. Passive scanning avoids the exchange and reports the advert
+	 * reliably.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_PASSIVE_DISCOVERY,
+
 	/*
 	 * When this quirk is set, the HCI_OP_READ_ENC_KEY_SIZE command is
 	 * skipped during an HCI_EV_ENCRYPT_CHANGE event. This is required
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b39eac1..3aa4c8b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6310,7 +6310,14 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		if (type == LE_ADV_DIRECT_IND)
 			return;
 
-		if (!hci_pend_le_action_lookup(&hdev->pend_le_reports,
+		/* Controllers with HCI_QUIRK_PASSIVE_DISCOVERY use passive
+		 * scanning only because they stop reporting connectable
+		 * advertisers after the first active-scan exchange; deliver
+		 * those reports during discovery instead of dropping them.
+		 */
+		if (!(hci_test_quirk(hdev, HCI_QUIRK_PASSIVE_DISCOVERY) &&
+		      d->state == DISCOVERY_FINDING) &&
+		    !hci_pend_le_action_lookup(&hdev->pend_le_reports,
 					       bdaddr, bdaddr_type) &&
 		    idr_is_empty(&hdev->adv_monitors_idr))
 			return;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 1101358..9da2404 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6182,6 +6182,7 @@ int hci_inquiry_sync(struct hci_dev *hdev, u8 length, u8 num_rsp)
 static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
 {
 	u8 own_addr_type;
+	u8 scan_type = LE_SCAN_ACTIVE;
 	/* Accept list is not used for discovery */
 	u8 filter_policy = 0x00;
 	/* Default is to enable duplicates filter */
@@ -6234,7 +6235,10 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
 		filter_dup = LE_SCAN_FILTER_DUP_DISABLE;
 	}
 
-	err = hci_start_scan_sync(hdev, LE_SCAN_ACTIVE, interval,
+	if (hci_test_quirk(hdev, HCI_QUIRK_PASSIVE_DISCOVERY))
+		scan_type = LE_SCAN_PASSIVE;
+
+	err = hci_start_scan_sync(hdev, scan_type, interval,
 				  hdev->le_scan_window_discovery,
 				  own_addr_type, filter_policy, filter_dup);
 	if (!err)
