Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B085428839
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772209545; cv=none; b=n1xALJH39lOr0G0PkPg+aYH2QUz9NFquolnZgA95x/jgVTm9S+laEBMO3HOlLYlU4PMokIiCK2AFhef7MDqUMFxUICXKXfzQEN+DRhf8zsHFwUnQrmTxtrE0N3iny12FnQdio5c2EOGVxpe1GXu0CAVc6epIWLRD0lem/BIkDiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772209545; c=relaxed/simple;
	bh=byo9Gsv5pzv4HIUdstk7yAOYCRiw+0tf+yWw/b9E+1g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VCNBbaA56chsbhT83lEubosF1MRAYomCsjh0bSXD1oQF+ebyevvMtHRkzJV/3g8jhauAeo1MhnZYptO+bp5rgjMWCLBuzbISuC2YLauzIAPzUzt2NqvugJCVAKfKH29kXz7Emm/05fD7aADegj0Aq1EioD6D27LXI6fh8dbEy6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iO5JOYxb; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iO5JOYxb"
Received: from github.com (hubbernetes-node-95378a2.ac4-iad.github.net [10.52.222.77])
	by smtp.github.com (Postfix) with ESMTPA id AAF3F640924
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 08:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772209543;
	bh=XdXYx5z6I1WEzgU/X+ppn2agZiyJm/oDbT0mQr5+hmE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iO5JOYxbxi8c8UAF2MXv2AHjPz/sZFmQepwFbJVHMLGgmF0N00l8OJ8LEO3HfSUWq
	 9oSoultYjGFGlAanjI5oZXxmENdiqFC22QQNboX4tj7TfbCn2wwg4ZA0kQD9m69gOt
	 YXcWRiWuLh/aIUtF6DbT/fm+/7tyf5j8ZiuayrWs=
Date: Fri, 27 Feb 2026 08:25:43 -0800
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1059103/000000-8b909d@github.com>
Subject: [bluez/bluez] b19a85: doc/qualification: gap-pics: add footnote for
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

  Branch: refs/heads/1059103
  Home:   https://github.com/bluez/bluez
  Commit: b19a85b5fd44e274f031c9dee98b913010f3b28f
      https://github.com/bluez/bluez/commit/b19a85b5fd44e274f031c9dee98b913010f3b28f
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M doc/qualification/gap-pics.rst

  Log Message:
  -----------
  doc/qualification: gap-pics: add footnote for TSPC_GAP_21_9 feature

