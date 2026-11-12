Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488070;
	b=oIocHOSik4xv/mzFBlWsO4K1g3vHogINMeqJ+amF0I9bI3Ww1qynYzJ48B4EEOKUT0t6
	 txevsr00zAeB53t+Zd2diJX7y19IlUrYtOw90c6gkU/oLEGPjNX+8bcITxm2Qqr0rF+6C
	 q9THyuS9z1hDU0t2w5jfYaJZG8BPEPGguafrjjwhFpVJdBcAgdP7DF1nEHxFGBU3EdDPf
	 Ww3ehBWQo1l9Uwb+6y6s4pt/8bPtfLDoBFO4Zp96B1KkxhAd1AL6epm8t68cKuKML6Arf
	 EPLwA1Lx4aZnSaRjYU7zNEFl59L5Q8czgCQSns69hgsJriaxIy/yEJQ4KDFbDydZUbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488070;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=sK8lSGd7CdKaAvaHcw1VrkPxB7/S/YIrxUcCKrE63b0=;
	b=GJcfY3WTFukL3P1CIyod+4TWUUXOSVOzGV++B0iMUyaM8hiNrss/HIjFXtHhp1xGeEEX
	 vWrZlvbgDp4rZ9GWfCP5WGl7VsBn9C6tVJSqtYcy1SySnXNJ9zxgykbDryh07RtP1r2mt
	 9q26EfablHyjbJ0ZHcnxZJ7WVBDh8xXIJzyodxYjsXCMLzgsNSN5Z75nRmZpSCh5Awkd9
	 odKYa9t4BIpqDStsmhgUG5zzeW5dxTiRBlEQY/q2LQlo9R8SPNa/74WoQBvbDeGHp3WMH
	 1XoNsgVNW92Y2T4dV8O9pEtnbgNKgPzctUohv881W1ECpDiJRLy3XrJLfdaMnQTsW5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=Gu+zG9Wf;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656BA606A327
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 12:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 656BA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=Gu+zG9Wf
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b5c3288e6cso1884175b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 04:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1794488068; x=1795092868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sK8lSGd7CdKaAvaHcw1VrkPxB7/S/YIrxUcCKrE63b0=;
        b=Gu+zG9WfkrnAkdUzhHZhNWwPUAGsUrbIWEIguDBzjcb/1PDvM/iyqvtJsO+HHV2L4K
         SYs7C+jDWrBrQNvbvzTU8XNoTfNlmnMZxLRGPK0IdZSbEXNgEJhiDsfDhCmzcg5Byagp
         rFQaUrGJWRt58qh+CAIssN67zvXuEwCF4IwH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794488068; x=1795092868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sK8lSGd7CdKaAvaHcw1VrkPxB7/S/YIrxUcCKrE63b0=;
        b=JZyV8MYtdMZDoUD/vLCdV59pNcO083TNRli5g30Sa428jhnHWScCSWSaLlCb0GEk/q
         zj4hEyWjqNpcHm5G5FsLPWwDUta3i4dgFuD8XK8m+gv+X0ltKRliL98WrLDh1Gu8t9k7
         aDo6/NTNHIPAgnEfgJj54Seuf0NEt9cYpwP3G31c2CJQxKblD6xxt0Q2J/hLoUsauOAx
         qAWTfY0JUXTMs2kWcR+0CGcys6E6AUuF0BZ6RNXQliKisgjtYood4+s8aJsShcIylv8g
         umfHuP6j7KIdSCpcxwvxbEgRV27PZxPjU5yJ9xEBLkp25f6xdrOryOwLCK+ZHwf1Tec5
         X5qw==
X-Gm-Message-State: APuU4Z8Sgd4J27RBQP+CSFw/dXJl5tXmjNzX8qUqUXSKRNXTVHf14yuJ
	BXthN6FUl6jkITfvfufaRFUeVY+3V4+CFCZqC63q33JUkwIWMk/aavU08QNejRxqL2E=
