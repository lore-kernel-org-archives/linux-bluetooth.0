Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=138.232.1.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792956236;
	b=MFJD8h+PEBrzTJvk9XgB0tL2xiMEEhnJqhd8RoxZi/tQhfsTMQwN6is8o+vZoL+/wkcv
	 YWB4wnZTe9Tp/DpFJa8xMr6nXTAiHV8cj1RCauiuMY3th6/bdE9f3qoTNp34btOu9L2SC
	 jQ4jt+ozmdajKtaw5aLNaJkbsQ5sLeAlQU75KpykdIvHTGIn2HlFIWZae/Yeqoci98aBg
	 s3EVPlrqPZRs0moHCGyW8HJ4EQ7iH0BZ+zVnzbwyrrCwi5drd+n6PiRf9udBGX1BXsoxg
	 7ATuJrznDsr/8jUwHWvGizVzWMkbOQqmrcx45JgHs57BM2WZI8S/xV25cKxGPj65mog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792956236;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Score:X-Scanned-By;
	bh=6E++VHotPZYkQ/ssHKSp6n1jMzbTEXMXVTkIq65oCPo=;
	b=WeV9J2/iQhlBbFf6/iWHNPby/cOgFV/N6Gk/LomWIbY+bSADeoPnHY9QYx+KLWSW+KIT
	 7xynLqWmAXk0QVS0eJpdXNOCLdg7Hl081xjruAQmKoZj61l8tRhKEMVO8lvtEYAM7nkE4
	 1z3aBQVXFnt8GRNYNYWA2TOw2aDsszk58HnaObpM3w/lr84iVFBXpxexyNSRe6opfU+2o
	 s9etON8z1RxO7hf2a6gck1JyFGkFQM/MbTTnhKAGiB3SlB5BQzZQfumrTBXvS/51Inw9Q
	 3z07yZrFODVjoB9905xZaYE5yyzLZ1jL685Ri/afdQCE3THvu6MAqRtT2cD9dNOi15A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.uibk.ac.at;
	spf=pass smtp.mailfrom=student.uibk.ac.at;
	dkim=pass header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b="BZfCUoq/";
	arc=none smtp.remote-ip=138.232.1.140