This feature is not supported by some host controllers (e.g. RTL8761BU)
and must be disabled with such hardware.


  Commit: 6a73d94d17fc90c308f50849b0afd4d72f0c719e
      https://github.com/bluez/bluez/commit/6a73d94d17fc90c308f50849b0afd4d72f0c719e
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M doc/qualification/gap-pts.rst

  Log Message:
  -----------
  doc/qualification: gap-pts: fix GAP/SEC/CSIGN/* tests

These tests require an additional characteristic for authenticated
signed writes:

> Couldn't find a characteristic which supports ATT Signed Write.


  Commit: 5363f436812b977062f4f907d7c6cc77d7e46877
      https://github.com/bluez/bluez/commit/5363f436812b977062f4f907d7c6cc77d7e46877
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M doc/qualification/gap-pts.rst

  Log Message:
  -----------
  doc/qualification: gap-pts: fix GAP/SEC/SEM/BV-24-C test

The test complains if the characteristic is created with read,write


  Commit: ac227fa1146f9d6947bee2dc0db954bac76704a9
      https://github.com/bluez/bluez/commit/ac227fa1146f9d6947bee2dc0db954bac76704a9
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M doc/qualification/sm-pics.rst

  Log Message:
  -----------
  doc/qualification: sm-pics: update capabilities in table 7b

Match naming with current Qualification Workspace


  Commit: b6fc33d4e2220d576175fa5329f6009b5ade3519
      https://github.com/bluez/bluez/commit/b6fc33d4e2220d576175fa5329f6009b5ade3519
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M doc/qualification/sm-pts.rst

  Log Message:
  -----------
  doc/qualification: sm-pts: fix SM/PER/PKE/BI-03-C and BV-02-C tests

Running 'btmgmt' is not required, passkey in shown in bluetoothctl.


  Commit: b62e46860d84dd853c88d1fd036d13d739a7d640
      https://github.com/bluez/bluez/commit/b62e46860d84dd853c88d1fd036d13d739a7d640
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M doc/qualification/sm-pts.rst

  Log Message:
  -----------
  doc/qualification: sm-pts: fix SM/PER/SCPK/BI-03-C test

Running 'btmgmt' is not required, passkey in shown in bluetoothctl.


  Commit: 03e8cdbcb6471eba8301123204c0c971cefb503c
      https://github.com/bluez/bluez/commit/03e8cdbcb6471eba8301123204c0c971cefb503c
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M doc/qualification/sm-pts.rst

  Log Message:
  -----------
  doc/qualification: sm-pts: add description for M/PER/PIS/BV-0[1-2]-C


  Commit: 1833a3577ec852a6182e2dd0ad3d1a8b92af103e
      https://github.com/bluez/bluez/commit/1833a3577ec852a6182e2dd0ad3d1a8b92af103e
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M doc/qualification/sm-pts.rst

  Log Message:
  -----------
  doc/qualification: sm-pts: add description for SM/PER/KDU/BI-04-C test


  Commit: 5fad0c8dab26c770e4e521c2609b1300bed893a3
      https://github.com/bluez/bluez/commit/5fad0c8dab26c770e4e521c2609b1300bed893a3
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M doc/qualification/gatt-pts.rst

  Log Message:
  -----------
  doc/qualification: gatt-pts: add description for GATT/SR/GAW/BI-39-C


  Commit: 5fddfac97bde4ed88506938e1854f140a1c1dbce
      https://github.com/bluez/bluez/commit/5fddfac97bde4ed88506938e1854f140a1c1dbce
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

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


  Commit: 3060f01bb44e1cea2606eeb03cefe8686805a83a
      https://github.com/bluez/bluez/commit/3060f01bb44e1cea2606eeb03cefe8686805a83a
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M doc/qualification/gatt-pts.rst

  Log Message:
  -----------
  doc/qualification: gatt-pts: add description for GATT/SR/GAN/BV-03-C

Same as for GATT/SR/GAN/BV-01-C.


  Commit: 687ea77bfcb425e7d760bdddf25a5a14e0509587
      https://github.com/bluez/bluez/commit/687ea77bfcb425e7d760bdddf25a5a14e0509587
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

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


  Commit: 2fe3096bea3db025ac0bb75f0ed3b2ce04a0d139
      https://github.com/bluez/bluez/commit/2fe3096bea3db025ac0bb75f0ed3b2ce04a0d139
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M doc/qualification/gatt-pts.rst

  Log Message:
  -----------
  doc/qualification: gatt-pts: add description for GATT/SR/GAI/BV-02-C

Same as for GATT/SR/GAI/BV-01-C


  Commit: 8b1b9cb59a751735f187a9218cd53d7a1c2804dd
      https://github.com/bluez/bluez/commit/8b1b9cb59a751735f187a9218cd53d7a1c2804dd
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M doc/qualification/l2cap-pts.rst

  Log Message:
  -----------
  doc/qualification: l2cap-pts: remove redundant test documentation

L2CAP/LE/REJ/BI-01-C is documented twice


  Commit: 8b909d0ef21372a770bfa4ae976fbb5d8fc076f9
      https://github.com/bluez/bluez/commit/8b909d0ef21372a770bfa4ae976fbb5d8fc076f9
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M doc/qualification/l2cap-pics.rst
    M doc/qualification/l2cap-pts.rst

  Log Message:
  -----------
  doc/qualification: l2cap-pts: add descriptions for LE CFC tests

All these tests depend on TSPC_L2CAP_2_46. Some tests require kernel
fixes.


Compare: https://github.com/bluez/bluez/compare/b19a85b5fd44%5E...8b909d0ef213

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
