Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBBA2FE044
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 20:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772482751; cv=none; b=J//Vnsh3OBgp5M0EyZYSji9MOXpWdS4PyofxpsjGYIHeqWDCsNE3Cj8OTOZKd07XWziGa2JeyxfZ+i5qiwN7cL+cBi6/pwlXvz8JYdxVCxl0Yis2vnhYDPJ6zqJLL/BJFiVWrMIv7bfAZNc4/kbBaJBxN8H5Ay2g5HcFtWHjGlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772482751; c=relaxed/simple;
	bh=4iW3XBJ8gXBtiPbUUnqU7hSbsNqc2aE928nOTU2GmIk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=A1kMKH+MF9oVw/JT9zW5tTtXyjM8vL+TgRO7i10J2GW2E2zjOIwO1t60wWbkCyNXeOJHLUiNEqpq+pEeE0G/8QsbetH713h64yU41gdFXcS/8/gS0/Gk5K+cm+Ovx+v2jMdO+N5CrViEdGMJvFhmcPgJPMHu21V2VW2GFWZhARA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gIP/mP4D; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gIP/mP4D"
Received: from github.com (hubbernetes-node-708af72.va3-iad.github.net [10.48.220.58])
	by smtp.github.com (Postfix) with ESMTPA id D390BE0BB5
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 12:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772482748;
	bh=FBp+5YHtjFLp3qLdoOvM0RzIygi3RWWO1riPoHIaMq4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gIP/mP4DHtUdu4Y359K6X5TjtaPpyux84YfbHyWZv1hzwCIb2wZG1F3MTz2p1XCxZ
	 ffX3uFxFG96P2ELhy4kqF/nW0rgmw3f1+6nHYdxU+4kecNEsUXVFNFtTTGG7MniQ96
	 x41+WnrM5QpUMterVxDCPchii1/15VTxnkI3i1TY=
Date: Mon, 02 Mar 2026 12:19:08 -0800
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/21e139-d99f2e@github.com>
Subject: [bluez/bluez] 1b7e68: doc/qualification: gap-pics: add footnote for
 TSPC...
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
  Commit: 1b7e682ef4b7641d12da43082fa00cfee55d4492
      https://github.com/bluez/bluez/commit/1b7e682ef4b7641d12da43082fa00cfee55d4492
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/gap-pics.rst

  Log Message:
  -----------
  doc/qualification: gap-pics: add footnote for TSPC_GAP_21_9 feature

