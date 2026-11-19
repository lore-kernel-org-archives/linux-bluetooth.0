Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048378;
	b=oQFBJhJqfY0IH7AyJSFiDxtRSdLstFqnaQrBBHK2n8Jy6vyo6oX6SmYU4fO4cO74kC9q
	 128jDdsGnlvBV+khHa2Zb8c2EsPhy7naPhD9SGkuuSOB7bC5v7R/yYChewfJqd6u3DWxl
	 n/aTIXbWAiFMep+llTg7oxrt3t5KRMLnSjTyAucDqtTrPGp+N9bAR0s95vir6+F1ZkeWu
	 uk77Fxwnwvuo50ORgxkFrGoPyhnq2JxJ4ysk1fIJMY90jsB+6gMBUVBeIEwTc8rzWxuuY
	 iUHWLltFF9M122wKGGb0eX+XqIZV6wYj+tt10DIZ8ovX6Ob1C45t7ue141uReQwV9qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kZXw7IZ/hLN7cWl0Dm2vmAwUT0Yvx9iPgvct4+gH2z0=;
	b=MyKUrqe3bsw7Qo/24IIzcg2j+JQEkkeaXtRB5h04Td52Z8B85UnngTHoFB8nvNHMlWjT
	 D21/N2jkDyGXBdk+WU1s9IoHmSR3F77aimlWXM39SHERClPhFFnDue+cO/dGsZG3wn+zA
	 sBqskAM+PXVtI8IWRIRzwJf7Tdc08bxslFPTumm+WcVT2ks4XIgrFKhXVvMbKQnS6y76g
	 sPI7emulggPVXjTflnJ14ierGnfxKBt1BbmpNsLeL7IfKFAeH8BzpeFu+CrBNnROw38KF
	 laWEBkaDP5ehfLEuVmTR42pbpJF0e+2awXOkg+hFZvACSFYFgnpCSpL79FSAplJSkbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AuWG4qA6;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9BF60A262A
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 00:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B9BF60A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AuWG4qA6
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a60f90a924so802817b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 16:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795048377; x=1795653177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kZXw7IZ/hLN7cWl0Dm2vmAwUT0Yvx9iPgvct4+gH2z0=;
        b=AuWG4qA6sJ9RxhRWUrFik0lRGdoj3JVvK3ryQfpIys+y6dQi9tiwjNzXxe60CO49IS
         tkHLZFWeS6JswB6vilvhFWfrgNrlRG6oWtjLlPlG78Vz8KiUPBVLOi1taty3YunkHQ+k
         caKCkQhCIKnLFWmZe5nQOxhRKpWxTpUaia8ZIMVOY76JcsvyUsNZuokxbvMUS/hNYewf
         McjQIn36QRXnOmiEQGwhFoKmkbVLefKBhp1zx+xNZmlAxo1J3a2iG1fDCjDzfGIDIief
         eymHLZyQ4pEq5C/iYj+uNZWndo+UPSonyAyAa2cR+mL/FmqwrK0hxTkRIITSxQva4lsX
         whtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795048377; x=1795653177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kZXw7IZ/hLN7cWl0Dm2vmAwUT0Yvx9iPgvct4+gH2z0=;
        b=E82zUDoqKvxO/QAtiIpijWqKtCYfOZUQtFdYyVdtfdK/TzeKVZUoEe/0iyih/FBKAX
         HRWAXBu/+VBjYoTm9+5Fv4FLXbeWUh9cqdR1AbNVbKn20dEcvuEjElgeOZWFE0NsqTmS
         aS4MliWRnbUAAo14dey3YGAFEZKokor3miGYZEEfRD2DvJu5U6GbCQ/CVaV30uWkD9zw
         fcXHoIPWnuyGmTpMkJux1hklUVXiSP5kUlXVbMEpfXV7ti+lwXVbRkK7c8HJOCB8bTZ1
         gcYbxAAv1RzbJ5mdlq5uYweft9zrX1vRMqTreDqJ/IukCRglGTGVCHWuQNX1I9t/yWkF
         v4Kw==
X-Gm-Message-State: APuU4Z/+NxhoENkQ4RUZPTCfwqUsXsEev58PeiruFxCIkPtsA8OZMpYI
	5EAeQTSwzGI8ma43zkwTCVC5JgMK+xLS0g1BpsjfWO/jQ/+aL8174Z1o
