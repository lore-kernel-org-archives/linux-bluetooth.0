Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202D4224AF8
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 19:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744830680; cv=none; b=Wnddpn/EszVPp38+tCB+XUn8m02Gsz+OOpjhsFliH4jQMzOAK3f/CBpCEmU4aFL3QiID0azlVYgwlNwM3ZIWSujeU1QbNDBkwVdscLNWtzLq72beehPAAwT76cGHlGIOkLmVC++CHznKbFTOggDrHEWLwBUV4jdEKGL7z8KjZ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744830680; c=relaxed/simple;
	bh=aAxIF4q044awTtO1WzdPDojvln6AXUXKHcPNcYYxYDk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bPHJynihD4Bj67SlCPKO/AUEJ2X6iA0Dl1B1iR5+OXQSbQ/ToMoWobLUiEwX9GDiZKsSCQK8Co6q6yUSYiuKQwWCFHomPtKKGC1z46ehdB8M5XlpOKzcCUy/9+QHCfUmZQVntD+L5eTNQxdV80DkmvSDp/xf49G3Nc2NNn2Fhag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=a6ST77F/; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="a6ST77F/"
Received: from github.com (hubbernetes-node-26ba929.ash1-iad.github.net [10.56.148.45])
	by smtp.github.com (Postfix) with ESMTPA id 2FCA26006E8
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 12:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1744830676;
	bh=RTtHkW9pCfAWd6KXLdO/4Nee7MBJXVW2R8CbZlCARHs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=a6ST77F/ftseO/sDgSza8AVldBaB/Pvq6mrF3yTKnrY3B+JpMgNqKcra/5Ea1oa9c
	 Ln/fBSjKR/VCXMuUxn/6NmQgEReMAFin4au5t8EChRPKSjvzRLpRgFXFyxSydimB0W
	 6blF8UL95wB8xPbvAXd3yocihMcTnxnahQ8bNTYc=
Date: Wed, 16 Apr 2025 12:11:16 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f8e7bc-aedd7b@github.com>
Subject: [bluez/bluez] 890149: bap: Fix not setting SID for broadcast receiver
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
  Commit: 890149c1fb56e36aae22918f2a68656a978fc2fd
      https://github.com/bluez/bluez/commit/890149c1fb56e36aae22918f2a68656a978fc2fd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-11 (Fri, 11 Apr 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix not setting SID for broadcast receiver

SID most be set otherwise 0x00 is assume which may not be what the
broadcast source is using over the air. but since we don't have access
to the SID of the advertisement in userspace mark de SID as invalid
(0xff) so the kernel fill it up while scanning when creating the PA
sync.


  Commit: 709aa00a1e502c434045f1fa2800391699ca0658
      https://github.com/bluez/bluez/commit/709aa00a1e502c434045f1fa2800391699ca0658
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-14 (Mon, 14 Apr 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Check for valid SID on BT_HCI_CMD_LE_PA_CREATE_SYNC


  Commit: e5a27a9c7b6881a1e11f57d6b10f66aed42246e6
      https://github.com/bluez/bluez/commit/e5a27a9c7b6881a1e11f57d6b10f66aed42246e6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-14 (Mon, 14 Apr 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix not matching SID on le_pa_sync_estabilished

In order to estabilish a PA sync the advertising SID must match:

7.8.67. LE Periodic Advertising Create Sync command:

'The Advertising_SID parameter, if used, specifies the value that shall match
 the Advertising SID subfield in the ADI field of the received advertisement
 for it to be used to synchronize.'


  Commit: 7e67dc9dcb9e851b44e9c9510b9075ef9b37c4db
      https://github.com/bluez/bluez/commit/7e67dc9dcb9e851b44e9c9510b9075ef9b37c4db
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-15 (Tue, 15 Apr 2025)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add test for SID=0xff

This adds the following test which is used to verify that when
application sets bc_sid to 0xff the kernel will attempt to scan for a
valid SID before attempting to create the PA sync:

ISO Broadcaster Receiver SID 0xff


  Commit: b4c5300f530477b197b309dd975207762fd7f405
      https://github.com/bluez/bluez/commit/b4c5300f530477b197b309dd975207762fd7f405
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-15 (Tue, 15 Apr 2025)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Test getpeername return SID

If test is not setting a valid SID (0xff) use getpeername to validate
the SID gets updated.


  Commit: 64e7377d455b7cd7653a0ef3dbddbbd0b3c6cab0
      https://github.com/bluez/bluez/commit/64e7377d455b7cd7653a0ef3dbddbbd0b3c6cab0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-15 (Tue, 15 Apr 2025)

  Changed paths:
    M btio/btio.c

  Log Message:
  -----------
  btio: Add support to BT_IO_OPT_ISO_BC_SID to bt_io_get

This adds support for reading BT_IO_OPT_ISO_BC_SID using bt_io_get


  Commit: aedd7b936b7240614a5305a8039a402d2da335ea
      https://github.com/bluez/bluez/commit/aedd7b936b7240614a5305a8039a402d2da335ea
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-15 (Tue, 15 Apr 2025)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/bass.c
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  bap: Add support for using SID for broadcast receiver

Broadcast receiver needs to set the SID of the advertisement, for now
that is done by using 0xff which indicates to the kernel to perform to
discover what is the actual SID in use over the air.


Compare: https://github.com/bluez/bluez/compare/f8e7bcfdfb83...aedd7b936b72

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
