Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010722;
	b=rzlmPJdQRB9wI5vpqOiBTntr/1kbqGDgTc4n4i5VmllfbqaAlHrSmFX2whnyUF76pikP
	 LUuehCz0Mdl3Kk/W7ustcAcf4sLFL6T3er24PEWUEta2xrHUOi2hVIF/YHw9PY6ZJaLq4
	 mexmVwHNj+1hbMOrHpCf3jT+04QCvO/0DQ1vRECfvrfBO/g1SsZFP0NfYkoVwTXNEX+GD
	 XqWaEZXYVb5CxTkNrMXY7g99CFzRPrvlYtU/bIZxpI6eCJkoMC9g4LupStIaiaF0d3D/b
	 0yIPtGiZqaRyv0erHaU0/YzqwWDb7PTATAvhfmamwtwE6DMgDZPHOhKXk3dQ3txxJxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7ijcgDjpR5WcpKIl+TW9FAYwC2/LS8BlAdbVYLxS328=;
	b=EPqupEUwGZCI9g7kMHL/Zg8IVFb6296X+M2ozlJRUCtnbjEwUV/xjWOwZj9+LQlnwNvu
	 cUjydHQF6hrU8YOJniqmXS2Ud8uFeyjZ+4kP4oOqGUbcBA1y5lHaRz8KN3oFKpOSjXDtQ
	 1x5a3Z2zR68rNDwYBlxBxHANfg0xIQT4QD+26qkT9i4t6D/98EBCoMeBL/lhEzssRHllY
	 6jiPrjf/JeOjFNjxZdvbTencNdEL8XngNaraCigCvur088aetL9kXzn+w81y9oClu3MHX
	 970Vh5DAcoXSnxdxbjEkmD14AwpRv2gjjZR2gjJamdTfknA4ypIfzhjNPXlkvySMylg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rdDFGt8t;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47EE606A32F
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 14:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D47EE606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rdDFGt8t
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7d2dc1ac787so303618137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795010721; x=1795615521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ijcgDjpR5WcpKIl+TW9FAYwC2/LS8BlAdbVYLxS328=;
        b=rdDFGt8tDi2DoNw9o9OtYK9goEnZMy6FzIGqJT6B6KQRAAqFd6oXAM08SBb812HSxq
         wVG/ZrL5Wxr+R3tujEgM5c5XupGWo7g8nAyf+ZIOrCSz5tfVzOxbYck9rjpude5Z4EB6
         rOAJivTromvHyJRPllF+YGCUIyLqq0IHGt9IhMKE2p64b4O5+kiRiYbUgOzi8DXUKdf7
         mIXvg1R+D8ojQnIvP3Y+n/7yYCRWZufwmU0Ac0QIpLc/3K/WGZnrQP8SiWvBkoF3icm0
         7vNFT8DgyxibU2KlexZCgEOPZJibzF6Q6DtjBdn6PdgPmlJbLm9MdTYHcCh6yeNw5MPv
         jqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010721; x=1795615521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7ijcgDjpR5WcpKIl+TW9FAYwC2/LS8BlAdbVYLxS328=;
        b=sPbJMoT6c4X1XiDfxSQVEAMrX9xxgyKW+YtuTbsEmavMVKjxXbzH5dE5NuN6b5vmkB
         dlUQjeoAXaYWnnbXvy1LNEca1F9iI9MOsAs99wCah0lfEnS+UaXD7n46iaJX/691dmID
         /yVVJREPqKNVaqnlY0KEgbpgSNvvmL9XCcwufwu+5294ykxtIUoIXprlPNPu3ticmgN7
         8icIIYUmakqntANKefens2KpA5xHAsnOxwDXhMyauirY3XXmp2S5LW7DDCng3+WdWZGf
         kL+/GOKVFFbskcwlp1fQPoQWVw0Sp7fKUoe8O7rRxF4h+Kc/98yR+S/90Wyd4iJcLx5Z
         Wfzw==
X-Gm-Message-State: APuU4Z8+m5y4OwLqLnOHVfn7149VWQCvRCU5I+6tbQBuWRK+GeICHs4r
	fZtKaktWT37t7KdFopvVHD/YZj40ZBcEYE93RdAdepmBwZGMAiieRAEV6t/u02Cc
