Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371273;
	b=U9/rAAECRncuatN3phRJfCRhzKJ3FQrlMG+4xF/NNZikeDnQzYJ2a6MRBmZRv5OYpxXy
	 gS0ni9rjSO7T757YOQhTtogV0HF3XUNdHFb7820AeOHZYlWvUdstwLfIAUcRUpC6k6M1W
	 HFIXoBZiYPzo7nEUJc8EfReC4O3ljvlglrYfkNeacF67l3Pz7hAFnngXfSPFIxm8buVx/
	 eg54E+yUzfpU4aQG92OnAxdizAEqZA4BjwjB89jUpJwFInoTqt10XeMJV6x0A5HaPbVBm
	 n1TpJC8yW2qLf6G1xZzB52MvRTcvFjhWzkN91llMxHgkIwnblLFUW7M2SBTz7q8QZYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=JYDByPlXdBCMoWh06kXDkmMOZ6sNKAX+n+p5n+W5BHw=;
	b=gvi97BG1QcaOeCls5pR7QoepR1ztbqv1KUHNJKYkIWrW2AC/vPzO6DA+VwHYbrTt/CtJ
	 ugfvR1ykl8/GtiYTi93isyzk5ioRBdLuOoC884alkop+hqC68SrHryx2qOWoSV8Fsy/Xi
	 kzBUp2/g1BsBvvmJR6ff4VYVFztmtQa3IVeq8VhFZxX23p5P32sBejDGjuwalTfOKaycO
	 7WdKQ+dcSU1Jzdy8b1LqBwChKWwyTnmXLdZJ7MaCdQakREZBTzPkTbcoqyUmZZE6hauDy
	 VLuSUSCiboCByhUiPWx7gJAK8kH1p/U1RAlesQjJu1xhvfx8B5suymYvnZl34dglX1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=b4n7FTdD;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3509606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 14:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3509606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=b4n7FTdD
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so267504c88.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 07:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1793371272; x=1793976072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JYDByPlXdBCMoWh06kXDkmMOZ6sNKAX+n+p5n+W5BHw=;
        b=b4n7FTdD4EXyOMPh9aZC1ysyPEDFBd5REsefd/7xjRQ3aHpWou+Cs8GrVQroNBykXY
         k5o97v9L8p8paf3OBblLO6Vmbi2MwHCtJUVyMcBnH8BNSUUbQcNh4oeAeZtmu8VyT1Vi
         kgvWDYr96MmKGj9T3lVJ92M+GeIQE+gENmnN+l8XqftorSNpPe/esD8RW5VIvCJUy0gB
         Su707uCBNVftPHZqechmH58n5HuYnjLa5GZLglIBTYsprYVDlfgy+u/2T9E4bcGdiGuO
         DxsJib4o2kW/9HzKE+erq9eEkQRCV2HMK4lmRw1KCTMAdm76yn9/QvzqctL9l9Id+Xa2
         gXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793371272; x=1793976072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JYDByPlXdBCMoWh06kXDkmMOZ6sNKAX+n+p5n+W5BHw=;
        b=UylwFKNHu0HdXiVzW9BG7a6JgIxTY5m2qJAmfJfpBU7sgt8DYA06640s67pw8uCLfc
         FetdY0NQy559cMb2ctCJ7u1lc1hLHHYHmXloqH43nNDA12gQUge1Yasyx5iC7XGGOxGK
         x2EUkXQ86f2NFZ9ArGuC8Og3lYTCmZqjuuNPMSNa6HPMFaRKU7DJTlGRVH/iIVWilKJg
         9W30AbU/pjF1fde8zCEVIm/RCYYtXncPRVvN4L8vNjdluuUD/Ohz7waHenmFu1zr4c0j
         WJaZBpwrQYxOP08APVGMBqsO7Wo98bWX4AvouK0HB7/HFfZuneVAYaPP2zN+7FFh+IYa
         RvmQ==
X-Gm-Message-State: AFq9FYICixZiGIncWRWcLUtbqcpwpz2k60BxS1lGnxlXV23fjDE0OfyO
	x1Q9Y0WSg4rFh4a/YIj8MzCpQxM2pF7U7v30gR+vTBZBDxlihO8tNFVnOeorRtg2CsrdGALsnIE
	Vg0qbcx/R/A==
X-Gm-Gg: AYBFou0GfgV7QDDMSxszjNXcPIJAgHMiwvw27T1z87QEV6swfU/vU6LNI4xURA0E/Ik
	P5eZXOJIbjmHqm3MxAwMz3l+qXtDPR2/+YnboMwAONVEe+eey1YcNz5R6Pm1ZcRVEcvzvOcNK+M
	UF4tzik5UNK3IqGVUSWqnD5pOKbP2wqSsSl8vsJbtPjS5OOKPz3APq8tuYcyUwFxxFxma8HC4rw
	TWvMrjukbkM7GgvSh1DStFMDu6eeUvhvAJ+hgmo7GzOMI3twqCXo7zEmdz89zx8fAIymGwhTRGh
	c94xtIX28zUK0iHhs3UholcPt8ElXZWk75Tdv+Byb/tkIBmhC/jiVNf9Bhp+2gRc2CwJ64VzPQZ
	BNKZR+/SBU/w2wDOpg9MM5QPg9jMcgwbuzk3BqqOPPsJBBdUoNBHdn4G5X9mcTaU0ZhDhYeIboV
	fWWWTKVzN0T8Vqh3DhhH87PXTWY7yvpjy+Xs/sm7qKyXIroIOw8DOvrRvGaBHe8O9CpHRRRB+a7
	aeVLovgcti2cg0QqxI4qqtDIAqeQWY7sKJ0eQzBQsH6GpwfRku8VR/MBamvO/1huAdMo11Qe95m
	t4Mts3kFJYnRPob/XvhYPHXmDqUOgRqR0gv4UPEIFr9r+pWXgh5EEe/UUpche4/YWBgUM3+IiWx
	zRAXPa/6haprAh6jSIt0QncIGBhH6zgG+kkJl9c4TGUR8iyn0z4o1ffiBjW/xL2CmlrVK6Uk=
