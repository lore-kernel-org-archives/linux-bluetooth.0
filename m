Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.69.30.187
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910001;
	b=VIPdRuDEA6VY1FEL6Xh9pBHT028LwITUcrtY+L4b+Vjfug//He5NRd6HqrNzz0CsY6tF
	 5fUMcjfiYWPWsNQqOvDvT4uPnf3HEosVIo/a5Ej7b3Y/tdpelxiIM4RrCH5eYrFMzhibh
	 2YZc2J1hlcCypHNm9z8g2sZCdq72aW7V/xXIHM65cYdzzygCbeMPa2OOUouIVkPKpHRy8
	 3WQ1uJa36TcU5Is+zgLwcgALCxOpRgyQrYQAoC/SC1edF5PDeHMlSJQnynVI7KxqosEaz
	 Npr1k+y54w7lDi3sfMnx+dh83b557N/hdGy0rfu8lypMW60sUQZMHZzRrnsOjX08/Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910001;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bgpF/EZX37bnef9QFnkTNMcMRCOnqfvQ1c3qRPjQWm0=;
	b=M9YFFjie6Xx7zl+GegZOEX6PmSuDqYZZ/eIY7RPdAQz0ojEdaT/ZxAHvq7IgbIclMMHQ
	 Ya+zys23Qhn8nT6+XilIzdFNxLAkjtgHWTo/BT5Dv0XVkoNPwwZXHiQp7s/TLveL4yJ22
	 CDoHz9pSbrHS/OXp9DEmKLtBqNtowMQLlKnXwJL5A9UUJa8zEALKLVetNzNAoF+XRwBos
	 P/SufSoon3dTorWMy/jNwC0IqpcjFjb69QjHoAzgV5QVE4OogmzfE0MQO5QhFcLzwhIG9
	 x2C2bu/XXvYLKrSDOFaqwaIhUYj5bvhZ5euBWJweK2DjRK8+tEbonb2JRs3rIo31ViA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=freenixos.com;
	spf=pass smtp.mailfrom=freenixos.com;
	dkim=pass header.d=freenixos.com header.i=@freenixos.com header.a=rsa-sha256 header.s=mail header.b=CvhTM3DG;
	arc=none smtp.remote-ip=54.69.30.187
Received: from mail.freenixos.com (mail.freenixos.com [54.69.30.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AE8606A31B;
	Thu,  5 Nov 2026 20:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8AE8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=freenixos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenixos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=freenixos.com header.i=@freenixos.com header.a=rsa-sha256 header.s=mail header.b=CvhTM3DG
From: Hex Lindqvist <hex@freenixos.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freenixos.com;
	s=mail; t=1793909994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bgpF/EZX37bnef9QFnkTNMcMRCOnqfvQ1c3qRPjQWm0=;
	b=CvhTM3DGoda1vSym7tUJxuEq2+FJO3Gv2JCOtkAXJZ1GtPgv2LRg/hcTSZivzwUFhFi1zx
	E82OmSeygyK3WNCj5cljICsxN8C9LrxalMZrAUYw06eISBbjl8rJeSQj5RtDGYf7K8caoA
	zbYFGXncTj4/thMW3tZsNwRq67athmRUK3y+mEeH3/Bmyt9R4KiFlUh0hqK6TkxbJo2JTo
	f3+2hqlIEtfZUrCsyrM9SvvkUW+20rm42MH0cUW9UAaUX4jru9own2dEQz0gGtRzy9euk8
	o1QEBITkCKODJWnipzABvrWgU+3rr0YoRHTqAf3EFtg22gicCXvYRHS+1bsGEQ==
To: Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: qca: Disable SoC debug logging for WCN3990
Date: Thu,  5 Nov 2026 12:19:52 -0800
Message-ID: <20261105201952.1556185-1-hex@freenixos.com>
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

Unless the host turns it off, the WCN3990 firmware sends debug logs to
the host as ACL packets on handle 0x2EDC. hci_qca passes them on as
diagnostic packets, which the core copies to the monitor socket and then
frees. On a OnePlus 6T (SoC version 0x40010214, ROM version 0x0201) that
is a packet of about 490 bytes every seven seconds on average, for as
long as the controller is up.

The driver already turns this logging off after the firmware download
for WCN3950 and WCN3991. Do the same for WCN3990.

Tested on a OnePlus 6T. With the crbtfw21.tlv rampatch from the OnePlus
firmware, no diagnostic packets arrive any more. The controller also
accepts the command with the crbtfw21.tlv from linux-firmware.

An AI assistant helped find and test this change and drafted this
message.

Signed-off-by: Hex Lindqvist <hex@freenixos.com>
---

Notes:
    Test details (OnePlus 6T, crnv21.bin from the OnePlus firmware, counts
    from btmon):
    
    - v7.2.10 with the postmarketOS sdm845 patches, OnePlus crbtfw21.tlv:
      87 diagnostic packets in a ten-minute capture started a minute after
      boot without this patch, none with it.
    - bluetooth-next (31333770a468), same firmware, btmon from boot: 42 in
      the first seven minutes without this patch, none with it; the command
      succeeded at every setup. Plain bluetooth-next hangs this phone after
      about seven minutes with or without this patch, hence the shorter
      window.
    - v7.2.10 with linux-firmware's crbtfw21.tlv (its only WCN3990
      rampatch): the controller returns success for the command (btmon
      during setup; not a ten-minute run).
    
    Not tested on other WCN3990 boards.

 drivers/bluetooth/btqca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 60735b70d89a..1db2cc626def 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -944,6 +944,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	case QCA_QCA2066:
 	case QCA_QCA6390:
 	case QCA_WCN3950:
+	case QCA_WCN3990:
 	case QCA_WCN3991:
 	case QCA_WCN6750:
 	case QCA_WCN6855:

base-commit: a063a00e6cd9e354aa6d67a154a0527951d7f881
-- 
2.56.0