X-Gm-Gg: AYBFou3gH8SD7opaRgFzWFM29H7FTDuTApFvFVH+QZpTH2CuFUJmyyU4SV/CiY2nyXj
	zRmwDpuc49TDqN6RTZdDyGS9lwtaVrJp9lkl2EjrYopb6j4Pxa5cOn7ajIxSA++luFug1+djCKq
	TOtzs3HObzy40zGUjbMP4Jxeq7boq1vbxI1yO/k4VBs/kOUc+o4/S4mLCgPsCrfeHfpGGRvR318
	t5Z/AhYD7mrZ1+Q6Q6OyKuyARDXL49FRMfNf4u3KDPdKDu80G5Adf6k31gYjs/7nZ9sJTY2hliR
	GlzU8u42MmMiwapZChSoQxgvCuyu1cA+wOnUx63R7RuCt2iXIjDWHASMMGjWyB8Jq7DORYkxSQR
	K4lcL91FPAbTUFG2rjWYyS6FHuqj3s9x1dp4oCv3JI14qpRepjqGvQ6WAb8cpJO+Z7ok6XtPFGW
	6GoDd3bF8NjfOPpHQDXF25shs2wN+giFrkK18ghAv8In4tsKpqWygNJ+QY8OR7Y3oDiXM5VZDyZ
	C0Wqw6ygJnKHnHuhg92WGA2s6gjHslaF6WPjsBLCU4o3U7hRwfYPYpsioNk6Ex4ppYDRKdpXNLD
	gEbjN+skPM0K906Ne5yzLxlGrGWYYfdzWf6h6JzJJwlq1vrGQtLQav8O+7cfPBi4Fcxv6mrPJC0
	0mA/MoRbnon41dTaXQcg38WN0hQrpSHRH7mGKK5uAcM+IF39aggXGtTW3cwn5b7L3
X-Received: by 2002:a05:6a00:600d:b0:886:9078:546 with SMTP id d2e1a72fcca58-8bc1cc682cfmr5525239b3a.26.1794488068390;
        Thu, 12 Nov 2026 04:54:28 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa86e1c9sm3492976b3a.23.2026.11.12.04.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:54:27 -0800 (PST)
From: Piyus Kedia <piyus@iiitd.ac.in>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kapil Vaswani <kapil@presceralabs.ai>,
	Piyus Kedia <piyus@iiitd.ac.in>
Subject: [PATCH v3] Bluetooth: mgmt: drop advertising instances the controller cannot carry
Date: Thu, 12 Nov 2026 18:24:20 +0530
Message-Id: <20261112125420.3905719-1-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
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

An advertising instance's data is validated once, when the instance is
added, by tlv_data_is_valid() -> tlv_data_max_len() -> max_adv_len().
max_adv_len() branches on ext_adv_capable(hdev), which reads
hdev->le_features[1] - a controller capability re-read from the device on
every bring-up.

Nothing re-checks the stored instances when that capability changes.  A
controller that reported LE Extended Advertising when the instance was
added, and does not report it after the next bring-up, leaves behind an
instance of up to 251 bytes that is then rendered into the 31-byte cp.data
of hci_set_adv_data_sync() or __hci_set_scan_rsp_data_sync():

  Kernel panic - not syncing: stack-protector: Kernel stack is corrupted
  in: hci_update_adv_data_sync+0x1dc/0x1e0

  Kernel panic - not syncing: stack-protector: Kernel stack is corrupted
  in: hci_update_scan_rsp_data_sync+0x20f/0x210

Drop such instances once the capability has been re-read, and tell
userspace through MGMT_EV_ADVERTISING_REMOVED so it can add them again at a
size this controller will take.

Two details decide whether this is correct.

The test has to be tlv_data_max_len() itself, not a bare max_adv_len().
That function already encodes the per-flag adjustments the render applies -
4 bytes for MGMT_ADV_FLAG_APPEARANCE, calculate_name_len() for
MGMT_ADV_FLAG_LOCAL_NAME, and the flags and TX power fields on the
advertising data side - so re-using it keeps one source of truth and the
check cannot drift away from eir_create_adv_data() and
eir_create_scan_rsp().  Comparing the stored lengths against max_adv_len()
instead misses exactly those bytes: a 30-byte scan response carrying
MGMT_ADV_FLAG_APPEARANCE is within 31 and is still rendered as 34.
hci_adv_instance_flags() returns adv->flags for any non-zero instance, so
adv->flags is the flag set the render will use.

