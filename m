Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D7136E37
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851210; cv=none; b=cLmyYEYid4XvZRkvRE3Kr5NIEedeI5fUUubFhk6RA6PbFpgAMrwikyGI/l/CGxaBtKROWDs18QMChwWt+ll2yGsMPq2CKi97/PGyaFgo0ycmzshXlHzjyYqAo+LTEVHPi/WrSSpNenK96I+guLuP0IGyhZrBujejs1xRRvWM+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851210; c=relaxed/simple;
	bh=voS58tw35m/lG/LM2fn0NTC8nXB2+G7MEc2/Zy3M30Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uN3wzaRIDxvxOihMhWZ/ejSuG/DTYgUQW8Seb782A/YGkDLvP5kVdNXMwTyCFQps4EHoawbr2WwUF0OgA/XEHVDayKQn77JJgvxETPnFWSbh7Us+oZb0YYYAMoNBg+rT89MuAy/1PcOYdDpK/BF7+OFslr1fXfYCae78A5WRU6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJVivGH9; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJVivGH9"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4de1b5a6b7fso60407781cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Oct 2025 08:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759851208; x=1760456008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xuvsR45lwtNudjpmCrpSYAZww8RRbfVYdMazovR1q4o=;
        b=SJVivGH9KeaMXZkuDWjyuoZtUj26PNsH/+AYDqPFFCeSYOFFkDVRdnBjKIjMj3chqf
         8PDiwN0f4BASS3nYCpDZDOJ1fwQ3LUi0bhgItJ6WZfRkDFY4nRpSfcp3rO/PHCHxF+5L
         0Cmo7jwi4ZFRYfrj6UoPBCYPTjXzI7HicePEVHm+2ps8Jc+G0U7EU8raSL2hFrySGohl
         GhQ9eQgWWGEa6bf9QCF3Y53DK82rdqPqGvriwUlHmS/2DGr7B4NeVaHU4ng9DbGxygTO
         bSJOWocCruQ+hcU9KRLEvg6+0I2iiZ9KEwBaHEl78E8B7pp0V7Q/wP6yB4wc/ytPXXaT
         N++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759851208; x=1760456008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xuvsR45lwtNudjpmCrpSYAZww8RRbfVYdMazovR1q4o=;
        b=wxqZozsAil+sUVJBNvvT4H0mUExPfZ6/5mC/UTYsW434+cn/jfhMNdw8QfPtGREPmu
         di2tRX/Qy0QM3ISJr2R1ZqW6kirKdN9rPvPIIFpCqSVMNl3o6XBBh6ipOkAPxTV1DAPH
         oxkNBT8eRFmAi3joeDv1UJAxFrVSrTfKgiUICPBJGBNvCyXCR7Y2XagdAfTKtkb5mvgt
         +JJlh//BtSPNkY18zTiwpEx/zYbkcatCbHA+5pf4GwtOK3AlIYbtqg6brXQNzGThRuK0
         H2OvV56RzA9BiuUkdSgLg/q0xvVtgtMdZEjntsaAL5lpy6sCffmSvLfn8VmLujqyyFvF
         xVxQ==
X-Gm-Message-State: AOJu0YwBIFPzwpP+NdFq2X1g6FP6MA8b9Mn3sih8mteabiJyf+QyONoJ
	QQA1iOhB6n2tvnedYN5mRHL1W9PZEC4XBhgFglZl3l71uqkVfg3Qzfn7
X-Gm-Gg: ASbGnctA2oc6fXYiUNXNk3IeBBBCDQCAjkrABj52bG2jguYyASnuDCn6J9AfkHGkt6G
	HP2u8uWDHRWBAKajoLPWVe+sympdjzH9xsOCcUxNaVfOS/8LI7CenKzHNYT1Q1LRi4rWGxXCQR9
	wuQNz59++BYJm5kB9+dlh9e0d+4zrg0gIOePWyCif99STqqFpppw0s8PfnQvFp6S8XFpnDGT56M
	DkqV2ZVhPdWHuPEl9KcAei02OwdLcmgNjwKGvcTLrIk9aOOGPGpAPmkvlsRM9BVbHK340E9SHLL
	qbZx73QccPtgpxLJMzRDcpnU102EAeBgB5UEy212xgOqRLXKBRDEFf4kHPCBmhaQXUc8GOko0cR
	aBKOUV1RzHTOB4KTTiqIISQ/w5IFOuVbEM8pELOgIVV5uXF6Rk0tuACGRyQ1MToE0
