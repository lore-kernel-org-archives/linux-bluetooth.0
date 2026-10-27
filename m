Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793134864;
	b=kEGvV5wE3lG2VP6w8oxMP+fzsuVsbCOEbQQcJNlwQHYDb5QMVyJyqi7X2+/ufGhxJKyK
	 SmvwWIGyqqKq/gXpT8o9aAzmCa69OilXZiyL2WiTYOzVUOvo3jEcIoQDPy58OAd/cT5p6
	 wNjLYaJZToOhGE78qRid4PV7luITyu5YGh5enjPONH+h/mhoqohkzrrBsCAWP9R357890
	 hwsmRcUFI10ah2Yk0BgT8o1BUn4YCuC3LhiY4QoLHQfLLyxtfzloxyyWYRMchfGaEk1xu
	 6PvyJLkOqilG8iDhYy3qdlKYoHvmFPv/k32d8/KUKERDyuStegf3CAhuzrvfJ3O+s5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vksKrVSWOCoTCBOOcilaf8iYOKdP6CKIUvBJMhUMzLc=;
	b=dLSUcRVll0SafJWw1rLi48h6tUgrRDqAfXZgjXH3W3qC08BDJGrg191H2/kNpuxnHBwq
	 mr8IBOHPV+EZM8mmc15M7yVK9jLm2qAJorx8FgEfo9tLaJq6EOxXxHCEALMgJ/4PDUYab
	 810VG7tvF5gP/QjbHJFhelHdtdEhUrsn/KA5HznR2OaArIXTkQdq5Bjo5cqgEqAXf0tPU
	 lEgsfqZhP4SHVzEUW4VY6Cp7pOwFTW9pSC1aq+HNsdiVSVY92IlftrxVf7i8bwDfsdLtm
	 oZ7pPQ/MOaZacFVA5FAKfNQdkEV49P2VLPoSxZCr+c+rDAyRT1RbI2JuN+Psmctru4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=AmTcmyYx;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E201606A31A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 21:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E201606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=AmTcmyYx
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35c76e9614aso466554eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 14:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1793134862; x=1793739662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vksKrVSWOCoTCBOOcilaf8iYOKdP6CKIUvBJMhUMzLc=;
        b=AmTcmyYxpmrV//SRIXmL+vGqWd7Dv5HBTY6IcLBRTgg40aJQwUDjsoRAUhEdSD1/KO
         D5EkXm8tcarR8ffyMZriNYYu4bDsihMoyTBgFBjJ5MYEmwZDB8JMNMpOgRKY+WEcHIwf
         CbmubGrPApbUZ88pk03A1YiDiuv4fZ4brSyNZOPKfq9oyGwUqY0BOgiwycPhmlkPGJ/v
         FmFIGAKYAfIBYOi0fcjBlTicM3iDNBmLBy5wGIL8S6prDg3/8BhNF4ai3zW1AgbfSBNQ
         meeNkVut/B40UQKFiDNDuq13IK8B47pYtyAI1Iw+RlguvbIK8WToAwlZd/POVTKrhQoy
         7g2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793134862; x=1793739662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vksKrVSWOCoTCBOOcilaf8iYOKdP6CKIUvBJMhUMzLc=;
        b=qEdFr8V5wVHNiwH+Ql4RDt8AwtaLOKco1Z7Fj1YDo0yYF/gIad/wny8mNXGQ5BbP/w
         T9ZA5VN3lqaBx8fhqZLZUEH24yI7FLds1OEHJpa+eRs9zJBZDdlt+UJoI28QlctGjAj8
         DIZwKKBeEp1Hyv94hMpGnqiiTcus6ZKmRc4RakS2REu+I9RwpIQzxvcnRzLIzwY6w931
         kPuUoVA5V9Z1ME+UoUve6HbUV/Dif1xl69rIwSH5uRpr6OJOTTmSeyNz45g2fzuAMUOd
         aK+6vFhq3NdnDzCjPR/yEcN111pOn9R7xar/nCMISygXLFyA5+SwsJmxsuNkmoyJeFxe
         RP2g==