Using the add-time test means the rule is "would this instance still be
accepted today", which is marginally stricter than "would this instance
overflow".  eir_create_adv_data() drops the flags and TX power fields when
they do not fit rather than overflowing, so an instance can be removed
here that would in fact still have rendered.  That seems the right way
round: the instance is one userspace could not add now, and it is told
about the removal so it can add a version that fits.

The call goes before the HCI_LE_ENABLED test in
hci_powered_update_adv_sync(), not after it.  set_le() on an unpowered
device changes that flag without clearing hdev->adv_instances, so an
instance left behind would otherwise survive a bring-up untouched.  This
runs once per bring-up, which is also the only point at which the
capability can have changed: hdev->le_features is written only by the two
handlers for the controller's LE Read Local Supported Features reply, both
inside the init sequence.

Per Documentation/process/generated-content.rst: the out-of-bounds writes
were found by an AI-driven fuzzing harness developed jointly by Kapil
Vaswani and myself.  The approach taken here is Luiz's, from his review of
v1; the patch text, this changelog and the test programs were produced with
the assistance of a large language model and reviewed by Kapil Vaswani and
myself, who designed and ran the testing described below the ---.

Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Signed-off-by: Kapil Vaswani <kapil@presceralabs.ai>
Signed-off-by: Piyus Kedia <piyus@iiitd.ac.in>
---
Changes in v3:
  - take the approach you suggested on v1 and unregister the instances,
    rather than bounding the copies in eir.c
  - test with tlv_data_max_len() rather than max_adv_len(), which is what
    Sashiko's second finding is about: the per-flag adjustments cannot
    drift from the render if the check reuses the add path's own test
  - call it before the HCI_LE_ENABLED early return, which is Sashiko's
    first finding
  - runtime before/after on net/main for four scenarios

Changes in v2:
  - dropped oversized instances in hci_powered_update_adv_sync(), tested
    against max_adv_len()

Both Sashiko findings, and where they land:

  1. The early return skipping the loop.  Fixed by calling before it.  We
     could not reproduce the overflow the report draws from it, though: on
     re-enabling LE, set_le_sync() calls
     hci_update_adv_data_sync(hdev, 0x00) and
     hci_update_scan_rsp_data_sync(hdev, 0x00), and instance 0 has no
     adv_info, so neither copy runs.  The skip is real and worth fixing;
     the path from it to a write was not one we could trigger.

  2. MGMT_ADV_FLAG_APPEARANCE with scan_rsp_len in 28..31.  Reproduced at
     30, which v2 keeps and renders as 34.
     tlv_data_max_len(hdev, MGMT_ADV_FLAG_APPEARANCE, false) is 27, so all
     of 28..31 are now dropped, and 27 - which renders as exactly 31 -
     is kept.

Tested on net/main at a2fd526d6442 (7.4.0-rc1), x86_64 defconfig plus KASAN
with KASAN_STACK, booted by hand under qemu against the same rootfs each
time with the image opened read-only.  "len=" is the length field of the HCI
command the kernel emitted, read off the virtual controller - a witness
independent of KASAN, since anything above 31 means eir_create_*() has
already written past cp.data[31]:

  scenario    | unpatched           | v2                  | this patch
  ------------+---------------------+---------------------+----------------
  adv_data    | len=220, panic      | no command          | no cmd, pruned
  scan_rsp    | len=220, panic      | no command          | no cmd, pruned
  appearance  | len=34              | len=34              | no cmd, pruned
  le_toggle   | no command          | no command          | no cmd, pruned

adv_data / scan_rsp: a 220-byte instance added while the controller reported
LE Extended Advertising, then re-read without it.  Both panic on an
unpatched kernel:

  Kernel panic - not syncing: stack-protector: Kernel stack is corrupted
  in: hci_update_adv_data_sync+0x1dc/0x1e0
  in: hci_update_scan_rsp_data_sync+0x20f/0x210

appearance: KASAN does not report this one - three bytes past a 32-byte
stack object land in adjacent locals rather than in a redzone - which is
why the emitted length is the evidence.

No Fixes: tag - our clone is shallow and git blame lands on the shallow
boundary, so we cannot name the introducing commit.

