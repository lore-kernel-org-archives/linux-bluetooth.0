Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CA32D7809
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797730; cv=none; b=AFTkOJ7hL4AZKRQlRlL4qgyh/qd1NJKrLSsJhB63bO/ECYN/ZvWqUal6xvf9Oc8XDVPBPJR3AeXtj87x9ntHG6KDu06ASEuKdzPhkHwmxtoTkwwPLdeYlctkQGSSOJc+3vO5Ts/WCnH6+24VFIqYyQfBMNSwfnxWb6CU5lzDZi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797730; c=relaxed/simple;
	bh=dM8dCNAnUyVGrxONV8D/A1a/ItNTavsEE0twh92gouo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Da5s5lJHhpeyvYSg48/KBU8nHyZQ+aL3Yn+QPLsxA1bM0QtDM4OM0wwAukZdCFWijxL5AlQr0xGsgPjnz3vHbg7gF1TaUM/7hIs8JuBsNTw0CKQjumxZAL0MXzPcOeJDJ6GJ20vUJdc7KAizpOkPrp0UxnncFEg/WVcnN0FlJkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JpSTyKl7; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JpSTyKl7"
Received: from github.com (hubbernetes-node-34f154c.ac4-iad.github.net [10.52.174.53])
	by smtp.github.com (Postfix) with ESMTPA id 8CC03640B7F
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 10:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755797728;
	bh=4gk/jcAug8he3bosjd7PiO8/bgHmPzgSbZpaqsJqDuQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JpSTyKl7PkP2zE31cWyN206qzGjpUyxak8Fk5oYALU4by4++Au2J19kR+3OJ8q/XD
	 GYzH+muK6puTCX1ejHsKs9FkhYkhrDIuRjOXHfRw5vw6WkPQwo1x9+d14wf8EDApRC
	 ALjJMCYgbeB4ainLmacUMjqjTISWEwMrVk7Ii9SQ=
Date: Thu, 21 Aug 2025 10:35:28 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/5f38ea-4784f5@github.com>
Subject: [bluez/bluez] 90a490: monitor: Add support for -K/--kernel
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
  Commit: 90a490569cb823c4621fea3d6f85c47ad06d2f2e
      https://github.com/bluez/bluez/commit/90a490569cb823c4621fea3d6f85c47ad06d2f2e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-08-21 (Thu, 21 Aug 2025)

  Changed paths:
    M monitor/btmon.rst
    M monitor/control.c
    M monitor/main.c
    M monitor/packet.h

  Log Message:
  -----------
  monitor: Add support for -K/--kernel

This adds support for -K/--kernel that open /proc/kmsg and attempts
to print messages starting with 'Kernel:':

> monitor/btmon -K
= Note: Kernel: BNEP (Ethernet Emulation) ver 1.3
= Note: Kernel: BNEP filters: protocol multicast
= Note: Kernel: BNEP socket layer initialized
= Note: Kernel: MGMT ver 1.23
= Note: Kernel: RFCOMM TTY layer initialized
= Note: Kernel: RFCOMM socket layer initialized
= Note: Kernel: RFCOMM ver 1.11


  Commit: 4167e89d8fbba56198ae10635182b43106a5faf0
      https://github.com/bluez/bluez/commit/4167e89d8fbba56198ae10635182b43106a5faf0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-08-21 (Thu, 21 Aug 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Print message if the frame information cannot be found

While processing Number of Packeted Completed event the code attempts to
print the frame information of each frame being acked but if no frame
was sent it didn't print anything, so this changes it to print
:#(frame not found)


  Commit: c773fd53c9539eea59c1a037c4fa7db59e1ac115
      https://github.com/bluez/bluez/commit/c773fd53c9539eea59c1a037c4fa7db59e1ac115
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-08-21 (Thu, 21 Aug 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  profiles/audio: Fix uninitialized params.subgroup_data warning

profiles/audio/bass.c:923:2: uninit_use_in_call:
Using uninitialized value "params".
Field "params.subgroup_data" is uninitialized when calling "util_iov_append".


  Commit: bb14a8b18f9462aade345cb0529957b152b75db9
      https://github.com/bluez/bluez/commit/bb14a8b18f9462aade345cb0529957b152b75db9
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-08-21 (Thu, 21 Aug 2025)

  Changed paths:
    M tools/l2cap-tester.c
    M tools/tester.h

  Log Message:
  -----------
  tools/tester: Fix fd leaks

tools/tester.h:314:3: leaked_handle:
Handle variable "sk" going out of scope leaks the handle.

tools/l2cap-tester.c:1957:4: leaked_handle:
Handle variable "sk" going out of scope leaks the handle.


  Commit: 4784f58ff0ecffb4781e161574a67e26a674cbf0
      https://github.com/bluez/bluez/commit/4784f58ff0ecffb4781e161574a67e26a674cbf0
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-08-21 (Thu, 21 Aug 2025)

  Changed paths:
    M profiles/input/hog.c
    M profiles/input/manager.c

  Log Message:
  -----------
  input: Fix incorrect destructors being used

g_key_file_get_string() expects its value to be freed with g_free(), not
free().

Fixes:
profiles/input/manager.c:118:2: leaked_storage:
Variable "uhid_enabled" going out of scope leaks the storage it points to.
profiles/input/hog.c:267:1: leaked_storage:
Variable "uhid_enabled" going out of scope leaks the storage it points to.


Compare: https://github.com/bluez/bluez/compare/5f38ea159ea8...4784f58ff0ec

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
