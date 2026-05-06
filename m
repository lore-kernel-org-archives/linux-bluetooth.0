Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F01034DB46
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 20:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778099009; cv=none; b=NcJdLuVQLilNvcO1vy2WZ/ubHo0Rwc1ZKf6PNOtwRDtRQHy9vOIB4DWE1r4ypqHI4XjiTIWrWZbDr6dBpaZ3Aq0VwjDdfNw56RczyqYsRhXUWdU9drrsWazbWnLPjMuNlfjkCYuqbzAaI+MshQTuR9CufAZtnhGBGsC736MztIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778099009; c=relaxed/simple;
	bh=/k/gNkcLtaZBHb/1oHU5Jjfj/QhYQ2nsURpAUHisMCQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OQyDkNMY3CIKl2zy7mpxxjDfRYHmjEDxir94Mg4qpO+0m/SSG9soqBEZm1BzkQZSCqDfKNBHRKHPG6hB3jRpZjOtSJdiaw4C77rOz6Qq/bw1ReB/S7Ul3/lk7gh7iUs0zSJ17K4PsBJYIpq+9oowtGbUYEmueULGXj/lwIFmNCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FVoUxucs; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FVoUxucs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778099007;
	bh=M2n095pL6RRqQ/iAw0iSMZ4iVchRFu0qz32mHaBzrTA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FVoUxucsKkHugW+XE51R0zJzkOYzs+XCEVQNrCHsiwccIRp6HN1rAXCmkB6+S1ANR
	 iNGwuGjJzwi2+0E9uqYbQKyheb3BdtCJLnlvRP9YMaG+3RZtzHxe0dU9ME+a6g3F9o
	 iG9FBp1XUJlIK9RBdt7zgwDlCdTNspAW3+FGuAU4=
Received: from github.com (hubbernetes-node-4275ebe.ash1-iad.github.net [10.56.14.53])
	by smtp.github.com (Postfix) with ESMTPA id AB6FD6010F4
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 13:23:27 -0700 (PDT)
Date: Wed, 06 May 2026 13:23:27 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1090665/000000-63ea27@github.com>
Subject: [bluez/bluez] 331e9d: tools/tester: Fix crash when hciemu_new fails
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

  Branch: refs/heads/1090665
  Home:   https://github.com/bluez/bluez
  Commit: 331e9d2b22eb2abd7d4f46268ac86c2276091283
      https://github.com/bluez/bluez/commit/331e9d2b22eb2abd7d4f46268ac86c2276091283
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-06 (Wed, 06 May 2026)

  Changed paths:
    M tools/6lowpan-tester.c
    M tools/bnep-tester.c
    M tools/ioctl-tester.c
    M tools/iso-tester.c
    M tools/l2cap-tester.c
    M tools/mesh-tester.c
    M tools/mgmt-tester.c
    M tools/rfcomm-tester.c
    M tools/sco-tester.c
    M tools/smp-tester.c
    M tools/userchan-tester.c

  Log Message:
  -----------
  tools/tester: Fix crash when hciemu_new fails

When hciemu_new returns NULL, the mgmt object was not being unreferenced
before returning from the pre-setup failure path. This could lead to a
NULL dereference in read_info_callback when it later calls
hciemu_get_address on the NULL hciemu pointer.

Add mgmt_unref and return to the error path across all testers.


  Commit: a00fdf8c694eb05d2099f3d8a110296eafc77453
      https://github.com/bluez/bluez/commit/a00fdf8c694eb05d2099f3d8a110296eafc77453
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-06 (Wed, 06 May 2026)

  Changed paths:
    M emulator/hciemu.c
    M emulator/hciemu.h

  Log Message:
  -----------
  emulator/hciemu: Add hciemu_new_debug/hciemu_new_num_debug

Add new constructors that accept debug callback and user_data parameters,
setting them up immediately after allocation so errors during early
initialization (create_vhci, hciemu_client_new) are captured by the debug
output.


  Commit: 63ea27eca0e63307069d4966248fe7a8610560a2
      https://github.com/bluez/bluez/commit/63ea27eca0e63307069d4966248fe7a8610560a2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-06 (Wed, 06 May 2026)

  Changed paths:
    M tools/6lowpan-tester.c
    M tools/bnep-tester.c
    M tools/ioctl-tester.c
    M tools/iso-tester.c
    M tools/l2cap-tester.c
    M tools/mesh-tester.c
    M tools/mgmt-tester.c
    M tools/rfcomm-tester.c
    M tools/sco-tester.c
    M tools/smp-tester.c
    M tools/userchan-tester.c

  Log Message:
  -----------
  tools/tester: Retry with debug on hciemu_new failure

When hciemu_new fails, retry using hciemu_new_debug to capture early
initialization errors before reporting the failure. This helps diagnose
issues like vhci or client creation failures in CI.


Compare: https://github.com/bluez/bluez/compare/331e9d2b22eb%5E...63ea27eca0e6

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