The reproducer is one C program with the four modes above and needs no
Bluetooth hardware.  It is not included here: this was found with AI
assistance, which Documentation/process/security-bugs.rst says to treat as
public while not posting the reproducer.  Ask and we will send it.

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_sync.c         |  8 ++++++
 net/bluetooth/mgmt.c             | 49 ++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6fb713d5e4be..ab5aa80abe2b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2573,6 +2573,7 @@ bool mgmt_get_connectable(struct hci_dev *hdev);
 u8 mgmt_get_adv_discov_flags(struct hci_dev *hdev);
 void mgmt_advertising_added(struct sock *sk, struct hci_dev *hdev,
 			    u8 instance);
+void mgmt_remove_oversized_adv_instances(struct hci_dev *hdev);
 void mgmt_advertising_removed(struct sock *sk, struct hci_dev *hdev,
 			      u8 instance);
 int mgmt_phy_configuration_changed(struct hci_dev *hdev, struct sock *skip);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9213e3ef9f26..b9f06dad1c41 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3605,6 +3605,14 @@ static int hci_powered_update_adv_sync(struct hci_dev *hdev)
 	struct adv_info *adv, *tmp;
 	int err;
 
+	/* The controller's advertising capability has just been re-read, so
+	 * this is the first point at which stored instances can be measured
+	 * against it.  Do it before the HCI_LE_ENABLED test below: set_le() on
+	 * an unpowered device clears that flag without clearing the instances,
+	 * and one left behind must not survive to be rendered later.
+	 */
+	mgmt_remove_oversized_adv_instances(hdev);
+
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return 0;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 260ef2a45719..d6a20a08b49d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8933,6 +8933,55 @@ static u8 tlv_data_max_len(struct hci_dev *hdev, u32 adv_flags,
 	return max_len;
 }
 
+/* Drop stored advertising instances that the controller can no longer carry.
+ *
+ * An instance's data was accepted against tlv_data_max_len() as it was when
+ * the instance was added, and that depends on max_adv_len(), which branches on
+ * ext_adv_capable() - a controller capability re-read from the device on every
+ * bring-up.  A controller that stops reporting LE Extended Advertising
+ * therefore leaves instances behind that can no longer be rendered:
+ * eir_create_adv_data() and eir_create_scan_rsp() would write past the 31-byte
+ * buffers of hci_set_adv_data_sync() and __hci_set_scan_rsp_data_sync().
+ *
+ * Re-using tlv_data_max_len() is deliberate.  It is the same test the add path
+ * applies, so the per-flag adjustments - 4 bytes for MGMT_ADV_FLAG_APPEARANCE,
+ * calculate_name_len() for MGMT_ADV_FLAG_LOCAL_NAME, and the flags and TX
+ * power fields on the advertising data side - cannot drift out of agreement
+ * with it.  Comparing the stored lengths against a bare max_adv_len() misses
+ * exactly those bytes.
+ *
+ * hci_adv_instance_flags() returns adv->flags for any non-zero instance, so
+ * adv->flags is the flag set the render will actually use.
+ */
+void mgmt_remove_oversized_adv_instances(struct hci_dev *hdev)
+{
+	struct adv_info *adv, *n;
+
+	/* This is safe as long as there is no command send while the lock is
+	 * held.
+	 */
+	hci_dev_lock(hdev);
+
+	list_for_each_entry_safe(adv, n, &hdev->adv_instances, list) {
+		u8 instance = adv->instance;
+
+		if (adv->adv_data_len <= tlv_data_max_len(hdev, adv->flags,
+							  true) &&
+		    adv->scan_rsp_len <= tlv_data_max_len(hdev, adv->flags,
+							  false))
+			continue;
+
+		bt_dev_warn(hdev,
+			    "advertising instance %u no longer fits, removing",
+			    instance);
+
+		if (!hci_remove_adv_instance(hdev, instance))
+			mgmt_advertising_removed(NULL, hdev, instance);
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 static bool flags_managed(u32 adv_flags)
 {
 	return adv_flags & (MGMT_ADV_FLAG_DISCOV |

base-commit: a2fd526d644233d6a892c28173f07c61e21e4c93
-- 
2.34.1