X-Gm-Gg: AYBFou1sVUeq5tixsNuxvx/KB8UZaYMNBQIgj1i/bXIK2Zq1xTsUpLBYpZVXZ6R5v6Y
	Lbn8bhZ0jFd5jeYEEKXlrh2sm8SIeEcpC2Bahp9p3chNlhOZqBeeMloGEdXcYdqjj/9qlWvWI/t
	yqSz7jD/mLWcQm+PUrlWkana8T/SsLRgVorAWkQWMQLZ2LmIRDqtyBZvYl5ui/Pdxfi97GcU9iD
	0lI2hphLPwoJVdDe2pE9UFkIoAnJqYL42xPmFujbTeL7XpccHN5TN+m0oHlPH8L0AF+hqjSDxY/
	cnrddWXW+qQfE18X+AOp1+UArRxK4bIP6z3rXijF53nWGLohlrMfw0kjF8YW4qF1FEhxB5s0jvW
	YiK39gW2QXseP5nqlEqoruQ1nFBIlVpRUdAH4kpjzgB1d1i2ADh4NfJszXJfNbL7U0TuQkx0J3h
	fYdVcKMSQvbrMzX5ZP6DamkTUxdt9APsa2WvVKt6lO6SrXidALHRDe0hB/2d61H6TI5r6KNLKKq
	4ENgbq2OfKnc4BiLXZQY7eQNsIH9e/OYzeULmBMgLCCmOglEGdeKer2LyMFEcMMhve/JywB3cEj
	19OVoiOwX/wfGT7SXziDDs3s
X-Received: by 2002:a05:6a00:230c:b0:89f:6989:cb9d with SMTP id d2e1a72fcca58-8c5d3638032mr3741025b3a.35.1795048376633;
        Wed, 18 Nov 2026 16:32:56 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5cba3313dsm1975051b3a.53.2026.11.18.16.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:32:56 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v2 1/2] Bluetooth: hci_sync: Fix remaining advertising instance UAFs
Date: Thu, 19 Nov 2026 08:32:45 +0800
Message-Id: <pm-bluetooth-objects-candidate-0245-v14-e37270232af59a877004-1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0245-v14-e37270232af59a877004-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0245-v14-e37270232af59a877004-0@gmail.com>
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

hci_enable_ext_advertising_sync() looks up the advertising instance
without hdev->lock and then reads it, while HCI event processing can
free the instance under the lock:

  Request work                    HCI event work
  hci_enable_ext_advertising_sync()
    adv = hci_find_adv_instance()
                                  hci_cc_le_clear_adv_sets()
                                    hci_dev_lock(hdev)
                                    hci_remove_adv_instance()
                                      kfree(adv)
                                    hci_dev_unlock(hdev)
    reads adv->enabled

Since the conversion to hci_sync, the advertising request paths run
without hdev->lock, and the periodic advertising, advertising timeout
and mesh code added later does the same, while management commands and
HCI event processing still add and free instances under the lock. The
same unlocked use exists in:

 - hci_set_adv_data_sync(), hci_disable_ext_adv_instance_sync(),
   the periodic advertising enable
   and disable helpers, hci_schedule_adv_instance_sync(),
   adv_expire_sync() and set_advertising_complete()
 - hci_enable_advertising_sync() and hci_start_per_adv_sync(), which
   keep the instance across HCI commands
 - hci_remove_advertising_sync() and hci_clear_adv_instance_sync(),
   which keep the next instance as a pointer
 - mesh_send_sync(), which adds the mesh instance
 - the walks of hdev->adv_instances in hci_dev_open_sync(),
   hci_dev_close_sync(), hci_resume_advertising_sync() and
   hci_powered_update_adv_sync()

