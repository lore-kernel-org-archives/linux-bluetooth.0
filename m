Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334284;
	b=lp4no8VLZ8QVbA+eMy8mmvBbSmfZW3C4KtiFOQAkFHrtAxLpcUnwwhQ1SiFn3UlNbE7W
	 P+EsowUhvkiP3/a0djrVuxaAmzqNid7WzuK7PFySmJWM6tuiYH1eo53NoFGVtEA1Rc0gj
	 llmeVec1ABXYSmLfqaQsMhD/uHcPqgQMh+64Hnw6NcSUZ/WuIdong9zLmwEU5vjVZUD5Y
	 yysH0XM3UzbtN2DSobXQaKJRKWFUW2Y/9b4tgw1hRpZEr2CqF2iCTOjfAbSTTk6B1arYU
	 BK/RRQeOGiFGPgXturxCn6tzFIww4lfly6hTTTssapGzmt3aM/SgWGumTuxl6ZYkF4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=wNbHYtwfLvXo93whyCdtmEX3Gno9FVHJZIDVuAj6REM=;
	b=y04bTV3EDzpkWK/uczsMlrd13TEytV2/AaOm3Linv9+7U2LYZLhGQj4eLJxFpq5k6n3K
	 thrSctU1owMI0dCZIy+n7msCViWFwFx9l2/p6BeDiI6N0zpnc89paPNLmBzVIkp4NYvy/
	 grDjItLzwfUYVKRvsmaWDOpOrFch5Fgd+ebIvooIMlqmAiqCZ72UStmyROMH2yKspJs+Y
	 Zx2ESoV8kTd6jYC+AsyahOVdXmIf47KtvY0jyMpOVSemh6QglthIjWmrdpTLJtw2Xn+no
	 HwbWkrJ5HPexEmUAU/adMTDImT3mTcT2fiIH1zhRMJjOjCcyL9M+RjjzOWc/kpgX8Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=HfIQf+UC;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FA4606A31D
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 04:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85FA4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=HfIQf+UC
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a3c08d6928so339307c88.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 21:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1793334283; x=1793939083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wNbHYtwfLvXo93whyCdtmEX3Gno9FVHJZIDVuAj6REM=;
        b=HfIQf+UCQsdEIqzV7zHvAlRza+J1kw9wSgJmYN5ztQ/l2H/OAesZxnRIHugjuDKxyL
         fpQDLH9FSbdftAyUPqGCtdMCX0oqqpKL/gVhNeGZMJ3mxpuL2rVNiEWnyA3V11RuVQ1p
         kLm+TI0UKgljwcClKnXlv58bgUrHjpEoOWthZTUqBBjDtLFunBx01cbvWD60RhJVaW+U
         UwDJG+THRpUp0mHqlJeONUTo1rav14k1NTGuYHvwLdjzDMhyhqXFTCANPyAOtTsTjfiR
         EkQvcfl87yY7XmE7wbSrtlkh7YdXRJBszZb9SWb4zjDlQz3oSwycixYLNestw6oiyqBF
         mtxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334283; x=1793939083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wNbHYtwfLvXo93whyCdtmEX3Gno9FVHJZIDVuAj6REM=;
        b=NIH9fcNRzqZWz+lPyHWAhlgW3B0e7y4aRJe+wk+Qz0ei9ypD46WKf6j6wwMT2nUv6h
         hQ/nr7xr6x++Y/WyIYFo9NzV/4GWIv2b13ndnRQ3a6hSuEZQQD9PgQzUy0Op8n0eL6dH
         A4vLhHo84Y/gMcxYK9cnBVcsxMmJqCyI+Q8RK3LrmdWei23d7HfwTu6miuQmgi6hDvEe
         jz7ZJfKxszIfinQxreUKs4RJD0DbkBhQS3bBKFLJBhyuvIbrjRs0wCCLC1EjwIfZ6gnh
         KpAqCWowELBu7SM+TuUGUYBkdx8YKCrchYLcgJS78yCavdpEAdTv53/zPSaRkiUFgtBo
         PSwg==
