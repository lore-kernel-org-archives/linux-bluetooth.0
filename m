Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=138.232.1.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792956233;
	b=HZqm5B1DoS9ekh+yXtQulJELXhJpkp2V1H6TNBo9ClAM/EOSHAskqEZrx9Dys181JFHC
	 dovG7P1YopsEGz2vytqfeomqHtXp539BgLTEdXxwq4SEZcgpnthyIrBi19LbQcmAfRagf
	 +czFai69DaWptXCq0HVYXtK7TIxZKl9Hgx5daRoeV5xK3vdp6Y9ALRgSXR4J2EZ7SQ7YJ
	 IeefUBt62Q7WR/xnkjVCJ9pkjzTMbzNeZ/nEpyrLKesqNqYK+oSm3FhwOn8+JUWRZ7Ise
	 t8CiE/FJdKBQUCz5xQkT/kiJAZ3D6Zj4sMwG2/4zk3bSc8mrz5A1q07U2klA3sX9L8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792956233;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Score:X-Scanned-By;
	bh=VIAOGyj5zSee2fheBf6+AbjLxYAPl3WFD1ZUhlbKULg=;
	b=2e9JfSl2LnDBa5hM6on9ZQnxjRxSc1VUafDOgMW4oqSwKLUxY+iYTRyMRasDttxc6rlv
	 EnDQh/88Q8uQBsm1Xe7ch2pvUVGKdBuJzs8cJ6oHkB2KOQ5Mf6Ythy5dxlUliBxCRaWqj
	 w2MKea+SmJ0bhu5SUbtiDdN+rXTm/jT5zgZW+BefQUprEVHSaoxlks5BGg/odGm4B66ko
	 31Hphf/LM4RYx1bkg+isuMvRr2/XO5q9dOLFRJnsrwe1U9Nf3fP3h2Yf9iPi4NHhf0YVu
	 AYYi+BQUqQkLZewCUHc0f+MysELBqtydTLPw0uulAqOniNr+0zJD370mJoGOGiO0eiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.uibk.ac.at;
	spf=pass smtp.mailfrom=student.uibk.ac.at;
	dkim=pass header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=UbFBc43S;
	arc=none smtp.remote-ip=138.232.1.140