Fix them as commit cdc36db204ff ("Bluetooth: hci_sync: Fix advertising
data UAFs") does for the extended advertising data paths: look the
instance up under hdev->lock, copy what is needed, and release the lock
before a command is sent, since command completion handlers take it.
Keep the next instance as an instance number. Walks that send no command
hold the lock, as hci_clear_adv_sync() does. The resume and power on
walks send a command per instance and cannot hold it, so they copy the
instance numbers under the lock into a fixed stack array first. Instance
identifiers are nonzero u8 values, so 255 bytes cover the whole
namespace. This preserves list order without adding an allocation
failure after the resume path consumes its pause state.

Use a u32 for the timeout-to-milliseconds conversion before converting
to the controller's 10 ms units, and clamp the result to U16_MAX. The
old u16 intermediate wrapped timeouts longer than 65 seconds.

KASAN report as below:

    BUG: KASAN: slab-use-after-free in
     hci_enable_ext_advertising_sync+0x2fd/0x330
    Read of size 1 at addr ffff88811673b810 by task kworker/u17:0/492

    Workqueue: hci0 hci_cmd_sync_work
    Call Trace:
     hci_enable_ext_advertising_sync+0x2fd/0x330
     add_ext_adv_data_sync+0x1f8/0x250
     hci_cmd_sync_work+0x1b3/0x450

    Allocated by task 490:
     hci_add_adv_instance+0x627/0x960
     add_ext_adv_params+0x4d4/0xaf0
     hci_sock_sendmsg+0x128b/0x22e0

    Freed by task 495:
     kfree+0x307/0x580
     hci_remove_adv_instance+0x226/0x4f0
     hci_cc_le_clear_adv_sets+0x2a5/0x400
     hci_cmd_complete_evt+0x373/0xab0
     hci_event_packet+0x4e8/0xc70
     hci_rx_work+0x367/0xf00

    The buggy address belongs to the object at ffff88811673b800
     which belongs to the cache kmalloc-1k of size 1024
    The buggy address is located 16 bytes inside of
     freed 1024-byte region [ffff88811673b800, ffff88811673bc00)

Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Fixes: c249ea9b4309 ("Bluetooth: Move Adv Instance timer to hci_sync")
Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---

 net/bluetooth/hci_sync.c | 271 +++++++++++++++++++++++++++++----------
 net/bluetooth/mgmt.c     |  34 ++++-
 2 files changed, 229 insertions(+), 76 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3fe179d649d0582a849090e165a837a6d3eeb9a6..7ba3644fa6eddb90b6515badfd037bb3d0228e91 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -501,7 +501,8 @@ static void cancel_adv_timeout(struct hci_dev *hdev)
 int hci_clear_adv_instance_sync(struct hci_dev *hdev, struct sock *sk,
 				u8 instance, bool force)
 {
-	struct adv_info *adv_instance, *n, *next_instance = NULL;
+	struct adv_info *adv_instance, *n;
+	u8 next_instance = 0;
 	int err;
 	u8 rem_inst;
 
@@ -509,12 +510,20 @@ int hci_clear_adv_instance_sync(struct hci_dev *hdev, struct sock *sk,
 	if (!instance || hdev->cur_adv_instance == instance)
 		cancel_adv_timeout(hdev);
 
+	/* This is safe as long as there is no command send while the
+	 * lock is held.
+	 */
+	hci_dev_lock(hdev);
+
 	/* Get the next instance to advertise BEFORE we remove
 	 * the current one. This can be the same instance again
 	 * if there is only one instance.
 	 */
-	if (instance && hdev->cur_adv_instance == instance)
-		next_instance = hci_get_next_instance(hdev, instance);
+	if (instance && hdev->cur_adv_instance == instance) {
+		adv_instance = hci_get_next_instance(hdev, instance);
+		if (adv_instance)
+			next_instance = adv_instance->instance;
+	}
 
 	if (instance == 0x00) {
 		list_for_each_entry_safe(adv_instance, n, &hdev->adv_instances,
@@ -533,9 +542,8 @@ int hci_clear_adv_instance_sync(struct hci_dev *hdev, struct sock *sk,
 		if (force || (adv_instance && adv_instance->timeout &&
 			      !adv_instance->remaining_time)) {
 			/* Don't advertise a removed instance. */
-			if (next_instance &&
-			    next_instance->instance == instance)
-				next_instance = NULL;
+			if (next_instance == instance)
+				next_instance = 0;
 
 			err = hci_remove_adv_instance(hdev, instance);
 			if (!err)
@@ -543,12 +551,13 @@ int hci_clear_adv_instance_sync(struct hci_dev *hdev, struct sock *sk,
 		}
 	}
 
+	hci_dev_unlock(hdev);
+
 	if (!hdev_is_powered(hdev) || hci_dev_test_flag(hdev, HCI_ADVERTISING))
 		return 0;
 
 	if (next_instance && !ext_adv_capable(hdev))
-		return hci_schedule_adv_instance_sync(hdev,
-						      next_instance->instance,
+		return hci_schedule_adv_instance_sync(hdev, next_instance,
 						      false);
 
 	return 0;
@@ -1226,16 +1235,26 @@ static int hci_disable_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	struct hci_cp_ext_adv_set *set;
 	u8 data[sizeof(*cp) + sizeof(*set) * 1];
 	u8 size;
-	struct adv_info *adv = NULL;
+	u8 handle = instance;
 
 	/* If request specifies an instance that doesn't exist, fail */
 	if (instance > 0) {
+		struct adv_info *adv;
+		bool enabled;
+
+		hci_dev_lock(hdev);
 		adv = hci_find_adv_instance(hdev, instance);
-		if (!adv)
+		if (!adv) {
+			hci_dev_unlock(hdev);
 			return -EINVAL;
+		}
+
+		enabled = adv->enabled;
+		handle = adv->handle;
+		hci_dev_unlock(hdev);
 
 		/* If not enabled there is nothing to do */
-		if (!adv->enabled)
+		if (!enabled)
 			return 0;
 	}
 
@@ -1248,7 +1267,7 @@ static int hci_disable_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	cp->num_of_sets = !!instance;
 	cp->enable = 0x00;
 
-	set->handle = adv ? adv->handle : instance;
+	set->handle = handle;
 
 	size = sizeof(*cp) + sizeof(*set) * cp->num_of_sets;
 
@@ -1419,14 +1438,21 @@ static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
 }
 
 static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
+	__context_unsafe(/* conditional locking */)
 {
 	struct hci_cp_le_set_adv_data cp;
 	u8 len;
 
 	memset(&cp, 0, sizeof(cp));
 
+	if (instance)
+		hci_dev_lock(hdev);
+
 	len = eir_create_adv_data(hdev, instance, cp.data, sizeof(cp.data));
 
+	if (instance)
+		hci_dev_unlock(hdev);
+
 	/* There's nothing to do if the data hasn't changed */
 	if (hdev->adv_data_len == len &&
 	    memcmp(cp.data, hdev->adv_data, len) == 0)
@@ -1715,17 +1741,33 @@ int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
 	struct hci_cp_le_set_ext_adv_enable *cp;
 	struct hci_cp_ext_adv_set *set;
 	u8 data[sizeof(*cp) + sizeof(*set) * 1];
-	struct adv_info *adv;
+	u8 handle = instance;
+	u32 duration = 0;
 
 	if (instance > 0) {
+		struct adv_info *adv;
+
+		hci_dev_lock(hdev);
 		adv = hci_find_adv_instance(hdev, instance);
-		if (!adv)
+		if (!adv) {
+			hci_dev_unlock(hdev);
 			return -EINVAL;
+		}
 		/* If already enabled there is nothing to do */
-		if (adv->enabled)
+		if (adv->enabled) {
+			hci_dev_unlock(hdev);
 			return 0;
-	} else {
-		adv = NULL;
+		}
+
+		handle = adv->handle;
+
+		/* Set duration per instance since controller is
+		 * responsible for scheduling it.
+		 */
+		if (adv->timeout)
+			duration = adv->mesh ? adv->timeout :
+					       adv->timeout * MSEC_PER_SEC;
+		hci_dev_unlock(hdev);
 	}
 
 	cp = (void *)data;
@@ -1738,18 +1780,10 @@ int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
 
 	memset(set, 0, sizeof(*set));
 
-	set->handle = adv ? adv->handle : instance;
+	set->handle = handle;
 
-	/* Set duration per instance since controller is responsible for
-	 * scheduling it.
-	 */
-	if (adv && adv->timeout) {
-		u16 duration = adv->mesh ? adv->timeout :
-					   adv->timeout * MSEC_PER_SEC;
-
-		/* Time = N * 10 ms */
-		set->duration = cpu_to_le16(duration / 10);
-	}
+	/* Time = N * 10 ms */
+	set->duration = cpu_to_le16(min_t(u32, duration / 10, U16_MAX));
 
 	/* Track which instance owns the advertising set since the handle
 	 * alone is ambiguous when instances share handle 0x00, see
@@ -1781,11 +1815,15 @@ int hci_start_ext_adv_sync(struct hci_dev *hdev, u8 instance)
 int hci_disable_per_advertising_sync(struct hci_dev *hdev, u8 instance)
 {
 	struct hci_cp_le_set_per_adv_enable cp;
-	struct adv_info *adv = NULL;
+	struct adv_info *adv;
+	bool enabled;
 
 	/* If periodic advertising already disabled there is nothing to do. */
+	hci_dev_lock(hdev);
 	adv = hci_find_adv_instance(hdev, instance);
-	if (!adv || !adv->periodic_enabled)
+	enabled = adv && adv->periodic_enabled;
+	hci_dev_unlock(hdev);
+	if (!enabled)
 		return 0;
 
 	memset(&cp, 0, sizeof(cp));
@@ -1854,11 +1892,15 @@ static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
 static int hci_enable_per_advertising_sync(struct hci_dev *hdev, u8 instance)
 {
 	struct hci_cp_le_set_per_adv_enable cp;
-	struct adv_info *adv = NULL;
+	struct adv_info *adv;
+	bool enabled;
 
 	/* If periodic advertising already enabled there is nothing to do. */
+	hci_dev_lock(hdev);
 	adv = hci_find_adv_instance(hdev, instance);
-	if (adv && adv->periodic_enabled)
+	enabled = adv && adv->periodic_enabled;
+	hci_dev_unlock(hdev);
+	if (enabled)
 		return 0;
 
 	memset(&cp, 0, sizeof(cp));
@@ -1873,25 +1915,36 @@ static int hci_enable_per_advertising_sync(struct hci_dev *hdev, u8 instance)
 /* Checks if periodic advertising data contains a Basic Announcement and if it
  * does generates a Broadcast ID and add Broadcast Announcement.
  */
-static int hci_adv_bcast_annoucement(struct hci_dev *hdev, struct adv_info *adv)
+static int hci_adv_bcast_annoucement(struct hci_dev *hdev, u8 instance)
 {
+	struct adv_info *adv;
 	u8 bid[3];
 	u8 ad[HCI_MAX_EXT_AD_LENGTH];
 	u8 len;
+	int err = 0;
 
-	/* Skip if NULL adv as instance 0x00 is used for general purpose
+	/* Skip if instance 0x00 as it is used for general purpose
 	 * advertising so it cannot used for the likes of Broadcast Announcement
 	 * as it can be overwritten at any point.
 	 */
-	if (!adv)
+	if (!instance)
 		return 0;
 
+	hci_dev_lock(hdev);
+
+	/* The instance may have been removed while waiting for the
+	 * controller, in which case there is nothing to announce.
+	 */
+	adv = hci_find_adv_instance(hdev, instance);
+	if (!adv)
+		goto unlock;
+
 	/* Check if PA data doesn't contains a Basic Audio Announcement then
 	 * there is nothing to do.
 	 */
 	if (!eir_get_service_data(adv->per_adv_data, adv->per_adv_data_len,
 				  0x1851, NULL))
-		return 0;
+		goto unlock;
 
 	/* Check if advertising data already has a Broadcast Announcement since
 	 * the process may want to control the Broadcast ID directly and in that
@@ -1899,34 +1952,44 @@ static int hci_adv_bcast_annoucement(struct hci_dev *hdev, struct adv_info *adv)
 	 */
 	if (eir_get_service_data(adv->adv_data, adv->adv_data_len, 0x1852,
 				 NULL))
-		return 0;
+		goto unlock;
 
 	/* Generate Broadcast ID */
 	get_random_bytes(bid, sizeof(bid));
 	len = eir_append_service_data(ad, 0, 0x1852, bid, sizeof(bid));
 	if (adv->adv_data_len > sizeof(ad) - len) {
 		bt_dev_err(hdev, "No room for Broadcast Announcement");
-		return -EINVAL;
+		err = -EINVAL;
+		goto unlock;
 	}
 
 	memcpy(ad + len, adv->adv_data, adv->adv_data_len);
-	hci_set_adv_instance_data(hdev, adv->instance, len + adv->adv_data_len,
+	hci_set_adv_instance_data(hdev, instance, len + adv->adv_data_len,
 				  ad, 0, NULL);
 
-	return hci_update_adv_data_sync(hdev, adv->instance);
+	hci_dev_unlock(hdev);
+
+	return hci_update_adv_data_sync(hdev, instance);
+
+unlock:
+	hci_dev_unlock(hdev);
+	return err;
 }
 
 int hci_start_per_adv_sync(struct hci_dev *hdev, u8 instance, u8 sid,
 			   u8 data_len, u8 *data, u32 flags, u16 min_interval,
 			   u16 max_interval, u16 sync_interval)
 {
-	struct adv_info *adv = NULL;
+	struct adv_info *adv;
+	u8 bcast_instance = 0;
 	int err;
 	bool added = false;
 
 	hci_disable_per_advertising_sync(hdev, instance);
 
 	if (instance) {
+		hci_dev_lock(hdev);
+
 		adv = hci_find_adv_instance(hdev, instance);
 		if (adv) {
 			if (sid != HCI_SID_INVALID && adv->sid != sid) {
@@ -1935,6 +1998,7 @@ int hci_start_per_adv_sync(struct hci_dev *hdev, u8 instance, u8 sid,
 				 */
 				adv = hci_find_adv_sid(hdev, sid);
 				if (!adv) {
+					hci_dev_unlock(hdev);
 					bt_dev_err(hdev,
 						   "Unable to find adv_info");
 					return -EINVAL;
@@ -1953,11 +2017,17 @@ int hci_start_per_adv_sync(struct hci_dev *hdev, u8 instance, u8 sid,
 						   data_len, data,
 						   sync_interval,
 						   sync_interval);
-			if (IS_ERR(adv))
+			if (IS_ERR(adv)) {
+				hci_dev_unlock(hdev);
 				return PTR_ERR(adv);
+			}
 			adv->pending = false;
 			added = true;
 		}
+
+		bcast_instance = adv->instance;
+
+		hci_dev_unlock(hdev);
 	}
 
 	/* Start advertising */
@@ -1965,7 +2035,7 @@ int hci_start_per_adv_sync(struct hci_dev *hdev, u8 instance, u8 sid,
 	if (err < 0)
 		goto fail;
 
-	err = hci_adv_bcast_annoucement(hdev, adv);
+	err = hci_adv_bcast_annoucement(hdev, bcast_instance);
 	if (err < 0)
 		goto fail;
 
@@ -1985,8 +2055,11 @@ int hci_start_per_adv_sync(struct hci_dev *hdev, u8 instance, u8 sid,
 	return 0;
 
 fail:
-	if (added)
+	if (added) {
+		hci_dev_lock(hdev);
 		hci_remove_adv_instance(hdev, instance);
+		hci_dev_unlock(hdev);
+	}
 
 	return err;
 }
@@ -2016,6 +2089,7 @@ int hci_enable_advertising_sync(struct hci_dev *hdev)
 	u8 own_addr_type, enable = 0x01;
 	bool connectable;
 	u16 adv_min_interval, adv_max_interval;
+	bool scannable;
 	u32 flags;
 	u8 status;
 
@@ -2023,8 +2097,25 @@ int hci_enable_advertising_sync(struct hci_dev *hdev)
 		return hci_enable_ext_advertising_sync(hdev,
 						       hdev->cur_adv_instance);
 
+	/* Snapshot the instance under hdev->lock since it may be removed
+	 * while waiting for the commands below to complete.
+	 */
+	hci_dev_lock(hdev);
+
 	flags = hci_adv_instance_flags(hdev, hdev->cur_adv_instance);
+	scannable = hci_adv_instance_is_scannable(hdev,
+						  hdev->cur_adv_instance);
+
 	adv_instance = hci_find_adv_instance(hdev, hdev->cur_adv_instance);
+	if (adv_instance) {
+		adv_min_interval = adv_instance->min_interval;
+		adv_max_interval = adv_instance->max_interval;
+	} else {
+		adv_min_interval = hdev->le_adv_min_interval;
+		adv_max_interval = hdev->le_adv_max_interval;
+	}
+
+	hci_dev_unlock(hdev);
 
 	/* If the "connectable" instance flag was not set, then choose between
 	 * ADV_IND and ADV_NONCONN_IND based on the global connectable setting.
@@ -2058,18 +2149,10 @@ int hci_enable_advertising_sync(struct hci_dev *hdev)
 
 	memset(&cp, 0, sizeof(cp));
 
-	if (adv_instance) {
-		adv_min_interval = adv_instance->min_interval;
-		adv_max_interval = adv_instance->max_interval;
-	} else {
-		adv_min_interval = hdev->le_adv_min_interval;
-		adv_max_interval = hdev->le_adv_max_interval;
-	}
-
 	if (connectable) {
 		cp.type = LE_ADV_IND;
 	} else {
-		if (hci_adv_instance_is_scannable(hdev, hdev->cur_adv_instance))
+		if (scannable)
 			cp.type = LE_ADV_SCAN_IND;
 		else
 			cp.type = LE_ADV_NONCONN_IND;
@@ -2197,9 +2280,13 @@ int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 	if (hdev->adv_instance_timeout)
 		return -EBUSY;
 
+	hci_dev_lock(hdev);
+
 	adv = hci_find_adv_instance(hdev, instance);
-	if (!adv)
+	if (!adv) {
+		hci_dev_unlock(hdev);
 		return -ENOENT;
+	}
 
 	/* A zero timeout means unlimited advertising. As long as there is
 	 * only one instance, duration should be ignored. We still set a timeout
@@ -2229,6 +2316,8 @@ int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 					       secs_to_jiffies(timeout));
 	}
 
+	hci_dev_unlock(hdev);
+
 	/* If we're just re-scheduling the same instance again then do not
 	 * execute any HCI commands. This happens when a single instance is
 	 * being advertised.
@@ -2326,7 +2415,7 @@ static int hci_remove_adv_sync(struct hci_dev *hdev, u8 instance,
 int hci_remove_advertising_sync(struct hci_dev *hdev, struct sock *sk,
 				u8 instance, bool force)
 {
-	struct adv_info *next = NULL;
+	u8 next_instance = 0;
 	int err;
 
 	/* Cancel any timeout concerning the removed instance(s). */
@@ -2337,20 +2426,34 @@ int hci_remove_advertising_sync(struct hci_dev *hdev, struct sock *sk,
 	 * the current one. This can be the same instance again
 	 * if there is only one instance.
 	 */
-	if (hdev->cur_adv_instance == instance)
+	if (hdev->cur_adv_instance == instance) {
+		struct adv_info *next;
+
+		hci_dev_lock(hdev);
 		next = hci_get_next_instance(hdev, instance);
+		if (next)
+			next_instance = next->instance;
+		hci_dev_unlock(hdev);
+	}
 
 	if (!instance) {
 		err = hci_clear_adv_sync(hdev, sk, force);
 		if (err)
 			return err;
 	} else {
-		struct adv_info *adv = hci_find_adv_instance(hdev, instance);
+		struct adv_info *adv;
+		bool remove;
 
-		if (force || (adv && adv->timeout && !adv->remaining_time)) {
+		hci_dev_lock(hdev);
+		adv = hci_find_adv_instance(hdev, instance);
+		remove = force ||
+			 (adv && adv->timeout && !adv->remaining_time);
+		hci_dev_unlock(hdev);
+
+		if (remove) {
 			/* Don't advertise a removed instance. */
-			if (next && next->instance == instance)
-				next = NULL;
+			if (next_instance == instance)
+				next_instance = 0;
 
 			err = hci_remove_adv_sync(hdev, instance, sk);
 			if (err)
@@ -2361,8 +2464,8 @@ int hci_remove_advertising_sync(struct hci_dev *hdev, struct sock *sk,
 	if (!hdev_is_powered(hdev) || hci_dev_test_flag(hdev, HCI_ADVERTISING))
 		return 0;
 
-	if (next && !ext_adv_capable(hdev))
-		hci_schedule_adv_instance_sync(hdev, next->instance, false);
+	if (next_instance && !ext_adv_capable(hdev))
+		hci_schedule_adv_instance_sync(hdev, next_instance, false);
 
 	return 0;
 }
@@ -2827,10 +2930,28 @@ static int hci_pause_advertising_sync(struct hci_dev *hdev)
 	return 0;
 }
 
+/* Copy the instance identifiers in list order under hdev->lock.
+ * There are at most U8_MAX instances, with identifiers 1..U8_MAX.
+ * Callers can then wait for commands without retaining list pointers.
+ */
+static size_t adv_instance_list_copy(struct hci_dev *hdev, u8 *ids)
+{
+	struct adv_info *adv;
+	size_t n = 0;
+
+	hci_dev_lock(hdev);
+
+	list_for_each_entry(adv, &hdev->adv_instances, list)
+		ids[n++] = adv->instance;
+
+	hci_dev_unlock(hdev);
+
+	return n;
+}
+
 /* This function enables all user advertising instances */
 static int hci_resume_advertising_sync(struct hci_dev *hdev)
 {
-	struct adv_info *adv, *tmp;
 	int err = 0;
 
 	/* If advertising has not been paused there is nothing  to do. */
@@ -2847,15 +2968,20 @@ static int hci_resume_advertising_sync(struct hci_dev *hdev)
 	bt_dev_dbg(hdev, "Resuming advertising instances");
 
 	if (ext_adv_capable(hdev)) {
+		u8 ids[U8_MAX];
+		size_t i, n;
+
+		n = adv_instance_list_copy(hdev, ids);
+
 		/* Call for each tracked instance to be re-enabled */
-		list_for_each_entry_safe(adv, tmp, &hdev->adv_instances, list) {
+		for (i = 0; i < n; i++) {
 			err = hci_enable_ext_advertising_sync(hdev,
-							      adv->instance);
+							      ids[i]);
 			if (!err)
 				continue;
 
 			/* If the instance cannot be resumed remove it */
-			hci_remove_ext_adv_instance_sync(hdev, adv->instance,
+			hci_remove_ext_adv_instance_sync(hdev, ids[i],
 							 NULL);
 		}
 
@@ -3680,7 +3806,8 @@ int hci_write_le_host_supported_sync(struct hci_dev *hdev, u8 le, u8 simul)
 
 static int hci_powered_update_adv_sync(struct hci_dev *hdev)
 {
-	struct adv_info *adv, *tmp;
+	u8 ids[U8_MAX];
+	size_t i, n;
 	int err;
 
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
@@ -3716,9 +3843,11 @@ static int hci_powered_update_adv_sync(struct hci_dev *hdev)
 			hci_enable_advertising_sync(hdev);
 	}
 
+	n = adv_instance_list_copy(hdev, ids);
+
 	/* Call for each tracked instance to be scheduled */
-	list_for_each_entry_safe(adv, tmp, &hdev->adv_instances, list)
-		hci_schedule_adv_instance_sync(hdev, adv->instance, true);
+	for (i = 0; i < n; i++)
+		hci_schedule_adv_instance_sync(hdev, ids[i], true);
 
 	return 0;
 }
@@ -5932,7 +6061,9 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 	if (!ret) {
 		hci_dev_hold(hdev);
 		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
+		hci_dev_lock(hdev);
 		hci_adv_instances_set_rpa_expired(hdev, true);
+		hci_dev_unlock(hdev);
 		set_bit(HCI_UP, &hdev->flags);
 		hci_sock_dev_event(hdev, HCI_DEV_UP);
 		hci_leds_update_powered(hdev, true);
@@ -6076,8 +6207,10 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 
 		cancel_delayed_work_sync(&hdev->rpa_expired);
 
+		hci_dev_lock(hdev);
 		list_for_each_entry(adv_instance, &hdev->adv_instances, list)
 			cancel_delayed_work_sync(&adv_instance->rpa_expired_cb);
+		hci_dev_unlock(hdev);
 	}
 
 	/* A delayed work whose timer was armed before close would queue
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6ed3bf6f173851fc0a3d72c05c85547726b5b1e9..c8cb8fb12ed19cff389ceede1e1803d48cacab57 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2347,6 +2347,9 @@ static int mesh_send_sync(struct hci_dev *hdev, void *data)
 
 	timeout = 1000;
 	duration = send->cnt * INTERVAL_TO_MS(hdev->le_adv_max_interval);
+
+	hci_dev_lock(hdev);
+
 	adv = hci_add_adv_instance(hdev, instance, 0,
 				   send->adv_data_len, send->adv_data,
 				   0, NULL,
@@ -2381,6 +2384,8 @@ static int mesh_send_sync(struct hci_dev *hdev, void *data)
 		instance = 0;
 	}
 
+	hci_dev_unlock(hdev);
+
 	if (instance)
 		return hci_schedule_adv_instance_sync(hdev, instance, true);
 
@@ -4019,22 +4024,34 @@ static int user_passkey_neg_reply(struct sock *sk, struct hci_dev *hdev,
 static int adv_expire_sync(struct hci_dev *hdev, u32 flags)
 {
 	struct adv_info *adv_instance;
+	u8 instance;
+
+	hci_dev_lock(hdev);
 
 	adv_instance = hci_find_adv_instance(hdev, hdev->cur_adv_instance);
 	if (!adv_instance)
-		return 0;
+		goto unlock;
 
 	/* stop if current instance doesn't need to be changed */
 	if (!(adv_instance->flags & flags))
-		return 0;
+		goto unlock;
 
 	cancel_adv_timeout(hdev);
 
 	adv_instance = hci_get_next_instance(hdev, adv_instance->instance);
 	if (!adv_instance)
-		return 0;
+		goto unlock;
+
+	instance = adv_instance->instance;
+
+	hci_dev_unlock(hdev);
 
-	hci_schedule_adv_instance_sync(hdev, adv_instance->instance, true);
+	hci_schedule_adv_instance_sync(hdev, instance, true);
+
+	return 0;
+
+unlock:
+	hci_dev_unlock(hdev);
 
 	return 0;
 }
@@ -6633,12 +6650,15 @@ static void set_advertising_complete(struct hci_dev *hdev, void *data, int err)
 
 	instance = hdev->cur_adv_instance;
 	if (!instance) {
+		hci_dev_lock(hdev);
 		adv_instance = list_first_entry_or_null(&hdev->adv_instances,
 							struct adv_info, list);
-		if (!adv_instance)
-			return;
+		if (adv_instance)
+			instance = adv_instance->instance;
+		hci_dev_unlock(hdev);
 
-		instance = adv_instance->instance;
+		if (!instance)
+			return;
 	}
 
 	err = hci_schedule_adv_instance_sync(hdev, instance, true);