X-Gm-Gg: AYBFou2E4mUGYN+OvM0+6p9c+iyVoKBkjpoqu/g7lsUpIz7Px0c8s4wMXH7t+IMsitM
	Uu182D9DrV+YVo3Lyhf+DJ6QvNiN0cSnuUeZy0+BEXC79nta9kofYR9KD1j++KUe3sk0UYecI0+
	TMF9srgE0n56Dx15dOLPuqk78ZPA9RGwMIg2GX69d+4CPyl4gMGFfIjpvVZ9Yir/F5ETs3LxlC+
	K6vMVGxyQgFonDysOqnwPZNMEJMPYGJUU3+YmymuW2nOsOi8SAFXjYqTyRZEgGXZnEgwFjQMFE/
	RIApzAhl+FyCDoyxYgqwOx8R5sCYvsnBTMfkV6yVg9pPn5EJdh9XAYZUINTT7Jwh71sg1C78CBO
	U/oK9a7wi/Qk00tufPCzjlwiqjaTHzsyOvaFIYkH7iwOe3nmMNFpeI+nlQxhqhYg1b+oWkum1oO
	Og7KQ2w4KhuNRbhpTM1DiyP08mGY8AtGmSQ8/WXm7/v8AFkgni0BkGawj2748uA18+igt9dGQ0R
	4OItuMRKYOCgPCqoJFh5HqmQyOlD4r85xLJ/RrwhUYoaNBOp4UV3leGOpn7q7I+uWhOrSLcqnXB
	OSpsjd9FJrWsP01xGsBVBCWu0cJXLZ9+CA9HVmNccf2a80saNOsGAGkAmHHJy0el1xy9WCzw4e8
	ac1fb7K9BXMd/FZRIQrycMnfosTtmAVGcBy44WuzzEy/w762OjiRjD0jks+BWk4PT4eqzQ7EbJJ
	Cna9A=
X-Received: by 2002:a67:e113:0:b0:7d2:a019:b42a with SMTP id ada2fe7eead31-7d6ba48d83dmr693015137.32.1795010719953;
        Wed, 18 Nov 2026 06:05:19 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b914e10esm1697639137.3.2026.11.18.06.05.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:05:19 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 00/17] Bluetooth: Fixes for issues reported by sashiko.dev
Date: Wed, 18 Nov 2026 09:05:01 -0500
Message-ID: <20261118140518.59878-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This series fixes issues reported by sashiko.dev against the Bluetooth
core, each patch carries the identifier of the report(s) it addresses in
its Reported-by tag.

Missing locking around shared state:
 - Patch 2 takes hci_req_sync_lock around hci_powered_update_sync() in
   hci_power_on().
 - Patches 3 and 4 look up advertising instances under hdev->lock in
   hci_disable_ext_adv_instance_sync() and
   hci_schedule_adv_instance_sync().
 - Patch 5 serializes the writers of hdev->link_keys. smp_notify_keys()
   runs with the l2cap channel lock held, which is ordered after
   hdev->lock, so this adds a dedicated hdev->link_keys_lock instead of
   taking hdev->lock there.
 - Patch 13 protects the MSFT event prefix with hdev->lock.
 - Patch 15 holds hdev->lock while looking up and freeing advertisement
   monitors.

Lifetime issues:
 - Patch 11 reworks the mesh transmission handling: mesh_pending and the
   advertising instances are accessed under hdev->lock, the cmd_sync
   entries carry the transmission handle rather than a pointer to it, the
   first transmission is always the one being sent, cancelling one stops
   the done timer or dequeues its done entry if it is the one in
   progress, and the transmissions left are flushed when the controller
   is powered off.
 - Patch 12 reads the pending Set Powered command under
   mgmt_pending_lock in mgmt_powering_down().
 - Patch 16 frees the response of the MSFT add/remove monitor commands and
   initializes the RSSI fields of the handle data when it is created.
 - Patch 17 doesn't fail removing a monitor the controller doesn't know.

Missing validation:
 - Patch 1 sizes the Read Index List reply from all the controllers.
 - Patch 6 checks hdev->smp_data before using SMP_DEV().
 - Patch 8 validates the length of the sent LE Set Extended Advertising
   Enable command before parsing it.
 - Patch 9 rejects a zero multi advertising rotation duration.
 - Patch 10 only uses the EFS option in l2cap_parse_conf_rsp() if the
   response carried one.

debugfs:
 - Patch 7 stops force_bredr_smp from creating the BR/EDR SMP channel
   while SMP is not registered, and serializes smp_register() with it.
 - Patch 14 sets/clears the debugfs controlled flags and quirks
   explicitly rather than toggling them, and serializes the writers.

Changes in v3 (addressing the sashiko.dev review of v2):
 - Patch 11: the cancel callback no longer clears HCI_MESH_SENDING, which
   let Mesh Send requeue a cancelled transmission still at the head of
   the list, the canceller clears it together with the removal. The
   transmissions left are now flushed, and the flag cleared, when the
   controller is powered off too, not only on index removal, and Mesh Send
   no longer reports the completion of a transmission whose handle
   userspace wasn't told about because queueing it failed.
 - Patch 16: also initialize the RSSI fields of the MSFT handle data when
   it is created rather than once the command completed.
 - Patch 17: fixed the Fixes tag, it is 7cf5c2978f23.

