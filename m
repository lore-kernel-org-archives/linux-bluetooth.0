Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD3D35FF6C
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789843470; cv=none; b=TYzhBHn9UZkFIPxoS5LzH4JCrPCImtCj054zKR7yiu6+e021s/Sqhn26DN7f+L6u2392iaH+1nG9NrX5TPTNvTWBS8Do75bneAhuoOysonkIQfAcZSpNg4Xzcxcb59LC7WRnAI7srpNxDZyi8qym83L9Y8k8l78pUlfYDnskkdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789843470; c=relaxed/simple;
	bh=Znc/vy3/qsWoigHEXgnninJznSIPaL3UHJ8folVdmUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rqmP/V1i5SjHARflxjI4rRu1lEciBIvxkEByonDcdE/iwOUFjgIPR9WDQdKn38NbttgosQyuF6SE74cs89STMMH2S+J7uEGpq6RXNEBkwBitGOAkZuOcNybrKYqmcMujBzkxXyLrKe6y5TnyUH+C5YWwD5nEVl94J1cEocVJwoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuFD4ik7; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuFD4ik7"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48435bcf9d9so220864f8f.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 11:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789843467; x=1790448267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VNLYgccXtxvpEcfi2++5YEl/FfiiYtqVtCiqkCskk7Q=;
        b=WuFD4ik7Q/YZoaE5cfIITQlINWPvxeBW3l242OR0N4xIArVPlJ6JMMRx8u9MZo4ci/
         b3eZWgHgQnMd6ieGrCh0iiHj3/H6yxyYzu9YUQAtw3e4Hzwz2L2yeat0kSOu2BfR7y5j
         WeiCLjkTw2A1PZqEW5R9B35YYo4YBbvpotsrraJCk9lJh/z+I0lpkPntE8myIT6E4aYd
         fuPl5mxEdEOfnKdI0Aegj760J2OpWe9UnH9lMBh453vf7Qo6DMqXHaa5jhiNU+4QV7u1
         z/FP9ROmd9d+DZtp24FmhOaHvRsdsP2fHuTdXLhF4VxUWryDzgcerUdGeeQ7hcRLaewP
         myYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789843467; x=1790448267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VNLYgccXtxvpEcfi2++5YEl/FfiiYtqVtCiqkCskk7Q=;
        b=ARzaUK2GBONe5nxlYVLaqw/QaAjerVIrCoG0lsYRypIhxLZUqgsRSW8zCKfjrdw360
         3MrmRKKXAnKPwRx+4IsFKUaP8LAPtZf8AupQ6kGSBe/IDQa1BFJH1zmxjSm/r9sYrBsp
         bdXOpea03k9XIQdJRbk285poglrYgJZ1aecEG2w7NEFnpVE1oH9eBXwoXzILkcGfCtno
         GaRBYsj3iUwtijkv1hGwVi/+h9SwtkqHYa17mTH0QoI+8P+HAztZNF4niIrBKVTfLeWS
         kqOEcDV1U+yAL9ysAuh5atu8cc91EK5Eh01qjbITghRw/ZfKNh1VqqXqkgi6RbofrlWo
         yrLw==
X-Gm-Message-State: AFuF++npochDiVHeCRt+BdMr1YZ8nEBObAquXvWI/4wwZMpzaBCRCIfx
	0NZZhWeZhHJS+2l0Hn2IOt1ybr3tVn4S/2B+gSYYp4v6GyAVq4XXsMwfgo8zfHTn
X-Gm-Gg: AYBFou3GYuZ34sqiq7dtWeoVPfoYYOL15fwtbh8fbX/6e7KpX0VSCi2ZAVRtk7zTqvI
	Ijwb5t33IC3nIicBOluPmKL4E2GmUpqrQ2ogGeKnnn/AI9MU1mZGCA6SaK/GupqJr0ayrkD4DDM
	y6XazJ8hbjYSE+3UvkNDk7alzVHON6jFGOwrm1sCtayc9+WSVCIAD5Nt3lbZOoLeVgXg2mb3zMr
	fYOpzxgTUFU8TqMLfZnFwPAh7jvPcKrjyr0OJgzVDHzQjmDMYcqzEXfPgt20NHkzBE5XdTC9AX9
	2iOmTedogL7jDMHkJvEx9JBRNe05qrhIo12avoaL7ShM6jwvRLr2PUMC1Z0RfYLtKdrgiI2YwqY
	PLd+a4s5Z9zELfwz8WkJOiRenyJ0wdr3cld0ttVnMXqGp1GEL7e/G6L5OBSblECXSXdmbpPOONx
	JRXyVIQoMOTk5+2UUyxyIh2NlvFSLnRPncx3UlIfKBQ5tMUhV5qMEfSNsVWHPm72jWI5lfyyTGH
	Rsz738RHycT83A72e7wOwa3y5LcHgXrHG2eVO75uEFkvQAZZ8ejMBI=
X-Received: by 2002:a05:600c:3b99:b0:49e:6683:d227 with SMTP id 5b1f17b1804b1-49fc7bbfe4bmr87005855e9.0.1789843466899;
        Sat, 19 Sep 2026 11:44:26 -0700 (PDT)
