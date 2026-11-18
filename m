Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017557;
	b=h5pGsU7bqc2Oeje5Rts9xsl/w86iJUdH5y9Lw7Z49auoRxWV4GqkSxNmW7G30XU6r4E2
	 Lt+4rYLBqrlTwmqv7iHI9X6MaD79RYpIoVQzL7z2XbtA2WcAh15z937/Hf8SjpdaiHm3M
	 wWwhkFluIUAl2Dr8mtymXtbbyj6H1CcHD5jVyNk+DD76Kw94+crEkGny9FwqwDTT+vW0l
	 UcIGVXPG2Tt5G5qU6zFligMRFWxuE0S4nWa1ovA4XUyHM9pM3YV0/gOC7r+Bx0CX3YEWA
	 F7U7iaiPvoI56lNxIccuKtb9relLCivYHpGHkWwfz6PjnJbocx18qjpyTHdzlO5qGQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017557;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=HVSZVQGWUp1Pc2E4bD9kb2xqf5vBXB6yOSTRAwVK4Tg=;
	b=5pmMbvcigZc/7RI3yg9ESj9Gum9NRLtAm8M09LTaaVs2S85bk4z1OV1ayd8JXVIbqZbv
	 mnIbcWYiBdCEqeuou6gMJkL740z2hF9oo/UovStae+/MgHu6tT+F/MEkxRfLiU/QV2zwI
	 XseXQA9P3vwmRYSCRNoik4kzg0tkSyi0mitjaCHlo+KJzDxZAiN5WGXb7FDiSXrgVHWke
	 D75jFCpaoOXkDAfF17cCev9q5R4R9Ik1K/fwaWEraO0pQzf/o6QqvkdBVJSZUD6tMNpPK
	 k0iSDkuU7zwtUKPLMuMhNfDjT3btn4BRDWiL5HNeFmK024QqBmC4Dz4QCEDHxvhHjiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hLPclnQe;
	arc=none smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86637606A331
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 15:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86637606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hLPclnQe
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5eac6c5f927so423831e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 07:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795017556; x=1795622356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HVSZVQGWUp1Pc2E4bD9kb2xqf5vBXB6yOSTRAwVK4Tg=;
        b=hLPclnQe5RZM0CzNYLbQBYiR1rbv8OIYliCKdY4McC+e0wIsxATi/bu1JEA/A/J4lT
         HkDHdX3zrcuxBdiHlo6MF25Ryvul6jtaa4rHJ7G7Fn8MNYzTEGAs8z5uJOOcpnceBtuU
         IBTzor8O18KphCvGRGfIskOP65PtMfJF63jCemIEQbGG6kTBd/f+l9PcBeu7fAhul7sD
         XR6RUEP/e/IMNdhFhRuCV74f8wZuD200vmWlm0XnIaHHqoMl5QKhYcVsZNajVPLIsInk
         6JAcTuNoQAmAS+l1GNrsPD+2UIWnespo4IYepk1rn3bQ6YXJtBF5j8XpxFfIJO5ICpR0
         lz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017556; x=1795622356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HVSZVQGWUp1Pc2E4bD9kb2xqf5vBXB6yOSTRAwVK4Tg=;
        b=DSsbsx9gfuNiyMHbrQTt3/rddnguSHWjb2m53Vz3G3+BAjLAHLt9i1O0S3DEE2QV7q
         LRi42sLkPQvsfmlQyWZLgLuhJGVgqIIzYXKvJixjlckQlzFtz65L3Z+YFcqG2MBGN3JE
         XgB17uQA5tMgqwHDt5ITYT0GwJ9J8KLU91imEK7AuOBwUCghuDNS/hELRxwMqhXCN13h
         e0OUQsKOVep04kMkb6G8VZUj0bhUNywN89ox5VQ4y0JL/C+IuYHFC8MlAEmd8mPJzgrx
         ReSkV6ZsdVTEDPs76D/4xp7v5wbqwiOJM1ZCJYZnDuNNrmrmtG2KXr8vi/myLZJIl+3u
         qgXw==
X-Gm-Message-State: APuU4Z8NM8DRpnDj6mJtrF0b1LgBnKAObeBHi6jxznr9YOSKVLLUVWI6
	b9i/FlctHc3dKbfhAbHUlTcr5ByOjDduYp0V+8Bfu+SK9nSba7W/Fj8bLHJWWLj+
