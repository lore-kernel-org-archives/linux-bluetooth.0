Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CD93D47A0
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795872; cv=none; b=e/yRb0RWiShcllHdd6/nYKQ1xEmAEuYEg9NS2MtmcpZazLYgucbPWnS2ZEvQAKEja7tr+tJjx90eY1f6MkZEoJMbQVQjr1QCX+DgfNEL1jyyNWmrPBaN/GNMnvY1E1yJK5C9qGC7eamGCq3VqKwwt6ydERApHWUz4fADCLYFDKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795872; c=relaxed/simple;
	bh=gQq1O7JqP0kuW94WnddaUC1hm0Wc2y7oDfulsD/YQbA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=b5pf5hpEzOxgR/NvPiQVv8ITUbXIJYoxzQ2D5xlb0FbSu3jCDiAemH1Cd/j0ehKrUnTEwwB+pllqG4+rf1NdpJsQ0ary+eMnh7zdR1iiOW3gZLUAv2bayBCHtGbiwk3KT8RcNlMvXsI7ipg4XAkLviOlROdx1TaM7fU4/y1n91Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=j34Tgdrc; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="j34Tgdrc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790795870;
	bh=LzUR0L6jSXfaVR2mmCR6m5JYyKtofMibozqj7zk324E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=j34TgdrcmXminLSQMfcI9rsWjSNqbkzvHY8BJmJVK/g1YxXb/yiDMnw7pSkYCkaPe
	 cVm2sc7Yex6yEUYg7Mb5uVZfIbrtWEa+FjssfBsZpLbmcLvI669OeXm3EA2umoLINo
	 Ydimc7AfzFPWcX6DAtz9zVV6Ipk6oUaejqeeIf88sMUdERB6PHSh1OSljDMd25EEII
	 PkPVOM45Hjqto7LMd5d0vhmj3/oAnOHT47bdf/JmBhR0QVMIJYFzgo2dUEJ0632MpT
	 sHe4ZeU8KduA6d2Dv9Yj09xhc0tf+50ksaAgZDE4YQYH6Dk0jJ11A0OYQZyi1pakRv
	 Y9I7Buo5gDfSQ==
Received: from github.com (hubbernetes-node-980c749.ash1-iad.github.net [10.56.193.37])
	by smtp.github.com (Postfix) with ESMTPA id 176A952153B
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 12:17:50 -0700 (PDT)
Date: Wed, 30 Sep 2026 12:17:50 -0700
From: =?UTF-8?B?QXVyw6lsaWVuIFJpdmV0?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1176997/000000-269438@github.com>
Subject: [bluez/bluez] 269438: mesh: Fix Command Disallowed on random address
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

  Branch: refs/heads/1176997
  Home:   https://github.com/bluez/bluez
  Commit: 269438e7a5bac1adf2d63d7f28da994129064e58
      https://github.com/bluez/bluez/commit/269438e7a5bac1adf2d63d7f28da9=
94129064e58
  Author: Aur=C3=A9lien Rivet <aurelienrivet@hotmail.fr>
  Date:   2026-09-30 (Wed, 30 Sep 2026)

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