Received: from localhost.localdomain ([194.36.104.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-487245a869asm8613109f8f.37.2026.09.19.11.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 11:44:26 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
Subject: [PATCH BlueZ] adapter: Fix crash on short start discovery reply
Date: Sat, 19 Sep 2026 20:44:25 +0200
Message-ID: <20260919184425.102314-1-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

start_discovery_complete() validates the reply length before using the
returned parameters:

	if (length < sizeof(*rp)) {
		btd_error(adapter->dev_id,
			"Wrong size of start discovery return parameters");
		discovery_complete(adapter, MGMT_STATUS_FAILED);
		return;
	}

but that check sits below the branch taken when the discovery client
list has emptied while the command was pending, and that branch has
already dereferenced the reply:

	if (!adapter->discovery_list) {
		struct mgmt_cp_stop_discovery cp;

		if (status != MGMT_STATUS_SUCCESS)
			return;

		/* Stop discovering as there are no clients left */
		cp.type = rp->type;      <-- rp may be NULL here

mgmt_cp_start_discovery is a single uint8_t, so rp->type is a one-byte
read at offset 0 and a NULL rp faults immediately.

The mgmt layer can invoke a command callback with no reply parameters:
src/shared/mgmt.c passes length 0 and a NULL param on the Command
Status path:

	case MGMT_EV_CMD_STATUS:
		...
		DBG(mgmt, "[0x%04x] command 0x%02x status: 0x%02x", ...);
		request_complete(mgmt, cs->status, opcode, index, 0, NULL);

Observed as a crash on a QCA9377 (13d3:3503) whose controller stops
answering HCI during audio use. The archived session logs show exactly
that sequence: the daemon's debug log (bluez 5.72) ends with the
Command Status delivery and the callback entry, for the Start Discovery
it had sent 2.05 s earlier, ten seconds after its last discovery client
had gone; the contemporaneous kernel log records the resulting fault:

  bluetoothd:
  21:03:16.750  discovery_remove() owner :1.125
  21:03:24.943  send_request() [0x0000] command 0x0023
  21:03:26.994  can_read_data() [0x0000] command 0x23 status: 0x00
  21:03:26.994  start_discovery_complete() status 0x00
  kernel:
  21:03:26.995  bluetoothd[2821]: segfault at 0 ...

"command ... status:" is the Command Status branch (Command Complete
logs "complete:"), so the callback ran with status 0, length 0 and a
NULL param, found discovery_list empty, and faulted on rp->type. The
crash site was resolved from the shipped binary:

  bluetoothd[2821]: segfault at 0 ip 00005d6eb1ad1986 sp 00007ffef8e784b0 \
      error 4 in bluetoothd[a6986,5d6eb1a50000+f3000]

  a6986:  41 0f b6 45 00    movzbl 0x0(%r13),%eax     <-- cp.type = rp->type
  a698b:  0f b7 53 04       movzwl 0x4(%rbx),%edx     <-- adapter->dev_id
  a6992:  4c 8d 45 d7       lea    -0x29(%rbp),%r8    <-- &cp

The same delivery, a Command Status with status 0x00 answering a Start
Discovery just sent, was logged five more times on that machine: four
in the crashing daemon's own lifetime and once on a later day. On each
of those the client list was non-empty, so the existing check below
the branch handled it ("Wrong size of start discovery return
parameters"); when the list is empty the branch above is reached
first.

Why the kernel answers Start Discovery with a successful Command
Status rather than the usual one-byte Command Complete is not
established here. The crashing instance arrived while the controller
was timing out HCI commands; the fix does not depend on the cause.

Perform the same length validation before using the reply in the
no-clients branch. The check is added inside that branch rather than
hoisted above it, so that no other path changes behaviour.

Fixes: 3597d1377723 ("adapter: Fix not waiting for start discovery result")
---
Context, not part of the change: the crash was recorded on a QCA9377
(13d3:3503) laptop under Ubuntu 24.04 / bluez 5.72-0ubuntu5.5 and the
site was resolved from the stripped distro binary, then checked against
a retained core; the archived session record (daemon debug log and the
kernel log beside it) independently shows the same sequence: client
removed, Start Discovery sent, Command Status 0x00, fault. This guard
has not fired since it was installed; the delivery it guards against
was logged five more times with clients present, so the pre-existing
check caught those. The record and the crash-site method are public:
https://github.com/ivoitovych/qca9377-bt-hang  (patches/bluez/README.md)

 src/adapter.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1863,6 +1863,12 @@
 		if (status != MGMT_STATUS_SUCCESS)
 			return;

+		if (length < sizeof(*rp)) {
+			btd_error(adapter->dev_id,
+				"Wrong size of start discovery return parameters");
+			return;
+		}
+
 		/* Stop discovering as there are no clients left */
 		cp.type = rp->type;
 		mgmt_send(adapter->mgmt, MGMT_OP_STOP_DISCOVERY,
--
2.43.0