Changes in v2 (addressing the sashiko.dev review of v1):
 - Dropped "Bluetooth: RFCOMM: Serialize tty device reparenting", the
   review found that it is incomplete (hci_conn_del_sysfs() also moves the
   device, and shutdown moves it before closing the DLC), a proper fix
   needs a shared lock with hci_sysfs.c.
 - Dropped "hci_sync: Take req_sync lock in interleave_scan_work()" and the
   change to hci_abort_conn_sync() from the earlier revisions, they were
   not correct (the former can deadlock with cancel_interleave_scan()).
 - Patch 4: fixed the Fixes tag, it is cba6b758711c.
 - Patch 5: debug keys are removed by reference with hci_del_link_key()
   since a lookup by address skips blocked keys and would leak them, and
   the comment and commit message about which callers may use the
   returned key were corrected.
 - Patch 7: smp_register() is now called with hdev->lock so it can't race
   with smp_unregister() and smp_force_bredr().
 - Patch 11: restored mgmt_cleanup(), the previous change could sleep in
   atomic context (it runs from the socket destructor) and can't run for a
   socket with pending transmissions anyway since they hold a reference to
   it. HCI_MESH_SENDING is now only cleared together with the removal of
   the transmission, the first transmission is the one queued, a failed
   queue no longer strands the remaining ones, a done entry already queued
   is dequeued on cancel, and the index removal clears the flag.
 - Patch 14: also use assign_bit() instead of change_bit() for the quirk
   attributes.
 - New patches 16 and 17, found by the review.

Not addressed by this series, also reported by the reviews and left for
follow ups: the unlocked LTK/IRK accesses in smp_notify_keys() and
hci_add_irk(), the unlocked advertising instance lookups in the callees of
hci_start_adv_sync(), hci_enable_ext_advertising_sync(),
hci_remove_advertising_sync() and hci_enable_advertising_sync(), the
cur_adv_instance race, the double list_del() of an MSFT address filter and
the RFCOMM lock ordering and device_move() races.

Testing: v1 was run with KASAN and lockdep enabled through the BlueZ
testers (mgmt, mesh, smp, l2cap, rfcomm, iso, ...) and test-functional
(which found the lock ordering problem with hdev->lock in patch 5 that
led to hdev->link_keys_lock). v3 was build tested (W=1, each patch) and
run with the same configuration: 68 passed, 1 skipped and 1 error. The error is
rfcomm-tester reporting a possible circular locking dependency
(rfcomm_mutex, hci_cb_list_lock, hdev->lock and the flush of the hci0
workqueue in hci_release_dev()), none of the locks touched by this series
are part of it. It is not caused by it: the same kernel testers run on the
base (without the series) failed the same way in one of two runs.

Luiz Augusto von Dentz (17):
  Bluetooth: mgmt: Fix read_index_list() buffer overflow
  Bluetooth: hci_core: Take req_sync lock in hci_power_on()
  Bluetooth: hci_sync: Lock the lookup in
    hci_disable_ext_adv_instance_sync()
  Bluetooth: hci_sync: Hold hdev->lock in
    hci_schedule_adv_instance_sync()
  Bluetooth: SMP: Serialize link key updates from smp_notify_keys()
  Bluetooth: SMP: Check smp_data before using SMP_DEV()
  Bluetooth: SMP: Don't create the BR/EDR channel while unregistered
  Bluetooth: hci_event: Validate sent command length in LE Set Ext Adv
    Enable
  Bluetooth: mgmt: Reject zero multi advertising rotation duration
  Bluetooth: L2CAP: Don't use uninitialized EFS in
    l2cap_parse_conf_rsp()
  Bluetooth: mgmt: Fix mesh transmission locking and lifetime
  Bluetooth: MGMT: Fix use-after-free in mgmt_powering_down()
  Bluetooth: MSFT: Protect the event prefix with hdev->lock
  Bluetooth: hci_debugfs: Fix racy toggling of debugfs controlled flags
  Bluetooth: hci_core: Hold hdev->lock when removing advertisement
    monitors
  Bluetooth: MSFT: Free the response of the monitor commands
  Bluetooth: hci_core: Don't fail removing a monitor unknown to the
    controller

 include/net/bluetooth/hci_core.h |   6 +
 net/bluetooth/hci_core.c         |  81 ++++++++-
 net/bluetooth/hci_debugfs.c      |  32 +++-
 net/bluetooth/hci_event.c        |   9 +-
 net/bluetooth/hci_sync.c         |  26 ++-
 net/bluetooth/l2cap_core.c       |   5 +-
 net/bluetooth/mgmt.c             | 302 ++++++++++++++++++++++++-------
 net/bluetooth/mgmt_config.c      |   6 +
 net/bluetooth/msft.c             |  61 ++++---
 net/bluetooth/smp.c              |  58 ++++--
 10 files changed, 454 insertions(+), 132 deletions(-)


base-commit: f42f5cae154b90a0cb6d8232dc84c7614ca2e6a0
-- 
2.56.0

