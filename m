Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003A832142B
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Mar 2026 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772378981; cv=none; b=N2Bj3+ODaW//+GrHmGqil8NrnPta+Zae4a+AJA+cyRQuCXPwpoUffDsNmzjQiZAQvW9wwEKNl1pmeFcsdO7EVlp4PI+jsFLTFauE0ts6uJUrytXs2IWsh5hxYieG+pyiySQSJQ+vJfd4Xu7ihSUb3q4Zq5u59l5C1jfjyz5f/84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772378981; c=relaxed/simple;
	bh=O7l1Mbfxp8ddf5OicRK892Ho01f5c0KpqLz4DRpfRAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I6Zu0s6OAm/xjstzhQ3/2pzQZoz9najOWI9gWjyDO95TD5sgMsSRHSLmyI/lXNL8L41PyN8EZPeSW+jb2T3MO+TtAKCcIGUFkqlpc/uClJLp3a70+PDMmVuUFaw1fVGUizbRhxESTCujUk1sdDUb2/eNrb8VcAg54pRSSYSxD5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=U0eM3Zxg; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="U0eM3Zxg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1772378978; x=1772983778; i=martinbts@gmx.net;
	bh=jMpmJ+RFGQD1Rgz/y56n2RhDU2SaXn5Kxm6TZsY9Gng=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=U0eM3ZxgrwFY5GyEwqhv7Gr5WkJ8cIoCVxZGYZNz70M+OAvX4dciqIlO4T5IoEMn
	 weitmLEkLH99mqlLPK5qgGxnSMMflM8hy1MLWdaFiCmin33C3thLAJO/eiCJDNMrB
	 ewLW1GSydgpB3Q94bLxeNPIjs52ZnqhCDEwwXns0i1vB6ep0retKvjOd+/lb5FfL0
	 7yNXqaPXq4QQdt6LBTaCSlGWxIFAZpNOuNnbflp3j04WP5P4OO2SfAycaIRuXx2RD
	 LMEYFrrflkXj8prguxvqJ2gcVIscyKz5gd7vmsesQP0YOqfvVd2JGxuMqjh1Jkvfj
	 FtkMTS6gVRO9sPHZTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgvvJ-1vTPfb0ClB-00kcTe; Sun, 01
 Mar 2026 16:29:38 +0100
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: Martin BTS <martinbts@gmx.net>
Subject: [PATCH BlueZ 0/5] Enable and add support for Nintendo Switch 2 controllers
Date: Sun,  1 Mar 2026 16:29:25 +0100
Message-ID: <20260301152930.221472-1-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DXTxQAWHLvyR4BdMHlnU078fJpUnPpn0+ajhyLPYBqKlrwFJo+n
 LJ4fBMdgqMF0BFrKCsBv5m/DIOaVDUdh0dikiTud/4PyLq0ICyKWP9q1hdShmyiri+z8zGT
 Eiln7OKR4n/y/689+J4S8Macaetfjart9VV/N2Dr4UrXkJod4167L+a36PdWdhzU9uNkzsP
 kjw5mZhPPn40iO9T+pm6w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:88S+IwyXYp0=;vNVZxsPPfZFpbcxU665UdqRM1Le
 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
 3vgjIBJHvgIVCYSKeCFniGsYyYXjZRsZjQf3dg

The Nintendo Switch 2 controllers are special in their handshake
(requirements) and the way how they use GATT notifications to transport us=
er
input.

This patchset plows the road and introduces an initial plugin for NS2
controllers, resulting in a uhid device that can be sensibly used by
hid-generic but is also supposed to sit well with the new (out-of-tree)
hid-switch2 driver.

Patches 1 and 2 are required, 3 and 4 are QoL improvements and patch 5
is the Nintendo Switch 2 specific part.

Disclaimer:
I only have a Pro Controller 2 and all work has been done with this Pro
Controller 2 only. This is also my first contribution ever this close to t=
he
kernel. I may only appear to know what I am doing and the development stat=
us
is "works on my machine".=20

Martin BTS (5):
  shared/att: Don't disconnect on ATT request timeout
  shared/gatt-client: Handle secondary discovery timeout
  device: Add btd_device_set_alias()
  dbus-common: Add Gaming appearance class (0x2a)
  plugins/switch2: Add Nintendo Switch 2 Controller plugin

 Makefile.plugins         |    3 +
 plugins/switch2.c        | 1053 ++++++++++++++++++++++++++++++++++++++
 src/dbus-common.c        |    2 +
 src/device.c             |   14 +
 src/device.h             |    1 +
 src/shared/att.c         |   12 +-
 src/shared/gatt-client.c |   13 +
 7 files changed, 1094 insertions(+), 4 deletions(-)
 create mode 100644 plugins/switch2.c

=2D-=20
2.47.3

