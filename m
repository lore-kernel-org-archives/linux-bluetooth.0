Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB303FD15D
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461665; cv=none; b=roSZN0MCTSgZtgjBP+uTxwP4fXorcU1y+Tm9HrAN+D++G0K8/cBBWTKjmCDCYx/nCBCN5lPuG/gEEdL3hwhGtkwyVky36cpDRXykBtVdcdlLsmVoI3fi8m+L5lJSlkhuIJJ+dwRqlt89R1nzvAMZ9lFaPH+vJFyXJT+Qb/xCY6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461665; c=relaxed/simple;
	bh=FZjVK0CSHQSwmrLUuVdZjfLWWZkX02ITarpgdN/h77A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZhfBOhf+yiB4LDJRQm7SRCn24yPYogFICOC6hBKCsy/UY7+FxBBr/Er+Zo6PMBkQ+KCt49rpV2UCe2lZIcXpUMYtwqmyvVGFkiDJ3ufWlqrVNDmf6FcpgOV9lDP6wd7M5mPvEILCYR1cWWEND/JsFleQfGW2GhXPqdi+HC/dtIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cXVnHNbj; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cXVnHNbj"
Received: from github.com (hubbernetes-node-6d0a2fa.va3-iad.github.net [10.48.13.81])
	by smtp.github.com (Postfix) with ESMTPA id 9DC62E138C
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 06:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772461662;
	bh=t3g+bi9i2pm2w0j6xVXPoJa0pyMQrlRXGqIYZyYf7S8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cXVnHNbjxNXG0cI+0sLZF2rD0r7p/DRliSrsGDwtZ2VMORHsObFZg5Uvl4AguvUD8
	 mFT0GofDdrmA3tsFUFufcpFcK1fOwPTctioZw4EjbWum7BLjStPsoAHam89DKNtMSX
	 BjBPbABAoP3jKRaSeE+ckoNlBS+VQg2B58rABbq4=
Date: Mon, 02 Mar 2026 06:27:42 -0800
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1060034/000000-5d4c8e@github.com>
Subject: [bluez/bluez] 83cf08: doc/qualification: gap-pics: add footnote for
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

  Branch: refs/heads/1060034
  Home:   https://github.com/bluez/bluez
  Commit: 83cf08d2adc6283461d836637d9208f199ef6f05
      https://github.com/bluez/bluez/commit/83cf08d2adc6283461d836637d9208f199ef6f05
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/gap-pics.rst

  Log Message:
  -----------
  doc/qualification: gap-pics: add footnote for TSPC_GAP_21_9 feature

This feature is not supported by some host controllers (e.g. RTL8761BU)
and must be disabled with such hardware.


  Commit: 6e368776f010430ef272c75a40a0050bafc4aad8
      https://github.com/bluez/bluez/commit/6e368776f010430ef272c75a40a0050bafc4aad8
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


  Commit: c22782b662601d9b6d4ae77788feb2592d51d417
      https://github.com/bluez/bluez/commit/c22782b662601d9b6d4ae77788feb2592d51d417
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/gap-pts.rst

  Log Message:
  -----------
  doc/qualification: gap-pts: fix GAP/SEC/SEM/BV-24-C test

The test complains if the characteristic is created with read,write


  Commit: 83a70412606d1c3ad36ba161908135eec2c0cb3c
      https://github.com/bluez/bluez/commit/83a70412606d1c3ad36ba161908135eec2c0cb3c
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/sm-pics.rst

  Log Message:
  -----------
  doc/qualification: sm-pics: update capabilities in table 7b

Match naming with current Qualification Workspace


  Commit: fcfd90ec54be851103cf0e20d859ca52609c4dd9
      https://github.com/bluez/bluez/commit/fcfd90ec54be851103cf0e20d859ca52609c4dd9
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/sm-pts.rst

  Log Message:
  -----------
  doc/qualification: sm-pts: fix SM/PER/PKE/BI-03-C and BV-02-C tests

Running 'btmgmt' is not required, passkey in shown in bluetoothctl.


  Commit: d39c70c63d8b36847682042d744341fe8a2766ab
      https://github.com/bluez/bluez/commit/d39c70c63d8b36847682042d744341fe8a2766ab
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/sm-pts.rst

  Log Message:
  -----------
  doc/qualification: sm-pts: fix SM/PER/SCPK/BI-03-C test

Running 'btmgmt' is not required, passkey in shown in bluetoothctl.


  Commit: 8d1a37021d7c7a1c73c40f15a038804fd25ffc98
      https://github.com/bluez/bluez/commit/8d1a37021d7c7a1c73c40f15a038804fd25ffc98
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/sm-pts.rst

  Log Message:
  -----------
  doc/qualification: sm-pts: add description for M/PER/PIS/BV-0[1-2]-C


  Commit: b5571b7aa3b4b22cd5111cde33aa4f69626416f6
      https://github.com/bluez/bluez/commit/b5571b7aa3b4b22cd5111cde33aa4f69626416f6
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/sm-pts.rst

  Log Message:
  -----------
  doc/qualification: sm-pts: add description for SM/PER/KDU/BI-04-C test


  Commit: 5d1af29506ea1c690037bd9fcb86393322bf7c34
      https://github.com/bluez/bluez/commit/5d1af29506ea1c690037bd9fcb86393322bf7c34
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/gatt-pts.rst

  Log Message:
  -----------
  doc/qualification: gatt-pts: add description for GATT/SR/GAW/BI-39-C


  Commit: 60eee191739f4d7d7db45afed636f9dd4dc85d4e
      https://github.com/bluez/bluez/commit/60eee191739f4d7d7db45afed636f9dd4dc85d4e
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


  Commit: 0414a2b8a9885daac1fbf8d05e6313718b4038d1
      https://github.com/bluez/bluez/commit/0414a2b8a9885daac1fbf8d05e6313718b4038d1
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/gatt-pts.rst

  Log Message:
  -----------
  doc/qualification: gatt-pts: add description for GATT/SR/GAN/BV-03-C

Same as for GATT/SR/GAN/BV-01-C.


  Commit: f8ae5dfd6c2c8cf06a8cf3e0c723fd30ccb2008e
      https://github.com/bluez/bluez/commit/f8ae5dfd6c2c8cf06a8cf3e0c723fd30ccb2008e
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


  Commit: 866797a67eeeede9e863a55fc9fde5068c56abf2
      https://github.com/bluez/bluez/commit/866797a67eeeede9e863a55fc9fde5068c56abf2
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/gatt-pts.rst

  Log Message:
  -----------
  doc/qualification: gatt-pts: add description for GATT/SR/GAI/BV-02-C

Same as for GATT/SR/GAI/BV-01-C


  Commit: 82bc4d15e371c447c9c0ba08ab0ac14361471b5a
      https://github.com/bluez/bluez/commit/82bc4d15e371c447c9c0ba08ab0ac14361471b5a
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-02 (Mon, 02 Mar 2026)

  Changed paths:
    M doc/qualification/l2cap-pts.rst

  Log Message:
  -----------
  doc/qualification: l2cap-pts: remove redundant test documentation

L2CAP/LE/REJ/BI-01-C is documented twice


  Commit: 5d4c8e755c90556cac5be9645960e0c503f41747
      https://github.com/bluez/bluez/commit/5d4c8e755c90556cac5be9645960e0c503f41747
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


Compare: https://github.com/bluez/bluez/compare/83cf08d2adc6%5E...5d4c8e755c90

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