X-Received: by 2002:a05:701a:c907:b0:185:33ab:4d55 with SMTP id a92af1059eb24-1ac5f1810d2mr3139800c88.29.1793371271677;
        Fri, 30 Oct 2026 07:41:11 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19f4a04esm7640002c88.15.2026.10.30.07.41.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 07:41:11 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH] Bluetooth: MGMT: Send Connection Subrate on LE connection and update
Date: Fri, 30 Oct 2026 07:41:06 -0700
Message-ID: <20261030144106.75414-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
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

Userspace is not told the parameters of LE connections: the Connection
Subrate event is only sent for LE Connection Rate Change, which needs
the Shorter Connection Interval feature, and nothing is sent when a
connection is established or updated with LE Connection Update
Complete. Applications that need the connection interval, e.g. to
estimate throughput or latency, have to read it from HCI traffic
instead.

Send the Connection Subrate event when an LE connection is established
and after each LE Connection Update, with the interval converted to
units of 0.125 ms. As these do not report subrating, keep the subrate
factor and continuation number of the last connection rate change, or
1 and 0 if there was none.

Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Kevin Dewald <kevin@simpleble.org>
---
bluetoothd already registers the Connection Subrate event, and only logs
it for now. Once this is merged, I'll send the BlueZ side: it exposes
the parameters as properties of org.bluez.Bearer.LE1 (Interval, Latency,
SupervisionTimeout and Subrate), and documents the new cases of the
event in doc/mgmt-protocol.rst.

I reused the Connection Subrate event since it already carries the
interval, latency and supervision timeout. If you would rather keep it
for the connection rate procedure, I can add a separate event instead.

Tested in test-runner with the functional tests of those BlueZ changes:
with this patch both hosts report the parameters once connected and
after a connection update, and without it neither does. The kernel
testers and the HoG tests, which also watch this event, pass as before.
Only tested with the emulator.

The PHY in use could be reported the same way, but the kernel does not
know which PHY a connection starts on, so that would also need LE Read
PHY after connecting. I left it out for now.

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_event.c        |  2 ++
 net/bluetooth/mgmt.c             | 20 ++++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9d5d3ab4a0..89aaae4be5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2589,6 +2589,7 @@ void mgmt_adv_monitor_device_lost(struct hci_dev *hdev, u16 handle,
 				  bdaddr_t *bdaddr, u8 addr_type);
 void mgmt_conn_subrate_notify(struct hci_dev *hdev, struct hci_conn *conn,
 			      u8 status);
+void mgmt_conn_update_notify(struct hci_dev *hdev, struct hci_conn *conn);
 
 int hci_abort_conn(struct hci_conn *conn, u8 reason);
 void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d05934fef4..13a8adccb3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6032,6 +6032,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	conn->le_conn_interval = interval;
 	conn->le_conn_latency = latency;
 	conn->le_supv_timeout = supervision_timeout;
+	mgmt_conn_update_notify(hdev, conn);
 
 	hci_debugfs_create_conn(conn);
 	hci_conn_add_sysfs(conn);
@@ -6296,6 +6297,7 @@ static void hci_le_conn_update_complete_evt(struct hci_dev *hdev, void *data,
 		conn->le_conn_interval = le16_to_cpu(ev->interval);
 		conn->le_conn_latency = le16_to_cpu(ev->latency);
 		conn->le_supv_timeout = le16_to_cpu(ev->supervision_timeout);
+		mgmt_conn_update_notify(hdev, conn);
 	}
 
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3cb4f9ece8..385c4c543f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -11071,6 +11071,26 @@ void mgmt_conn_subrate_notify(struct hci_dev *hdev, struct hci_conn *conn,
 	mgmt_event(MGMT_EV_CONN_SUBRATE, hdev, &ev, sizeof(ev), NULL);
 }
 
+void mgmt_conn_update_notify(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	struct mgmt_ev_conn_subrate ev;
+
+	bacpy(&ev.addr.bdaddr, &conn->dst);
+	ev.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
+	ev.status = MGMT_STATUS_SUCCESS;
+	/* The connection interval is in units of 1.25 ms and the event uses
+	 * units of 0.125 ms. Connection updates don't report subrating, so
+	 * keep the values of the last connection rate change, if any.
+	 */
+	ev.interval = cpu_to_le16(conn->le_conn_interval * 10);
+	ev.subrate = cpu_to_le16(conn->le_subrate ? : 1);
+	ev.latency = cpu_to_le16(conn->le_conn_latency);
+	ev.cont_num = cpu_to_le16(conn->le_cont_num);
+	ev.supv_timeout = cpu_to_le16(conn->le_supv_timeout);
+
+	mgmt_event(MGMT_EV_CONN_SUBRATE, hdev, &ev, sizeof(ev), NULL);
+}
+
 void mgmt_exit(void)
 {
 	hci_mgmt_chan_unregister(&chan);

base-commit: 1081a6ef8f1e0661fd52eb3f878691b0b96cdff9
-- 
2.53.0