X-Google-Smtp-Source: AGHT+IGoEb/IGrmnpp4yezwDrWbOKdqI3indtAMm6uFh9R75EEpUxW2kD3vf9k0rDrfPXCPONiHGaw==
X-Received: by 2002:ac8:5a84:0:b0:4e0:33d8:c636 with SMTP id d75a77b69052e-4e576a80529mr211267621cf.26.1759851207508;
        Tue, 07 Oct 2025 08:33:27 -0700 (PDT)
Received: from etsgit14.ad.etsmtl.ca ([142.137.141.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8777a7e0779sm1561444085a.60.2025.10.07.08.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 08:33:27 -0700 (PDT)
From: Pascal Giard <evilynux@gmail.com>
X-Google-Original-From: Pascal Giard <pascal.giard@etsmtl.ca>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pascal Giard <pascal.giard@etsmtl.ca>
Subject: [PATCH v2 1/1] Bluetooth: btusb: Reclassify Qualcomm WCN6855 debug packets
Date: Tue,  7 Oct 2025 11:33:15 -0400
Message-ID: <20251007153315.72565-1-pascal.giard@etsmtl.ca>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Qualcomm Bluetooth controllers, e.g., QCNFA765 with WCN6855
chip, send debug packets as ACL frames with header 0x2EDC.
The kernel misinterprets these as malformed ACL packets, causing
repeated errors:

  Bluetooth: hci0: ACL packet for unknown connection handle 3804

This can occur hundreds of times per minute, greatly cluttering logs.
On my computer, I am observing approximately 7 messages per second
when streaming audio to a speaker.

For Qualcomm controllers exchanging over UART, hci_qca.c already
filters out these debug packets. This patch is for controllers
not going through UART, but USB.

This patch uses the classify_pkt_type callback to reclassify the
packets with handle 0x2EDC as HCI_DIAG_PKT before they reach the
HCI layer. This change is only applied to Qualcomm devices marked
as BTUSB_QCA_WCN6855.

Tested on: Thinkpad T14 gen2 (AMD) with QCNFA765 (0489:E0D0)
Signed-off-by: Pascal Giard <pascal.giard@etsmtl.ca>
---
Changes in v2:
- Address reviewer feedback about 0x2EDC being a valid HCI handle
- Use classify_pkt_type callback instead of filtering in recv_acl
- Only apply to devices with BTUSB_QCA_WCN6855 quirk
---
 drivers/bluetooth/btusb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5e9ebf0c5312..256179ace853 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1131,6 +1131,24 @@ static void btusb_qca_reset(struct hci_dev *hdev)
 	btusb_reset(hdev);
 }
 
+static u8 btusb_classify_qca_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	/* Some Qualcomm controllers, e.g., QCNFA765 with WCN6855 chip, send debug
+	 * packets as ACL frames with connection handle 0x2EDC. These are not real
+	 * ACL packets and should be reclassified as HCI_DIAG_PKT to prevent
+	 * "ACL packet for unknown connection handle 3804" errors.
+	 */
+	if (skb->len >= 2) {
+		u16 handle = get_unaligned_le16(skb->data);
+
+		if (handle == 0x2EDC)
+			return HCI_DIAG_PKT;
+	}
+
+	/* Use default packet type for other packets */
+	return hci_skb_pkt_type(skb);
+}
+
 static inline void btusb_free_frags(struct btusb_data *data)
 {
 	unsigned long flags;
@@ -4201,6 +4219,7 @@ static int btusb_probe(struct usb_interface *intf,
 		data->recv_acl = btusb_recv_acl_qca;
 		hci_devcd_register(hdev, btusb_coredump_qca, btusb_dump_hdr_qca, NULL);
 		data->setup_on_usb = btusb_setup_qca;
+		hdev->classify_pkt_type = btusb_classify_qca_pkt_type;
 		hdev->shutdown = btusb_shutdown_qca;
 		hdev->set_bdaddr = btusb_set_bdaddr_wcn6855;
 		hdev->reset = btusb_qca_reset;
-- 
2.51.0