This feature is not supported by some host controllers (e.g. RTL8761BU)
and must be disabled with such hardware.


  Commit: 4da5d644b884d320f755a3922e2f25336051370f
      https://github.com/bluez/bluez/commit/4da5d644b884d320f755a3922e2f25336051370f
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/gap-pts.rst

  Log Message:
  -----------
  doc/qualification: gap-pts: fix GAP/SEC/CSIGN/* tests

These tests require an additional characteristic for authenticated
signed writes:

> Couldn't find a characteristic which supports ATT Signed Write.


  Commit: 737b2e6b106722fe929ababb94e11f15d7c08bd6
      https://github.com/bluez/bluez/commit/737b2e6b106722fe929ababb94e11f15d7c08bd6
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/gap-pts.rst

  Log Message:
  -----------
  doc/qualification: gap-pts: fix GAP/SEC/SEM/BV-24-C test

The test complains if the characteristic is created with read,write


  Commit: 68b03755160d033d864c03c2d039029b73213a37
      https://github.com/bluez/bluez/commit/68b03755160d033d864c03c2d039029b73213a37
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/sm-pics.rst

  Log Message:
  -----------
  doc/qualification: sm-pics: update capabilities in table 7b

Match naming with current Qualification Workspace


  Commit: 61424fa2886f9146130b9831fb4c55a8095af7ce
      https://github.com/bluez/bluez/commit/61424fa2886f9146130b9831fb4c55a8095af7ce
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/sm-pts.rst

  Log Message:
  -----------
  doc/qualification: sm-pts: fix SM/PER/PKE/BI-03-C and BV-02-C tests

Running 'btmgmt' is not required, passkey in shown in bluetoothctl.


  Commit: 160e9bdf20ae16102deb0c72189ecb6f00ca24c0
      https://github.com/bluez/bluez/commit/160e9bdf20ae16102deb0c72189ecb6f00ca24c0
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/sm-pts.rst

  Log Message:
  -----------
  doc/qualification: sm-pts: fix SM/PER/SCPK/BI-03-C test

Running 'btmgmt' is not required, passkey in shown in bluetoothctl.


  Commit: 682fff74cd2aa78397f422df21e8aafbd34afaf7
      https://github.com/bluez/bluez/commit/682fff74cd2aa78397f422df21e8aafbd34afaf7
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/sm-pts.rst

  Log Message:
  -----------
  doc/qualification: sm-pts: add description for M/PER/PIS/BV-0[1-2]-C


  Commit: 19b050c73b60f0b7fa27d6b39eec1aa3aee2b8b9
      https://github.com/bluez/bluez/commit/19b050c73b60f0b7fa27d6b39eec1aa3aee2b8b9
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/sm-pts.rst

  Log Message:
  -----------
  doc/qualification: sm-pts: add description for SM/PER/KDU/BI-04-C test


  Commit: db7d1a9c770c57c815be98cf2c4841591952a2e0
      https://github.com/bluez/bluez/commit/db7d1a9c770c57c815be98cf2c4841591952a2e0
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/gatt-pts.rst

  Log Message:
  -----------
  doc/qualification: gatt-pts: add description for GATT/SR/GAW/BI-39-C


  Commit: a87273da5a469f7aee132f87887ddbeb27740f94
      https://github.com/bluez/bluez/commit/a87273da5a469f7aee132f87887ddbeb27740f94
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/gatt-pts.rst

  Log Message:
  -----------
  doc/qualification: gatt-pts: update description for GATT/SR/GAN/BV-01-C

'btgatt-server' exits after PTS disconnects and is not available when
PTS reconnects. Starting btgatt-server again would solve the problem,
but we should prefer testing with the real GATT daemon instead of using
debugging containers. Additionally, this solution also works for
GATT/SR/GAN/BV-03-C (next commit).


  Commit: 268d715b80e0af4d641f91b27576b25ce905e36d
      https://github.com/bluez/bluez/commit/268d715b80e0af4d641f91b27576b25ce905e36d
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/gatt-pts.rst

  Log Message:
  -----------
  doc/qualification: gatt-pts: add description for GATT/SR/GAN/BV-03-C

Same as for GATT/SR/GAN/BV-01-C.


  Commit: 7a2d04492f9809727786b43cbac1b2934572634d
      https://github.com/bluez/bluez/commit/7a2d04492f9809727786b43cbac1b2934572634d
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/gatt-pts.rst

  Log Message:
  -----------
  doc/qualification: gatt-pts: update description for GATT/SR/GAI/BV-01-C

This tests requires an indication on the "Service Changed"
characteristic of the builtin "GATT" service. This indication can be
raised by adding (or removing) a custom service. Of course we have to do
this at the point when PTS is expecting to revice the notification.

https://lore.kernel.org/linux-bluetooth/CABBYNZ+O6KbjXoxTKSaPnSd=p2CDJ7j6cBktPT4xXD=PR0CBhA@mail.gmail.com/


  Commit: 04af0bbeca6309644c06fc9ce2399195db8f9eda
      https://github.com/bluez/bluez/commit/04af0bbeca6309644c06fc9ce2399195db8f9eda
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/gatt-pts.rst

  Log Message:
  -----------
  doc/qualification: gatt-pts: add description for GATT/SR/GAI/BV-02-C

Same as for GATT/SR/GAI/BV-01-C


  Commit: 8a2186d6926f062f82bf0f69f64416374c053c8e
      https://github.com/bluez/bluez/commit/8a2186d6926f062f82bf0f69f64416374c053c8e
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/l2cap-pts.rst

  Log Message:
  -----------
  doc/qualification: l2cap-pts: remove redundant test documentation

L2CAP/LE/REJ/BI-01-C is documented twice


  Commit: d99f2e129634f80843e5cdacf06f8dc9b9096ea5
      https://github.com/bluez/bluez/commit/d99f2e129634f80843e5cdacf06f8dc9b9096ea5
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/l2cap-pics.rst
    M doc/qualification/l2cap-pts.rst

  Log Message:
  -----------
  doc/qualification: l2cap-pts: add descriptions for LE CFC tests

All these tests depend on TSPC_L2CAP_2_46. Some tests require kernel
fixes.


Compare: https://github.com/bluez/bluez/compare/21e13976f2e3...d99f2e129634

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
