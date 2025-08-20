Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91BF285C8E
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755700803; cv=none; b=LaG9ILOPB6TO4etjM0SWkicDZCl+lprIvfy4kYcYYGoh7Zkv5jeJoJp9oXYjCuE8RAowsSgbShX3Dj9fRjdCv6UKqXRmcBLWJ261wCrGLVx2Ece3gsfrYM/zSFPKWF/u+yCLvUgrSCfnjgxVX+G6FNmiUCjNi3cBIEEFokDGJDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755700803; c=relaxed/simple;
	bh=FBwLR9dOTbB5JDtT9xwIPyPIgmau4AeAi7I6bSn/18A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MbPo2BYC9QcNFrsBAVKaN67zRY22mpDSUAK1Om2FKyxzXfwtyt+eHEvS673FNdg7wseSuQetAJUU/nMJ+Y46dvFNvVtbv/TERedW4Je4OdoH3X8ehRWQtXE/a6c0EtKo9r1oKkH61fETlNuSM/Vp0MBMURMFJizxUclHEJz0V6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QKLi4Y/c; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QKLi4Y/c"
Received: from github.com (hubbernetes-node-8a28120.ash1-iad.github.net [10.56.147.43])
	by smtp.github.com (Postfix) with ESMTPA id DA5411412F3
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 07:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755700800;
	bh=M5G9KA3VKT8gM+9BLukar/+T6aasoknAI+ygRHjnYUM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QKLi4Y/cahrHprN+m/ZvpWkkx+jlq6drDoWxl15blPehmCPzkSF2yf45D6oyYwNcq
	 uDXrd97fy9kPguCmz8iofT8LLCRlUTxO8vwHCo4z7fgKOFqtF07HWVJfQob8IBoGmk
	 V4+fcRXb1dbnU0M6/J619v3s5UdwG5VAkx3Q1lQI=
Date: Wed, 20 Aug 2025 07:40:00 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/993547/000000-f47078@github.com>
Subject: [bluez/bluez] e656e2: profiles/audio: Fix uninitialized
 params.subgroup_...
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

  Branch: refs/heads/993547
  Home:   https://github.com/bluez/bluez
  Commit: e656e29d3c9c36935772e650509111558d081a91
      https://github.com/bluez/bluez/commit/e656e29d3c9c36935772e650509111558d081a91
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-08-20 (Wed, 20 Aug 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  profiles/audio: Fix uninitialized params.subgroup_data warning

profiles/audio/bass.c:923:2: uninit_use_in_call: Using uninitialized value "params". Field "params.subgroup_data" is uninitialized when calling "util_iov_append".


  Commit: 7b8a363d01074868966350d442d941a1485ba018
      https://github.com/bluez/bluez/commit/7b8a363d01074868966350d442d941a1485ba018
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-08-20 (Wed, 20 Aug 2025)

  Changed paths:
    M tools/l2cap-tester.c
    M tools/tester.h

  Log Message:
  -----------
  tools/tester: Fix fd leaks

tools/tester.h:314:3: leaked_handle: Handle variable "sk" going out of scope leaks the handle.
tools/l2cap-tester.c:1957:4: leaked_handle: Handle variable "sk" going out of scope leaks the handle.


  Commit: f47078de941e944a310d16d74161b77726bc1c82
      https://github.com/bluez/bluez/commit/f47078de941e944a310d16d74161b77726bc1c82
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-08-20 (Wed, 20 Aug 2025)

  Changed paths:
    M profiles/input/hog.c
    M profiles/input/manager.c

  Log Message:
  -----------
  input: Fix incorrect destructors being used

g_key_file_get_string() expects its value to be freed with g_free(), not
free().

Fixes:
profiles/input/manager.c:118:2: leaked_storage: Variable "uhid_enabled" going out of scope leaks the storage it points to.
profiles/input/hog.c:267:1: leaked_storage: Variable "uhid_enabled" going out of scope leaks the storage it points to.


Compare: https://github.com/bluez/bluez/compare/e656e29d3c9c%5E...f47078de941e

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
