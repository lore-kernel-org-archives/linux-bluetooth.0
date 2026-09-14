Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C1E43F8AE
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394242; cv=none; b=rAlqJcnKmYTuMSC7bL4iLcx4YJVqJWJGEs+PoNxsrxSrACgh1ag/1+obQQs4WOKZ90SopXwsLyformC8yUUlQQ8zYHvjQBBx7b1pAVu65rfSBTYqd6f0mcH0T5e7keBiSVY2mX6DjDgb9/hHcstcAbJqDzojMd6R7LzGPHU1/fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394242; c=relaxed/simple;
	bh=92SKzTJwmRkrBP7sXDC6C6x+S98sJmgVbEFdz8c5cFk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=h2gOs04rlRdzyjkUy7rtiBFC/ajIx+IYzKXJoUs3KPI7s3dvx5LYbN3q5CdSe9JbiZ7KzZnWTIwASlculKmo9I4uhjITbKiv7MlORXn3zCk3kVizGG08S5Qm4mEdDXhacqdcHrrz530vV2xPatlHRY6gp9SykKO4UW76+GSIuGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hrxO9tdG; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hrxO9tdG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789394238;
	bh=RPECuoX691mFpDjBPsemn7a2QUGAgDcxBAc5Rnus4pc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hrxO9tdGvmjOTzwKxdMTC/dd2+O4rHKB9WefpXhy7IsG6RJhO6oXL5xbhRwUg4+OG
	 spWKv9pCKND2fV4aYtvfmW1tFU+xRFdHTzH/WtdmSWSZj/RrA0p3cSojfGLXYOXDk4
	 3jY0MElG+781Jp9g1EIprsLbG4W34WR8gmRBo3XQ=
Received: from github.com (hubbernetes-node-c8253cd.va3-iad.github.net [10.48.175.43])
	by smtp.github.com (Postfix) with ESMTPA id EADAB501045
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 06:57:18 -0700 (PDT)
Date: Mon, 14 Sep 2026 06:57:18 -0700
From: =?UTF-8?B?QXVyw6lsaWVuIFJpdmV0?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1164346/000000-13999b@github.com>
Subject: [bluez/bluez] 13999b: mesh: Fix Command Disallowed on random address
 cha...
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

  Branch: refs/heads/1164346
  Home:   https://github.com/bluez/bluez
  Commit: 13999b132abcab9103aaac9fd90b69152c968049
      https://github.com/bluez/bluez/commit/13999b132abcab9103aaac9fd90b6=
9152c968049
  Author: Aur=C3=A9lien Rivet <aurelienrivet@hotmail.fr>
  Date:   2026-09-14 (Mon, 14 Sep 2026)

  Changed paths:
    M mesh/mesh-io-generic.c

  Log Message:
  -----------
  mesh: Fix Command Disallowed on random address change in generic IO

send_cancel_done() issues LE Set Random Address at the end of every
burst of ADVs. The controller rejects that command with Command
Disallowed (0x0c) while scanning is enabled, per Core Spec, Vol 4,
Part E, Section 7.8.4, so the address never rotates as long as any
scan is registered, such as a provisioner discovering unprovisioned
devices.

Pause scanning around the address change and resume it afterwards,
mirroring the disable/re-enable sequence restart_scan() already uses.
When no scan is registered there is nothing to pause, so the address
change is issued directly.

Confirmed with btmon on a Raspberry Pi built-in controller: over a
60 s capture, 12 rotations about 5 s apart, each one LE Set Scan
Enable(disable) -> LE Set Random Address -> LE Set Scan
Enable(enable), every command completing with Success and every
rotation programming a distinct address. No Command Disallowed
anywhere in the capture, where the address change previously failed
on every attempt. Scanning is suspended for 1.2 ms to 2.6 ms per
rotation, which mesh retransmissions absorb.

Assisted-by: Claude:claude-sonnet-5
Assisted-by: Claude:claude-opus-5



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
