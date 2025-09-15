Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5372D0283
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943193; cv=none; b=d6NfMsHrb9TQijOGaMG+M/Edhf6DroMZab6WbbGsJFYCq338NEiQOJOYm2TnqswmIW9PdaEEyByJBAOLP6pAKzRTAPPtOqR4nd9lVmc15STpM9E59IgowR6Fem8dGsfjv7j3DxBdDxsta4rJk9wttt9Zhhqt5fMjCn7H7lhXr/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943193; c=relaxed/simple;
	bh=fuHhyyxzKu2cqNqh/DgohszUkjP7U8YFo1OUIdBLIos=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gCG0d19rep+590AZ/G07ScYk+0HXAit4NG+z03PK76Nhqe35G4BE3lYu13Dt/MlUSfrli8OZ5OlhQr09Ya+BeKLmGNdOquN/qKrVOi5dDl0kOvzqXrCDcEfbclL4WBaDojsg9+O2zXAEKaK4RKKA8h408+iWAqlVSrbNsf7pjkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ASRzF3s7; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ASRzF3s7"
Received: from github.com (hubbernetes-node-e390919.ac4-iad.github.net [10.52.147.32])
	by smtp.github.com (Postfix) with ESMTPA id 2382B700C1D
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 06:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757943191;
	bh=5xPmjyBdMD9wTuKxo9yQPSGwS9hgg+3S+eUxKpUWRJI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ASRzF3s7K0yTZNF3Jb34RlhOz6P+kZ8bKk8RzTh75v23d2nvqypUfpVIquR6WQLm/
	 VUxjd6CrWMw6NylMTaNLfewyIo1pbsSFmI0/wW9LUe7VYl1+IJHaW3f6dWj41yB7JA
	 smsXQYn/F4eHMLntLEAhG+RIqaBLoDfx0tnJWN40=
Date: Mon, 15 Sep 2025 06:33:11 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/befdac-4d7d25@github.com>
Subject: [bluez/bluez] 9c9d6c: audio: Fix typos in A2DP error messages
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
  Commit: 9c9d6ca27bcb3deb3bc80a7aff2b990e39377dc9
      https://github.com/bluez/bluez/commit/9c9d6ca27bcb3deb3bc80a7aff2b9=
90e39377dc9
  Author: Per Waag=C3=B8 <pwaago@cisco.com>
  Date:   2025-09-15 (Mon, 15 Sep 2025)

  Changed paths:
    M doc/org.bluez.MediaEndpoint.rst
    M profiles/audio/a2dp.c
    M profiles/audio/a2dp.h

  Log Message:
  -----------
  audio: Fix typos in A2DP error messages


  Commit: 4d7d25b702454a7c5e4b88877d463860b10dbd69
      https://github.com/bluez/bluez/commit/4d7d25b702454a7c5e4b88877d463=
860b10dbd69
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-09-15 (Mon, 15 Sep 2025)

  Changed paths:
    M profiles/audio/avdtp.c

  Log Message:
  -----------
  avdtp: wait for L2CAP Disconnect Rsp before CLOSING->IDLE

Delay CLOSING->IDLE until remote acknowledges L2CAP channel closure.

It is not explicitly stated in AVDTP v1.3 Sec. 6.13, but some devices
refuse commands sent immediately after L2CAP Disconnect Req, so wait
until Rsp.

Fails:

> ACL Data RX: Handle 6 flags 0x02 dlen 6
      Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Close (0x08) Response Accept (0x02) type 0x00 label 0 nosp 0=

< ACL Data TX: Handle 6 flags 0x00 dlen 12
      L2CAP: Disconnection Request (0x06) ident 16 len 4
        Destination CID: 65
        Source CID: 65
< ACL Data TX: Handle 6 flags 0x00 dlen 22
      Channel: 64 len 18 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 1 no=
sp 0
        ACP SEID: 7
        INT SEID: 1
        Service Category: Media Transport (0x01)
        Service Category: Media Codec (0x07)
          Media Type: Audio (0x00)
          Media Codec: MPEG-2,4 AAC (0x02)
            Object Type: MPEG-4 AAC LC (0x40)
            Frequency: 44100 (0x100)
            Channels: 2 (0x04)
            Bitrate: 220000bps
            VBR: No
        Service Category: Delay Reporting (0x08)
> ACL Data RX: Handle 6 flags 0x02 dlen 12
      L2CAP: Disconnection Response (0x07) ident 16 len 4
        Destination CID: 65
        Source CID: 65
> ACL Data RX: Handle 6 flags 0x02 dlen 8
      Channel: 64 len 4 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Set Configuration (0x03) Response Reject (0x03) type 0x00 la=
bel 1 nosp 0
        Service Category: Reserved (0x29)
        Error code: UNSUPPORTED_CONFIGURATION (0x29)

Works:

> ACL Data RX: Handle 4 flags 0x02 dlen 6
      Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Close (0x08) Response Accept (0x02) type 0x00 label 12 nosp =
0
< ACL Data TX: Handle 4 flags 0x00 dlen 12
      L2CAP: Disconnection Request (0x06) ident 16 len 4
        Destination CID: 65
        Source CID: 65
> ACL Data RX: Handle 4 flags 0x02 dlen 12
      L2CAP: Disconnection Response (0x07) ident 16 len 4
        Destination CID: 65
        Source CID: 65
< ACL Data TX: Handle 4 flags 0x00 dlen 22
      Channel: 64 len 18 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 13 n=
osp 0
        ACP SEID: 9
        INT SEID: 2
        Service Category: Media Transport (0x01)
        Service Category: Media Codec (0x07)
          Media Type: Audio (0x00)
          Media Codec: MPEG-2,4 AAC (0x02)
            Object Type: MPEG-4 AAC LC (0x40)
            Frequency: 44100 (0x100)
            Channels: 2 (0x04)
            Bitrate: 220000bps
            VBR: No
        Service Category: Delay Reporting (0x08)
> ACL Data RX: Handle 4 flags 0x02 dlen 6
      Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Set Configuration (0x03) Response Accept (0x02) type 0x00 la=
bel 13 nosp 0

Fixes: https://github.com/bluez/bluez/issues/1471
Fixes: aa118e965b ("a2dp: Don't wait to reconfigure")


Compare: https://github.com/bluez/bluez/compare/befdacd236c3...4d7d25b702=
45

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
