Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638815;
	b=Kb4cbZ/FlOL84mhGIOPBkQqVQcdiZ7cs/GK2gR/whddmuMQQ0fFdK7+bR7JhTMjdXRcM
	 AD8LmTC5jvgzV4uv88vU0/xhyngklW+jugRxM5mp/sCp5rZ/epDU1kz/8BP6b8Diq1QsV
	 xWEATvLwGkF6KkAzQ2vtZmaV7xkPcWhCCZF8BF8aInjqVOMI/md2vwdTUwqQdFmqhFi2P
	 OpXAvqJ5tFElI48XTkEDQIuTUIOR65GZV93sEyfgcxxu1oaS5Q1YFjAwp+vf+Xgbo0QEI
	 grNwHua2BqkhBHlnxkeUHcBgZWqBNfXlDqgAoAPVL91FYSNOP/hGc++1VIJzVDFcWVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638815;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Gj+cEnUX//I8NTeCN+X3F8KLHoyCJOOVE92EzAIsAdg=;
	b=Rw6FYvCdi1De7ttwLEC+a2cGTkonLPDRyuvA9ty9t3CpsVyTxK02UsrGdSuPwlo7KKFy
	 zEK5M+6LMKnNsLqcaxz2+F+syV1MyXWd/pA+luGAJwSEJ9QLbh1DJNWWf3KO2/MVQv299
	 duubx3Txjv0rFLZAExprJYRAQ2mjpFmjzO1IbXuCjQ6NrdsiFZxofQMqXfhiI5RlvUviC
	 m2xaDgbB5cc9oGr65DBtdGBLwhb8Yj2ulNRv//9Nd0yPApyGZKRUs+gEwGla9t8itzGUt
	 LUKL7gfmCHs1e995A2Vq8iYcIxb8RBSh1YjuyuDpBdxisuhYL9dlJb/gFe1vgGhW7Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=lXQGkVQZ;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDD5606E02F
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 17:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDDD5606E02F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=lXQGkVQZ
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1aefd1bf74aso2040930c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 09:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1793638814; x=1794243614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gj+cEnUX//I8NTeCN+X3F8KLHoyCJOOVE92EzAIsAdg=;
        b=lXQGkVQZDqQD70UuI+r6mqvyH2Roh67io4mSjOU6eBRIP4qTLqJylEtWlj35kB64H5
         EZfB9tVXpuN5qaKHFUqUYyO8YJezGhAYpLzniDHEDy6V2IKCeMy9+rqVY+bccvu6/7Et
         eEQXzdjSavrJDIZEWouHb3htYjXUUz8tI6FeblePdx6tvmPjE+Dbus8REeahqXQDKz8H
         2xloDTiSYGa5V9eM2/UKrYIIeHKdCUUBuNYec+9MKwZPY0jqRReYaRKIFwdFYui8k5v7
         1OQroqp3Qtruar5VDPDPjuVgfDWy4j5KmTfXDpzaCm8505njDYFuSfNTN09BzoNz52p8
         a9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638814; x=1794243614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gj+cEnUX//I8NTeCN+X3F8KLHoyCJOOVE92EzAIsAdg=;
        b=xMz4kAWUmeDYNWt0Xi2Y41eJCtQOHb0Mu6fJFVtneRreABwQNwpIW+AUiDgwwCKJDz
         9fW5oN1eIqzTOeMs+wASKOWLuOjLRLbDER8/ljLR0nPeJVp/hNBMiKnYYCpetZ9YsBVm
         XFHXGYaFEfHSBRLIBRo8Zgn6778Ix5vJDitPdt1k4Hv6+GY23QWWW13RO2Lqc3HkvOZu
         DpMmpUN6obvjkkY0RMPa+gBzlTNuJ8PxcLcs+CPXhZUFiypBsNSSZSpep900lfVB5q6k
         SL33m5ISR1lrFDCR2VWsVfxf67j3ouaVvYfJuYlMjV0GZ9s8wqPY6hL8awg8P29OMgFW
         fOlg==
X-Gm-Message-State: AFq9FYKPYI1a2vlSnYLTS7UfdkS9UuoKFNPCkjrk9Yk74GUqHT6yGHXt
	tixff9IHm7T2glE0c+T+fNZeyo82mByAVe1H9LmcvlY/lZH5JCZcd10eWKFC+EBO13PKL0cKxKa
	0puRXZ7w=
X-Gm-Gg: AYBFou3ZuK33eJ6/4BTwYEXWZDRWGfp+uXYc9RlviMlnb5wxbLfSnE/K4bu5ZmWX/L8
	1SToFbmrCRc+jgP4F6bg8mx7gxSIUZ9Lk0HQvhoMlnYlyNylr7420G9vJ9Iulz7Y3Vcr3SdRtGj
	xiPVAA/fYZ1zqSAu5XshgTprBIKdjofGhym54SUUJZHbrhau6h1FeTMW1VR7459XymCScO3azJS
	GXh5NheoYMUNaOZbjTPYGotXqMy1oDB6tzcacciQX+uKBLtYCXdtA0p1/RxNjTm/EJ9TgP/SauW
	LsXQvpQ1apBQgVKM/OvbOK6bnZQdiBhpAlPmB/MMok8nZiuKueQa+1vcAqVCtpPcP49JAbK4b3T
	lTP1JOx9te/Rvsxa+W6ssGBKlzNnaZ85W0a/wmyGWgDTSlw5upMzuSZLar/X5GxEUcJG+SYdNw7
	EXtFo2UVUZJxWgAvC3wKJIDgOCM1vMl51nPwRhG18ewA1RFNiltSgVFMRbxhTXvjskX5nVyUNSP
	+Ng8YgYzFgeQrc9XIU2ydyNuV8JPcHgcqAgn8OWL8FHMSUEpmSQ2W5IVNNLcHnMTigQ6SASy6Fp
	YDytSYIt/cCBDAYXrniPj7r/LdNk0rYik1Z1maZRGbZXf7pS0Ur2eJb5t4oj9kpTWEhEMTcrlwm
	IxhjuSgd//t12Byhh7mZ1Dc/G5R6+0Ai9aQgIytGr3dljw5He3IA7WZCdnvNp3OYnebPyZYybM3
	ws0hifzjzXa1O6Q+0r
