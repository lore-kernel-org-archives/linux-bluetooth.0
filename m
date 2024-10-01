Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865011C68AE
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Oct 2024 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796103; cv=none; b=MF4AbXLE7HSjlOSP31ERANsec8IV6oVMB9fl6qrN7arhQtBxKR8rmh20abX+EnHIyB76gMQs74g006f+pnvxU1w/x9knHzrIvC5FGwo/wxOxKg3xovx3SOjHgT0BKvco9vuWngsjGKRO8BbkPCp/CWcrmL4l9rUid78xXqTCoPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796103; c=relaxed/simple;
	bh=w7zneVYmJ1MSbusVQdVJgCrVRyPEuy+tYpmGlvWaT+c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=O8etFdnXfgx6Pd/BiqilXi5y7Rkh7IGiRcZY3WRBKoqOUnMRqXoyF3VRdtXkXda0GlEQ49+lvaWzstQjxWvaifZxNpY3xTSsAO+37JOZ2Ydq4kQGpJpAsWRPJP+Dzu9453Mv0l0aAcE3G8w6qPbjD9whcwmOYikO/8kP2Pzh5y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHPbN9bS; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHPbN9bS"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6c3f1939d12so46498507b3.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Oct 2024 08:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727796099; x=1728400899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jpz1nY5Sq4QxLHDCVs04EHH6bNTs7unfS+PrflkV8BE=;
        b=eHPbN9bSmhL8e7P6M5oHD1E66ir+qfRPMY3igmaabURv8quGUsQUNGcKjmxwSZGdCN
         P7Mxs0JqmzttQ+NSQBZkGjSaA82sCbNcuExshtU2iUVeBUU/ubdzGS2eSyDCRJ9aqn0M
         ntZtYxeJA95FDkP8KNqXcs9k57EqHw3iQUZchpm36FzZObL+jWaVC49IxBz4eRkhdFvV
         M+ckdRnC76wr0muxDdmW2vNfDZGghu0nsIeRqFJo7EO8TeXTncYifAkoa/UCtQJXDvtz
         SgnzV8PXHHKWF6TfL4Jsyp6crjpt/oYKPpjSX+pdK4RY9xJtK71E2wQr818wrIkfqpx0
         KiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727796099; x=1728400899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jpz1nY5Sq4QxLHDCVs04EHH6bNTs7unfS+PrflkV8BE=;
        b=ZO1Q7OpBnXYwBf+Ogz8q2k2PPi4Inyyj/kbHX6xKltbQaeIMjb17mXoGkRZDPELmNe
         oeDtH9gG+ReoyN0DstaAIOTQdLwQyQmMdtmsrLbETwb8cmVOvjAJQrYvHItI4xYbq34g
         wu/aVmuCrcXM1NYQIwHPdJ9JhXWtRH/uSWdHuHXDFyHYvqAiNh7gsoIpfeq7xuQWXczd
         mhfXprpG/zvrsIuxaMHCPAk1EJ7WRjH/t5aHiHGsE28AVFGeI3aaJhoDt7Kp1gj4Ciju
         Q123HZCKBVeIe5jDIg6k91cKK82J7M6cJ2PJ3VyeE0PPhdfcGu/IpVajOZb4hD46Wfet
         4QrQ==
X-Gm-Message-State: AOJu0YyHoSPcGZ/YTHDlvLWVtu7Xz96mjptS482TiVdD1NY7z7s9Ey6g
	b4Xv4uLuIt82NtVPwitHcruX2Xyhh5Tm2N+XaUHQfjsgDsck1eyYCgmC0A==
X-Google-Smtp-Source: AGHT+IHjrYhNug9B1ODG+Zc0OgPqYNxYYFw844WWmfq/A+rvrV4CwxHfzrCMLwSwiwHByKBU/GoClA==
X-Received: by 2002:a05:690c:6ac8:b0:6e2:1334:a944 with SMTP id 00721157ae682-6e2a2ada28bmr1051197b3.9.1727796099400;
        Tue, 01 Oct 2024 08:21:39 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2454a1dbasm20342417b3.137.2024.10.01.08.21.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 08:21:38 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RESEND v3] Bluetooth: btusb: Don't fail external suspend requests
Date: Tue,  1 Oct 2024 11:21:37 -0400
Message-ID: <20241001152137.3071690-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.1
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
index 4d3eea414c2a..d14b941bfde8 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4075,16 +4075,29 @@ static void btusb_disconnect(struct usb_interface *intf)
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
@@ -4092,6 +4105,7 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 	} else {
 		spin_unlock_irq(&data->txlock);
 		data->suspend_count--;
+		hci_resume_dev(data->hdev);
 		return -EBUSY;
 	}
 
@@ -4212,6 +4226,8 @@ static int btusb_resume(struct usb_interface *intf)
 	spin_unlock_irq(&data->txlock);
 	schedule_work(&data->work);
 
+	hci_resume_dev(data->hdev);
+
 	return 0;
 
 failed:
-- 
2.46.1

