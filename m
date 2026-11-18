Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029082;
	b=f3fC7WWLrgQyRPvhdotjrfModIJw7DgVarHyGPojhUD6EkdGJKf6qNPV6C8F23ryP81H
	 58SWF3NO8NHozSpNBFe+9pdw4L7p4B8wzKAlXESqtiLVpCibiyNIotFty4M4FbjUVccUy
	 JN2J6SfKfeQOabr8ViPzLvQacIvXI9yxXlBGd1HTxKgs/sJVinD2IcylrVvEoDuP9siMz
	 aFHSXGRtcloxxORVkR+IjWLuHfX15H7x3kYNmvermHW4Pu8WLB2KwLi65nH0DyMKsGYgl
	 HJ8jMQNZnMzXguLEE4EDc3xIZSn+aXqYM2TTBWLQDAcv0qvZHlDqEaRPb/M50jC4+ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029082;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8KonhWvBw19nL0H2O+EzQhAy8W9dOz2lQmr9jXZffyY=;
	b=hmAdKUUsW4OKZaNJ/+AIU8c/p98CpiYD3AbGFWlfcHMkp7mhc+21oNupB38PmgW8EKZJ
	 XIgaMPrm2n0hrr1L+hJQDSnmIHqgnr25O8x39b/Rt3gdhSxATnwjSbnbh7v9g1DsBH2ZV
	 8gKnU5Dqnwwel9krSL976sLsSLoS6j1t4QWCNJfXRGTUtUazt+e3xvK3hX6jYUZu2RrfB
	 t3207qkbyGWBn4Ve0UwR2J05qlewP29vHv/Zfxo/GK6pd3ZsKrOSG5WnM8Or9Kti+gXjG
	 44n6GGqpJFVmo9EY92OrGcqqe515olkwwUwSQFKUEd2cA5m3t1WE3K5znYhKkhDGKPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FvJBQMWN;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB87606A320
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CB87606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FvJBQMWN
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-77bf892b496so527367137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795029081; x=1795633881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8KonhWvBw19nL0H2O+EzQhAy8W9dOz2lQmr9jXZffyY=;
        b=FvJBQMWNrjDnpkfpsqyS2ugClbsL3ruJLnXtAsgdHLFQIUzQm4NUdY6ydajltdupXb
         6RJ3gr9nCfHuQiRsSB8hXEcPR2fJ5CJXdlZTqEcpmz5+yHnfntuC4yaS0poNVe4EPwM9
         ts1uclgNlzZDgkTLiLnRFNlmA2w81Ag2GU3KVBW2E4fY7Nw8n4Od1oC2bihkPcLtyOj/
         uvryoMoRhk2O6FdMpcUnZYtODRu9MaMXgThf6d56kBoSAZ4hHqizZh9tVV0IFP4ox9oG
         AZZxoGmonJtlxtCQ0+WaWIwkvJaykMcaOPuapBk8kSy8m5Qbzdh+aQcjgOFpC34EBKG2
         TMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795029081; x=1795633881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8KonhWvBw19nL0H2O+EzQhAy8W9dOz2lQmr9jXZffyY=;
        b=vmP3ZukAHWEHjnp0igMYidqeyoynxzd/3PrDdzhad8WPsPzDLisAxre+s/X7oyB+g8
         EL9CEbmGALarrTG7wBYUk2f0BxPhI++OfgrglIh9iNRyNcsM9IKbNEJaZxDBMY9YyW+T
         5nzWF/SqcDSjmrJ1IO5wPU+iMPisVdf5sVCWGSBJ8lGcMDQlIcY+ybh+BO3nJzcxmRqh
         oqUFB231/O/lBlDDPRgxAXZpmwk78Xtp3g7LqLbeXLItS5eQZL0wXJk7aruVcPqlwJYE
         u3tuXmHGINZ1MhMeN5MP6tAe4VHDFLzk88B+Di9zei86rhgtj+tSK9DMzVbjeGYvf+IA
         k+ag==
