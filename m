Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415900;
	b=wSdwhPbV4reWgY7GkMpsSfcHGZrSIr2llkdqEJmvojtpDoFwVbwv3s3avry5AxUFnxiC
	 s8A/BJesdZAZ1zGGMSVEJewaBmUEM+0HB6zCJUf+czaLQtPEBGgD2jlSFlbdonfZpAAEt
	 KfpnD/7ejBd2H3LtNpqXDVFsFNpreRoAOKcpiU9X+iknAILoA2/mwpc4LpsDdjHeUzLbq
	 74YrzvbKTCy9Nx7JKS+k2HuwP03iDIMKs6/GEpHTSo80MREcR1djsHgMPrPbuW9EE6led
	 7+ipE5aPl1TEo5c81UseNK05ofPhIUqqvWA8R9Zvhzt0XTLC82/oPTMKA8ai0HVXLQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=TgPQedwOORB1ASwbuFoQCs4fDden9LVH1kJnjIwXYCM=;
	b=a+UuPTuaBzmXXBgI/qZ4OuDvb7AbncdP+NdMya69SYkc1bFjpn2o4I7IRMFSuKCnkZcv
	 W7DKzbj4jnx3yEnwsPbSk7XfPjXnJbWuMmuPeFZEn+7xNUqwKoXgvjM9VG8KXJId+zidR
	 nsMQ+USePLhzOaKix1HHZzYsV5WBlnySRF4RvykyZKo6+z3zGO7kqegjlxTx4pijqrbQR
	 w2zTI1G8OHbYjuPV6qqVJl2HS0lf2OGlBY0H5B3VizCgEVee+Jc9+iLTSSvoFyg/R0eMa
	 A4ZBLbPaeimEWwwQYgXb686mZtgi/IyNXkiQbozfogS+zADNUIy2YwvYGpErkq80KxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JxglTF5w;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CC1606A33B
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4CC1606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JxglTF5w
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3712b6d9843so3289181eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415899; x=1795020699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TgPQedwOORB1ASwbuFoQCs4fDden9LVH1kJnjIwXYCM=;
        b=JxglTF5wON4DqQ36nFpxCFKDq1ZGAEQHZYNTpg0y8qGlh7uGQqqRlkPReEwR4Wnh0V
         VIeVUlmNceISS2hL87zaBf7a6nFA+TTLHnHIlOwo0DRDYy9lZ+MX8vg/oODD900S+iX0
         hnUX/oRwrbabogdt0LjLFxoMSuXmJwY5HZraeRXabl5gnydACQGiW4VaLHDK8kTnH7wE
         xg60Ld/7GSp5YX1oSo7LvV3DLVfIcql+/rGWX3OxV782yEVvM15kURyBtZbQp7MOMZpl
         bcmBoywFHpUW3BI5tYoSEP+NpEJpj0Ug/0B7+aSKvY6KuaEBw9VAGjwOGKEQ0x8/Hzkq
         D06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415899; x=1795020699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TgPQedwOORB1ASwbuFoQCs4fDden9LVH1kJnjIwXYCM=;
        b=zaFcBP1AnpB6zg6pgoZxrdA53DXg4hVj3bB9xsSGzzPSUgsD3M4LyAVeK8DuDKaFDH
         MgVwRL3Jt/AxZV/mwDvZy5H7e3+yZDOLGeRkcLv60cCXd8fDXkJI64ggd1wFs1uMnpE+
         BL+ZVuEtT01Ze2gOCzKcjAkZa/5BVHFBa4kdMDP8ffKDqKKVveofCDLl1SIpQ7s49Hf4
         mWEJ+L7AhhXc0adKl0dOMwC53vGMmdqPgwkeyuOEuDjo+GOa6HgsW0qpG6k+a75gjlbS
         HeOH8f7jg/TD4Av06Pz3OOM61fZP79b2OR7QAH96xHiXizTzmGHePUVT7G+qSJB8U5E8
         yukg==
X-Gm-Message-State: APuU4Z87SuXsxwnL5Cw9l84qI/RUJNI3+lbModH0OwF9oqcDD0/1pOLq
	KxxgMhgLUSB+AbGzh5hpS+qq/CXXdw8qWQipV20B/K70sWiZgdtzHh+pgBILufUymBc=
X-Gm-Gg: AYBFou2n7OnI+0n/UUjxvUNo8uKq26GUhVjcjY02ZfnEwU7qwzVB7eLsqljQGJSGWwG
	9PbnuyKg20HMw3x8O1IwmvZGqdCSUSybnEwn3C/ZZYUVXJvP2/k7tjDWXNiImB2B73tcqo1+imG
	a/tiislwEKC7OgtdWGzRtZQOGbc5LWE/CzmGC8Y7SO4PeU+KQwN1nEQYrxJFtFqkST/4GDXyRcK
	MQIo25MSTA/UQG3UMv7kQiwOlfe5o6DVpIFbJhqPfVicUoTtEkLk3dn+b7fxtrvh9EJmz61iBEf
	QUaE7o98CsiZkz9kI4igh6cgBC3qlCY/6YV1+bnjGSA5itfW1IHDaF+T7IGLleo2MyPzHjGmS/i
	9JcpM5wSw8riWE0BH5lRQusgISbTFykRKJmWfIdEs5ouHFAqL4Zpm/IvExtxALWZXRQRLL8QFIm
	nBXikfqmDJ1iFGWjao7w8LXYCaU2thc356e8/AUbVkgN8QUyVcddY79kHiw7GDDUkcAmewY2Ef5
	m6p94aNqLDR7j5xpXrMy5sKEk5pdEqGMWTZsIEiLrXv52tHor4+PnlL0s9pJU2GJkxg44EXra8F
	Qq3Gnc/btzslPJU/gPj6+ztO38SdrdRnFcLF5JC3cBzjaq/tERTRVOrkxqq06dzOD9/UC5vit0d
	D
