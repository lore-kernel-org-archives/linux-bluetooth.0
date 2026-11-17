Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941861;
	b=bbYvk27i6m6H8cCDQnEGSyYX6MtSudEvKplLi7KeilgupoqkhIOi9mBjPszxBfJarKst
	 fw7Iq8Q27L9O29uVANqyFTz+8SpT0EtAhIlagxO523tVnWFj9N9nHJlXKvGgz75CONFfQ
	 j0c8DHe7Oje1nTa9FR+D8A/F7tPaJvyWExsLIch0J3NyKoYgCUCADkaAIy/wl9LH6e5sx
	 jHSROWml/IbJrC/NhYJETv+pfMOpF6sHtJvN7vvgZeDHMpWSwta8Seya6QL47wLlGS/r1
	 zBtliLoSSL5VrEzVZOcaGfXYIWcgT44pC5k8DIP70iIZDpLcRO82X/U4MODMn0MkFSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941861;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=esMDnGoMsB6OQEO+DkvTm5pnjpTNe+GodEVLBAYkUdU=;
	b=2k1giUjBziU2G76BFqcgCvnkmAY1vO5f6vkUTaCc/bwvqRAVR3EUuJWCZWiBBS30MPip
	 HazQoqA3i0UkDZjwP63w49RZVhDLMfOPzm18MWNxWmTkgS+bQRZg6NiHQos0U6UQby+Rg
	 4nNM6/Ouv4AM3ta8ngSypXs7Y7CpynPWTmVY0Wprzi/btkvPLy8Rjj/JXOQ3//KSP0Mjw
	 dqqrboZ7dH8xiG64YUprYo/Suu+6ev1SP6L/Y+heBDnXyM2WvuzANPDvEJ7rrAhDPx90O
	 ZKFaLiun0Nxnkme9yBERlzRfNtLOz937uXMc/HfLYFbRshVP/Vc4JwcQ4nHlNi6xxIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hATBpFNS;
	arc=none smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A899606A886
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A899606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hATBpFNS
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-97ca72f2cd9so90318241.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 10:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794941859; x=1795546659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=esMDnGoMsB6OQEO+DkvTm5pnjpTNe+GodEVLBAYkUdU=;
        b=hATBpFNSxzJWnaT+O4azkUAVQTUJGx2IP/poT/hEb3VWaT3r+cs0UkimP4Pucti+Q8
         9bsVUK+11KIaZeOXEkaBEMlY0FmUyy+jJJvydV5MD/Ocus8fBafVfMuwqizwJgVETs/m
         pQ5RLdfFK/I8d2+Myaip7dGvYWT2Agk/v5QbNnsLPXE7suDdawH7yEBkQfphMhMczV/M
         9mAHX10/xE9w6t5xZjKNV4CI3wGgo6IN6n8VYcwQNCrntOHK94/NmFAxVTiCANJKIRC1
         yuR/lf+JxGE5NcXY6jmKl3ri+Q49CAh11OPKknDqSTqLcM2E1B2vz5q7Srd83SPgN6hL
         S8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941859; x=1795546659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=esMDnGoMsB6OQEO+DkvTm5pnjpTNe+GodEVLBAYkUdU=;
        b=ysdPvpPxdkGfpc6gBDZzh3iDmiBzcCIvM8uzT0FvS9K8V2W/uvl7Qbn4hdN8wQ+4IR
         CT2oy2FSc5eAmZHqRWUWjESx6UCyjkqvC+ZBgQHYWvoAmCr1Na8yICJr0dZCXvu1lYfg
         sbvjO/ag7WURkry8tGPfDDFhGUZ9LIkbND6lAX3gP0zl+LXxvHVvDnX/01ndFWg8SirT
         mPrZxzVX466djx8buDrx4C2UhcrS3SGSgd07ipvrIhWrGQnqfDMcvbeH7YmqoztLITP/
         jxlxJhNp2lOvF/5gQbggHCzQPYv+AOdz7Ok2WBQ1QkVShnTH2HPIecorZn3m7QZhf9Sv
         dWeQ==
X-Gm-Message-State: APuU4Z9A8Uds1+DuljvNr7XQNZ7t++Cn1+TfEkbBlDkyb6IXQE4ZrCRx
	5V978uYVSvYfck/rboW92HF3Z4QTwDE81hvnSLtOgRiWZTrjFHGTdOfp78EyRA==
