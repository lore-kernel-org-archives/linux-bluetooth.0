Received: from out-4.smtp.github.com (out-4.smtp.github.com [192.30.252.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475BA345EB7
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 21:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789851986; cv=none; b=WNbfOU+MRNfnpj4BRz9FZRIwO6ZErpBjUtG90yCx9uQ16xgNq1z/NonNazQakQy9qjXdJ9oC8GV85CFGx0PkgLMoUymN09S/91kSqQBX9yGzqjOSLf7Iuiuz0QxuB3viQheTL4HUlPkrs0stIsieStPMR35YXpL0fDg0IMOi2tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789851986; c=relaxed/simple;
	bh=RhcBC1opaxz6ucneYCRW99pMwOcmZd7fLJjVUOWrM6Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CIUzUFSRLTACvWTF4ME9koqRG7MiM+CKvVd4LlYpR5WbjDFHFlqS3i//bESUcVfKvRdC39phMzdOh8Rj7nvsaifDoqrbAlrf8etDcjzCTuC9nNjDQ5iUf/HqJQyktQH9pWX0YXdHZxdFaE3se/NC89hPgxPMXbxxW/m24zMFiGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kZORGPIM; arc=none smtp.client-ip=192.30.252.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kZORGPIM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789851983;
	bh=AqhRnWc542IIrFRGxxovT3AMLPcjX4HQKCL8U+81P5Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kZORGPIMA9dE3qZauuMAqIIgmyG26/vvaAxs8f2kAnH4bBV9w2MoNMiajyoWp+Sqk
	 mfSVQsmXMjGavmgql74wqa5eZt8lYHakZbTahGmxczY9Lt159pdp4QzTp/r0flMiPI
	 ieMdT1oKNIkwrrYs0kZ2rdg4yQxcMZ4fegftnXVM=
Received: from github.com (hubbernetes-node-d3edd9b.va3-iad.github.net [10.48.147.32])
	by smtp.github.com (Postfix) with ESMTPA id 414DF340139
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 14:06:23 -0700 (PDT)
Date: Sat, 19 Sep 2026 14:06:23 -0700
From: IAROSLAV VOITOVYCH <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1169362/000000-1bc658@github.com>
Subject: [bluez/bluez] 1bc658: adapter: Fix crash on short start discovery
 reply
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1169362
  Home:   https://github.com/bluez/bluez
  Commit: 1bc658e29d68c03ec3ee4aa79e153d591df01af3
      https://github.com/bluez/bluez/commit/1bc658e29d68c03ec3ee4aa79e153d591df01af3
  Author: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
  Date:   2026-09-19 (Sat, 19 Sep 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix crash on short start discovery reply

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



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
