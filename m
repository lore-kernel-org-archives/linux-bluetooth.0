Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048430;
	b=tiyOmeU6rfVylgDqr0e1W1EhHSIiEQPJX4tHlx9AtRiAuLFhrCTQVq+zK4d9du/GOHDl
	 Vnz8IObx/GAQ4AgBHudPPhnwa5SW2JoAb+lFpmajgnLEAKcZQNM9g+ZbXHsBeYe1NG0ap
	 PID0H5BgvZ7EKCVw2v58HJ9o5MnxO8aND2AkLg9zeMWzgts+00fYhd56ZYxhWhMtQVnZd
	 tvLQ7SnLZ71dMCgUsfVMdFBLlbpOihmFAlFGisdNXEtfff0GbQbI3+oe1PPXdb0Ibnk9E
	 3GuCIKxv4fLgjL6sMbSuhmnUCjPsC08fMCQGNr1Th8gfZEJtEykrgOSn6DQcgxfOUHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=P81WPXJmA8egwXU9Dmn1Codsx2X71Blt1Qj5CaLpdJ4=;
	b=PY4Pt025Q1883vOEveKflRFuqUTQM2IcbjUhq81mDt/mMvAMbfT3emTKu2ygpW7EpqKK
	 cFCsAtahvD6CDBqQ6o+Q8l4gPe/Q8041Zlh4uujJ0/MVW0OeXjGIpf/U1n/ajRWuEC+ri
	 VeSkggfCRMjuEioA1UE0FfNtNx/mq1VSvJrZPBNLhVdjwVjay5H8mG1qC3f4IS7y/UX/B
	 nubCEkvj5ORFUy5jkOKITYpglYlsr9+MUtn6IcYllo5jZVZYwlf5hlOO2gLX6XCrEDKxa
	 hUNgJ2aQ+FfiM4wF7kguCTJ9CrwuEu+NJdmVz7BYg7twCSc+/zB40h54PxajVQZwwmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I4+l74D3;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C1C606A339
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 00:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63C1C606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I4+l74D3
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a06cc097c7so1287883b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 16:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795048429; x=1795653229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P81WPXJmA8egwXU9Dmn1Codsx2X71Blt1Qj5CaLpdJ4=;
        b=I4+l74D3JqeHKDiZDmgA6lOAN8ebrJrL6BeJWSj67UxIfqZyLYnmJ0OOOg/fLEbwQx
         07CVizwSGQc/CvlqLDqZVh+AJPc9MTJ53zjq0MK3QrqNtEpLsLCY2LDqKl4LqrZx/+6X
         43wuyas2GJoJgXrEzNjUW7vfUgknxiYOlvHGs8+H9h+jS7F7ih9Ux3p0tmBgQBuTDK8A
         wWw4wjX9/fg9jT6sect00nTtvL4KstE5AlkpQvpsWJYSXLhS9KtQg9CKr0LPgz9m5JIM
         LkcMysQ4I7saR0AXWLNtn88uFXEpevILrNF6YZ0OpXClfgJ+mrCxhIUKGhb3B6T8GJtT
         /4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795048429; x=1795653229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P81WPXJmA8egwXU9Dmn1Codsx2X71Blt1Qj5CaLpdJ4=;
        b=EGAZn4E2Pm6cn75gRP9tTLpJ2UiWicuBDhGx4TgWFY/yv4ta5jVPUbo/9h4KOb1NKI
         HCBCPBBKYw7U9UMEpkZqOgpDM9ieHGkVqg3X/ayiA9NBRGEpVx44FAAgx/ZEUz6URbkj
         5UO5bxK+M0ezQOxHpzlO0anunB5xi6X0fhYqDGklHmh5Z0uTLpgEmXIoBZO686D5rhY0
         2OhG3lY7WMZgynX2bjfrcM/q5mR5Y9pTDfZ+8W+Auu0ztqWG1533i8ov/9o7ZI15EN/a
         CPmmzXlFsQ0dI7cKuvbhPdB+yZ8JbkVyC1TnAOrNpx6NKbfceXZDGSz0NLYBKtzoYNgw
         BxGg==
X-Gm-Message-State: APuU4Z98Ud6flAjf6NcKLP35alG4vfuPzzqfRlKs1upbFKRQbB6qg736
	yV21JIyCLUnPiksrwwUkOZs98iw3YFIJaQLf6rsz4NKpQfmLVlN3Lr+5
X-Gm-Gg: AYBFou3BzAjz7jlD7OCPjT6rqBXH3pqwflMfUZQ1crpAkLneLmb3NmtyfJ2kuxg1aqr
	6Qyk6gOnFpDyghDhY29V7N8Hx3GOoDWIJLsC/P/FEYkuc8fTYZiHDC+ETdiYbd5yslbb/s/0VRp
	ia1htYg1it85gCWYJyW24SA2x/jTc0CapV32C9YPFuVXbzN3ONNzPnUKIipMOBfjH9H90jzdoOi
	WVHkryHqEIHYKYmtz8pdNuosV57hoh7+Gmc/bsLAlVAOBtgRxoe6LxvvYOa0vSEIZVA9NotJlUd
	Zdr/jDBOnXrKqcVrQH33nCEBRmGiJtPVTdTr8vK1nL8MJNeraYBaydF/B/pW8phAPRiyL4QSfiD
	NLXk+09ggaKHbJvWdZO6OhBr2LfST2jCe3BU6S6g5wjkJ6kGQYCLEgHGVeLlC6S+n6fQK+0NrKf
	KUqZz8SO2wKzZ0DJh5wv7TzgdZUFjTJjMGVzYrkoBrfHswRSO/109M8MNGZ0D8K2NNLoXEgBcgH
	g//Ini4/VqajT+5kHBLCzjjXSPdjkfe0YBkdcDsvGSjjhtkJ1RAI/uLevgWt/MchonUcEj5Z5pj
	yUZsmXjc5BLHVoiVONX3bj72
