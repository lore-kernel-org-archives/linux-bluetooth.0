Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D342F313550
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 18:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030138; cv=none; b=ZvB8PRxr7rQMz0axfEIpn772xfx5SNLw4GPDAQRzCvVHAr8JtNXVh9yFOxcvzIcSuox/7Cu6DX23SViN8cAknObmS3Ead0LPQcl02eFtpMM9flrd5a1GiIc0SF8zMIVNZla67Bc0VVpvNXN+mb+djEeh5QJG40YJUZf4ra0p1sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030138; c=relaxed/simple;
	bh=Lpa8wAhx3vQ+HJ4vz7zhzF1h+EKDtj9mfLYFikoFyuw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=s4o6U78htzc9NrjDWAxQaZErDWzUuyseRmvI2k7FyrVspmCyTvhGQWtcQaen4GbdWfgk44p6AZWe2I1HuGwCbbjQZPWjysJuw3VdYPf1mHdWePKvzS2LnxgAKsFpEG7CtGUdov2TnWwAzwUC8TWaG/M7zieM5HpD8Y+9DQSCt5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=T9t1CXqT; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="T9t1CXqT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781030136;
	bh=imjj3samZzf8JYG2GA43p/yF5dzorhXRJiSxVRUGofk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=T9t1CXqTeM/dA13HCNdHt40TYGA6X6NVtRBWGfy99OxpmjH+Oag6s4ZM3Pxe20uBy
	 bqf+xNmKOOk9mMCiM3RS36WsSeDSIGKS7mACaS43PnTRARlwojvJNPV/khEra6pL7Y
	 0hJNyeN73/SMuvYAsFZoJEQkMyfab7M/knvI26Q4=
Received: from github.com (hubbernetes-node-1f5efd2.va3-iad.github.net [10.48.205.42])
	by smtp.github.com (Postfix) with ESMTPA id 2B0AE1811E2
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 11:35:36 -0700 (PDT)
Date: Tue, 09 Jun 2026 11:35:36 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108736/000000-2f53c2@github.com>
Subject: [bluez/bluez] 7ecb11: btio: Handle EOPNOTSUPP from accept() to
 prevent b...
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

  Branch: refs/heads/1108736
  Home:   https://github.com/bluez/bluez
  Commit: 7ecb11301c829a12cc274ed2a0f7c89c63354a87
      https://github.com/bluez/bluez/commit/7ecb11301c829a12cc274ed2a0f7c89c63354a87
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M btio/btio.c

  Log Message:
  -----------
  btio: Handle EOPNOTSUPP from accept() to prevent busy loop

When accept() returns EOPNOTSUPP on an L2CAP SEQPACKET server socket
(e.g. AVCTP browsing channel, PSM 0x1b), the error is permanent and
retrying will never succeed. Previously, only EBADFD was treated as
fatal, causing server_cb to return TRUE for EOPNOTSUPP. Since the fd
remains readable, this creates an infinite busy loop that hangs
bluetoothd.

Treat EOPNOTSUPP the same as EBADFD by returning FALSE to remove the
GLib IO watch and stop the loop.


  Commit: c3e01f6ca296d8d8a22fd0fde7a2a59ec21ea0bc
      https://github.com/bluez/bluez/commit/c3e01f6ca296d8d8a22fd0fde7a2a59ec21ea0bc
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M src/profile.c

  Log Message:
  -----------
  profile: Check if bearer is enabled on registration

btd_profile_register now verifies that the profile's bearer type is
compatible with btd_opts.mode before registering. If the required bearer
is not enabled (e.g. LE-only profile when mode is BR/EDR, or BR/EDR-only
profile when mode is LE), registration is rejected with -ENOTSUP.


  Commit: a900f8944421290ab80fead5908f8eec0f164053
      https://github.com/bluez/bluez/commit/a900f8944421290ab80fead5908f8eec0f164053
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M profiles/audio/a2dp.c
    M profiles/audio/avrcp.c
    M profiles/audio/hfp-hf.c
    M profiles/audio/micp.c
    M profiles/input/manager.c
    M profiles/network/manager.c
    M src/gatt-database.c

  Log Message:
  -----------
  plugins: Check btd_profile_register return value

Ensure all plugin init functions check the return value of
btd_profile_register. If registration fails (e.g. bearer not enabled),
the plugin init propagates the error instead of continuing with an
unregistered profile.


  Commit: 2f53c2749db24ab84461c02ba7a2b52f6b2269d4
      https://github.com/bluez/bluez/commit/2f53c2749db24ab84461c02ba7a2b52f6b2269d4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M src/bearer.c

  Log Message:
  -----------
  bearer: Check btd_opts.mode on btd_bearer_new

Only create the bearer interface if the corresponding transport is
enabled. Return NULL if BREDR bearer is requested in LE-only mode or
LE bearer in BREDR-only mode, so the D-Bus interface is never
registered for unsupported bearers.


Compare: https://github.com/bluez/bluez/compare/7ecb11301c82%5E...2f53c2749db2

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
