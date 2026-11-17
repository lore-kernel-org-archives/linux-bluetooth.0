Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946836;
	b=bKoiCdC+FdSydVBoZ17e2eOcQSAusCnM1VX1n0WNl7o9Y+Ot38pVdxn0HM+0+3H+qMcG
	 tgPJKX9PDACCIeQ+r8x688DeY8U042AAlWSRTW3QXbSunwHs44KbmT5tZfmjy0LOHocV5
	 gHPwwy4zvto4u9NJmQzg9hM3ST3wZWA/f0QiA5G8Ehf7+zMpazh9hzlAe2TV+HdHq2uOl
	 viYkRn+GA5QQSmIoJArTDYTYUxDXrX6A9/eXbXMz+zun7F1DMWGbg7vLjhoRGELd+k2kK
	 JIkisvsaJzcGB1Z4NcIJTGFGgK5qm+De7pIMNBEz7YGA+DBItSB6ruawRgnGrCr+Z7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946836;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Cdv1S9oXWyOsn5CrT/FV9+b1SGOThg4m5A3/OgnAwBk=;
	b=VrieaXsuxnucP8N8ZFbJVpy02HQ63z72ZpeU21rZ7J/clSBAP4QGLpIPBUyb7/lmjtBu
	 jLJ61w919DtZT0BSLic8Cf2i1SDQonedzNbW/SsPIzr6Rz1h8cznIIm0aK5uSiWav5ZI6
	 VjmYY8jbHTYfubnw1nGQPR4t/nbh9qo+Ha8sFJaO/5NroX080OvHS1PwI3Sz5wjkMz4mu
	 rpQsXEZtsiXUIvo71funo3i4O9Zj34A+M3f6cJhjLDX/3QHHnfxDJeGsab9r0ARqV0Bhk
	 ImD0XtJWmSrXY+eYHIPieKg5rhxJycHV8Zc9RpWSeILY+5AyM96OWXgCvchGxJGhnwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W6EJuqgv;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74D2606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 20:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B74D2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W6EJuqgv
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7d2bf046ceaso117459137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 12:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794946835; x=1795551635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cdv1S9oXWyOsn5CrT/FV9+b1SGOThg4m5A3/OgnAwBk=;
        b=W6EJuqgvA3HYmBbFP+VjwfOxZ4rZ6PVZem27+EDB7nDUPoFXguB5fmTfQMVtYGsWvy
         SQZlGktzKGdgx6xo4OdhOf0oaSdXTUOl3xO5jNbt/c5lcXP6AOkusWerfUSAcAfVVrIH
         HwRmfntOVk9g7kYeaZYTH4c7qIytfn/SFUCkgz+J+fG9HeD5lQnJn1/Kcxg0EYaCJ/42
         UMAToc/tiS+8fmk9+fYjEz5h4sRkre+lRWrPtVXLc/Uqzy66aYdVrmlMifG24i3jq3B3
         pnJVv4sdV/1MaaW2orSlUT89FntEKtV4qvhifiCCiPMHl/5imePZW4C522mnwV6HPdwJ
         VcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794946835; x=1795551635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Cdv1S9oXWyOsn5CrT/FV9+b1SGOThg4m5A3/OgnAwBk=;
        b=RtQJ6zlx0JqXGATWwt4tWQgGHWO18WXckNZYUmHLqrzLrP1lo660Gp5iYgsChIOgd8
         tzsJUZfPSUpIFXx0vKenZc2qr5C0hksohiqH+t07HjYvqK04+3Opn910sA64iR4w/wgd
         CNNBzEXfDXjnrOFy9KmK1aKp3GmlVwHGwgvxW8vyekeraIOjpaKflyLlnVmOAT0hjwFi
         A1gYuUz5+mFoz1CkGNQnwhCbEHe7vHtlz/cZWzYDftyf7oVGKkshGJxoLQxXjas9DD2y
         Q0rRkJLIMxTw7S38/v6Pt5v0h9beK8UkykGtw48Ev1Kyo4KrMDKCIgdvB+l8QTd/fOpM
         7mVw==
X-Gm-Message-State: APuU4Z/N2NBeFV9DzEw9ITQTm4MsWeFA6ABSG73WwHLUmST/kq21dohJ
	qaf4HmTGTdhsi0LfqCDTSYE/GDac4KJE0ruCAFlcjEdIhzebTwX/P622i4tb/g==