Received: from smtp.uibk.ac.at (smtp.uibk.ac.at [138.232.1.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C098F606A327;
	Sun, 25 Oct 2026 19:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C098F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=BZfCUoq/
Received: from surface-pro-5 (178.115.151.51.wireless.dyn.drei.com [178.115.151.51])
	(authenticated bits=0)
	by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 69PJNdOv518064
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 25 Oct 2026 20:23:44 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 69PJNdOv518064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
	s=prod24a; t=1792956225;
	bh=6E++VHotPZYkQ/ssHKSp6n1jMzbTEXMXVTkIq65oCPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BZfCUoq/aWBQXv97kKmESMNH8V3ZbNVwYSrxVX4yPzXaK8GhFm9ErnSOVjWThMHrW
	 XIn9ZkIrsZJ06LHhjy05sBXwi20GE20hGgtvVnLHeV2Jo1j6TG02GHoUQGnVXqQ+HL
	 BWgTqtmkxoXlnOj0/S8FaQ6nLQxbSUL3YCyTW6l0=
From: christian.koever-draxl@student.uibk.ac.at
To: yang.li@amlogic.com, marcel@holtmann.org, luiz.dentz@gmail.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
Subject: [PATCH 2/7] Bluetooth: add a quirk for controllers that hang on Write Current IAC LAP
Date: Sun, 25 Oct 2026 20:23:33 +0100
Message-ID: <20261025192338.209574-3-christian.koever-draxl@student.uibk.ac.at>
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

Some controllers list Write Current IAC LAP among their supported
commands and answer Read Current IAC LAP, but stop responding to HCI
altogether as soon as the write is issued, even when the value written
is the general inquiry access code the controller already reports.
Nothing short of a power cycle recovers the part.

The write is only sent on the way to becoming discoverable, so such a
controller dies exactly when something asks it to become visible, and
the failure looks like a dead radio rather than a refused command.

Add HCI_QUIRK_BROKEN_WRITE_CURRENT_IAC_LAP and skip the write when it
is set. This costs limited discoverable mode, which needs the LIAC
programmed. General discoverable mode is unaffected, as the controller
already holds the GIAC.

Seen on the Amlogic W1 (W155S2); set the quirk in hci_aml.

Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 drivers/bluetooth/hci_aml.c |  6 ++++++
 include/net/bluetooth/hci.h | 18 ++++++++++++++++++
 net/bluetooth/hci_sync.c    |  8 ++++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/bluetooth/hci_aml.c b/drivers/bluetooth/hci_aml.c
index 990e701da4be..5979b114f2e4 100644
--- a/drivers/bluetooth/hci_aml.c
+++ b/drivers/bluetooth/hci_aml.c
@@ -603,6 +603,12 @@ static int aml_setup(struct hci_uart *hu)
 	 */
 	hci_set_quirk(hdev, HCI_QUIRK_BROKEN_WRITE_SC_SUPPORT);
 
+	/* Write Current IAC LAP is advertised, but the controller stops
+	 * answering HCI as soon as it is sent, until the combo chip is power
+	 * cycled. It is sent when the adapter is made discoverable.
+	 */
+	hci_set_quirk(hdev, HCI_QUIRK_BROKEN_WRITE_CURRENT_IAC_LAP);
+
 	err = aml_power_on(amldev);
 	if (err)
 		return err;
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index bcbe76c84d1b..a59f48f387ac 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -389,6 +389,24 @@ enum {
 	 */
 	HCI_QUIRK_BROKEN_WRITE_SC_SUPPORT,
 
+	/* When this quirk is set, HCI_OP_WRITE_CURRENT_IAC_LAP is never sent.
+	 *
+	 * Some controllers list the command among the ones they support, and
+	 * answer Read Current IAC LAP quite happily, but wedge and stop
+	 * responding to anything at all the moment the write is issued - even
+	 * when the value being written is the general inquiry access code the
+	 * controller already reports. Going discoverable is what triggers the
+	 * write, so on such a controller the adapter dies precisely when it is
+	 * asked to become visible.
+	 *
+	 * Skipping the write costs limited discoverable mode, which needs the
+	 * LIAC programmed. General discoverable mode is unaffected: the GIAC
+	 * is what these controllers already have.
+	 *
+	 * This quirk must be set before hci_register_dev is called.
+	 */
+	HCI_QUIRK_BROKEN_WRITE_CURRENT_IAC_LAP,
+
 	__HCI_NUM_QUIRKS,
 };
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index f1dfef81ca96..92c442910d6a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5258,6 +5258,8 @@ static const struct {
 			 "and will not be used."),
 	HCI_QUIRK_BROKEN(WRITE_SC_SUPPORT,
 			 "HCI BR/EDR Secure Connections is advertised, but cannot be enabled."),
+	HCI_QUIRK_BROKEN(WRITE_CURRENT_IAC_LAP,
+			 "HCI Write Current IAC LAP is advertised, but hangs the controller."),
 	HCI_QUIRK_BROKEN(LE_CODED,
 			 "HCI LE Coded PHY feature bit is set, "
 			 "but its usage is not supported.")
@@ -6127,6 +6129,12 @@ static int hci_write_iac_sync(struct hci_dev *hdev)
 	if (!hci_dev_test_flag(hdev, HCI_DISCOVERABLE))
 		return 0;
 
+	/* Controllers that wedge on the write are left alone. They already
+	 * hold the GIAC, so general discoverable mode works without it.
+	 */
+	if (hci_test_quirk(hdev, HCI_QUIRK_BROKEN_WRITE_CURRENT_IAC_LAP))
+		return 0;
+
 	memset(&cp, 0, sizeof(cp));
 
 	if (hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE)) {
-- 
2.56.0

