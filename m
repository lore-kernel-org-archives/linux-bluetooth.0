Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9531C35FF6C
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 21:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791495830; cv=none; b=RlLtjiXP4OMmny+/GCJ5GpO5eVoyjXtnKSidpVdFNGsyimT8MpzZ09ilW0qJuOwokhZ1UHM41FsWS4qehlsDOZuLQbGhDH6MoB+yoTOifDlWeejjx2ObZY00FprfAzYdERMUmvha9yqTelpDttXmMTf+7pH3OK/5JHJsgWjCpBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791495830; c=relaxed/simple;
	bh=629BcmczqXOsMXzMNOravhZg1IiURX0h8ubLSuyqWAY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gkZ0KPA8vFueD5TKL4K5mCy08pdQ+cmROS8w8JPGAFKNiVEG12oGptis8EEvk3k/IsL/4Uo5QrReoV93t77uWakztdUaO6QT9t6dD53Ia9nDw8Swths22RrKw0rAXbuTMl6/T8fu/DUi5iE8z0jKNGjwXEhOgGHg55nyMnt2/dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=KivwepBs; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="KivwepBs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791495828;
	bh=sLvb+Ir4ajAXUiWp43RTWDPMcH+SOValVgCZmFnziV4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KivwepBsTyofNh3s5ZaXPR1eCSjL48kdOTGcThnZsCJloLzCybqto/lc8Ro4+0oLs
	 BVCiYiepSqBoWprLDtfM+jGzbJSm3x8m441/YLI8LYMVsJ5FNFfA+KBjg/j166UDLz
	 mZBDMYsWuyp3yBCiTT0RVtUe34avjeurmhm6MPplZRx1BxCpFFe+8NY84/GEo8fNfP
	 OzCnYOKXTYdyouPAgvi4ZXgGB87PYg03p+ed2qKXGDbMya1kElwqXJGUlRr51sk5Mb
	 HrMqPtBhmC178S29zo/A0zctQ6HNcsdbzheaqTg88qs0xHPrd4tWWSDtwc8A1SORIB
	 DgcOABrjarexA==
Received: from github.com (hubbernetes-node-9517290.ac4-iad.github.net [10.52.181.56])
	by smtp.github.com (Postfix) with ESMTPA id A10A4A08B4
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 14:43:48 -0700 (PDT)
Date: Thu, 08 Oct 2026 14:43:48 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1181777/000000-fc88f0@github.com>
Subject: [bluez/bluez] 66a56a: org.bluez.Bearer: Add Role property
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

  Branch: refs/heads/1181777
  Home:   https://github.com/bluez/bluez
  Commit: 66a56a646fae75c04b74655a346a3fa4f480e486
      https://github.com/bluez/bluez/commit/66a56a646fae75c04b74655a346a3fa4f480e486
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-08 (Thu, 08 Oct 2026)

  Changed paths:
    M doc/org.bluez.Bearer.LE.rst

  Log Message:
  -----------
  org.bluez.Bearer: Add Role property

This adds Role property to org.bluez.Bearer.LE1 which indicates whether
the remote device is the central or the peripheral of the current LE
connection, so applications can tell a central that connected to the
adapter from a peripheral the adapter connected to.

Assisted-by: Claude:claude-opus-5.5


  Commit: b125c39c4780682382aa54f83ef431f22322393c
      https://github.com/bluez/bluez/commit/b125c39c4780682382aa54f83ef431f22322393c
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-08 (Thu, 08 Oct 2026)

  Changed paths:
    M src/bearer.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  bearer: Add Role property

This implements Role property for the LE bearer using the initiator
flag of the Device Connected event, which the kernel sets when the
adapter created the connection as central, and emits PropertiesChanged
along with Connected.

Assisted-by: Claude:claude-opus-5.5


  Commit: fc88f0a65813f71a09bf479ac3ee9a4e4b17a6fa
      https://github.com/bluez/bluez/commit/fc88f0a65813f71a09bf479ac3ee9a4e4b17a6fa
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-08 (Thu, 08 Oct 2026)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Print LE.Role in info

This prints the Role property of the LE bearer with the likes of info
command:

bluetoothctl> info <addr>
...
        LE.Connected: yes
        LE.Connectable: yes
        LE.Role: central

Assisted-by: Claude:claude-opus-5.5


Compare: https://github.com/bluez/bluez/compare/66a56a646fae%5E...fc88f0a65813

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