X-Received: by 2002:a05:6a00:339b:b0:89f:3053:9ac1 with SMTP id d2e1a72fcca58-8c5d324b710mr3874029b3a.17.1795048428503;
        Wed, 18 Nov 2026 16:33:48 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5c7f99f91sm1906491b3a.5.2026.11.18.16.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:33:47 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v5 0/4] Bluetooth: SMP: Serialize root channel updates
Date: Thu, 19 Nov 2026 08:33:39 +0800
Message-Id: <pm-bluetooth-objects-candidate-0184-v12-e80229724d6ad14ca88c-0@gmail.com>
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

SMP root changes must serialize with their users. Publish BT_LISTEN only
after the root is initialized, under the global channel list lock,
so another controller with the same address cannot select a
partially initialized root (patch 1).

The force_bredr_smp writer takes hdev->lock and changes only its flag
while the controller is down (patch 2). Power-on holds the request lock
for its auto-off update (patch 3). Registration then runs on the ordered
HCI workqueue under hdev->lock (patch 4), excluding both HCI event users
and SMP receive callbacks from root replacement. Patch 4 depends on
patch 3. Patch 2's exclusion from power-on also needs patch 4.

The old mgmt_powered() called smp_register() synchronously under the
device mutex before submitting the HCI update. It did not run in the
receive worker. SMP receive callbacks began using root-owned OOB data in
March 2015, before the synchronous HCI update conversion that November.
The shared root transform use was added in September 2018. Patch 4
corrects that history and tags the earlier root-data access as well.

The WARN_ON() for replacing an already registered root remains. The
separate HCI_CONFIG auto-off shortcut issue mentioned in the review
also predates this series and is outside these root lifetime changes.

Validation: GCC modular and Clang built-in Bluetooth builds, including
Clang context analysis; every prefix and the combined tree with the six
new Bluetooth series build successfully. No new kernel runtime test was
run; the quoted reports are from the earlier instrumented test kernels.

I used Codex (OpenAI) to help write these patches.

Cen Zhang (4):
  Bluetooth: SMP: Publish root channels after initialization
  Bluetooth: SMP: Serialize forced BR/EDR channel changes
  Bluetooth: hci_core: Hold the request lock for the power-on update
  Bluetooth: SMP: Serialize root channel replacement

 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/hci_core.c      |  3 +++
 net/bluetooth/hci_debugfs.c   |  2 ++
 net/bluetooth/l2cap_core.c    |  8 ++++++
 net/bluetooth/smp.c           | 46 ++++++++++++++++++++++++++++++++---
 net/bluetooth/smp.h           |  3 ++-
 6 files changed, 59 insertions(+), 4 deletions(-)

---
Changes in v5:
- Move the AI assistance disclosure to plain text in the cover letter.

Changes in v4:
- Address the cross-controller root publication and powered-off debugfs
  concerns raised by Sashiko:
  https://netdev-ai.bots.linux.dev/sashiko/#/patchset/pm-bluetooth-objects-candidate-0184-v9-4094fa28af7bd56a283a-0%40gmail.com
- Publish fixed roots only after initialization under chan_list_lock, and
  change only the force flag while HCI_UP is clear.
- Correct the registration history and early root-data Fixes reference;
  state the dependency between debugfs and power-on serialization.

Changes in v3:
- Address the hci_power_on() path that reaches smp_register() without the
  request lock, raised by Sashiko: https://sashiko.dev/#/patchset/99158
- Add patch 2, which takes the request lock in hci_power_on() again, and
  correct the locking description of patch 3; the code of patches 1 and 3 is
  unchanged.

Changes in v2:
- Address the CheckPatch and GitLint long-line failures reported by the
  Bluetooth CI: https://patchwork.kernel.org/series/1197223/
- Trim the crash reports in both commit messages to the headline, call trace
  and allocation/free stacks; no code changes.

Link to v1: https://lore.kernel.org/r/pm-bluetooth-objects-candidate-0184-v7-c26e53b52c260063ab6a-0@gmail.com
Link to v2: https://lore.kernel.org/r/pm-bluetooth-objects-candidate-0184-v8-60106ad0c49170f5bfb4-0@gmail.com
Link to v3: https://lore.kernel.org/r/pm-bluetooth-objects-candidate-0184-v9-4094fa28af7bd56a283a-0@gmail.com
Link to v4: https://lore.kernel.org/r/pm-bluetooth-objects-candidate-0184-v11-900043ed2303656c76fe-0@gmail.com