X-Gm-Gg: AYBFou13nrzNtpRc7DxI6+/lQXh5QZeXpjczkvaOO3ejRiuvRJ/zGVpvKgMLeysAQkT
	tzs8jusN3Vkiksw2VxNERk7wCAFwaSS4fvJIBwb41ydQnPKZf3wUCVTQ7US+e7+25B2ajxdzKbT
	Rrxq6WM6myP6xHIWdkR6/LOf4yxY5wiLGghWLlX4xSq/0DP/2BHgvSf4KSPmyPylyyRJNEsVlNZ
	j4Z0URdViqudHWIoEZlteoANv9jNVInGb0I5ykbXylGp6D1/nBsZNWYwb/sz3J6fa5aSSNLrdX9
	3tJjdn0w3bJPpyJoljdLbaOEyabgEbfVpbcyboj+sB4ZBSR45PQ0XWaCtejltbwz86ypyl2J0ob
	NL0qRH2jsRhxCoDxjl1VxM9zqL53X8ohCLcQdodNHEepkibYgoGZw16tKjL24Low+IGpraBhtyR
	teFFjXOvYldSbiPm4qmAnf+3X0PN0EJfmH78ih9dQssho6hUNgdJ3aTTCthkwCLPgUCIgJ3NLlB
	Zrf2D3SZunmy54E1wgFQqicOb0Tj3YO5VajjQyDLRoM1mXYw/t9nHmd6qtcsXN5+TOMzYuM71C3
	CHAhIscVlFreAszdfGoWFS0FZCXD9Nn53ilLk3v2it8MiSdEM7hGbfAnjE5lJfF/Rlel9rpbxEj
	84crhb/1/izg6O9MwEEf7O5RudMlBycfvWDrDsuwWTDi6O9RHZ2BS1icMQBDrRijaqm15LPn44Z
	OHak8=
X-Received: by 2002:a05:6122:62f2:b0:5ee:b4a:681f with SMTP id 71dfb90a1353d-5ee6476127bmr1315614e0c.20.1795017556115;
        Wed, 18 Nov 2026 07:59:16 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64e4dfe3sm1919266e0c.5.2026.11.18.07.59.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:59:15 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 00/17] Bluetooth: Fixes for issues reported by sashiko.dev
Date: Wed, 18 Nov 2026 10:58:57 -0500
Message-ID: <20261118155914.178050-1-luiz.dentz@gmail.com>
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

Changes in v4 (addressing the sashiko.dev review of v3), all in patch 11:
 - The transmissions left are flushed when the controller is closed, also
   when it is auto powered off, not only from __mgmt_power_off(), and the
   entries still queued for them (mesh_send_sync and mesh_send_done_sync)
   are dequeued so they can't act on the transmissions started after the
   controller is powered on again.
 - Mesh Send is rejected with Not Powered when the controller isn't
   powered, serialized with the flush by hdev->lock, so it can't queue a
   transmission that nothing is going to send.
 - mgmt_mesh_add() doesn't reuse the handle of a transmission still pending
   when the counter wraps around, now that the handle is what identifies a
   transmission, otherwise Mesh Send Cancel could cancel the transmission
   of another socket.

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
led to hdev->link_keys_lock). v4 was build tested (W=1, each patch) and
run with the same configuration: 67 passed, 1 skipped and 1 xfailed (the
expected failures of mesh-tester, whose "Send cancel" tests are flaky and
pass, or not, with or without this series). Earlier runs had rfcomm-tester
report a possible circular locking dependency (rfcomm_mutex,
hci_cb_list_lock, hdev->lock and the flush of the hci0 workqueue in
hci_release_dev()), which doesn't involve any lock of this series and
happens on the base kernel too.

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

 include/net/bluetooth/hci_core.h |   7 +
 net/bluetooth/hci_core.c         |  81 +++++++-
 net/bluetooth/hci_debugfs.c      |  32 ++-
 net/bluetooth/hci_event.c        |   9 +-
 net/bluetooth/hci_sync.c         |  31 ++-
 net/bluetooth/l2cap_core.c       |   5 +-
 net/bluetooth/mgmt.c             | 325 ++++++++++++++++++++++++-------
 net/bluetooth/mgmt_config.c      |   6 +
 net/bluetooth/mgmt_util.c        |  23 ++-
 net/bluetooth/msft.c             |  61 +++---
 net/bluetooth/smp.c              |  58 ++++--
 11 files changed, 502 insertions(+), 136 deletions(-)


base-commit: f42f5cae154b90a0cb6d8232dc84c7614ca2e6a0
-- 
2.56.0

