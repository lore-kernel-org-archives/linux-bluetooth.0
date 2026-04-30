Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AA02C2346
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 04:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777524927; cv=none; b=HpL2kTdR83WUL3GbYyb+1ONzSIYDFmYgRFN666RZD4jbw01I8AKV3ISYPEBVGTlLQDG26Pd5pwejIwSE++uth53/3j2coLJ12fHL/7+LezX+zRzZgtVYKZkIGLVCIOf1NcmETZKClU07RwRLh1A3mOv+rEzgkV5Wm2C/zLilA8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777524927; c=relaxed/simple;
	bh=ofb0sxB9uuzURkQ5EG+Vb7H6fcChUgJxzzoWZx2S1k0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KjgW6vzNxL4ijrkK5CGmuhIFkMRnnOwYtrdXe85QLXb/f3bZtHRXZy6UF6YS/e5AQYRwrZPdb+JhZXeMli5nDvBDxEcRTEcEEtSzp77yeKfYg+hCBnH4Di0c0JgFTs0XgPDb0BRg6U8+vkBJaxEV6kUdfRvavV1R7HmVMWYzhy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNFigEG1; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNFigEG1"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8ed4dd182efso28943385a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 21:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777524925; x=1778129725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NAe8cP6TYFnEN8/YXGSawR9WCiVkG3O6SqUP6943CY0=;
        b=HNFigEG1toRtA40rtRZYxTBIZ26ffrMzTf/2sab49oe8vaP5p9kzzS/boynOu2qlCO
         a8bGWfn53KOJOZ43K2nIWIP5ZBgLfRlp+KZLSRjpC5iYsodFJ4NT/UWkJDlDZUlJAzN3
         89u6mu54knPvwqs74p+42oL/yVcHK0hmz8a6JZVafH315WpiClrnViQAkvT2PoQpiDXm
         JmRyBIvZDhzCjZVqwyhGpvSyBIuAN7txecRJBjzSjgdOJ8uCey/2CNVGCjfp453bh+pn
         mXCUMMjjfkw0r9r0y68HEQi5JTh85L//l9Ryq0/H1WoVExSzMjyp/C9P/RPjzg8gfnRs
         c3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777524925; x=1778129725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAe8cP6TYFnEN8/YXGSawR9WCiVkG3O6SqUP6943CY0=;
        b=bfDA4TvT3ccCzAuuPZM8KcX7BRc9txdiX3gJFYR3V+d4klkA8/Mu3NlpWEI9l3zoz2
         f2RY7X/yh//u/gQH3TiQvDc3gg4To5jJqlM2DlJ3wbnIiBJEUYtHbQOw7z2qT4W+qtjA
         2xTAj6rxTvaiIaM4xiAX733+VM6x8k5acdR4nqGNkNBer2fjW/Yug9AKgCTgS4Qsyjhk
         puWiZclekF5V/65K7yWgiIrASSc3CT80cPVxk/aYWgaYwzpahyqQrnxEg+KIUfqtlpKS
         p9dHDBsRHE/BUccYd/sfRwAgrhgsSgKmjCbdv0WClEHmQAXuG8UKAQWY6zm10aEmKT9o
         Rn1A==
X-Gm-Message-State: AOJu0YyJt1fKuWQg62Uikir9cby8IWmugWlwo1BDS8zUnXJoHLt8HNDN
	sKbQ+cqePyooHqS1eU4kQkTTSTuJUcddN89BfOSjj9s5a8xODmi9wnTmsqo9wIey
X-Gm-Gg: AeBDieuqFYb69JqjR0gswU6sbZlutderRFNTLonbAWRVSdvI5KyCiMlUGSRMzgJVOxb
	OMZW1bpQBEmcqZRWWc7GATad2Tt9KgG9eiicStxZKccuZLdFwPrzgP0pQv+Q/K+Z9AhiXP+SXGK
	xDL1HyQUfnLTpItiIADGNCnqR4Tu2Xnu0mRVS0w+lD4/Gyktce0+il6Hb59swPwd+o3jSrPl2ZP
	IDPYe2wNWcdOJCQw/UTQ0SdCRxd6lKmmTKacQ/XE2E4UeN3X6oZz/dK+qnv+dmNkhQWDNTSIe8s
	e53glNjfhYijP9lLlXh4zA6vgLggg4ejYkTnxl10JqjyUq2qrHj4p05qhhhzu7DIyQLLWM2Eit0
	CxbIpanRyKSHHfebZQKfd2KbDuYa916NeMnLBI7S6s/l9Fyw77s8tNaGRuXtfMtqOA2UBnBhSAj
	z4VetdZAOzCVht1zXQ4baxIoxbGu+6MP4prJuZTFeg5TBjSl/DXUOV2mldU2Y=
