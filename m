Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F262561B6
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 20:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759525162; cv=none; b=oXImqa2tA5ulwr6Dg0t1BhZGffp3SNnaRissM21hm/zi7bugT1cfkp/oOZT3xEtPr9UQ/0nrcfJ9B3xELuhnhQkcz5R1XPpC1GjPWI/VpdCwaH2YeMTIkp3oyJnppji9GvK6NNqKG+XoJKWl42XckTdT+7EAu8HkW/xHgN0YjwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759525162; c=relaxed/simple;
	bh=3iS0NPyXkoJCsxxmYHv7FSsoUUYgEBq2uJwzGDpCMzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AQe4QFm6Et5L6CdTCNGBFAo9L+94JyBADxTA43Fit0XnPybf82vPPbShw7doXcLik5F2GMyzxp8LCtFYzGdp1Vy9h6ZL9RE+Hp8/qX7P+hCYnagiN00pfmpl9Z46IqKpjW/hJB7zWJAcNCr5ZSeNALgrw31rOkTlEld+LAlQnis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyWx08qS; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyWx08qS"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8571a0947d1so282450385a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Oct 2025 13:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759525160; x=1760129960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KT4nMlGTNRa2oLGSJ7qmFMgvXCrjlBGOzo/18l5VvRs=;
        b=SyWx08qSUUlzAzNYA7Ei+s2WPLuRHioRrLddHhtG4HxDVApCO3s/DdRjlpSJ+JdiKO
         eWTZfnoRxdZq/oiqR4bNLZpS6g7PvNjqK93R4ZrSaE5gIbzy+t7FE8SWW6TSY98VErp6
         Bao06ISlPFZC8R1+BQsbBW5GI2HgQTgsefvuqWtXylxY9WiCTkDFl/TY13ahQ4IvHmQs
         Lp/7TjjsO36rv2JAxXUipJGcZeqJNs0Jz7V1jsVemjt0a5FT15zfMhf49na2SlrPC9r8
         TyGO0UDML86KsFe1N1V2+eL6IvxmOuOX8XfUNYoQM7WQiEHT6WwSgOu4keFmBJOeHm5m
         ogxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759525160; x=1760129960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KT4nMlGTNRa2oLGSJ7qmFMgvXCrjlBGOzo/18l5VvRs=;
        b=r32mIi8o61mZlTkOGJR5AGGtcYekCVWFULn+Sua7aCUinph1g+u+rSJDm9o1v3mr+v
         ldVRMyr0T+j18+x0S9S6cXyIrm6JsGqFVpGVkl00eSzko3CvdbppXDregJ87ZpeRMQOi
         q5GTe/wUkwbbWrZI4v2nrV/bX0g0ZtY5NB5oNNcspWJjewSkZODwUHpRlWsWsEtD8iWf
         ClcMxDDnw0YVDT/1Et1313oLCCBwxIpPIRw+w2StU42zxhGKT3gP7gY173l8JaK8PgWA
         pxZtvQrR54XjIZUTEQZUqqwekyW/h08TeksWRpOGqz7xaHSP3JLqM1GYYYfYIPjgxs33
         Oxog==
X-Gm-Message-State: AOJu0YyCg6Pdr9FW+G62QK3LCFgEDBCdFuqbgs5I9dPDeBG5F3QrR9r5
	4kZiKw3uV91ZfIDJRjcr2w1rVsZ+bmLe5wj0EAHHFltdmq0G7eozZy9h
X-Gm-Gg: ASbGnctpCy3VQkYthpyoenbMT49Rav7vKGa4N1bDyeJGQkMC4UIZXhq3RjznxvMNmsO
	jhNcLQXRWbZW+rnNqgKwHuB+qjLziCsD9SFeM2I40Xtt85DGBUsjx0/XZTBU/QnBDRec6XyY4jZ
	Vytk81diWEAgeKh4MNZcVcleo9yLH6y7GvgMADyLFsBCL40Mk6oOoW9v950wTVcKH8DRgiZO0iV
	JGXRLr60GU7ToLrGNkDe7zk7e5b3neiJ45l5byLVnIju1kpHLY8SaQy9lAx7izWIqyoACEle6+t
	sQCOb3uSTdudvThNrmaDBZYuR6acWl3sPs3aK7K01o8tGPJmwm2Y4CpifwQQ5QmIymgeTc4hUhS
	YTliCT7Y1UnjQEKS9n5YG1AggUFRbzA/IMrWGBPHzaFZtiISnnZk=
X-Google-Smtp-Source: AGHT+IG52HETqCWP88p+h8ZNfHvJ7DJyecVGzPgXEf1tHWE6Q+vyJHKSUErRHgLmxu46A08JBLL+cw==
X-Received: by 2002:a05:620a:4002:b0:828:4c12:9a67 with SMTP id af79cd13be357-87a3376d80bmr657803985a.17.1759525160083;
        Fri, 03 Oct 2025 13:59:20 -0700 (PDT)
Received: from etsgit14.hitronhub.home ([2607:fa49:173b:2900::2ca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8777a7e0295sm514898085a.59.2025.10.03.13.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 13:59:19 -0700 (PDT)
From: Pascal Giard <evilynux@gmail.com>
X-Google-Original-From: Pascal Giard <pascal.giard@etsmtl.ca>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pascal Giard <pascal.giard@etsmtl.ca>
Subject: [PATCH] Bluetooth: Add filter for Qualcomm debug packets
Date: Fri,  3 Oct 2025 16:58:37 -0400
Message-ID: <20251003205837.10748-1-pascal.giard@etsmtl.ca>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Qualcomm Bluetooth controllers, e.g., QCNFA765 send debug packets
as ACL frames with header 0x2EDC. The kernel misinterprets these as
malformed ACL packets, causing repeated errors:

  Bluetooth: hci0: ACL packet for unknown connection handle 3804

This can occur hundreds of times per minute, greatly cluttering logs.
On my computer, I am observing approximately 7 messages per second
when streaming audio to a speaker.

For Qualcomm controllers exchanging over UART, hci_qca.c already
filters out these debug packets. This patch is for controllers
not going through UART, but USB.

This patch filters these packets in btusb_recv_acl() before they reach
the HCI layer, redirecting them to hci_recv_diag().

Tested on: Thinkpad T14 gen2 (AMD) with QCNFA765, kernel 6.16.9

Signed-off-by: Pascal Giard <pascal.giard@etsmtl.ca>
---
 drivers/bluetooth/btusb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5e9ebf0c5312..900400646315 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -68,6 +68,9 @@ static struct usb_driver btusb_driver;
 #define BTUSB_ACTIONS_SEMI		BIT(27)
 #define BTUSB_BARROT			BIT(28)
 
+/* Qualcomm firmware debug packets header */
+#define QCA_DEBUG_HEADER	0x2EDC
+
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
 	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
@@ -1229,6 +1232,12 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 
 static int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb)
 {
+	/* Drop QCA firmware debug packets sent as ACL frames */
+	if (skb->len >= 2) {
+		if (get_unaligned_le16(skb->data) == QCA_DEBUG_HEADER)
+			return hci_recv_diag(data->hdev, skb);
+	}
+
 	/* Only queue ACL packet if intr_interval is set as it means
 	 * force_poll_sync has been enabled.
 	 */
-- 
2.51.0