X-Received: by 2002:a05:7022:b889:b0:195:8fa1:b447 with SMTP id a92af1059eb24-1a9494d8f22mr19453283c88.12.1793638813082;
        Mon, 02 Nov 2026 09:00:13 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcf67csm35506402c88.21.2026.11.02.09.00.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 09:00:12 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH v2] Bluetooth: MGMT: Send Connection Subrate on LE connection and update
Date: Mon,  2 Nov 2026 09:00:08 -0800
Message-ID: <20261102170008.62788-1-kevin@simpleble.org>
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

Keep the connection rate parameters, which the event reports, in sync
when an LE connection is established and after each LE Connection
Update, with the interval converted to units of 0.125 ms, and send the
event then. As these do not report subrating, keep the subrate factor
and continuation number of the last connection rate change, or 1 and 0
if there was none. Load Connection Subrate then also compares new
parameters against the current ones rather than those of the last
connection rate change, and a failed connection rate change reports
the current parameters.

Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Kevin Dewald <kevin@simpleble.org>
---
Changes in v2:
- Keep the connection rate parameters in sync and send the event with
  mgmt_conn_subrate_notify() instead of a new function (Sashiko).
- Rebase on bluetooth-next 42b8c2d729.
- v1: https://lore.kernel.org/linux-bluetooth/20261030144106.75414-1-kevin@simpleble.org/

bluetoothd already registers the Connection Subrate event, and only logs
it for now. Once this is merged, I'll send the BlueZ side: it exposes
the parameters as properties of org.bluez.Bearer.LE1 (Interval, Latency,
SupervisionTimeout and Subrate), and documents the new cases of the
event in doc/mgmt-protocol.rst.

I reused the Connection Subrate event since it already carries the
interval, latency and supervision timeout. If you would rather keep it
for the connection rate procedure, I can add a separate event instead.

As the rate parameters now follow the connection, Load Connection
Subrate no longer requests a connection rate change for a connected
device whose current parameters already match the new ones. Before, it
did so until the first connection rate change.

Tested in test-runner with the functional tests of those BlueZ changes:
with this patch both hosts report the parameters once connected and
after a connection update, and without it neither does. The kernel
testers and the HoG tests, which also use Load Connection Subrate and
watch this event, pass as before. Only tested with the emulator.

The PHY in use could be reported the same way, but the kernel does not
know which PHY a connection starts on, so that would also need LE Read
PHY after connecting. I left it out for now.

 net/bluetooth/hci_event.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d05934fef4..6330f2da99 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5886,6 +5886,26 @@ static void le_conn_update_addr(struct hci_conn *conn, bdaddr_t *bdaddr,
 	}
 }
 
+/* Keep the connection rate parameters, which the Connection Subrate event
+ * reports, in sync with the connection parameters and send the event. LE
+ * Connection Complete and LE Connection Update Complete don't report
+ * subrating, so keep the subrate factor and continuation number of the last
+ * connection rate change, if any.
+ */
+static void le_conn_update_rate(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	/* The connection interval is in units of 1.25 ms and the connection
+	 * rate interval in units of 0.125 ms.
+	 */
+	conn->le_rate_interval = conn->le_conn_interval * 10;
+	conn->le_rate_latency = conn->le_conn_latency;
+	conn->le_rate_supv_timeout = conn->le_supv_timeout;
+	if (!conn->le_subrate)
+		conn->le_subrate = 1;
+
+	mgmt_conn_subrate_notify(hdev, conn, 0x00);
+}
+
 static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 				 bdaddr_t *bdaddr, u8 bdaddr_type,
 				 bdaddr_t *local_rpa, u8 role, u16 handle,
@@ -6032,6 +6052,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	conn->le_conn_interval = interval;
 	conn->le_conn_latency = latency;
 	conn->le_supv_timeout = supervision_timeout;
+	le_conn_update_rate(hdev, conn);
 
 	hci_debugfs_create_conn(conn);
 	hci_conn_add_sysfs(conn);
@@ -6296,6 +6317,7 @@ static void hci_le_conn_update_complete_evt(struct hci_dev *hdev, void *data,
 		conn->le_conn_interval = le16_to_cpu(ev->interval);
 		conn->le_conn_latency = le16_to_cpu(ev->latency);
 		conn->le_supv_timeout = le16_to_cpu(ev->supervision_timeout);
+		le_conn_update_rate(hdev, conn);
 	}
 
 	hci_dev_unlock(hdev);

base-commit: 42b8c2d729268a65a2d98064e8dc59ff53646b14
-- 
2.53.0

