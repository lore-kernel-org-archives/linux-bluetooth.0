Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35675449ECA
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624420; cv=none; b=KhgLYiTGlpGVCrqlypT0S2vkmFdI+Ux0tiyww/qB9hKR+oBqWvC90ThtgJIVCaJrZdiBv30XxdREvlKFPy6Ye4n7e38gfy3lGnuuBl/n7gXe/16575pLaN5kCM4+X9Cy49PL/gADFO8EpumB9h+bGX2V/eZN8HgupKFeJLs+GRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624420; c=relaxed/simple;
	bh=B/n/Z6ngnyOBJW8wbql6PASwEIY1LngqzzNEia4uSuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lMC5sNziryderedduLHJtJN8v7L8Z5bybGcSWm3ZPrPzyr5betr9j7WFrxP4Vhm5FeUvI464vsOzUmJctiFiqAZlEkPrsh7YhrgGQAuD1MjtajJN7aT3awUWSPvygEjcsfaKJJ6Ku/7ue13nvZV+dAFQpJ7HaEMAaHqqdMwqcLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3K9Phuz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3K9Phuz"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0c20f0c0aso33629565ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 08:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781624418; x=1782229218; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wbFbHS6xILg2w0HrbS7VWz1p9iJAmBeN6fgMuEOOmxk=;
        b=D3K9PhuztCmPJQ+aXNtACKKW8Xk8X8jOhTjtQA+N2kyKiVoJq+A5Vo+n1jXgUQweM0
         OI4lEI77y7l/cNWo/8AlJN8lB8OgGb5f22qICgCT6m1wzXaizFAlbmby3XM1YAGMel2O
         idVOARmjOESk+n4w/pdc60NzOWlptvKBb4nV8bXtPGM+Wh1/0g4hC+cxsufQp6ZsoD0s
         6KMBNsPlZRC7r7dG5BMi3EhyjltmbqZ96oVGmS44xhqlF3jr7LYJ8Dhpzbumw6odUivg
         +DU1mlDgO8frMkCqkHmmUp9WvjpFFuOIMLAZmonxeJPG1ryHdNJ1veWpASc9/QBGvSaL
         ogBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781624418; x=1782229218;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbFbHS6xILg2w0HrbS7VWz1p9iJAmBeN6fgMuEOOmxk=;
        b=SV9HLAsbOIGkcu0xbrVbQmqYYiytEXWgFTOioDx9gtTvSg5hMm7Dk97dJeumVgYonG
         WFXuy+3kuNqiU/i5tHOp+SHU0Bmc0GfosJf0jy2NfURJTRKxQEnOJcBRU+0DBqNxzzzJ
         juOH40p97bB83DtxuIr/vNeoGueKNndsDTMZn0VNZIfRtnnm+VohQOu/8CHeWm3gTQ1Q
         vfCIhNn3kmTMWawZzxyhRUSsw4ZzkDo/iceRqkZLslMVyo/xhxsZNN65Dp5Plt4EPTTs
         pxoJV7fkQsHkLyBHzYNsz8fTAtDkwW+HB89DwdF4pgcLEZkVgSOiIN/WXIYAiilC0bwD
         BT0A==
X-Forwarded-Encrypted: i=1; AFNElJ/exlVVVMgjI+3ycmzt/ezFmGUMssRscX2HiQRR1fvGdBw/Kr3eCQUPD44DqScmypXAX/fE9lUaVkj2USeiJds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtmHrcPvaqfyXau9BYADPrik879zngaarMkYQcgRLe3dl4gutk
	qT+5saMFmL8lIeVhjtcy5LfaAszd1pulSVcRCNp/6pCucJD1v7qX7emW5BOYHw==
X-Gm-Gg: Acq92OG+EKssA2RJsUjc7Dt00WdvkTHfO5vOZDlUGUPoK7/TrgBD9IT27cgblD/pCMq
	8NBZiZJDkm9lj4Udl0PaWOYlZVori2pUe7rVwYfqv6NZ4kYrk6ntTOEwwjWkqEnMmNQK3ehHv/i
	lgeLmxu04JW2nConZSU3UtxhhotTxcO+cEcMGDbcrtdOVmIfwQgLKebvFUjp/mV4rIur2PdvGxR
	AiEYoINBiGeA51qvtdJN/3CQopkk9eW1Vt5Nf1v9w4EKcO4dLD1Ja43ZZImKyqugQJDWG/1/Crz
	LZVkJu2USWHNx8mMlFdfr0Gb9RYLXTMaim0et2697/7+6EYhp1sEWZgv5i06vk5leF/c8S79UOx
	BG6cFlKoi56fUNJC9jqcx+CEVq7bx/eNV6WvmNwlq/mPN14yy3f0F2+e3027pMFSRh+Q3PkQM2e
	vfM/Bqkc8H8nscJKQrSgoHeNyW7PzlB2fXd6seEYZhskCz5RgYmzerwGiOzp4=
X-Received: by 2002:a17:903:1247:b0:2c0:b081:84b1 with SMTP id d9443c01a7336-2c6641611f5mr168532715ad.10.1781624418202;
        Tue, 16 Jun 2026 08:40:18 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432c8dd4bsm143323175ad.60.2026.06.16.08.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 08:40:17 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Amitkumar Karwar <amitkumar.karwar@nxp.com>,
 Neeraj Kale <neeraj.sanjaykale@nxp.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Ilpo =?utf-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btnxpuart: Fix out-of-bounds firmware read in
 nxp_recv_fw_req_v3()
Date: Tue, 16 Jun 2026 23:40:13 +0800
Message-ID: <178162441367.2434858.9590661629618538235@maoyixie.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

During the v3 firmware download the controller sends a v3_data_req with a
32 bit offset and a 16 bit len. nxp_recv_fw_req_v3() checks only the lower
bound of the offset and then sends firmware from that offset.

	nxpdev->fw_dnld_v3_offset = offset - nxpdev->fw_v3_offset_correction;
	serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data +
				nxpdev->fw_dnld_v3_offset, len);

Nothing checks that fw_dnld_v3_offset + len stays within nxpdev->fw->size, so a
controller that asks for an offset or length past the firmware image makes the
driver read past the end of nxpdev->fw->data and send that memory back over
UART.

nxp_recv_fw_req_v1() already bounds the same write. Add the equivalent check to
the v3 path, reject the request when it falls outside the firmware image, and
zero len on the error path so the fw_v3_prev_sent bookkeeping at free_skb stays
consistent.

Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
Suggested-by: Neeraj Kale <neeraj.sanjaykale@nxp.com>
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
This is the fix for the out of bounds read I reported on linux-bluetooth. Neeraj
confirmed the bug and asked me to send it. The Suggested-by is for his suggestion
to zero len on the reject path, which keeps the fw_v3_prev_sent bookkeeping at
free_skb consistent.

 drivers/bluetooth/btnxpuart.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index e7036a48ce48..6a1cffe08d5f 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1267,6 +1267,12 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	nxpdev->fw_dnld_v3_offset = offset - nxpdev->fw_v3_offset_correction;
+	if (nxpdev->fw_dnld_v3_offset >= nxpdev->fw->size ||
+	    len > nxpdev->fw->size - nxpdev->fw_dnld_v3_offset) {
+		bt_dev_err(hdev, "FW download out of bounds, ignoring request");
+		len = 0;
+		goto free_skb;
+	}
 	serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data +
 				nxpdev->fw_dnld_v3_offset, len);
 
-- 
2.34.1

