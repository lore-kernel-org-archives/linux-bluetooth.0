Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B56C3D9DB0
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773246924; cv=none; b=SEh44hWBAcc3lhzrVeIloE8dhG+1+4PvqnsV4qcXPf3CI1jmAQ3hvuyhW/7wu1zIx6o6w2+YZhKDllyRq19ZG2bjka+om+aJIf+AXZMRXDlT3Fo2eE5odCwshxaJ3cuqnDUOeUF8s1+YngoIviCI10zQUJBImntS3BwW6BibWe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773246924; c=relaxed/simple;
	bh=vgBBGA94UuSorrYZet6DzF/XE8COkTzD6P8r2bdhpjs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dKFcUb5oBdwxO6xmSnHd7Yk4U31SqR+Bfq7JErMnKLvbe86SDEaBpVj04Ukyr4eGmLoBHVrfahQobX15JUnyxJW4l2juZmS3lbBLhmTLnuyiE7pa0/gs35jkKfmwXzHDxauemeaIz57c5RW8tI+CNeg07R1jyYoOAbmkCAwm7g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=O8W/RwfB; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="O8W/RwfB"
Received: from github.com (hubbernetes-node-df451ee.ac4-iad.github.net [10.52.220.37])
	by smtp.github.com (Postfix) with ESMTPA id 486DB640544
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 09:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773246921;
	bh=A3FedaUt0yIK1NblPMhi8RaMei5DWa8V6sMFH7TY9wc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=O8W/RwfBOtNBod3amXqKulx78NqjY+V3YvgJo5shlTAWiCuVx6j+vQUvBnzIb3Nma
	 r0Y91pzFAPfrypWYfV1Fo94/NMco99v3koXE+rp6FUH7PPOU/OiURNqMvHEAZC6JV5
	 rPkde9VkOou5edvfyq6J84uxyU/IDL2HIaQ0yO2w=
Date: Wed, 11 Mar 2026 09:35:21 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1065141/000000-6e61a1@github.com>
Subject: [bluez/bluez] 3c4727: bthost: fix receiving timestamped ISO packets
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

  Branch: refs/heads/1065141
  Home:   https://github.com/bluez/bluez
  Commit: 3c4727b1b14125a6d168a515de6806dcae1d99c4
      https://github.com/bluez/bluez/commit/3c4727b1b14125a6d168a515de6806dcae1d99c4
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-11 (Wed, 11 Mar 2026)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h
    M tools/iso-tester.c

  Log Message:
  -----------
  bthost: fix receiving timestamped ISO packets

Parse timestamped ISO packets correctly. Pass sequence number and
timestamp to the hook callback.


  Commit: 9dbe3541d45a7e6ca8ca2eef40afd7c498f156ab
      https://github.com/bluez/bluez/commit/9dbe3541d45a7e6ca8ca2eef40afd7c498f156ab
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-11 (Wed, 11 Mar 2026)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: implement LE Read ISO TX Sync command

Parse incoming ISO packets and implement LE Read ISO TX Sync.

The timestamps and sequence numbers are just some values; the emulator
does not have real ISOAL or clock, and we don't attempt to add them
here.  The last transmitted numbers are tracked in struct iso_data
attached to each ISO connection.


  Commit: 6abb1ae2b88769c9c25cfedb5b6115d8ad892644
      https://github.com/bluez/bluez/commit/6abb1ae2b88769c9c25cfedb5b6115d8ad892644
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-11 (Wed, 11 Mar 2026)

  Changed paths:
    M tools/iso-tester.c
    M tools/l2cap-tester.c
    M tools/sco-tester.c
    M tools/tester.h

  Log Message:
  -----------
  iso-tester: add tests for ISO HW timestamps

Add tests that check LE Read ISO TX Sync handling in kernel

ISO Send - HW Timestamping
ISO Send - SWHW Timestamping


  Commit: 6e61a1bb2b22927045cb9f40b98610e5525cd948
      https://github.com/bluez/bluez/commit/6e61a1bb2b22927045cb9f40b98610e5525cd948
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-11 (Wed, 11 Mar 2026)

  Changed paths:
    M tools/iso-tester.c
    M tools/tester.h

  Log Message:
  -----------
  iso-tester: Add test for sending ISO packets with set timestamps

Add test

ISO Send - Set HW Timestamp


Compare: https://github.com/bluez/bluez/compare/3c4727b1b141%5E...6e61a1bb2b22

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