X-Gm-Message-State: AFq9FYJlLB4oQNraJvOsiJyAxknpup76wejwf8HV6S3BNsHazC2teKwp
	ci+/L5BbJFK9mpidp/OLzrdHb892pbg6+fBPJgO0ssrYQSFfV4vMPx2F/SNYpx2oJ9YrXy+4d8s
	dMAqqT+0Rqg==
X-Gm-Gg: AYBFou11pXLtZ0/V7XdQUJbQISGPeDoWVEaUdDLIFFfx0J+6m3RiS7v3Hj9aXizikXl
	/tsvdZIn+FmAJt0p9poxctgKL1dnYraFCSxdlLHxGNhel02puWEJehQVyu1oBz+c59ZNOghcRkg
	RsJ5eoxgHy0k6sP+L+86pT/+CdzBKsE8NIorV+DnAIrTDI3bNEUxavRE/cjjPLAxO1adMBDb199
	EyDBQtekZ5AzZZ4AtLjHx2ADssC9jQ4mCNcPeW67A1w/FpraTfUjVOmQafPW9acQngor4Ldm9Jl
	W6YgkS5sj0ThbGyV7B4dFjm6+U+7K9aeyeXT7aTETBbHELxNASSJoP+Bc5MDFd0woQsRAZ5bfhK
	YZ9OVPyn6ogeN/T3WhDq06ke+Wp22lUTkOWsYy9ShBfk6FXFX/TYoMz9NT7SyvakObDSYe8SUtc
	H+iUaZkjjubOLNkbRBikyCn/QseiBTXHVR+ba+B9hNb3Q9uVd5P+9nYSCBrWavB08MYMcuJm4R9
	DK+DPqJtrI1HSOF71Yhhv544bVeIa5SQMVR1vqR17ps+YdmrEGogSi3Q8paiwixEspRG1aLPBIA
	FxdrHZ7pX7/WnggJ47JnlkLCHIfbMxlHXfTfgsyJ19yuXr91w+EldtuksdFGxSU7h471ZI+89FZ
	lY1q/cMCd0feMAw57Vu/sFIF8NdDcuWvodho00P2XSv1aMhSYPc+MVPXheF3mqSVGo9aizBc=
X-Received: by 2002:a05:7022:b047:20b0:16d:dd5c:4261 with SMTP id a92af1059eb24-1ac5e6f4e87mr1626155c88.46.1793334282334;
        Thu, 29 Oct 2026 21:24:42 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b38ac58sm3235755c88.23.2026.10.29.21.24.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 21:24:41 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH v4] Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery
Date: Thu, 29 Oct 2026 21:24:37 -0700
Message-ID: <20261030042437.42733-1-kevin@simpleble.org>
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
while its inquiry or active LE scan is still running, so that it can be
stopped again, unless it was stopped meanwhile, for example by Inquiry
Cancel when only the passive scan could not be disabled. Do this under
hci_dev_lock(), like the command completions that change these flags,
and only cancel the LE scan timeout once the scan is disabled, so that
the discovery still ends on its own.

A timed out LE Set Scan Enable can still complete afterwards, which
cancels the timeout as well, so also stop the discovery when its scan
is disabled while the timeout is pending, or while the timeout work
waits for the lock.

Fixes: 0e05bba6f6f8 ("Bluetooth: Update stop_discovery to use HCI request")
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Kevin Dewald <kevin@simpleble.org>
---
Changes in v4:
- Only go back to DISCOVERY_FINDING while the discovery is still
  stopping, and not for the passive scan (Sashiko).
- Check the flags and change the state under hci_dev_lock() (Sashiko).
- Also stop the discovery in le_scan_disable() when the scan was
  disabled while it waited for the lock (Sashiko).
