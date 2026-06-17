Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B32392C46
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 08:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781685418; cv=none; b=cYK43MVUV4ev/U3sVL/fALbDQth+wFcoiIj0HSuWkTl6msMrOrgl9LSU/79L5lJlwQ9K9vWuhwZRt47LMcnCUcibBYpKTAfN6pVdoAyBiGuo2rII4Vtr4plq8lD1FPk5KGFHeHJ5GA9eHbS9NMCt9Ouqbv6ATRE6UUgDGdADN0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781685418; c=relaxed/simple;
	bh=FUG2QigVdVHAm4QzZM6dR99xMrjsNu7JoxNHHaKkzvA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XsWyDduflMh/FOuodw4FsJe1S5eCGoGYaiK0uijZoXCt+YIa1QeVovMojg4kLif/AoGDcDcAKaIbA0cT98hjNXe4oV0t1hCqq0rfAgVT5BIc0G1wwxoZMT70ckRzENEuTkrOH0dj5ygbSU0RArJ8Feg3awic43pQeNI+YASW9H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7F59svi; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7F59svi"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf77d4a4e2so3904725ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 01:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781685416; x=1782290216; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NK8psNNr27+GOKA1xCru6YjdqvmvAX/I/d9FqkeeZMw=;
        b=I7F59sviDie5zTDMBpKo/f8FMMUY+3caOmXJeEMue+A/Z+FBwWJAF0aRvGbIkHlzjb
         fyx36AW9AYfxH/BS7PJK2nLACgIycqif3065nVpEZ70etrjxXtrOrIt+zJ0H3WoTRwOs
         ew8ezTIx02XUTxineGCWODbgqSpLB29Ye3uCnZ8hnNU3UxZqdagy5yKScP1yQVBDlLXo
         G/yEe1aXlv6Q5rVNb+5yFdXCtIprWFZJ4LiGuvZ0A3XVCIT4Hekm8bpq7HmP0o4XwAWX
         9Ex9OuWo/88bADbS8d1DE3Y84aVWp8+Dtfi9rhPr/lCfQ9ET8SijbnCNjL2C7CIaXpIj
         6YKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781685416; x=1782290216;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NK8psNNr27+GOKA1xCru6YjdqvmvAX/I/d9FqkeeZMw=;
        b=IrDlBHKOaFavG5fsmMdatZTxtAYMmuXlkzSXVA9Nggl4FBw3yRNZYsZW2cU1Z0R0xl
         BeBCk8tuHw7Mb1OapdD8K4P78Ai8memE9XdOC7GQsrVcIo34Tcx63QzHg3KbIDY2ap2A
         UsbZfWLI0vROv/0VXwZl6Y8XFooK3SUmI0wETsUSBvEwiAXIG+kpUC55ztKZBCicBf4b
         aWsHwz1powK0LIDWQMIx/OFYTKJCqTe4TlCf309yqCPmcdzkmv4MXoN3LN2mGuVDhJJU
         vUaJXLKioqa/vuMYNWiKoOiT+7jTlY/c+3V9TQC9pBd1CEXd8vK8SnH2WgnuPsjujfzQ
         X8LQ==
X-Forwarded-Encrypted: i=1; AFNElJ8tvM/9+9lcniOCScksJNS7vem+fJj9H46oAQy09juZXSLkUIBV22fC3dFXziz/GYpo6nNQj2mZibSMM1lhyJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Pt3DcnGj++uANGTTh40pg4q8qqymKD6y6RurRpKariS1nXsg
	pVoZ9He5Fc3MigafYfz2/rCGVsWQkLb9epcY4Qr/QX17CXpPrlvo7hqfLcebtw==
X-Gm-Gg: AfdE7cnmvFnreqNoCfQZiopVm+pfjYvMtYdmaxFAYtuuQFIawxnco2P4CWSIKX/twk+
	v+pOgu1O4OoG6vR8NVgaUgwNWw8gWroe+JYMu26t1D5KFieTJD3faYW9gTP28RackbOf7jH9Qig
	9HeauKfFD5h2wvQpFY5j3AG28tPJgJJic1gKIRg4m6H1OsJXCBQ5gq29Orr8hP22nJuQAJ8G7A5
	nWpZ9tF8t8vFsopv1FjsvOfQvI9quE8C7wqUeBgg/lxlX4vuoP6CQ7i0Xam6F5AYia8QSyW/NUJ
	jXsXImEME9wBtWM1LnZwFUWTTLjV5c4lkFkkKyzStdF96DtNLQlvcXPgqARjRahm+8D4X5jbmSY
	lOPO9b1cajqNoASNUsuZSXiPMVkcWeOb389YO/Az6OtvJdmSE5xCQdQ4YWfCOElaNUrrYNnQcT1
	AMOWs0RptNDtcm5BcrOevCIOWpB0ATSg2LdCwVqXvEaLwzLzdG
X-Received: by 2002:a17:902:ecc1:b0:2c6:829b:b0c2 with SMTP id d9443c01a7336-2c6bd1093d7mr19604795ad.11.1781685416416;
        Wed, 17 Jun 2026 01:36:56 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6cf116e65sm1034795ad.24.2026.06.17.01.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 01:36:55 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Amitkumar Karwar <amitkumar.karwar@nxp.com>,
 Neeraj Kale <neeraj.sanjaykale@nxp.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Ilpo =?utf-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btnxpuart: Fix out-of-bounds firmware read in
 nxp_recv_fw_req_v3()
Date: Wed, 17 Jun 2026 16:36:52 +0800
Message-ID: <178168541269.2821257.9969892285942248117@maoyixie.com>
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

Nothing checks that fw_dnld_v3_offset + len stays within nxpdev->fw->size,
so a controller that asks for an offset or length past the firmware image
makes the driver read past the end of nxpdev->fw->data and send that
memory back over UART.

nxp_recv_fw_req_v1() already bounds the same write. Add the equivalent
check to the v3 path, reject the request when it falls outside the firmware
image, and zero len on the error path so the fw_v3_prev_sent bookkeeping at
free_skb stays consistent.

Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
Suggested-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Reviewed-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
v2: rewrap the commit message under 75 columns and drop the hard tabs from
    the quoted code so checkpatch and gitlint pass. No code change, so I
    carried Neeraj's Reviewed-by from v1 (the diff is byte-identical).

The Suggested-by credits his suggestion to zero len on the reject path.

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

