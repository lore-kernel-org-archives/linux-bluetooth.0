Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.107
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795719609;
	b=wivP18+v6WbkO3pGBE5ysYqbEdcWe/11pGyZ0jeEIg8/A7xOzQE/ZTWeQ6fu87rgPv33
	 MDuXVKsfowh0mp5cUeXGvc9w7jgiVLACWwh8oOuTUJpCF0a4wOzM6te6CFofvilvWTOzi
	 R7MuUMfma9UO5FdJAzMMBe0OCTMCcAPknhPLK64QIxBNRhLg3irxuzMxZJ/kMKCWaIzVl
	 J1tbHfOjKm0wKZFr4HimzVh6aXNlncmY0vEnIcfn1DhSAA56bROpk8WBA5Hp+ZJaKwCKK
	 T0bTvp+BNRKxFxjG1kEQuz1YGrJ+GMxPxuKH074wMHjb+QE8wHvum0z74JG3Sq7vMMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795719609;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Date:
	 Subject:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=K7ymiYInnsuA5Q53EewPdrFYhNjoCzCpkr9WJ9qOr0A=;
	b=BvFeIG98vE0QDWSbgl+HTmFtCKbjaRUSDSrGt29l4nKVdT6qkh/zxKjtdbf6TADGMlP6
	 q3ulAAEZshMdyJ7/Lr7TCYZk9cd9gUW/TQaPDbpC53KqlwKN4ONWTPXMquxaPf0Xfwqck
	 w/8oSsPl6n/J3sNmraA42wWJhzcInr14W/yt3VysHFlNarVcr96v1S1Kh46bA8Bw87lGV
	 VKNlIlO93VZrdloO4IYOpYkDia9VJPRe6ijJnDUF686aZndr7TLp1P2EFAhYVtglqahRn
	 feNcQcApVQfCt+8XuDZfje78PrRQcHU8fhG7LVQdukMIJZE8j+xAVmfVQ2Fw9w8XuVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b="Ilud/c35";
	arc=none smtp.remote-ip=109.224.244.107
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA01606A33A;
	Thu, 26 Nov 2026 19:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AA01606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=Ilud/c35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1795719606; x=1795978806;
	bh=K7ymiYInnsuA5Q53EewPdrFYhNjoCzCpkr9WJ9qOr0A=;
	h=From:To:Cc:Date:Subject:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Ilud/c35MsgyW/kepDF19UqaOv4HtanH55j53Y0PbtGwPjYXhJKePH9nQwvelN3sR
	 EE0S5yyL1JgRFhL90BNX6RexGgDs36OBCUjgZ5pp9THfk01kh2+kHA7KDS6kCmVTHp
	 MfFazIjOLmpbQA9OnVN+b4W2DlYQOyeeWtsL3zNdu8wLCYJEvMoz5r7eyt8HyejiXh
	 wlV7fwImTcpRhpImk+j5Emj9iTkvpcfIIBZHaRnpPK77yc6GNEzMTh/BirsBXOBJ+1
	 q+F17pPqIykbONJoXHkWVTzOX2gYKMrnHdqfYD8S4VMARGjF4dQCd/ztOcwbJ7Qa9r
	 eUq5dEev/jpDQ==
X-Pm-Submission-Id: 4jb5TK1Qlbz2ScXZ
From: Michael McAllister <me@michaelmcallister.org>
To: marcel@holtmann.org, luiz.dentz@gmail.com
Cc: brgl@kernel.org, enderaoelyther@gmail.com, linux-arm-msm@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 lumag@kernel.org, markus.probst@posteo.de, mka@chromium.org,
 phone-devel@vger.kernel.org, quic_bgodavar@quicinc.com,
 shuai.zhang@oss.qualcomm.com, zhaojinming@uniontech.com,
 me@michaelmcallister.org
Date: Thu, 26 Nov 2026 18:59:41 +0000
Subject: [PATCH v4 3/4] Bluetooth: qca: Handle failed power-pulse writes
Message-ID: <179571958168.81221.2447983225223068787.wcn3950-poweroff-v4-3@michaelmcallister.org>
In-Reply-To: <179571958163.81221.3368253997777320112.wcn3950-poweroff-v4-0@michaelmcallister.org>
References: <179484638195.54009.1916641645532262287.wcn3950-poweroff-v3-0@michaelmcallister.org>
 <hvwqozj3r7n7igxw5qogu7xxya4fkhqanb334sroj37ufzdizu@qarvtlkkulmj> <179571958163.81221.3368253997777320112.wcn3950-poweroff-v4-0@michaelmcallister.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

A failed UART write leaves hardware flow control disabled. A zero-byte
write is also treated as success even though no pulse was queued.

Require the one-byte pulse to be accepted and restore flow control on
the error path, returning -EIO for a zero-byte write.

Fixes: f9558270b85c ("Bluetooth: hci_qca: use wait_until_sent() for power pulses")

Signed-off-by: Michael McAllister <me@michaelmcallister.org>
---
 drivers/bluetooth/hci_qca.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 53239b0ab..d341481cd 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1426,9 +1426,10 @@ static int qca_send_power_pulse(struct hci_uart *hu, bool on)
 	serdev_device_write_flush(hu->serdev);
 	hci_uart_set_flow_control(hu, true);
 	ret = serdev_device_write_buf(hu->serdev, &cmd, sizeof(cmd));
-	if (ret < 0) {
+	if (ret != sizeof(cmd)) {
 		bt_dev_err(hu->hdev, "failed to send power pulse %02x", cmd);
-		return ret;
+		hci_uart_set_flow_control(hu, false);
+		return ret < 0 ? ret : -EIO;
 	}
 
 	serdev_device_wait_until_sent(hu->serdev, timeout);
-- 
2.39.5

