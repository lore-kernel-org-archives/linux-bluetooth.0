Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370478;
	b=GDLNtLtIMVvYKj4FzJyDqKegmojyiYi88i7ouxWyh1OMGOdVm71ucGR9dGOZbVo/+udK
	 B+Ar/KLuLq4bYYAPRnulhtHXimAF9etOLHDLNPuRKBWrGoO1eA6lNJzZBkRqZJnr0TqUQ
	 rM0w9Tlq+9asAz4JxvSu1pfCm8cM9BaiK3g6gFOW9iuWBh+lABaGNOl8bRVSX0vvMWF6D
	 49sXMQB7W4ln5OHaTLDxv9O6aJv5w06Mw+nvrOBoXTFWhmGap1YHe3GdanYd4a/8+Yz1t
	 XgCaVPqDWtTMluCA0pi6KQf7WlN5Bu5atliuLCcA8WuOBgmJTBBvKvL9tqTup3p8ZBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bkGqT/nR1oKIP28+lJ4yafQPuCGjN47Z5Ipned2fXRg=;
	b=YPK37E55ndnm0tFjq+cUOCT29xmgbm7fEVL/u64ymfUBthiPg9o1YMOOUUGz67zeawGK
	 JHD/A7JHN4JZN92s/gWUiOBgG5AuL/gAqMoygV28u1Npa3c8+0UbGw/pHH5TUVTe+FN/n
	 I6+CEQ+PlorEktIZx6+KINNv3OPG8S04m4qptsmBX7yZy8jVzvYSrBhODIPPukbLlraD9
	 w7TZ80l95Wl8GRI/ch07NBrXrV/nwvc2hWUsNvyHxDdv3n64HM+LrkIUh6WHnXMha8iGX
	 tO/BNftmcoq4yv7MdzwcCke13gP7qH2jxtUo+1gTfgFbJNZSOS4MP92JoG8ZERnFTPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oepWNleX;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4794606A31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 14:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4794606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oepWNleX
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a06e79e152so393332b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 07:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793370477; x=1793975277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bkGqT/nR1oKIP28+lJ4yafQPuCGjN47Z5Ipned2fXRg=;
        b=oepWNleXM+fk/Ka8KBqkYWqudSXv3HHQ8qPjE6VbcwxHD9STGyCdgut36hbQRoJ5FR
         MgChR7PTml7apmgcDJuZJHTAH6sGKSMkvFT8sEkehCUuOkPqFjDSXI/jCEgxSGofdOBo
         GoCxNEeQD3mvlhfp15zV+iW5OBndPwi/GiLqLu78kG/JAA6rh4BYa/8KdIjzBp6udEl9
         /VHCeZN/PviA9YLU0JoaEMHnfCGdl9hskXXwH8t2CNAreE2gTIkqx6zcY4gE6rLRNjQa
         2CysIv8qGi0OMIgTJm0bclUO7Ly45LvhHXUz8hlKD3ikg2d68kWxbxIHSDfKuWjScGjr
         PhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793370477; x=1793975277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bkGqT/nR1oKIP28+lJ4yafQPuCGjN47Z5Ipned2fXRg=;
        b=PK08KySRVUm8AHRiVOgPZJjyMefeOZMyGJw8u8Evq/7TmYtAGddHw2lxdcfSkTHiKj
         nW6YpD1mPYfwJOtadn0Nw3PEr5RZ8i+ke4Nvy6P3BUMqWQUtR4PzvnnAaUmivHBHVBJy
         TR5vuSkIG1eiGTYMYNNXIjGTm4ukPqcS2b6JpwGsdboolrJ2GEXLY+9Whp50ryeMiIqZ
         LTnu1X6Dbt+6ELx7ajU/6XQcCWbeKtO8qwbCPwlFqsLz/9OimG9lnIPeltckgjGJoKDa
         2TP97qHi3IoK8r6uOAZyjfu45S0HNwlmeJRrPBDi8OESMjMZ1j+Jz7pq8wfp2dUhCynG
         vw0A==
