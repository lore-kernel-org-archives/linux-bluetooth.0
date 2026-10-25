Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=138.232.1.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792956243;
	b=FNWOVKb6Mpe9McNiT+g6Y6Mgqhcit6ZTWwJfKPHIDvE/G68TyRELuwq45n4kattqDy4m
	 E6PxNPeUmpoy6pErBJxpf+UZi5j3oJDyhiwVCnjAvaFkXVULDCQ2TTsXEQGrK/0yrIWfC
	 CN+Aec1WPetfnee3gYxCZmXGZgNNshZJNoGkaqmOwr6zjNb/kgYiAgd6ja2kgFLbUCF5R
	 p/kiV8N5KpFyQ6RM4OHQKAfcWD6NepD+DZcNWUjA1o5CHij0PC2bPD4oOsw451bxZy8ST
	 TH9z7giSG97l+cY0weQDwqDK13sZA3pYFIL4HZ0XwZCBMXBtNmq7yFrNtFkBGOqTOjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792956243;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Score:X-Scanned-By;
	bh=p8j3sBY+GkwxBC3BBGFGN9pwRwBAKa3qwpVoozhYhec=;
	b=5RQzIwSEdTAf4pT4MKwESd0lS43NnmmRpsB83NPsS+gPgx+y1cczYV/iMWDJg9t2bBHH
	 vgOyMqK8/PW6ZVenaDi+rZ3gVj2lXabrWWJZCROv25WAsjig8PV89EAs/lyBAN113YwUm
	 18bdE272BF2WFXO8fec2HRk2LEhwQvrTOP248lcBYBZu8KV/j+HZPFuKqyI+gEpm+VUxN
	 TasKo6IqqvpZkay5wZhKcc7uu4Vo/r1/nGseMp7wS+zqLEHCyPDULI7ebZmncrg0bDT09
	 ccLeATFNxUIO0b5MG7+9/F3VUO+UVZSUsDXRbphwVpDZJqY3QtomhzATI2NJQTkvwfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.uibk.ac.at;
	spf=pass smtp.mailfrom=student.uibk.ac.at;
	dkim=pass header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=oRzVefiH;
	arc=none smtp.remote-ip=138.232.1.140
Received: from smtp.uibk.ac.at (smtp.uibk.ac.at [138.232.1.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615D060A382F;
	Sun, 25 Oct 2026 19:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 615D060A382F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=oRzVefiH
Received: from surface-pro-5 (178.115.151.51.wireless.dyn.drei.com [178.115.151.51])
	(authenticated bits=0)
	by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 69PJNdP2518064
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 25 Oct 2026 20:23:52 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 69PJNdP2518064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
	s=prod24a; t=1792956233;
	bh=p8j3sBY+GkwxBC3BBGFGN9pwRwBAKa3qwpVoozhYhec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oRzVefiHLySDdSjm9fnfUNnoraB1iMO+I7bkFis2QThsggaHGhpB+d9ZveLq/3l2N
	 17Rn6ynAfN5jyz9j6roHP5mmle2D2Xr6FUMrli8oqRRhFfjNNXV48CC2h9BPOt+WOK
	 fzRUc0CQ0k7c7Hn7GUxX74qO8QK4YbF1znw4Hsns=
From: christian.koever-draxl@student.uibk.ac.at
To: yang.li@amlogic.com, marcel@holtmann.org, luiz.dentz@gmail.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
Subject: [PATCH 7/7] Bluetooth: hci_aml: configure the RF for a shared antenna
Date: Sun, 25 Oct 2026 20:23:38 +0100
Message-ID: <20261025192338.209574-8-christian.koever-draxl@student.uibk.ac.at>
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

The RF configuration selects the single antenna setting only for parts
flagged as coexistence capable. On an S905W2 TV box with a W155S2-class
W1 chip, Bluetooth and Wi-Fi share one antenna; with the default dual
antenna setting the received signal is about 15 dB weaker.

Use the single antenna setting when the board sets
amlogic,shared-antenna.

Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 drivers/bluetooth/hci_aml.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_aml.c b/drivers/bluetooth/hci_aml.c
index d1b83f7bd388..dc797ab665b9 100644
--- a/drivers/bluetooth/hci_aml.c
+++ b/drivers/bluetooth/hci_aml.c
@@ -123,6 +123,7 @@ struct aml_serdev {
 	struct clk *lpo_clk;
 	const struct aml_device_data *aml_dev_data;
 	const char *firmware_name;
+	bool shared_antenna;
 	bool powered;
 };
 
@@ -569,6 +570,9 @@ static int aml_parse_dt(struct aml_serdev *amldev)
 		return -ENODEV;
 	}
 
+	amldev->shared_antenna = device_property_read_bool(pdev,
+							   "amlogic,shared-antenna");
+
 	amldev->bt_supply = devm_regulator_get(pdev, "vddio");
 	if (IS_ERR(amldev->bt_supply)) {
 		dev_err(pdev, "Failed to acquire regulator");
@@ -696,6 +700,8 @@ static int aml_flush(struct hci_uart *hu)
 static int aml_setup_controller(struct hci_uart *hu, struct aml_serdev *amldev,
 				struct hci_dev *hdev)
 {
+	bool single_antenna = amldev->aml_dev_data->is_coex ||
+			      amldev->shared_antenna;
 	int err;
 	int i;
 
@@ -717,7 +723,7 @@ static int aml_setup_controller(struct hci_uart *hu, struct aml_serdev *amldev,
 	if (err)
 		return err;
 
-	err = aml_config_rf(hdev, amldev->aml_dev_data->is_coex);
+	err = aml_config_rf(hdev, single_antenna);
 	if (err)
 		return err;
 
-- 
2.56.0

