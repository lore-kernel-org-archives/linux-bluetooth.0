Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8343F3112DC
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770749071; cv=none; b=kYgNsacB7cMOVdQT8mBEEq+HkmddPuInGhBzI29SQYUveifYKhNP2XDlUSyE7aOP7uYY4SjhK5GaL8bRdWrO4pKLsaD71LwTbESoQxNVhYuyNlBAVVm5ln7pwZ/m71F3fdjzdftocbWiDzWhdFnfLtpQmL2nsGRFS2Ab1MNDqkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770749071; c=relaxed/simple;
	bh=cSfgABbi236TeXQl7sm5WbhH4bFfMVDZhgC0/l38yeY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=T5DAPuLLLsMRZ1q418bDjk1Az7IW5ZxpuSyP3rdqlASQKFUOj4cbuzD/VI9XS1H0BnRYK53evQrQtD9cPD1qD1jXLIwSKWoMcKJrLrjAYljgVzlfUuzGtkKWE35wrhzQI38bWJX5PZlS62eUK+nCWvJgvvmeTUlS0Kc7gqnM3P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ugb4/fJJ; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ugb4/fJJ"
Received: from github.com (hubbernetes-node-5fa7fd0.ash1-iad.github.net [10.56.207.68])
	by smtp.github.com (Postfix) with ESMTPA id 6141E984058
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 10:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1770748768;
	bh=qdQ8x2C25M1awe+p6j0H35D53K6uXmxdWhiKmaTc9mk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ugb4/fJJfA3mIIRTIXBDCqBL7UAxtxkTLTjptx+rt4QxejkwWxsuthwKVuartzRZS
	 ktTNpcWiZ75UAOfSCdHDbTOtU3R1B4gDTg95JThcf4rf3eeg21k/fFScP2+m8yVJRe
	 WpX9hKgZU4GvseHZpMefo1j9GEM/Ni+UBKRSxoS0=
Date: Tue, 10 Feb 2026 10:39:28 -0800
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/74770b-f1eedd@github.com>
Subject: [bluez/bluez] ecf444: adapter: Add btd_adapter_send_cmd_event_sync
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: ecf4448a5811cc8d56421112f88e1a57059b6956
      https://github.com/bluez/bluez/commit/ecf4448a5811cc8d56421112f88e1=
a57059b6956
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-09 (Mon, 09 Feb 2026)

  Changed paths:
    M src/adapter.c
    M src/adapter.h

  Log Message:
  -----------
  adapter: Add btd_adapter_send_cmd_event_sync

This adds btd_adapter_send_cmd_event_sync which acts as a function
helper to generate MGMT_OP_HCI_CMD_SYNC.


  Commit: f1eedda9cefc3080b642f58342a38cfcc264d3d8
      https://github.com/bluez/bluez/commit/f1eedda9cefc3080b642f58342a38=
cfcc264d3d8
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-02-10 (Tue, 10 Feb 2026)

  Changed paths:
    M emulator/bthost.c

  Log Message:
  -----------
  emulator: Fix compilation on big endian systems

This fixes the build on big endian systems like s390x:

Remove the "static" so the array doesn't need to be initialised
with constants.

emulator/bthost.c: In function =E2=80=98bthost_setup_sco=E2=80=99:
./src/shared/util.h:43:26: error: initializer element is not constant
   43 | #define cpu_to_le32(val) bswap_32(val)
      |                          ^~~~~~~~
etc.

Fixes: 85888a8357ea ("bthost: add bthost_setup_sco() and accept
incoming eSCO")


Compare: https://github.com/bluez/bluez/compare/74770b1fd2be...f1eedda9ce=
fc

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
