Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061E220322
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Sep 2025 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757852435; cv=none; b=dx9V79nw6fVuRPtWuveE1RAmyWAo3dwMS/avczspilnV36VsoXaTwpXOocgs9FHr9XWLyWib4Kqju9GtixPRGuh2zWuQ0r8itOuGZFfdKUMySY/ATx18Ulk/tocr7ksmTLuy1teppJ4qgGDhZwxY8qdsVPgEfjU6rqr6bFlHnjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757852435; c=relaxed/simple;
	bh=pl9JM18xNnaIdi5sbrSRI1YFMiAtTUnHIrAYWwkK6PY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=feUneAyhMuHMls+SmlHtp5oxTVd1VQmyR82icB5Y6qK5Uqk+EVfezJnolKjt8m0orCPQCO/gp1mTbADv87yq1HBO+M6bhIGKEsyx6R88nihwFxUIOCeCyJv2cBpMK/di2Pqn8LASTxD97/xLpuJBgvEe6rl3l4uylbOc+qkLBkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ey53npWU; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ey53npWU"
Received: from github.com (hubbernetes-node-d89bf7d.ac4-iad.github.net [10.52.173.33])
	by smtp.github.com (Postfix) with ESMTPA id 2411E7009E8
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Sep 2025 05:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757852433;
	bh=UaAczJHe44uhvx9S4HYFxvh0SlPJVWLPKrg/HuAaEX4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ey53npWU4H0vExTWQXrYKDrCBHCQbtqgeWkgvBWGd8LszXhW1COwjQzoq+iblMF5z
	 hxu+y38C+lRcUtermYxN2t5w6iQyno6bAcB0AJ+ClZaPFZ1UQOidBgOtYt+llCXfbS
	 RsnYG/WP+Iis69oh4OuBwKBkQlPASk0PrvciRAfc=
Date: Sun, 14 Sep 2025 05:20:33 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1002158/000000-249126@github.com>
Subject: [bluez/bluez] a5513f: shared/io: add helper for asynchronous
 shutdown() ...
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

  Branch: refs/heads/1002158
  Home:   https://github.com/bluez/bluez
  Commit: a5513fa0d83aa3ece6c6f9c8ebc3ac65b16fbeea
      https://github.com/bluez/bluez/commit/a5513fa0d83aa3ece6c6f9c8ebc3ac65b16fbeea
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-09-14 (Sun, 14 Sep 2025)

  Changed paths:
    M src/shared/io-ell.c
    M src/shared/io-glib.c
    M src/shared/io-mainloop.c
    M src/shared/io.h

  Log Message:
  -----------
  shared/io: add helper for asynchronous shutdown() with SO_LINGER

Add io_glib_shutdown_linger() for socket shutdown with wait for
remote ACK via SO_LINGER. E.g. wait for L2CAP Disconnect Rsp.

We don't want to block the main loop for the linger timeout, so call
shutdown() in a separate thread, as socket API seems to provide only the
blocking way to do it.

Implement it with Glib source API, as that's more convenient for the
AVDTP plugin that needs this.


  Commit: 24912664b9093d88a14d2effae32951a36b02dba
      https://github.com/bluez/bluez/commit/24912664b9093d88a14d2effae32951a36b02dba
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


Compare: https://github.com/bluez/bluez/compare/a5513fa0d83a%5E...24912664b909

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
