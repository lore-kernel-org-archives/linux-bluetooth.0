Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEF818EFD7
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 15:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538097; cv=none; b=PG/Q5igLaf9w2HatCAryYNikbKiYRU4Km8AS6vxwIKiM0mEjBlkFfxsb7pvkIM0WiyS7UchXOnTnGv7XQkdPvUxx/VSvD4EDZeia6DFo/+iK7F3vx5MdKboiAIDGDrAnfRKoF4IvgqXOooc7FvTUBp+umL7KVdgjPo1gUBAYFzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538097; c=relaxed/simple;
	bh=w1mGFCUPF9ALHXw3pjQCgoYJBK/arzptkLi0iIWdvZU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ngR+PLCI/QjHUGL4m4qHFrX1clWmZtzi+MbmAHEOJv/CWcQI4o+UpHI5u0JLsrdJrLoIDAEXbuHsDtMecVkCyTFeLtGe2wiQZGFd0bvMjOxU7vtmXmC+b6gUZ3rNFMZJThEnfMgO6gCLPsrfX3ylpMG/uOUK/T7SxubE2uPUw7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=C6v+Anm/; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="C6v+Anm/"
Received: from github.com (hubbernetes-node-b002f15.va3-iad.github.net [10.48.200.33])
	by smtp.github.com (Postfix) with ESMTPA id 675D04E0968
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 08:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1720538095;
	bh=3ZVNzesR65/GYyEJKIjdt4H+h2hGzBKfoHjTA9x7Ub4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=C6v+Anm/65mR0gmUp2CYQRefQYLZcKaBwoprJTKLhh+ygX2jReIaBq12+3LJujmzx
	 qGP72vJ7T5ujaPR+3QkqAFCIH3R5pZYgoZawd7xTEjifTQadBIrJvkdGifTp9j+jEJ
	 cIi0TzFFSnchwvgj9umTNe13T3hfIq1DS3mRi7ug=
Date: Tue, 09 Jul 2024 08:14:55 -0700
From: Antonio Vazquez <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/68864d-34aca9@github.com>
Subject: [bluez/bluez] f00d55: tools/btmgmt: Fix --index option for
 non-interacti...
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
  Commit: f00d5546c9e989dd68ce0de0190cd0e043b0f1f5
      https://github.com/bluez/bluez/commit/f00d5546c9e989dd68ce0de0190cd=
0e043b0f1f5
  Author: Arjan Opmeer <arjan.opmeer@gmail.com>
  Date:   2024-07-09 (Tue, 09 Jul 2024)

  Changed paths:
    M tools/btmgmt.c

  Log Message:
  -----------
  tools/btmgmt: Fix --index option for non-interactive mode

In non-interactive mode the --index option does not work because the
call to mgmt_set_index() is made after bt_shell_attach().

Fixes: https://github.com/bluez/bluez/issues/893


  Commit: 66a76c268d05583c2396054e3f63a19c6f18bb9c
      https://github.com/bluez/bluez/commit/66a76c268d05583c2396054e3f63a=
19c6f18bb9c
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-07-09 (Tue, 09 Jul 2024)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.MediaAssistant.rst

  Log Message:
  -----------
  doc: Add initial MediaAssistant rst

This adds initial documentation for the MediaAssistant D-Bus API, to
be used by a Broadcast Assistant application to interract with the
BlueZ implementation (BASS Client).


  Commit: 34aca9a4fbcf3d4da459f97cef4a863d7853f6e4
      https://github.com/bluez/bluez/commit/34aca9a4fbcf3d4da459f97cef4a8=
63d7853f6e4
  Author: Antonio V=C3=A1zquez Blanco <antoniovazquezblanco@gmail.com>
  Date:   2024-07-09 (Tue, 09 Jul 2024)

  Changed paths:
    M tools/bdaddr.c

  Log Message:
  -----------
  bdaddr: Add cypress manufacturer support


Compare: https://github.com/bluez/bluez/compare/68864d1aa818...34aca9a4fb=
cf

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
