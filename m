Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=138.232.1.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792956243;
	b=cOkVLDcfsfprhKKz9qntvIsMisy5TPdcTZcQqPENd56R0e87NZOC5GKsJyuKcKnGwRlT
	 7EPdrw2ouAbCTpWzI8tABXJeHWk7qsaFXepAXsF0PDpTwsrwhwMmsDUx6qhLgGLBV5zTC
	 tao2aHweUB2p6tO3i7HUiTxPqttlTt8FcTaLKofhmPqUdLRB6OKu6EbGfjxStrPhgFp91
	 xzRNh6h70I+YCbqRD3037A9mdusrFNBrXHa4bUORo9cEhP/9PPtmoBlOMfpEsG41uCYtk
	 7LFXE/wLL+ELlFX0lryvYHf1tMWIqSn7lZBg/YhFtaUtUkdBXUR6RR1/8FMo1i8b/eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792956243;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Score:X-Scanned-By;
	bh=giv2Oq99AZU4emHMuBbOr6PdOEXlLujdot2f25HQx5Q=;
	b=OtkLHClUMon3V0TrKHY5XllBfdx+P68nH7WcM5AY9IhiWwKYMY4sJfnWQYHV5q1UwTIo
	 7odBE+T+BlmA8OEoW4YlxFSf7b9iRtXz9wITZJ+GvDcHtUSIcubvm41jHvpVAZwnKH5m5
	 HKkHadubk8hWuWGrseSq9zmGm/x19KD2pSP7n8v9ksjIrboTZei4SFHrkQJI5/SNI2HvS
	 1EooZXnJxrGd7pgRK0JJd1pE68vCoRl/qr+FiJNjJKQcDfoBMHPoMvnNtA3FSvlISs1CB
	 Z5NHDy9KR62cVjIAXNVtXE51TgxBDh29O9stEST2KUf1nARPQ5KFiS/adMNR01hC1Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.uibk.ac.at;
	spf=pass smtp.mailfrom=student.uibk.ac.at;
	dkim=pass header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=E0HxzIue;
	arc=none smtp.remote-ip=138.232.1.140
Received: from smtp.uibk.ac.at (smtp.uibk.ac.at [138.232.1.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F28660A381D;
	Sun, 25 Oct 2026 19:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F28660A381D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=E0HxzIue
Received: from surface-pro-5 (178.115.151.51.wireless.dyn.drei.com [178.115.151.51])
	(authenticated bits=0)
	by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 69PJNdP0518064
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 25 Oct 2026 20:23:49 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 69PJNdP0518064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
	s=prod24a; t=1792956230;
	bh=giv2Oq99AZU4emHMuBbOr6PdOEXlLujdot2f25HQx5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E0HxzIuePOiyePQDFvwx4gLK9ktTXPxGqnLDYs5ftlUoOnFzbNbtxkTn3Pmt4WiWD
	 FBDzJfIuApRc53ZBfMoiSZDHkFsJu9AY1Xks6LWGWp/LzXDEBA9moD4BdM2ipgiwee
	 JeRMTFDDQucoQYh8m8aRpAkqgok8cepyibqHNlMU=
From: christian.koever-draxl@student.uibk.ac.at
To: yang.li@amlogic.com, marcel@holtmann.org, luiz.dentz@gmail.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
Subject: [PATCH 5/7] Bluetooth: hci_aml: take the address from the firmware description
Date: Sun, 25 Oct 2026 20:23:36 +0100
Message-ID: <20261025192338.209574-6-christian.koever-draxl@student.uibk.ac.at>
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

When the controller reports the Amlogic default address the driver
marks it invalid, which leaves userspace to configure one before the
adapter can be used. The controller does not keep an address across a
power cycle, so there is nowhere else a stable one can come from.

Set HCI_QUIRK_USE_BDADDR_PROPERTY as well, so that a local-bd-address
property, typically filled in by the bootloader, is used when present.

Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 drivers/bluetooth/hci_aml.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/hci_aml.c b/drivers/bluetooth/hci_aml.c
index 8561618867e8..d1b83f7bd388 100644
--- a/drivers/bluetooth/hci_aml.c
+++ b/drivers/bluetooth/hci_aml.c
@@ -528,6 +528,10 @@ static int aml_check_bdaddr(struct hci_dev *hdev)
 	if (!bacmp(&paddr->bdaddr, AML_BDADDR_DEFAULT)) {
 		bt_dev_info(hdev, "amlbt using default bdaddr (%pM)", &paddr->bdaddr);
 		hci_set_quirk(hdev, HCI_QUIRK_INVALID_BDADDR);
+		/* Nothing is kept across a power cycle either, so let the
+		 * firmware description provide an address.
+		 */
+		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
 	}
 
 exit:
-- 
2.56.0

