Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610D71922DD
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Sep 2025 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757855361; cv=none; b=fLsP/WW0Cx8QwEGCdzBjFy8IFhgd4S+8N2K3/XQTfDmlHsldFT0lgdwcxuWJxeEIIvSpxJW9pEy9tRtoS5EfiiAUpgBqI1B6+aBkggotSGdzy2eK5pzlvLwHrjUa877ZrJzHeWsItI0CeXqx+HKsQSKGUZyl2ig4dz/oVYIK6A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757855361; c=relaxed/simple;
	bh=W3J3CKU9UM7BMuYUMW6cMP4refhxAEcDSZoWXzJglSw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DL+NOfh+9Q28QjdmgbMdgIqST6jRJL6IBHvslyq2lg3rAfVGZRIByA+vA4Czdhd4Uj+9Z6mFryjCO3oTSjNR/zAz4QQy7A4yIY7foL5YVaTkXPUjJfpVk3Tp9h0hJKjbhwzwI8dwDStNVvuaJXsq18H1Q2fYAWGsLR6LkUoRZtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KJFctURN; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KJFctURN"
Received: from github.com (hubbernetes-node-700c305.va3-iad.github.net [10.48.12.95])
	by smtp.github.com (Postfix) with ESMTPA id 734094E03CE
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Sep 2025 06:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757855359;
	bh=qqiM+3oEgK5U8pCyUyv/7w0c4Xn69NSOMqtwP2OGcTE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KJFctURNGNHS7SJjbrwrNKyjhPBOJ0O569hEDdoX5+te36g57KLot/EhhHvm30aEM
	 1KdicVje3oaZ/MAJ7KwhBDJoSsomv1DyIc7hc6jq+7l3Jgpif2aCaDKnpg6F0ma9vx
	 ZMf329Xuiz5NK/7QY2363bViBfofr9JCrfntOhnE=
Date: Sun, 14 Sep 2025 06:09:19 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1002167/000000-bb5d72@github.com>
Subject: [bluez/bluez] bb5d72: avdtp: wait for L2CAP Disconnect Rsp before
 CLOSIN...
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

  Branch: refs/heads/1002167
  Home:   https://github.com/bluez/bluez
  Commit: bb5d72ab477d84f36fb70954d71b17d5f0fadbb6
      https://github.com/bluez/bluez/commit/bb5d72ab477d84f36fb70954d71b17d5f0fadbb6
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-09-14 (Sun, 14 Sep 2025)

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
      AVDTP: Close (0x08) Response Accept (0x02) type 0x00 label 0 nosp 0
< ACL Data TX: Handle 6 flags 0x00 dlen 12
      L2CAP: Disconnection Request (0x06) ident 16 len 4
        Destination CID: 65
        Source CID: 65
< ACL Data TX: Handle 6 flags 0x00 dlen 22
      Channel: 64 len 18 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 1 nosp 0
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
      AVDTP: Set Configuration (0x03) Response Reject (0x03) type 0x00 label 1 nosp 0
        Service Category: Reserved (0x29)
        Error code: UNSUPPORTED_CONFIGURATION (0x29)

Works:

> ACL Data RX: Handle 4 flags 0x02 dlen 6
      Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Close (0x08) Response Accept (0x02) type 0x00 label 12 nosp 0
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
      AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 13 nosp 0
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
      AVDTP: Set Configuration (0x03) Response Accept (0x02) type 0x00 label 13 nosp 0

Fixes: https://github.com/bluez/bluez/issues/1471
Fixes: aa118e965b ("a2dp: Don't wait to reconfigure")



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