X-Received: by 2002:a05:7301:3f19:b0:36a:532e:4abe with SMTP id 5a478bee46e88-3768701e279mr4460320eec.35.1794415898447;
        Wed, 11 Nov 2026 08:51:38 -0800 (PST)
Received: from localhost.localdomain ([96.44.128.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060899asm17119793eec.11.2026.11.11.08.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:51:37 -0800 (PST)
From: Weihong Guan <weihong.guan@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Weihong Guan <weihong.guan@gmail.com>
Subject: [PATCH v3 0/4] Bluetooth: Advertising sets on a single-set controller
Date: Wed, 11 Nov 2026 16:51:29 +0000
Message-ID: <20261111165133.827594-1-weihong.guan@gmail.com>
X-Mailer: git-send-email 2.47.3
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

When the controller supports a single advertising set,
hci_add_adv_instance() gives instance 1 handle 0x00, the handle Global
Advertising uses too. The parameters, data and enable commands already
use adv->handle; these patches cover what still takes the instance
number for the handle: setting the set's random address, removing the
set, and the Advertising Set Terminated event (with a helper to free an
instance already found).

Changes in v3, addressing Luiz's review of v2's patch 3:

 - Patch 3 (new): hci_free_adv_instance() frees an instance already
   found; hci_remove_adv_instance() looks it up and calls it, so its
   other callers are unchanged.
 - Patch 4 (v2's patch 3): on an error, the instance found is freed
   with hci_free_adv_instance() rather than looked up again by
   hci_remove_adv_instance().
 - Shorter titles for patches 1 and 4 (GitLint).

Changes in v2, addressing the review at
https://sashiko.dev/#/patchset/20261023132421.1889022-1-weihong.guan%40gmail.com
(I hadn't seen it, sorry):

 - The instance is looked up, and adv->handle read, with hdev->lock held.
 - Patch 1: hci_cc_le_set_adv_set_random_addr() records the address of
   the instance numbered as the handle and leaves handle 0x00 alone, so
   instance 1's address on handle 0x00 went unrecorded. It is now
   recorded in hci_set_adv_set_random_addr_sync() when the instance and
   its handle differ.
 - Patch 2: hci_cc_le_remove_adv_set() looked up instance 0 for handle
   0x00 and left instance 1 in hdev->adv_instances. The completion can't
   tell instance 1 from instance 0, which MGMT's Set Advertising also
   removes on handle 0x00, so instance 1 is removed in
   hci_remove_ext_adv_instance_sync() once the command succeeds.
 - Patch 2: while Global Advertising is on it owns handle 0x00, and the
   controller would refuse to remove an enabled set, so only the instance
   is removed then.
 - Patch 3 (new; patch 4 in v3): the Advertising Set Terminated event
   finds the instance owning handle 0x00, the one enabled on it as
   hci_le_ext_adv_set_enabled() tracks, for the connection's responder
   address (which SMP checks), the instance re-enabled after the
   disconnection, and the removal on an error.

Tested again with v3 on a Raspberry Pi 5 (rpi-7.4.y, 7.4-rc2, with
net/bluetooth and include/net/bluetooth from bluetooth-next and these
patches) with a controller reporting one advertising set (LE Read
Number of Supported Advertising Sets = 1), btmgmt and btmon:

  - A non-connectable instance (a random address) starts: its address
    goes to handle 0x00 and the set advertises from it.
  - Removing it sends LE Remove Advertising Set for handle 0x00; the
    instance leaves the list (Read Advertising Features: none) and
    Advertising Removed goes out.
  - An instance with a timeout (btmgmt add-adv -t 2): the controller
    ends the set with Advertising Set Terminated, Advertising Timeout
    (0x3c), for handle 0x00; instance 1 is freed as found (patch 4), no
    LE Remove Advertising Set is sent, and Advertising Removed goes out
    for instance 1.
  - With Global Advertising on, removing instance 1 sends no LE Remove
    Advertising Set, the instance still leaves the list, and the set
    keeps advertising for Global Advertising.
  - A connectable instance from a random static address
    (force_static_address) on handle 0x00: Advertising Set Terminated
    for handle 0x00, LE Secure Connections pairing completes (DHKey
    Check both ways, so the responder address is the one advertised),
    and after the disconnection instance 1 advertises again.

Built with W=1; checkpatch clean but for the Assisted-by tag.

v2: https://lore.kernel.org/linux-bluetooth/20261111010940.728149-1-weihong.guan@gmail.com/
v1: https://lore.kernel.org/linux-bluetooth/20261023132421.1889022-1-weihong.guan@gmail.com/

Weihong Guan (4):
  Bluetooth: hci_sync: Set random address on the set's handle
  Bluetooth: hci_sync: Remove an advertising set by its handle
  Bluetooth: hci_core: Add hci_free_adv_instance()
  Bluetooth: hci_event: Find the owner of a terminated adv set

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 24 +++++---
 net/bluetooth/hci_event.c        | 42 ++++++++++----
 net/bluetooth/hci_sync.c         | 94 +++++++++++++++++++++++++++++---
 4 files changed, 132 insertions(+), 29 deletions(-)


base-commit: def8a484b8883cd21d44a2a45702dcced9bf2627
-- 
2.47.3