X-Gm-Message-State: AFq9FYLLCREwPtClyiQB7QKRG1dYYWW61yo6CTsd1s+lwJq0gyroes5B
	ZbCis+YvN1unFrwK6csAhbDsKOzG9cEOXYUNClWFM96x3JVCKvNMKVoL
X-Gm-Gg: AYBFou2321lvGO/pkuHp3GF2dDozkKgN2FzvTMNcsTTSqtf44I0MvD8qxLJ+xBWpaAz
	FCpMvCgrbrAQeLZtp4dRa/yMyCizmEpMkYCeNdWT74FlsuKDP06LoLYpOyHlD6S9blAdt+M133Q
	BKC+Jnbwm6zKl0T55YtkBjHYcui/gm9Vj+PRx3CJdzNTSbeMOPmXINZhfnpnL4Zx2mum/nXD0cp
	N6M/JBbUKWatrR+KErtw4DiytD45OZgNCnvqi2R3jw1rIhEbFJGtmVB99M9JGq/8TnCbzg8IPnS
	A6ey7y5BW5nXyyy9/XCm4Ggf3bNosR7dCelsNK+qdeiBhct0ZVOnnyV7vexRdF9P9DNXyp97xy+
	tb71N50r0HmB39gXxGvYKo/SfvNrCuKx0ZuAURNgYe1nPFEJAU85zNXf2PP+Jt++Ij6u/x6rgWT
	SQjhNdLWXm43Rbxz5dBNWXjOkWJAIiUU1AkK3Kuzr6+Ujz0yvL3FUHVvIZtwZ6QOuERY8gEDWiw
	oaeWVHxHPT5ej8H7SQpCVkspFfu9GNrfIciYC6BbheIw1intvBXERYcOjIaICDKZswKlW8vdUIu
	I5bYT5OJje2xIDvMDCtLy1lvNI4ZA1nY6VlM2E+Agh66Zg==
X-Received: by 2002:a05:6a00:1393:b0:899:27b5:214e with SMTP id d2e1a72fcca58-8a9bed5ba40mr1861555b3a.30.1793370476994;
        Fri, 30 Oct 2026 07:27:56 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad43ab44asm74093b3a.0.2026.10.30.07.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:27:56 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 1/2] Bluetooth: hci_sync: Fix remaining advertising instance UAFs