Received: from smtp.uibk.ac.at (smtp.uibk.ac.at [138.232.1.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02935606A33E;
	Sun, 25 Oct 2026 19:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02935606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=UbFBc43S
Received: from surface-pro-5 (178.115.151.51.wireless.dyn.drei.com [178.115.151.51])
	(authenticated bits=0)
	by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 69PJNdOu518064
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 25 Oct 2026 20:23:43 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 69PJNdOu518064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
	s=prod24a; t=1792956223;
	bh=VIAOGyj5zSee2fheBf6+AbjLxYAPl3WFD1ZUhlbKULg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UbFBc43S6JGOX6qXYxPYMGysML3SCFV53Mdq6L1qADFUuEE0iiqfbjw8qem8NUFc+
	 QZ9z2JMiAYlzheTCuetAmbQkQIELRVFC4tronrD8j/6rgMS0rEBvkZlRQLQsRV8Aag
	 dDBRCwN5a8qM1BI3xlLHbvIFHW74QOh0nvw+RVfA=
From: christian.koever-draxl@student.uibk.ac.at
To: yang.li@amlogic.com, marcel@holtmann.org, luiz.dentz@gmail.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
Subject: [PATCH 1/7] Bluetooth: add a quirk for controllers that cannot enable Secure Connections
Date: Sun, 25 Oct 2026 20:23:32 +0100
Message-ID: <20261025192338.209574-2-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025192338.209574-1-christian.koever-draxl@student.uibk.ac.at>
References: <20261025192338.209574-1-christian.koever-draxl@student.uibk.ac.at>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: () -14.0 ALL_TRUSTED,RCV_SMTP_AUTH,RCV_SMTP_UIBK,U_RCPTS_11_PLUS
X-Scanned-By: MIMEDefang_3.2_at_uibk.ac.at

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

The Amlogic W1 (W155S2) lists BR/EDR Secure Connections among its
extended features and then fails HCI_OP_WRITE_SC_SUPPORT with an error.
That failure is fatal to hci_dev_open_sync(), so the adapter can never
be powered on: every mgmt Set Powered returns Invalid Parameters and
bluetoothd gives up on the controller.

Add HCI_QUIRK_BROKEN_WRITE_SC_SUPPORT for controllers whose feature bit
cannot be taken at face value, skip the command in both places it is
issued, and set the quirk in hci_aml.

Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 drivers/bluetooth/hci_aml.c |  5 +++++
 include/net/bluetooth/hci.h | 14 ++++++++++++++
 net/bluetooth/hci_sync.c    |  8 ++++++--
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_aml.c b/drivers/bluetooth/hci_aml.c
index 067fbf278b44..990e701da4be 100644
--- a/drivers/bluetooth/hci_aml.c
+++ b/drivers/bluetooth/hci_aml.c
@@ -598,6 +598,11 @@ static int aml_setup(struct hci_uart *hu)
 	/* Setup bdaddr */
 	hdev->set_bdaddr = aml_set_bdaddr;
 
+	/* The controller lists BR/EDR Secure Connections among its extended
+	 * features and then rejects the command that turns host support on.
+	 */
+	hci_set_quirk(hdev, HCI_QUIRK_BROKEN_WRITE_SC_SUPPORT);
+
 	err = aml_power_on(amldev);
 	if (err)
 		return err;
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1641d879dbda..bcbe76c84d1b 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -375,6 +375,20 @@ enum {
 	 */
 	HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
 
+	/*
+	 * When this quirk is set, the HCI_OP_WRITE_SC_SUPPORT command is
+	 * not supported.
+	 *
+	 * This quirk is intended for controllers that list BR/EDR Secure
+	 * Connections among their extended features and then reject the
+	 * command that turns host support on. Without it the failure takes
+	 * the whole of hci_dev_open_sync() with it and the controller can
+	 * never be powered on.
+	 *
+	 * This quirk must be set before hci_register_dev is called.
+	 */
+	HCI_QUIRK_BROKEN_WRITE_SC_SUPPORT,
+
 	__HCI_NUM_QUIRKS,
 };
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a92a81846e9d..f1dfef81ca96 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3419,7 +3419,8 @@ int hci_write_sc_support_sync(struct hci_dev *hdev, u8 val)
 {
 	int err;
 
-	if (!bredr_sc_enabled(hdev) || lmp_host_sc_capable(hdev))
+	if (!bredr_sc_enabled(hdev) || lmp_host_sc_capable(hdev) ||
+	    hci_test_quirk(hdev, HCI_QUIRK_BROKEN_WRITE_SC_SUPPORT))
 		return 0;
 
 	err = __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SC_SUPPORT,
@@ -5040,7 +5041,8 @@ static int hci_write_sc_support_1_sync(struct hci_dev *hdev)
 	u8 support = 0x01;
 
 	if (!hci_dev_test_flag(hdev, HCI_SSP_ENABLED) ||
-	    !bredr_sc_enabled(hdev))
+	    !bredr_sc_enabled(hdev) ||
+	    hci_test_quirk(hdev, HCI_QUIRK_BROKEN_WRITE_SC_SUPPORT))
 		return 0;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SC_SUPPORT,
@@ -5254,6 +5256,8 @@ static const struct {
 			 "HCI WRITE AUTH PAYLOAD TIMEOUT command leads "
 			 "to unexpected SMP errors when pairing "
 			 "and will not be used."),
+	HCI_QUIRK_BROKEN(WRITE_SC_SUPPORT,
+			 "HCI BR/EDR Secure Connections is advertised, but cannot be enabled."),
 	HCI_QUIRK_BROKEN(LE_CODED,
 			 "HCI LE Coded PHY feature bit is set, "
 			 "but its usage is not supported.")
-- 
2.56.0

