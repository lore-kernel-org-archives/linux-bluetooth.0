Received: from out-35.smtp.github.com (out-35.smtp.github.com [192.30.252.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74761A682E
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778015332; cv=none; b=tcyzwZFVFdNCpJUICVidsK4BGku4gkhkPaoDxGrmtqWn0UykiGBTaGuVQgXuQrSwQI++1oGLBQlXDTrOde1ZatFSG0WhbUBojnr5MWqVvKz6FD+f6le3WtzbAQp5iF8XuK3tjz8t4Rb+bplRKWnhELppJ9yis4163M+GmbWx+2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778015332; c=relaxed/simple;
	bh=fd7raSalN7qaNcJBiLFEBa93FVmZNjgYcqwmmIMTjnc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DBz/z9mr3gNFt9ERPn0clAaNay7lOOTNHhm5GBDDsNDYnsS13ijnSDrsc2LnV6Dy5OJ8YJ5wXop30ulhzk2wEigic8uDQNvymJZ5ECH79P6mm0/+LDcd2xEUZslgM10RmQJAAKkNJUnkq7T6yga3QHCc42gA/S8F8SfaIlAlWa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PZwUPxit; arc=none smtp.client-ip=192.30.252.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PZwUPxit"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778015331;
	bh=M6TkHn4UqoFvrjHhEGL/PpyjlH09LAEPzhUV1ZS6v7M=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PZwUPxitJlWsTnUy4glY+E7KDS2mcMTl+vNm11bHSBZAI2dXHXs9NdTsx/1/na9cw
	 6HSQUvOLvX0bPH/iUOJ8pQW59aRqKk7IBNdXWrjyMskbd3i0FrK//OUwjBa2TfrrZ0
	 92KO6efffwAu4phwi5oY9pCHIFXzcAbfGjtDc/EU=
Received: from github.com (hubbernetes-node-1df25af.ac4-iad.github.net [10.52.162.36])
	by smtp.github.com (Postfix) with ESMTPA id 041B574045A
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 14:08:51 -0700 (PDT)
Date: Tue, 05 May 2026 14:08:51 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1090123/000000-5125b3@github.com>
Subject: [bluez/bluez] 7828f7: emulator/vhci: Add debug messages to error
 paths
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

  Branch: refs/heads/1090123
  Home:   https://github.com/bluez/bluez
  Commit: 7828f7436ad604c278d96e491c24815eb5eba465
      https://github.com/bluez/bluez/commit/7828f7436ad604c278d96e491c24815eb5eba465
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-05 (Tue, 05 May 2026)

  Changed paths:
    M emulator/vhci.c

  Log Message:
  -----------
  emulator/vhci: Add debug messages to error paths

Add debug_callback, debug_destroy and debug_data fields to struct vhci
so vhci_set_debug stores the callback locally in addition to passing it
to btdev. Introduce a variadic vhci_debug() helper using util_debug_va
and add debug messages to the following error paths:

 - vhci_write_callback: failed io_send
 - vhci_read_callback: failed read
 - vhci_debugfs_write: failed open and failed write


  Commit: eeb46df9fd4944f73df1b5bc991582fa94140872
      https://github.com/bluez/bluez/commit/eeb46df9fd4944f73df1b5bc991582fa94140872
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-05 (Tue, 05 May 2026)

  Changed paths:
    M emulator/hciemu.c

  Log Message:
  -----------
  emulator/hciemu: Add debug messages to error paths

Introduce a variadic hciemu_debug() helper using util_debug_va and add
debug messages to the following error paths:

 - create_vhci: failed to open vhci
 - hciemu_client_new: failed to create btdev, bthost, or socketpair


  Commit: 3037ba762200454aada62411a4d4567150ed39a5
      https://github.com/bluez/bluez/commit/3037ba762200454aada62411a4d4567150ed39a5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-05 (Tue, 05 May 2026)

  Changed paths:
    M tools/gap-tester.c

  Log Message:
  -----------
  tools/gap-tester: Enable hciemu debug output

Add print_debug callback and call hciemu_set_debug when debug output is
enabled so that hciemu error paths are visible during test runs.


  Commit: 5125b3d39fe26a3c5c824fb18bc44a8e05602b37
      https://github.com/bluez/bluez/commit/5125b3d39fe26a3c5c824fb18bc44a8e05602b37
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-05 (Tue, 05 May 2026)

  Changed paths:
    M tools/userchan-tester.c

  Log Message:
  -----------
  tools/userchan-tester: Enable hciemu debug output

Call hciemu_set_debug when debug output is enabled so that hciemu error
paths are visible during test runs.


Compare: https://github.com/bluez/bluez/compare/7828f7436ad6%5E...5125b3d39fe2

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