Date: Fri, 30 Oct 2026 22:27:44 +0800
Message-Id: <pm-bluetooth-objects-candidate-0245-v9-6b34bc036455ad3dd4ea-1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0245-v9-6b34bc036455ad3dd4ea-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0245-v9-6b34bc036455ad3dd4ea-0@gmail.com>
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
   hci_remove_ext_adv_instance_sync(), the periodic advertising enable
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
Keep the next instance as an instance number. Walks that send no
command hold the lock, as hci_clear_adv_sync() does. The resume and
power on walks send a command per instance and cannot hold it, so they
copy the instance numbers under the lock first, as commit cac164b6246f
("Bluetooth: hci_sync: Copy the LE accept list under hdev->lock") does
for the accept list.

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
Assisted-by: LLM

 net/bluetooth/hci_sync.c | 296 +++++++++++++++++++++++++++++----------
 net/bluetooth/mgmt.c     |  34 ++++-
 2 files changed, 252 insertions(+), 78 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9d71ce96bd8ec..72533236ee819 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -489,7 +489,8 @@ static void cancel_adv_timeout(struct hci_dev *hdev)
 int hci_clear_adv_instance_sync(struct hci_dev *hdev, struct sock *sk,
 				u8 instance, bool force)
 {
-	struct adv_info *adv_instance, *n, *next_instance = NULL;
+	struct adv_info *adv_instance, *n;
+	u8 next_instance = 0;
 	int err;
 	u8 rem_inst;
 
@@ -497,12 +498,20 @@ int hci_clear_adv_instance_sync(struct hci_dev *hdev, struct sock *sk,
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
@@ -521,9 +530,8 @@ int hci_clear_adv_instance_sync(struct hci_dev *hdev, struct sock *sk,
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
@@ -531,12 +539,13 @@ int hci_clear_adv_instance_sync(struct hci_dev *hdev, struct sock *sk,
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
@@ -1214,16 +1223,26 @@ static int hci_disable_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
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
 
@@ -1236,7 +1255,7 @@ static int hci_disable_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	cp->num_of_sets = !!instance;
 	cp->enable = 0x00;
 
-	set->handle = adv ? adv->handle : instance;
+	set->handle = handle;
 
 	size = sizeof(*cp) + sizeof(*set) * cp->num_of_sets;
 
@@ -1374,14 +1393,21 @@ static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
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
@@ -1670,17 +1696,33 @@ int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
 	struct hci_cp_le_set_ext_adv_enable *cp;
 	struct hci_cp_ext_adv_set *set;
 	u8 data[sizeof(*cp) + sizeof(*set) * 1];
-	struct adv_info *adv;
+	u8 handle = instance;
+	u16 duration = 0;
 
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
@@ -1693,18 +1735,10 @@ int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
 
 	memset(set, 0, sizeof(*set));
 
-	set->handle = adv ? adv->handle : instance;
-
-	/* Set duration per instance since controller is responsible for
-	 * scheduling it.
-	 */
-	if (adv && adv->timeout) {
-		u16 duration = adv->mesh ? adv->timeout :
-					   adv->timeout * MSEC_PER_SEC;
+	set->handle = handle;
 
-		/* Time = N * 10 ms */
-		set->duration = cpu_to_le16(duration / 10);
-	}
+	/* Time = N * 10 ms */
+	set->duration = cpu_to_le16(duration / 10);
 
 	/* Track which instance owns the advertising set since the handle
 	 * alone is ambiguous when instances share handle 0x00, see
@@ -1736,11 +1770,15 @@ int hci_start_ext_adv_sync(struct hci_dev *hdev, u8 instance)
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
@@ -1809,11 +1847,15 @@ static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
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
@@ -1828,25 +1870,36 @@ static int hci_enable_per_advertising_sync(struct hci_dev *hdev, u8 instance)
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
@@ -1854,34 +1907,44 @@ static int hci_adv_bcast_annoucement(struct hci_dev *hdev, struct adv_info *adv)
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
@@ -1890,6 +1953,7 @@ int hci_start_per_adv_sync(struct hci_dev *hdev, u8 instance, u8 sid,
 				 */
 				adv = hci_find_adv_sid(hdev, sid);
 				if (!adv) {
+					hci_dev_unlock(hdev);
 					bt_dev_err(hdev,
 						   "Unable to find adv_info");
 					return -EINVAL;
@@ -1908,11 +1972,17 @@ int hci_start_per_adv_sync(struct hci_dev *hdev, u8 instance, u8 sid,
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
@@ -1920,7 +1990,7 @@ int hci_start_per_adv_sync(struct hci_dev *hdev, u8 instance, u8 sid,
 	if (err < 0)
 		goto fail;
 
-	err = hci_adv_bcast_annoucement(hdev, adv);
+	err = hci_adv_bcast_annoucement(hdev, bcast_instance);
 	if (err < 0)
 		goto fail;
 
@@ -1940,8 +2010,11 @@ int hci_start_per_adv_sync(struct hci_dev *hdev, u8 instance, u8 sid,
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
@@ -1971,6 +2044,7 @@ int hci_enable_advertising_sync(struct hci_dev *hdev)
 	u8 own_addr_type, enable = 0x01;
 	bool connectable;
 	u16 adv_min_interval, adv_max_interval;
+	bool scannable;
 	u32 flags;
 	u8 status;
 
@@ -1978,8 +2052,25 @@ int hci_enable_advertising_sync(struct hci_dev *hdev)
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
@@ -2013,18 +2104,10 @@ int hci_enable_advertising_sync(struct hci_dev *hdev)
 
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
@@ -2077,8 +2160,16 @@ int hci_remove_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 		return err;
 
 	/* If request specifies an instance that doesn't exist, fail */
-	if (instance > 0 && !hci_find_adv_instance(hdev, instance))
-		return -EINVAL;
+	if (instance > 0) {
+		bool exists;
+
+		hci_dev_lock(hdev);
+		exists = !!hci_find_adv_instance(hdev, instance);
+		hci_dev_unlock(hdev);
+
+		if (!exists)
+			return -EINVAL;
+	}
 
 	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_REMOVE_ADV_SET,
 					sizeof(instance), &instance, 0,
@@ -2109,9 +2200,13 @@ int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
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
@@ -2141,6 +2236,8 @@ int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 					       secs_to_jiffies(timeout));
 	}
 
+	hci_dev_unlock(hdev);
+
 	/* If we're just re-scheduling the same instance again then do not
 	 * execute any HCI commands. This happens when a single instance is
 	 * being advertised.
@@ -2238,7 +2335,7 @@ static int hci_remove_adv_sync(struct hci_dev *hdev, u8 instance,
 int hci_remove_advertising_sync(struct hci_dev *hdev, struct sock *sk,
 				u8 instance, bool force)
 {
-	struct adv_info *next = NULL;
+	u8 next_instance = 0;
 	int err;
 
 	/* Cancel any timeout concerning the removed instance(s). */
@@ -2249,20 +2346,34 @@ int hci_remove_advertising_sync(struct hci_dev *hdev, struct sock *sk,
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
+
+		hci_dev_lock(hdev);
+		adv = hci_find_adv_instance(hdev, instance);
+		remove = force ||
+			 (adv && adv->timeout && !adv->remaining_time);
+		hci_dev_unlock(hdev);
 
-		if (force || (adv && adv->timeout && !adv->remaining_time)) {
+		if (remove) {
 			/* Don't advertise a removed instance. */
-			if (next && next->instance == instance)
-				next = NULL;
+			if (next_instance == instance)
+				next_instance = 0;
 
 			err = hci_remove_adv_sync(hdev, instance, sk);
 			if (err)
@@ -2273,8 +2384,8 @@ int hci_remove_advertising_sync(struct hci_dev *hdev, struct sock *sk,
 	if (!hdev_is_powered(hdev) || hci_dev_test_flag(hdev, HCI_ADVERTISING))
 		return 0;
 
-	if (next && !ext_adv_capable(hdev))
-		hci_schedule_adv_instance_sync(hdev, next->instance, false);
+	if (next_instance && !ext_adv_capable(hdev))
+		hci_schedule_adv_instance_sync(hdev, next_instance, false);
 
 	return 0;
 }
@@ -2732,10 +2843,33 @@ static int hci_pause_advertising_sync(struct hci_dev *hdev)
 	return 0;
 }
 
+/* Copy the instance identifiers under hdev->lock, in list order, so that
+ * the caller can walk them while waiting for HCI commands to complete.
+ */
+static u8 *adv_instance_list_copy(struct hci_dev *hdev, size_t *n)
+{
+	struct adv_info *adv;
+	size_t i = 0;
+	u8 *ids;
+
+	hci_dev_lock(hdev);
+
+	*n = list_count_nodes(&hdev->adv_instances);
+	ids = kvzalloc_objs(u8, *n);
+	if (!ids)
+		goto unlock;
+
+	list_for_each_entry(adv, &hdev->adv_instances, list)
+		ids[i++] = adv->instance;
+
+unlock:
+	hci_dev_unlock(hdev);
+	return ids;
+}
+
 /* This function enables all user advertising instances */
 static int hci_resume_advertising_sync(struct hci_dev *hdev)
 {
-	struct adv_info *adv, *tmp;
 	int err = 0;
 
 	/* If advertising has not been paused there is nothing  to do. */
@@ -2752,18 +2886,27 @@ static int hci_resume_advertising_sync(struct hci_dev *hdev)
 	bt_dev_dbg(hdev, "Resuming advertising instances");
 
 	if (ext_adv_capable(hdev)) {
+		size_t i, n;
+		u8 *ids;
+
+		ids = adv_instance_list_copy(hdev, &n);
+		if (!ids)
+			return -ENOMEM;
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
 
+		kvfree(ids);
+
 		/* If current advertising instance is set to instance 0x00
 		 * then we need to re-enable it.
 		 */
@@ -3585,7 +3728,8 @@ int hci_write_le_host_supported_sync(struct hci_dev *hdev, u8 le, u8 simul)
 
 static int hci_powered_update_adv_sync(struct hci_dev *hdev)
 {
-	struct adv_info *adv, *tmp;
+	size_t i, n;
+	u8 *ids;
 	int err;
 
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
@@ -3621,9 +3765,15 @@ static int hci_powered_update_adv_sync(struct hci_dev *hdev)
 			hci_enable_advertising_sync(hdev);
 	}
 
+	ids = adv_instance_list_copy(hdev, &n);
+	if (!ids)
+		return -ENOMEM;
+
 	/* Call for each tracked instance to be scheduled */
-	list_for_each_entry_safe(adv, tmp, &hdev->adv_instances, list)
-		hci_schedule_adv_instance_sync(hdev, adv->instance, true);
+	for (i = 0; i < n; i++)
+		hci_schedule_adv_instance_sync(hdev, ids[i], true);
+
+	kvfree(ids);
 
 	return 0;
 }
@@ -5597,7 +5747,9 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 	if (!ret) {
 		hci_dev_hold(hdev);
 		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
+		hci_dev_lock(hdev);
 		hci_adv_instances_set_rpa_expired(hdev, true);
+		hci_dev_unlock(hdev);
 		set_bit(HCI_UP, &hdev->flags);
 		hci_sock_dev_event(hdev, HCI_DEV_UP);
 		hci_leds_update_powered(hdev, true);
@@ -5740,8 +5892,10 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 
 		cancel_delayed_work_sync(&hdev->rpa_expired);
 
+		hci_dev_lock(hdev);
 		list_for_each_entry(adv_instance, &hdev->adv_instances, list)
 			cancel_delayed_work_sync(&adv_instance->rpa_expired_cb);
+		hci_dev_unlock(hdev);
 	}
 
 	/* Avoid potential lockdep warnings from the *_flush() calls by
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3cb4f9ece83cb..d8b1b9b241eb7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2341,6 +2341,9 @@ static int mesh_send_sync(struct hci_dev *hdev, void *data)
 
 	timeout = 1000;
 	duration = send->cnt * INTERVAL_TO_MS(hdev->le_adv_max_interval);
+
+	hci_dev_lock(hdev);
+
 	adv = hci_add_adv_instance(hdev, instance, 0,
 				   send->adv_data_len, send->adv_data,
 				   0, NULL,
@@ -2375,6 +2378,8 @@ static int mesh_send_sync(struct hci_dev *hdev, void *data)
 		instance = 0;
 	}
 
+	hci_dev_unlock(hdev);
+
 	if (instance)
 		return hci_schedule_adv_instance_sync(hdev, instance, true);
 
@@ -4013,22 +4018,34 @@ static int user_passkey_neg_reply(struct sock *sk, struct hci_dev *hdev,
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
@@ -6610,12 +6627,15 @@ static void set_advertising_complete(struct hci_dev *hdev, void *data, int err)
 
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