X-Gm-Message-State: APuU4Z9nbJP7/DEGbnV/aGMYRMesxlZyLJpD58xMlI49fE2d+2bXhMt2
	LE/ukrbqchIlUcXBtjet1x9cDKvd406dEGTiWGdrtqFkKpv9aPEZ8Fd0ZR7VmWtH
X-Gm-Gg: AYBFou3/5wxhJx4lg/7vsqvhTk1ztcrmD29CAnQAYo/t50gtt7IXaBgowRAD+/omQ2g
	43lphfXG56rpphtSUVbdXHOPE2J1nSlQfz17n2n9ktSLGdkUv5wLpHR5lLyHN3sUkof0phWMHVM
	tlPajh9i80GkkTCj9AQ//CSc4Js2+mx8Dd7cD+J2q2r6rko128z6quc+P+WCsx9kfrLjTvePszw
	+XuRq+aBwkO29MGkYOhNsWQq9dDgVJyIkXRwxMj2QcBafvSlyZTuYHE8ihPiX/Bh31yZtYhjNRg
	tkvcMc9T3RvcJP1zbUSWiLl88A0SxJ7LxqROlWd8jnd4w0eIwMYyBAZbyyU0evtSIMEAURhCsRi
	2WZ3cWJFgAerw3g/VDqQAL23c0KAULhy+GFeOJg53RVgiikz5/MNyH+VriCWD5sdSyRfY7ewNQR
	dSpqgCWh0TOSUbd6ptWteOTpkls9HirHSGKMU1RchHMgZXpKxQTap2JF0/5iOhTRERub/UcI39O
	/S+IkXNeW7SkbNeaZjPdur41QjXsAsSvDQ9l+gcheIDUtK02uRuulLUOa1o2sv7Ic2jZ+jLM/2C
	ts3NvVtjNJSMDLLFwGmcXhuN25soq50hzl7ZgT6m2vaMgEKhR9L5MVY8BgHe2iLHzNYaWGaBY95
	5uHnJd2OwYQKMWpgnT8WpP5pKzh8nTS+N01saN8U7KS6AOWQss2BBK5zWVeONXHD0aTc+EoEDeW
	AY3PVl+DY9y0yEPbunIG5UFdrf
X-Received: by 2002:a05:6102:548e:b0:7c1:6de4:9f67 with SMTP id ada2fe7eead31-7d6ba191141mr1342420137.2.1795029080772;
        Wed, 18 Nov 2026 11:11:20 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64c1801fsm2479672e0c.0.2026.11.18.11.11.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:11:19 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 00/17] Bluetooth: Fixes for issues reported by sashiko.dev
Date: Wed, 18 Nov 2026 14:11:01 -0500
Message-ID: <20261118191118.318779-1-luiz.dentz@gmail.com>
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

Changes in v5 (addressing the sashiko.dev review of v4), in patch 11:
 - mesh_flush() clears HCI_MESH_SENDING and stops the done timer before
   dequeuing the queued entries, otherwise a timer that already passed its
   HCI_MESH_SENDING check (it runs without hdev->lock) could queue
   mesh_send_done_sync behind the dequeue and have it complete a
   transmission started after the controller is powered on again.

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
led to hdev->link_keys_lock). v4 passed the whole test-functional run
(67 passed, 1 skipped and 1 xfailed, the expected failures of mesh-tester,
whose "Send cancel" tests are flaky and pass, or not, with or without this
series). v5 only changes the order of the calls in mesh_flush(), it was
build tested (W=1, each patch) and mesh-tester and mgmt-tester were run
again with the same configuration, with no warnings.

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
 net/bluetooth/mgmt.c             | 329 ++++++++++++++++++++++++-------
 net/bluetooth/mgmt_config.c      |   6 +
 net/bluetooth/mgmt_util.c        |  23 ++-
 net/bluetooth/msft.c             |  61 +++---
 net/bluetooth/smp.c              |  58 ++++--
 11 files changed, 506 insertions(+), 136 deletions(-)


base-commit: f42f5cae154b90a0cb6d8232dc84c7614ca2e6a0
-- 
2.56.0

