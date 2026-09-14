Received: from out-6.smtp.github.com (out-6.smtp.github.com [192.30.252.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4008479860
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789424841; cv=none; b=uXKhwm++dt+LDU7qaaj9t1Sbeik7zcfX7FhY/m1R6Z6voYX0dpVtLN95gD0vpEvfIgvKoOsO67G2a5bLggh4a7VHzzI3VBTCSgqHwZaLeYb5CKz1h26ePZKfK0FkAXnf3GE23OR4eA+rdNlAVd3gewCEjV080HSI6iTwbABP5L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789424841; c=relaxed/simple;
	bh=7J5LszGhBRLR1hj/KDoJJoyK1PrLEDqF7XiPqLiPJbc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JHBrc1mnbGZWtkvWNZW/cxeZtgLY+CTLvVJ+oUAubKaD3I61CLJlZbmkriXKSaoawSKwUSoeLmA/soDtmEHccREWsAoWIFLau0HRBOytTQ1n3hq10UgFM4iYxhrkRn0GU12oLbhQ43Poj4/45S6xyk5DfF4E9TexhKBZtg/jrBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XNy3y8ez; arc=none smtp.client-ip=192.30.252.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XNy3y8ez"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789424839;
	bh=kcXU00t5g3xh9SQKdeyOKniCewZ2ARmvNN9v1sJHh6Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XNy3y8ez/a9EVj+Qt5S542A+6qOop68PHX/+HO/Ni6TKdx/c+zGZQe/I20kv4DRmH
	 CkkifuWRrxusIDRLN0/vRgx2mUgdz9J26c7hyTWibWA965mgZVCfUeIQ1lvNGY9o6d
	 EuUvrLL5XhqwXW1Gl0rd6DoaBIVaJ1aGt3dcxxew=
Received: from github.com (hubbernetes-node-5ff46b6.va3-iad.github.net [10.48.164.54])
	by smtp.github.com (Postfix) with ESMTPA id A194878034B
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 15:27:19 -0700 (PDT)
Date: Mon, 14 Sep 2026 15:27:19 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1164802/000000-fa99a4@github.com>
Subject: [bluez/bluez] 35fb23: doc: test-runner: document the virtual machine
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

  Branch: refs/heads/1164802
  Home:   https://github.com/bluez/bluez
  Commit: 35fb236ce03cdfefd14c27cb63132ece2bd46f66
      https://github.com/bluez/bluez/commit/35fb236ce03cdfefd14c27cb63132ece2bd46f66
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


  Commit: fa99a412ac66e8f7a9a24df19c856b95df272b79
      https://github.com/bluez/bluez/commit/fa99a412ac66e8f7a9a24df19c856b95df272b79
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


Compare: https://github.com/bluez/bluez/compare/35fb236ce03c%5E...fa99a412ac66

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