X-Gm-Gg: AYBFou3B+SbbROdxXaOTKC3It8F362oqBft1v+2blzTYUFP7CgiF2IDEWPrhWF+Vo/B
	d8AWEib2rh5XE6yhn+mDwOvKlna5TtM2K1A9AIajvEame9NbZ4eW+Cwvv9SLY5/u4kJlv/2TxfL
	rrmJHbZQWHw5EaBFl26J5X8V5i6J9hnfyqksDvL9+oZXNC8rSeABv+XpxCIDPIZbGzuW2Pw+N/n
	WT7UXRUgCAuNLcEmye6xwuASuZ3ZIP8Z6BlJjxSaKMUudbcRIsh3tH0+ufLdIh9QbaPKXI2cXPC
	cECAq+mgCYRRJQdRcgdGDVVaFvIiGidTyNozcSqIwraujBWUFTVzHw4Jwpd+BdiB8V01JUD6lPR
	oa1YG2qevCy2oQqI5zjzPMCek2KNfh56hrd9gtM2tL69YKzsBkGo4TjTTcnbrX9g1HJ3COO8elQ
	1IV8SKHVdhkRXRp3obLk0EQnql+91E0Bd1whurIkJDN4Wg0yNZnYl8VD5iZXlj6leEijSIMAyBV
	K1/nVGmHJSmb6fjs93g/TsIo76MxOolMiAkr7yg3TBKRlGBdNh5fYIRJ4APuK4kx7uiBVOVceEj
	mjetOl9ZVer53G9q8wFQOvyxzfuo9lGpBk0oMv/Iriy7GUDeNAyq3BD0Rm60IGtqrm+gDs+77m5
	v4Z3sXuyn/QWQurxvMor5iubPihhPxoXp0QqhNlvDBvx6L0h/lDNdvFvjiPdjgnaZOgk8sdlhMV
	malq4=
X-Received: by 2002:a05:6102:32d2:b0:7cc:56a:58d3 with SMTP id ada2fe7eead31-7d64d8b0045mr6320995137.31.1794941859468;
        Tue, 17 Nov 2026 10:57:39 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a1b61eesm357064241.3.2026.11.17.10.57.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 10:57:39 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 00/16] Bluetooth: Fixes for issues reported by sashiko.dev
Date: Tue, 17 Nov 2026 13:57:21 -0500
Message-ID: <20261117185737.3758255-1-luiz.dentz@gmail.com>
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
 - Patch 16 serializes the reparenting of the RFCOMM tty device.

Lifetime issues:
 - Patch 11 reworks the mesh transmission handling: mesh_pending and the
   advertising instances are accessed under hdev->lock, the cmd_sync
   entries carry the transmission handle rather than a pointer to it, and
   Mesh Send Cancel and mgmt_cleanup() cancel a transmission the same
   way, stopping the done timer if it is the one in progress.
 - Patch 12 reads the pending Set Powered command under
   mgmt_pending_lock in mgmt_powering_down().

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
   while SMP is not registered.
 - Patch 14 sets/clears the debugfs controlled flags explicitly rather
   than toggling them, and serializes the writers.

Known limitation: in patch 11, if the done timer has already fired when a
transmission is cancelled, mesh_send_done_sync() can still complete the
next transmission early.

Testing: an earlier revision of the series was run with KASAN and lockdep
enabled through the BlueZ testers (mgmt, mesh, smp, l2cap, rfcomm, iso,
...) and test-functional. This revision, rebased on top of bluetooth-next
with patch 11 reworked, has only been build tested (W=1, each patch).

Luiz Augusto von Dentz (16):
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
  Bluetooth: RFCOMM: Serialize tty device reparenting

 include/net/bluetooth/hci_core.h |   4 +
 net/bluetooth/hci_core.c         |  54 ++++++-
 net/bluetooth/hci_debugfs.c      |  30 +++-
 net/bluetooth/hci_event.c        |   9 +-
 net/bluetooth/hci_sync.c         |  24 ++-
 net/bluetooth/l2cap_core.c       |   5 +-
 net/bluetooth/mgmt.c             | 262 +++++++++++++++++++++++++------
 net/bluetooth/mgmt_config.c      |   6 +
 net/bluetooth/msft.c             |  29 ++--
 net/bluetooth/rfcomm/tty.c       |  21 ++-
 net/bluetooth/smp.c              |  58 +++++--
 11 files changed, 406 insertions(+), 96 deletions(-)


base-commit: 3c5963d23d64972385786e0be47be16d89ff4434
-- 
2.56.0