X-Gm-Message-State: AFq9FYIVBbNNIiMyWUiUR8o93g5mSvIdx3MpOLnzUJVmnPs/wRWGnl18
	ViCOtu/m/QJ4tP6aQCpr2A6sy4dk18tgfznYU4htXPXLHXpjZI6P5+KgwesYTuOH53UAPZ1r6b4
	sMleUGa/jFA==
X-Gm-Gg: AYBFou3MQqCgf8mY+lSN5R+MlxBaREQWXwnB83IMf2+RdZREoluPFzzEnpei9Ce2uxw
	DenAk695EtcnLQIb+qt2eEGpo404GNYC9G3H3TlKYmcYA2dO7wuZAkU00pNL/o/fFPOlrdxT0Tx
	0zwNHif9CSKai0x2NXf8wVN5NunokV8qeGwq9FKMBps0Ui40vEphaZ+T4AsIdyTQKRQJsOyFYRO
	IOG3m9jLRx83Vq4qxVeN9wjg0wyp3R/I2FdZqcViLQ9pnxwHokSJKCUTJlCt0lg4IJ+zqT/i4iu
	Ey0MijXQjhwXbadUmw1FCFDeV81VAt7vZgsfQCYAUz++sDMs4+LzUMrV+5n0r+KSYYxABLcR7kw
	+Q7lE/+DQaV+Fz/qvGxwFSZBq76L+QpLTBJt6T6bWlIlla/HGcJz37xf8qI7oKsIOnNRZADYdPG
	uTEH8NAJmvJpolX7xYkqagpMjX2aj05KRixAjX6V4wcrOgJh9+keQXSOpbmfPOuhkSs/BLsO1uA
	MEl2F9BmMrY+p1wdIX2owyUsv6F+DLtQymk+WqFR3tzy4nKkltPAWIYU9bFOaZucc7AWkGYv3tw
	8HQcQ7d5mOCd43HNbTYxAy3fKdtfEkGsUTB0hEWe+fN/U0KpZ/JHsS5Y38FR9E+tQOetsII6BMX
	1PBqJiI2LG2gzfo52bgSHCw==
X-Received: by 2002:a05:7300:7312:b0:358:ec5c:bef1 with SMTP id 5a478bee46e88-36a204773c0mr1110485eec.39.1793134861237;
        Tue, 27 Oct 2026 14:01:01 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8daf444sm34855931eec.18.2026.10.27.14.00.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 14:01:00 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH v3] Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery
Date: Tue, 27 Oct 2026 14:00:57 -0700
Message-ID: <20261027210057.44347-1-kevin@simpleble.org>
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

Stop Discovery moves the discovery to DISCOVERY_STOPPING, and
stop_discovery_complete() only moves it on to DISCOVERY_STOPPED when
stopping succeeded. When it fails, for example because LE Set Scan
Enable times out, nothing moves the discovery out of
DISCOVERY_STOPPING: Stop Discovery is rejected, as the discovery is not
active anymore, and the LE scan timeout was cancelled before the scan
was disabled. Until the controller is powered off, every Start
Discovery then fails with Busy, and hci_update_passive_scan_sync()
skips background scanning, so devices set to auto-connect are not
connected anymore.

Move the discovery back to DISCOVERY_FINDING when stopping it failed
while the inquiry or the LE scan is still running, so that it can be
stopped again, and only cancel the LE scan timeout once the scan is
disabled, so that the discovery still ends on its own. A timed out LE
Set Scan Enable can still complete afterwards, which cancels the
timeout as well, so also stop the discovery when its scan is disabled
while the timeout is pending.

Fixes: 0e05bba6f6f8 ("Bluetooth: Update stop_discovery to use HCI request")
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Kevin Dewald <kevin@simpleble.org>
---
Changes in v3:
- Go back to DISCOVERY_FINDING instead of DISCOVERY_STOPPED when
  stopping failed while the inquiry or the LE scan is still running.
- Keep the LE scan timeout until the scan is disabled, so that the
  discovery still ends on its own.
- Stop the discovery when a timed out LE Set Scan Enable completes
  afterwards, as that cancels the timeout too.
- v2: https://lore.kernel.org/linux-bluetooth/20261027172730.86568-1-kevin@simpleble.org/

