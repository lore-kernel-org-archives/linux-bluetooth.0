Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1EB4CC610
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789498643; cv=none; b=j3YWBO6Qp95StE1d+a0vPK0JBDSOQx0QcVc/OR1t8QokgSTaZ30fxucQ7IvEKVE+v7I3GUZZz/71WNt9ZaRYSlGh5T5hgng20K86gVkFb6GBL4UmYXgco3LWv7QLsyK1opxNusdQn8Zcm3aSF370dRTmfTOafg+iy+BUhEcsGLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789498643; c=relaxed/simple;
	bh=f43x3o8SFVg64/cOCL7lgc5/Q4tRB/NbxkCmxX3kNTM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GHH6kPwtlC1pwdOBZpK89o4Kv5uOKBk98Ni2Rx2UJ8PZjHqvTduCHvFV0EqfnKeDA+vzqYxD7V8yyI4q/txCm5zopLzxSmQCWc6/noZ2L33uO+pMPKAr/n6AYf0BwB1yXE86RsCy29EjX4dImY5xWOFTr0dhCK3nJaK0hwFJO80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fgpFznuI; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fgpFznuI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789498639;
	bh=eXmHKoM1N9e0Qi0vsAQUtT4pCyvB71VLShkWfrTDo5o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fgpFznuINPxpEVNfQokrc8i+UtF/LXzWl82PEWyL0on5SYcNyjLvOjFO1EWfgCeff
	 liut+2ZeObFVBC7ltB77WnQasg6XZG+jsrB8A3KMbHEfND8HX56gUCd3MmDQ//Asdl
	 L4AAwGZK1fXKh2lVLunmbNlcTxOvniDDAYEr/how=
Received: from github.com (hubbernetes-node-ba48795.va3-iad.github.net [10.48.160.23])
	by smtp.github.com (Postfix) with ESMTPA id BC82C50162E
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 11:57:19 -0700 (PDT)
Date: Tue, 15 Sep 2026 11:57:19 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c8e2b9-6dc064@github.com>
Subject: [bluez/bluez] b41763: doc: test-runner: document the virtual machine
 arc...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: b4176324909d4663c295aef92a446fe403caacd1
      https://github.com/bluez/bluez/commit/b4176324909d4663c295aef92a446fe403caacd1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-14 (Mon, 14 Sep 2026)

  Changed paths:
    M doc/test-runner.rst

  Log Message:
  -----------
  doc: test-runner: document the virtual machine architecture

Add an ARCHITECTURE section describing how the virtual machine instance
is created and how it communicates with the launcher.

Document that the tool is both the launcher and the guest init, that
there is no disk image and the launcher root filesystem is shared
read-only over 9p, the TEST* variables passed on the kernel command
line, the sandbox mounts and the writable overlays needed on top of the
read-only root.

Also document the console and controller attachment: the guest console
is /dev/hvc0, and '-u' attaches the given socket as a second virtio
console, /dev/hvc1, on which the N_HCI line discipline is set so the
transport is HCI H:4 to the hci_uart driver. Mention '-o' as the way
additional channels are added, as done by test-functional.

While at it, add the missing '-H' and '-o' entries to OPTIONS.

Assisted-by: opencode:claude-opus-5


  Commit: 6dc064623c575bd1cea3ff0728fdca787fdc8a57
      https://github.com/bluez/bluez/commit/6dc064623c575bd1cea3ff0728fdca787fdc8a57
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-14 (Mon, 14 Sep 2026)

  Changed paths:
    M doc/test-functional.rst

  Log Message:
  -----------
  doc: test-functional: document the test environment architecture

Add an ARCHITECTURE section describing the split between the Pytest
upper tester, which runs on the developer machine and drives the test,
and the VM hosts started via test-runner, which run the BlueZ and kernel
instances under test.

Document the control, log, tty and shared channels set up on top of
test-runner and how they relate to the existing options, and the btvirt
and USB controller topologies. Details of the virtual machine setup
itself are left to test-runner, and writing VM-side test code to the
pytest-bluezenv documentation.

Also fix the temporary directory paths, which are named after
pytest-bluezenv rather than bluez-func-test.

Assisted-by: opencode:claude-opus-5


Compare: https://github.com/bluez/bluez/compare/c8e2b951b07f...6dc064623c57

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
