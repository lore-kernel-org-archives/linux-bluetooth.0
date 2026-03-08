Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB07F35F17A
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Mar 2026 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772974110; cv=none; b=ltLSEr8pzyQykwR5G4LTX7FBJq0HYgUBDcTcyecOHd/Z/jfc+nrVAAR5QQExWDK0qwHWlOsCmZDA0Ii3Bk0w0VE6s3/B9Xm+/0eJSm/U2bO3F9korccI9fbLyYDxYSHcovsJsgCDhiTv28EM2mrKIDaKux5/mKicDY8YPLFjohg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772974110; c=relaxed/simple;
	bh=/O+LzGqq4BawnyWAovxHmE+b4XLbeJv7bmXqbtiKC38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kUpWNKqejnZbmgKKWjO4R6KH7hhPhwEMmAAP1bi8/Otl1cUajkOVGnagB0Zrag++DQyz2H5jZKXX3apq36CYbFlTiPnPZ1DkAVggwZ7chzDfTUOgZEULL3LpKANOf6ZRUuB6IbIq3w02YTSUxQH1RNe36hb/3d82R855hfMoNXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=LYQ1RQD1; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="LYQ1RQD1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1772974101; x=1773578901; i=martinbts@gmx.net;
	bh=LVmaX9pqdNp9PT9ptbTgn2C9XOnEblDahj8ZgN9S43Q=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LYQ1RQD1m7KSKke9RvafvCI7GTcF1V1LN6WUt5u9lbSGMMBq3dzFJMJHS782opLX
	 stJuhu17nrk+vRXF1za+qaO4P6BfqkR3iF8w8ClsFW0Wpm0XF+QBvVOpMN9aDGuqf
	 Cd3h2SaLN3wuqahunpOVRxyNTijmg7DkiXC6q2H+8wtvn2uFPcUWa8gpmlsepLmCY
	 0Fp7qL1mxA37YZAQMcS0xf0qFYTdZFTP6A3x5mT4tDvw7rgQrVomNTmZlXdi0Y3Xg
	 NDvJlgzYuql0wZxYEt5spynYFMrtG2dazxdnHI9yz41o9krBpq2tOseljhS/nFfbw
	 zDAGAL6lQsRX7Z30lg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbzyP-1vN9Ja2qS7-00icUs; Sun, 08
 Mar 2026 13:48:21 +0100
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net,
	luiz.dentz@gmail.com,
	vi@endrift.com,
	Martin BTS <martinbts@gmx.net>
Subject: [PATCH BlueZ v2 0/6] Nintendo Switch 2 support
Date: Sun,  8 Mar 2026 13:47:37 +0100
Message-ID: <20260308124745.19248-1-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1391Q8n+EHR7mwpSGnBWCrE37QGCboVsEf0sq9FtGGWZ67SQOTG
 JImBu8O+zl8PtGW1pEUWa3zz93DW5P03VHZ9BZ2wRXwkILhnIrDXb+mLID1H35KuEXHmanQ
 IxZsgiIYz+bnA/BVW+IVJzd189cKPReywoIoJoV2AfSv4mHNc3/7fp+Jgnymlh9ehGNRQX7
 wtrjzHp+evHbJVwe4WByg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eqCtEvPnG80=;mLPnsJ42qqFD019heVfnBXCeGoY
 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
 e2xQewHuWl3PFm7JQ=

Changes v2:
* Drop original patches 1 and 2 (tollerate ATT timeout)
* New patches 1, 2, 3 introduce a device property skip_secondary,
  that makes secondary device discovery optional
* set_alias() is now public btd_device_set_alias() as suggested
* Fix assigned numbers reference comment
* Link to v1: https://lore.kernel.org/all/20260301152930.221472-1-martinbt=
s@gmx.net/

v2 blurb:

The problem is the secondary service discovery. It will time out on the
Procon2 which is essentially an unrecoverable error and we cannot
connect the controller as a result.

This patchset proposes making the secondary service discovery optional,
so that we can prevent dealing with the Procon2's behaviour.
It now is a property of the device, if it wants/needs a secondary
discovery, or not. This allows device specific plugins to make the
correct configuration in time, bevor a gatt-client is created. The
default is the original behaviour: do a secondary services discovery.

I marked patch 1 as a breaking change, because of how it changes the
gatt-client interface. It appears this gatt-client is only used
internally and never exposed so it technically isn't a breaking change
for BlueZ, but I cannot be sure.

For the record: The Procon2 reports appearance 0x0A82 Portable handheld co=
nsole

Martin BTS (6):
  shared/gatt: make secondary discovery optional
  device: allow skip secondary discovery
  fixup: propagate new gatt interface through codebase
  device: Rename set_alias to  btd_device_set_alias()
  dbus-common: Add Gaming appearance class (0x2a)
  plugins/switch2: Add Nintendo Switch 2 Controller plugin

 Makefile.plugins         |    3 +
 peripheral/gatt.c        |    5 +-
 plugins/switch2.c        | 1070 ++++++++++++++++++++++++++++++++++++++
 src/dbus-common.c        |    2 +
 src/device.c             |   33 +-
 src/device.h             |    2 +
 src/shared/gatt-client.c |   22 +-
 src/shared/gatt-client.h |    4 +-
 tools/btgatt-client.c    |    5 +-
 unit/test-bap.c          |    3 +-
 unit/test-gatt.c         |    3 +-
 unit/test-gmap.c         |    3 +-
 unit/test-mcp.c          |    3 +-
 unit/test-micp.c         |    3 +-
 unit/test-tmap.c         |    3 +-
 15 files changed, 1133 insertions(+), 31 deletions(-)
 create mode 100644 plugins/switch2.c

=2D-=20
2.47.3