X-Received: by 2002:a05:620a:4046:b0:8ee:f43a:bb6d with SMTP id af79cd13be357-8fa89fe7febmr222171185a.57.1777524924655;
        Wed, 29 Apr 2026 21:55:24 -0700 (PDT)
Received: from dans-laptop.miyazaki.mit.edu ([18.11.149.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f93f582702sm339595285a.29.2026.04.29.21.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:55:23 -0700 (PDT)
From: Dan Klishch <danilklishch@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] Bluetooth: fix Set Public Address on controller in HCI_AUTO_OFF grace period
Date: Thu, 30 Apr 2026 00:55:22 -0400
Message-ID: <20260430045522.7881-1-danilklishch@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When mgmt's Set Public Address command (and Set External Configuration)
stages a configuration change, set_public_address() sets HCI_CONFIG and
HCI_AUTO_OFF on the device and queues hci_power_on. The intent is for
the queued power_on to run hci_dev_init_sync() -- which detects
HCI_CONFIG and calls hdev->set_bdaddr() to program the new address into
the firmware -- and then re-emit Index Added with the controller back in
the boot-init grace period (HCI_UP=1, HCI_AUTO_OFF=1) so userspace can
re-push pending config commands and drive a fresh Set Powered 1 cycle.

The bug bites when the command is issued while the controller is in
that same grace period itself -- the normal post-boot state, before
bluetoothd has claimed the controller via Set Powered 1. In that state
HCI_UP=1 and HCI_AUTO_OFF=1, so hdev_is_powered() is false (the command
is accepted) but hci_power_on()'s "already up" early-return condition
HCI_UP && HCI_MGMT && HCI_AUTO_OFF is true. The early-return path runs
hci_powered_update_sync() -- which is the wrong thing for this case:
neither hci_dev_init_sync() nor mgmt_index_added() runs. The result:

  - hdev->public_addr is recorded but never reaches the firmware via
    hdev->set_bdaddr(),
  - userspace sees Index Removed (from set_public_address) but no
    Index Added, leaving the controller invisible to mgmt clients;
    it is not in the configured, unconfigured or extended index list
    yet remains registered in the kernel.

The other two starting states are fine: HCI_UP=0 falls through to the
full hci_dev_do_open() path (correct); HCI_UP=1 with HCI_AUTO_OFF=0
makes hdev_is_powered() true, so set_public_address() rejects with
MGMT_STATUS_REJECTED before queueing power_on at all.

Fix: at the top of hci_power_on(), if HCI_CONFIG is pending and we are
in the affected grace-period state (HCI_UP, HCI_MGMT, !HCI_RFKILLED),
close the device first. The early-return condition then fails and we
fall through to hci_dev_do_open() -> hci_dev_init_sync(), which honors
HCI_CONFIG by invoking hdev->set_bdaddr(); the post-open block then
re-emits Index Added via the existing HCI_CONFIG branch.

hci_dev_close_sync() clears HCI_AUTO_OFF as a side effect of going
through the regular power-down path, but set_public_address() had set
it deliberately so the post-reopen state matches the boot-init grace
period that mgmt clients expect ("treat as new one" per the protocol
contract). Several mgmt commands -- Set Privacy, Set Wideband Speech,
Set LE, Set BR/EDR, etc. -- gate on !hdev_is_powered(), and bluetoothd
expects to push them during this window before issuing Set Powered 1
itself. Restore HCI_AUTO_OFF after the close so hdev_is_powered() ==
false again.

This matches the documented behavior for Set Public Address on a
fully-configured controller ("Once the address has been successfully
changed an Index Added event will be sent.")

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Dan Klishch <danilklishch@gmail.com>
---
 net/bluetooth/hci_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -948,6 +948,14 @@ static void hci_power_on(struct work_struct *work)

 	BT_DBG("%s", hdev->name);

+	if (hci_dev_test_flag(hdev, HCI_CONFIG) &&
+	    hci_dev_test_flag(hdev, HCI_MGMT) &&
+	    !hci_dev_test_flag(hdev, HCI_RFKILLED) &&
+	    test_bit(HCI_UP, &hdev->flags)) {
+		hci_dev_do_close(hdev);
+		hci_dev_set_flag(hdev, HCI_AUTO_OFF);
+	}
+
 	if (test_bit(HCI_UP, &hdev->flags) &&
 	    hci_dev_test_flag(hdev, HCI_MGMT) &&
 	    hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF)) {

---

Claude was able to fully convince me that the patch and the explanation
are correct. Moreover, this indeed fixed a problem I had with a custom
patched bluetoothd that happened to override public-addr in the 2
second post-boot window. However, both the patch and commit description
are fully AI-generated.
