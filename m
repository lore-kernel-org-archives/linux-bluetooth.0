Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D418814EC4D
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720466253; cv=none; b=HzBn+Sy6mytj9Y5Tcgd4d6P9OH3MCUTvADtzqG8J9YlRfzW8wQaeyZ8Lthn5DgNdOV5nnRm1UR0SEW/by9ZS7qDV2IYd6jat5sYkX9ipHKXfw+Wiydu+Af4NE7q/Jvzhm7zeKO/gXtEZycocg2MBmpkU8WY+Q8yqeNLzd3Vqo7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720466253; c=relaxed/simple;
	bh=9cqJOvmAWy0P6H41jX1TK9ySMRUqojNmllA/HXVXMAg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GINotAtsJbrPjG2447bzLCs7JM2DbFztDbJO42jswBWTlyKsj1xy7/kzu7HRhkFTuEkJurfAZ26X4bTN0ecphGU0ohVI+RNXHzkuVC2qlwGzmszv0W47lbHELDdU3y4cj01CJ7K8aFB7D6QU0DIZSXSZZU1q7z1ifG7wpXM9shQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKUx78ht; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKUx78ht"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8100ff1cec5so1260284241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2024 12:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720466250; x=1721071050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0a27X78OZtV9qFQoGmuQ1vN2vzWDIYyyrajQujL0MDY=;
        b=BKUx78htTI+2ymo3Q0t1IaRJIOxIKoBEGzXJn6MpfwLYop8eQuVK4DRQ8zOXGc7sMd
         YU3vqAHOcd85fn9A3enmIIWZfT001D1e5+Cpj0hPPFUyauA39hIfBizWB/vb3lCion80
         cSG/0mwkW85oIHffa3+Y34YsHtYFMATuj/Uvmg/CqcxFpkSGCuwSOVABYWsn/I7pJoML
         Q6BlyKmAOuKTq7EyF7oJowgb6FXmGi1EGP1kHYsFDxC1I74E8PzjyLAKeWAAZ5jghOuC
         piUjPKxEPkn17QJ6QAWzyotQhaY5L1DHkDAvxwATinhUbAqG6QIUCMpGeTWDlNrnWJU1
         1vdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720466250; x=1721071050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0a27X78OZtV9qFQoGmuQ1vN2vzWDIYyyrajQujL0MDY=;
        b=SqkfE2yuoGTf9tieVcx3tBFpRFKDS1qYpGoLwWUll/M/Ig8gHrsBNzhd3q6hnTKwt1
         I2pJoFwQd4X9j8ggtIeN2bW3UWuuM6x9AZ9zH59JXEAN0aTW3MnQGkiYrNfKfJD+lZi8
         k2AF36VZv+7XmfIbsnsAV/UyAYDjmuHqDwUqbzMOBLKvY5WfM/duae8N07q2OUmeLqIG
         3BcXD2/axSEqS1JAKE0LC5lD1WFtf8Xv3fimD6Jf8xxdOMlw4Aczm4Pxdxv1+VhZ7xJu
         LSqbla8c14P+1gS/fnnj5Td9J9QhsNu4nafXIL9qlqSHK3gjJmzOeJ1N8Oy+ArxyNufR
         S63w==
X-Gm-Message-State: AOJu0YyDR1/37551BlcoQd7M+f6zWuGAnRUNdlDIY6qYsB5mvybmYirY
	WtgkYqVxK8xreddits0wcI1/mwDHEfRuRpOhgGzphsDmBewUzqNCRoFJBg==
X-Google-Smtp-Source: AGHT+IE2baMES7hn4vOFF01Q50kUWmZATDbhf3QP5jY5bUwxu3KAsRNqpNVeRFknC8Ax57lYwzAm1Q==
X-Received: by 2002:a05:6102:304e:b0:48f:4f10:cb0c with SMTP id ada2fe7eead31-490321f8253mr391638137.22.1720466249910;
        Mon, 08 Jul 2024 12:17:29 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-490316d1504sm80014137.26.2024.07.08.12.17.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 12:17:29 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btusb: Don't fail external suspend requests
Date: Mon,  8 Jul 2024 15:17:27 -0400
Message-ID: <20240708191727.2775854-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Commit 4e0a1d8b0675
("Bluetooth: btusb: Don't suspend when there are connections")
introduces a check for connections to prevent auto-suspend but that
actually ignored the fact the .suspend callback can be called for
external suspend requests which
Documentation/driver-api/usb/power-management.rst states the following:

 'External suspend calls should never be allowed to fail in this way,
 only autosuspend calls.  The driver can tell them apart by applying
 the :c:func:`PMSG_IS_AUTO` macro to the message argument to the
 ``suspend`` method; it will return True for internal PM events
 (autosuspend) and False for external PM events.'

In addition to that align system suspend with USB suspend by using
hci_suspend_dev since otherwise the stack would be expecting events
such as advertising reports which may not be delivered while the
transport is suspended.

Fixes: 4e0a1d8b0675 ("Bluetooth: btusb: Don't suspend when there are connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2d5c971a59ad..e09984ab6db9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4697,16 +4697,29 @@ static void btusb_disconnect(struct usb_interface *intf)
 static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct btusb_data *data = usb_get_intfdata(intf);
+	int err;
 
 	BT_DBG("intf %p", intf);
 
-	/* Don't suspend if there are connections */
-	if (hci_conn_count(data->hdev))
+	/* Don't auto-suspend if there are connections; external suspend calls
+	 * shall never fail.
+	 */
+	if (PMSG_IS_AUTO(message) && hci_conn_count(data->hdev))
 		return -EBUSY;
 
 	if (data->suspend_count++)
 		return 0;
 
+	/* Notify Host stack to suspend; this has to be done before stopping
+	 * the traffic since the hci_suspend_dev itself may generate some
+	 * traffic.
+	 */
+	err = hci_suspend_dev(data->hdev);
+	if (err) {
+		data->suspend_count--;
+		return err;
+	}
+
 	spin_lock_irq(&data->txlock);
 	if (!(PMSG_IS_AUTO(message) && data->tx_in_flight)) {
 		set_bit(BTUSB_SUSPENDING, &data->flags);
@@ -4714,6 +4727,7 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 	} else {
 		spin_unlock_irq(&data->txlock);
 		data->suspend_count--;
+		hci_resume_dev(data->hdev);
 		return -EBUSY;
 	}
 
@@ -4828,6 +4842,8 @@ static int btusb_resume(struct usb_interface *intf)
 	spin_unlock_irq(&data->txlock);
 	schedule_work(&data->work);
 
+	hci_resume_dev(data->hdev);
+
 	return 0;
 
 failed:
-- 
2.45.2