- Rebase on bluetooth-next 1081a6ef8f.
- v3: https://lore.kernel.org/linux-bluetooth/20261027210057.44347-1-kevin@simpleble.org/

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
the inquiry completed into success. So this checks HCI_INQUIRY and
HCI_LE_SCAN instead, which are only cleared once the controller
confirms. Going back to DISCOVERY_FINDING sends Discovering (enabled)
again.

Reproduced in test-runner with a new mgmt-tester case, "Stop Discovery -
Scan Disable Failed 1", in which the emulator answers the first LE Set
Scan Enable (disable) with Unspecified Error: without this patch a
second Stop Discovery is rejected and Start Discovery fails with Busy;
with it the second Stop Discovery succeeds, and so does Start Discovery
(3 of 3 runs). Without the second Stop Discovery, the discovery ends at
the LE scan timeout.

The v3 regression reproduces with a BR/EDR discovery while passive
scanning for an auto-connect device, where only disabling the passive
scan fails: with v3 the discovery is enabled again and Start Discovery
fails with Busy (2 of 2 runs), with this version it stays stopped and
Start Discovery succeeds (3 of 3).

Freezing the emulated controller while bluetoothd stops discovering
makes LE Set Scan Enable time out and then complete just after: the
discovery is stopped when it completes, and Start Discovery succeeds
(3 of 3). The other kernel testers pass as before. The two lock
orderings Sashiko raised are not reproduced, only checked in the code.
Only tested with the emulator, not with real controllers. I can send
the mgmt-tester case to BlueZ if you want it.

Not changed: hci_pause_discovery_sync() has the same pattern on suspend,
which I have not reproduced. A simultaneous discovery that is stopped
while it resolves names also goes back to DISCOVERY_FINDING rather than
DISCOVERY_RESOLVING, so its remaining names are not resolved and the LE
scan timeout ends it.

 net/bluetooth/hci_event.c | 12 +++++++++++-
 net/bluetooth/hci_sync.c  | 20 +++++++++++++++++---
 net/bluetooth/mgmt.c      | 15 ++++++++++++++-
 3 files changed, 42 insertions(+), 5 deletions(-)

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
index 9d71ce96bd..0babc776f1 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -376,8 +376,18 @@ static void le_scan_disable(struct work_struct *work)
 	bt_dev_dbg(hdev, "");
 	hci_dev_lock(hdev);
 
-	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
+	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
+		/* The scan of a discovery can be disabled while this work
+		 * waits for the lock, for example by a Stop Discovery that
+		 * timed out and still completed, so end the discovery as
+		 * le_set_scan_enable_complete() does when it cancels this
+		 * work.
+		 */
+		if (hdev->discovery.state == DISCOVERY_FINDING)
+			goto discov_stopped;
+
 		goto _return;
+	}
 
 	status = hci_cmd_sync_queue(hdev, scan_disable_sync, NULL, NULL);
 	if (status) {
@@ -5913,11 +5923,15 @@ int hci_stop_discovery_sync(struct hci_dev *hdev)
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
index 3cb4f9ece8..03f5869c03 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6322,8 +6322,21 @@ static void stop_discovery_complete(struct hci_dev *hdev, void *data, int err)
 			  cmd->param, 1);
 	mgmt_pending_free(cmd);
 
-	if (!err)
+	hci_dev_lock(hdev);
+
+	/* Go back to DISCOVERY_FINDING when stopping failed while the inquiry
+	 * or the active LE scan of the discovery is still running, unless the
+	 * discovery was stopped meanwhile, so that it can be stopped again.
+	 */
+	if (err && hdev->discovery.state == DISCOVERY_STOPPING &&
+	    (test_bit(HCI_INQUIRY, &hdev->flags) ||
+	     (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
+	      hdev->le_scan_type == LE_SCAN_ACTIVE)))
+		hci_discovery_set_state(hdev, DISCOVERY_FINDING);
+	else
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+
+	hci_dev_unlock(hdev);
 }
 
 static int stop_discovery_sync(struct hci_dev *hdev, void *data)

base-commit: 1081a6ef8f1e0661fd52eb3f878691b0b96cdff9
-- 
2.53.0