X-Gm-Gg: AYBFou2Zf/ymCR3aJ5qCa94J+a0Hhub1qMWo3ljXnliJpRt5UInlZUGQcg5HGxvA7s0
	qUjC29bU6NaTbGLBbQSx8eb7CUD2FX9uRyDFr+Nc13rIVjgtlDS1ZjOQbcfM2ZcvLb4qmCoGbrv
	sQjSd/hFQvr0KgHtOeZUELjt7jgiACPq8A58iW6Hwrq9GREjWsJcdB2/5pOyQLsrEN7fz1ASwP7
	z41jIwfksLKePWDYbr8EAsT/NnDalyFU0AY89Rw6eBCczN2DlWrOWtxmDrHjLnlcrinphIRg/s2
	OmCvL6SSLcVaHI23b2NJPUKzeMUm7esOKQahKuAQ7BE5tsT7v80NsnsydT4Ir5dUemW/uYbi+IB
	N/J5xh4CmSwj0zexTFZ72wQDvx7LlwkLYL6OZFG3gvoVvLFaEz2K7twhposfBMLBz18KgPerDrv
	gsV7icQG07Mg9lF/MusTDddhwteEKKq6eYTDSKB7jWI2uOqlU5UOBOw8glJgphl+dYbQFw/MEiT
	irDQ7TTUg8oRIVBKs/5ZrGCn8WewoANNjgpOaBNSz8st0QThKoSFlWgu76ppnjF3mm6vidQj/0O
	JoTueHZ74J+o0yn5jRFhNfgbLMlRrtDRPL8EQkdwlNDHDoEJOhkQQjMp2qyzuM2JGMp8GXVccrw
	tAjcIOiKitfYnXYoOAwVNQsIprDwTB8caxmU/m/h3vB+i5h40pWO/wAKqWt04W4x0+UkMTTEkfj
	3P+20=
X-Received: by 2002:a05:6102:441f:b0:7b3:32fe:77b6 with SMTP id ada2fe7eead31-7d6ba17358bmr84488137.3.1794946834629;
        Tue, 17 Nov 2026 12:20:34 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b935ddf3sm303166137.11.2026.11.17.12.20.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:20:34 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 00/17] Bluetooth: Fixes for issues reported by sashiko.dev
Date: Tue, 17 Nov 2026 15:20:15 -0500
Message-ID: <20261117202032.3848411-1-luiz.dentz@gmail.com>
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
   first transmission is always the one being sent, and cancelling one
   stops the done timer or dequeues its done entry if it is the one in
   progress.
 - Patch 12 reads the pending Set Powered command under
   mgmt_pending_lock in mgmt_powering_down().
 - Patch 16 frees the response of the MSFT add/remove monitor commands.
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

Not addressed by this series, also reported by the review and left for
follow ups: the unlocked LTK/IRK accesses in smp_notify_keys() and
hci_add_irk(), the callees of hci_start_adv_sync() and cur_adv_instance
without hdev->lock, the double list_del() of an MSFT address filter and
the RFCOMM lock ordering and device_move() races.

Testing: v1 was run with KASAN and lockdep enabled through the BlueZ
testers (mgmt, mesh, smp, l2cap, rfcomm, iso, ...) and test-functional
(which found the lock ordering problem with hdev->lock in patch 5 that
led to hdev->link_keys_lock). v2 has been build tested (W=1, each patch)
and test-functional was run with the same configuration: 68 passed, 1
skipped and 1 error. The error is rfcomm-tester reporting a possible
circular locking dependency (rfcomm_mutex, hci_cb_list_lock, hdev->lock
and the flush of the hci0 workqueue in hci_release_dev()), none of the
locks touched by this series are part of it. It is not caused by it: the
same kernel testers run on the base (without the series) failed the same
way in one of two runs.

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
 net/bluetooth/mgmt.c             | 285 +++++++++++++++++++++++--------
 net/bluetooth/mgmt_config.c      |   6 +
 net/bluetooth/msft.c             |  48 ++++--
 net/bluetooth/smp.c              |  58 +++++--
 10 files changed, 439 insertions(+), 117 deletions(-)


base-commit: f42f5cae154b90a0cb6d8232dc84c7614ca2e6a0
-- 
2.56.0