I did not find an error status that shows by itself that the scan
already stopped: the kernel only disables the scan while HCI_LE_SCAN is
set, and hci_cc_inquiry_cancel() already turns Command Disallowed after
the inquiry completed into success. So v3 checks HCI_INQUIRY and
HCI_LE_SCAN instead, which are only cleared once the controller
confirms. Going back to DISCOVERY_FINDING sends Discovering (enabled)
again.

Reproduced in test-runner with a new mgmt-tester case, "Stop Discovery -
Scan Disable Failed 1", in which the emulator answers the first LE Set
Scan Enable (disable) with Unspecified Error: without this patch a
second Stop Discovery is rejected and Start Discovery fails with Busy
(3 of 3 runs); with it the second Stop Discovery succeeds, and so does
Start Discovery (3 of 3). Without the second Stop Discovery, the
discovery now ends at the LE scan timeout. Freezing the emulated
controller while bluetoothd stops discovering makes LE Set Scan Enable
time out and then complete just after: the discovery is stopped when it
completes, and Start Discovery succeeds (3 of 3). The other kernel
testers pass as before. Only tested with the emulator, not with real
controllers. I can send the mgmt-tester case to BlueZ if you want it.

hci_pause_discovery_sync() has the same pattern on suspend, which I have
not reproduced.

 net/bluetooth/hci_event.c | 12 +++++++++++-
 net/bluetooth/hci_sync.c  |  8 ++++++--
 net/bluetooth/mgmt.c      |  9 ++++++++-
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d05934fef4..80679f1881 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1819,6 +1819,8 @@ static void store_pending_adv_report(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 static void le_set_scan_enable_complete(struct hci_dev *hdev, u8 enable)
 {
+	bool timeout_pending;
+
 	hci_dev_lock(hdev);
 
 	switch (enable) {
@@ -1848,10 +1850,18 @@ static void le_set_scan_enable_complete(struct hci_dev *hdev, u8 enable)
 		/* Cancel this timer so that we don't try to disable scanning
 		 * when it's already disabled.
 		 */
-		cancel_delayed_work(&hdev->le_scan_disable);
+		timeout_pending = cancel_delayed_work(&hdev->le_scan_disable);
 
 		hci_dev_clear_flag(hdev, HCI_LE_SCAN);
 
+		/* The scan of a discovery was disabled before its timeout,
+		 * for example by a Stop Discovery that timed out and still
+		 * completed, so nothing else would end the discovery.
+		 */
+		if (timeout_pending &&
+		    hdev->discovery.state == DISCOVERY_FINDING)
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+
 		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
 		    hci_test_quirk(hdev, HCI_QUIRK_SIMULTANEOUS_DISCOVERY) &&
 		    !test_bit(HCI_INQUIRY, &hdev->flags) &&
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9d71ce96bd..6465198f13 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5913,11 +5913,15 @@ int hci_stop_discovery_sync(struct hci_dev *hdev)
 		}
 
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
-			cancel_delayed_work(&hdev->le_scan_disable);
-
 			err = hci_scan_disable_sync(hdev);
 			if (err)
 				return err;
+
+			/* Only cancel the LE scan timeout once the scan is
+			 * disabled, so that the discovery still ends if
+			 * stopping it failed.
+			 */
+			cancel_delayed_work(&hdev->le_scan_disable);
 		}
 
 	} else {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3cb4f9ece8..2bdc355786 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6322,7 +6322,14 @@ static void stop_discovery_complete(struct hci_dev *hdev, void *data, int err)
 			  cmd->param, 1);
 	mgmt_pending_free(cmd);
 
-	if (!err)
+	/* Go back to DISCOVERY_FINDING when stopping failed while the inquiry
+	 * or the LE scan is still running, so that the discovery can be
+	 * stopped again.
+	 */
+	if (err && (test_bit(HCI_INQUIRY, &hdev->flags) ||
+		    hci_dev_test_flag(hdev, HCI_LE_SCAN)))
+		hci_discovery_set_state(hdev, DISCOVERY_FINDING);
+	else
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 }
 

base-commit: 47d4d9f67e92d56ef3965f2727f9c98a5a611368
-- 
2.53.0

