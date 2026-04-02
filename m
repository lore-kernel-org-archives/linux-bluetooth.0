Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1333C246782
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775119075; cv=none; b=H1ntpPEOGys4tu4IpYWVOfd4SCLBxWJA3g0EVymCHbIp2JzKQQF4Hj2wjAQNkcGjVEhLLMrcoPxNfOeq5LB6158ZAZlKmnMni2PixxoDy2336RvoJCt5LY3ksbmjMvI2hEzS2OVePzBDfUoTJDPduXybrA0uC8oU+xozVUHooC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775119075; c=relaxed/simple;
	bh=3EN7OC8iSoHBi5hAGRlWdow1/jFV3G60KxScstaB2Vo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=sQOF+9ejZHlotu7KiDklTlHpcbqXdavIvDYwhBhkg9buwAhGV8/10TsJemf/TXNiuKPwAhrtoRHnQ80rYZWrSYoQn8M8K/lMKKjL4C4Mwd0OSDX2DYBZTshzU6D5ONg48tcyPRxZR5S8DiUAapkFdJk3FN9Rh2sFVKtEif0LY6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WO0OWUZm; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WO0OWUZm"
Received: from github.com (hubbernetes-node-d8d307a.ash1-iad.github.net [10.56.167.25])
	by smtp.github.com (Postfix) with ESMTPA id 4D261140849
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 01:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775119073;
	bh=0CUcAlsx3JO7C7GB1l6PPAVHEiOOqn0YqRFHkGQ0uiQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WO0OWUZm3S9AZOdJkhde/zl6ZohUEHWhjMp4EBOKKn302ipWdeGZYU6fwMM8yF7Qx
	 6rO9rcVYyVh6MNnvH/VSqZ1RIdaMEBsvU//aWFNDXjnDbaSZbHsTKMu80htIoY7X+/
	 VQ43sKTLzMjkUtbV7bNxkjaKs7xgdq/wsban9Fog=
Date: Thu, 02 Apr 2026 01:37:53 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1076276/000000-5d6a4f@github.com>
Subject: [bluez/bluez] 5d6a4f: avdtp: ignore Discover cmd when host sends
 before
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

  Branch: refs/heads/1076276
  Home:   https://github.com/bluez/bluez
  Commit: 5d6a4f5523e9c549d09d8061c78a5b75d18686f5
      https://github.com/bluez/bluez/commit/5d6a4f5523e9c549d09d8061c78a5b75d18686f5
  Author: Zhang Chen <zhangchen01@kylinos.cn>
  Date:   2026-04-02 (Thu, 02 Apr 2026)

  Changed paths:
    M profiles/audio/avdtp.c

  Log Message:
  -----------
  avdtp: ignore Discover cmd when host sends before

Theoretically, the party that initiates the connection should send the DISCOVER
command. However, some devices, even though they are the connected party, still
send the DISCOVER command. In such cases, there is a probability of connection
failure.

Fails:

< ACL Data TX: Handle 10 flags 0x00 dlen 6
      Channel: 71 len 2 [PSM 25 mode Basic (0x00)] {chan 1}
      AVDTP: Discover (0x01) Command (0x00) type 0x00 label 4 nosp 0
> ACL Data RX: Handle 10 flags 0x02 dlen 8
      Channel: 64 len 4 [PSM 25 mode Basic (0x00)] {chan 1}
      AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 4 nosp 0
        ACP SEID: 1
          Media Type: Audio (0x00)
          SEP Type: SRC (0x00)
          In use: No
< ACL Data TX: Handle 10 flags 0x00 dlen 18
      Channel: 71 len 14 [PSM 25 mode Basic (0x00)] {chan 1}
      AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 5 nosp 0
        ACP SEID: 1
        INT SEID: 37
        Service Category: Media Transport (0x01)
        Service Category: Media Codec (0x07)
          Media Type: Audio (0x00)
          Media Codec: SBC (0x00)
            Frequency: 44100 (0x20)
            Channel Mode: Joint Stereo (0x01)
            Block Length: 16 (0x10)
            Subbands: 8 (0x04)
            Allocation Method: Loudness (0x01)
            Minimum Bitpool: 2
            Maximum Bitpool: 53
> ACL Data RX: Handle 10 flags 0x02 dlen 6
      Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 1}
      AVDTP: Set Configuration (0x03) Response Accept (0x02) type 0x00 label 5 >
> ACL Data RX: Handle 10 flags 0x02 dlen 6
      Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 1}
      AVDTP: Discover (0x01) Command (0x00) type 0x00 label 0 nosp 0
< ACL Data TX: Handle 10 flags 0x00 dlen 10
      Channel: 71 len 6 [PSM 25 mode Basic (0x00)] {chan 1}
      AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 0 nosp 0
        ACP SEID: 25
          Media Type: Audio (0x00)
          SEP Type: SNK (0x01)
          In use: No
        ACP SEID: 38
          Media Type: Audio (0x00)
          SEP Type: SRC (0x00)
          In use: No
< ACL Data TX: Handle 10 flags 0x00 dlen 7
      Channel: 71 len 3 [PSM 25 mode Basic (0x00)] {chan 1}
      AVDTP: Open (0x06) Command (0x00) type 0x00 label 6 nosp 0
        ACP SEID: 1
> ACL Data RX: Handle 10 flags 0x02 dlen 6
      Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 1}
      AVDTP: Open (0x06) Response Accept (0x02) type 0x00 label 6 nosp 0
< ACL Data TX: Handle 10 flags 0x00 dlen 12
      L2CAP: Connection Request (0x02) ident 5 len 4
        PSM: 25 (0x0019)
        Source CID: 65
> ACL Data RX: Handle 10 flags 0x02 dlen 12
      L2CAP: Disconnection Request (0x06) ident 5 len 4
        Destination CID: 64
        Source CID: 71
< ACL Data TX: Handle 10 flags 0x00 dlen 12
      L2CAP: Disconnection Response (0x07) ident 5 len 4
        Destination CID: 64
        Source CID: 71
> ACL Data RX: Handle 10 flags 0x02 dlen 16
      L2CAP: Connection Response (0x03) ident 5 len 8
        Destination CID: 127
        Source CID: 65
        Result: Connection refused - PSM not supported (0x0002)
        Status: No further information available (0x0000)

Works:

< ACL Data TX: Handle 12 flags 0x00 dlen 6
      Channel: 77 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Discover (0x01) Command (0x00) type 0x00 label 11 nosp 0
> ACL Data RX: Handle 12 flags 0x02 dlen 8
      Channel: 64 len 4 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 11 nosp 0
        ACP SEID: 1
          Media Type: Audio (0x00)
          SEP Type: SRC (0x00)
          In use: No
< ACL Data TX: Handle 12 flags 0x00 dlen 18
      Channel: 77 len 14 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 12 nosp 0
        ACP SEID: 1
        INT SEID: 13
        Service Category: Media Transport (0x01)
        Service Category: Media Codec (0x07)
          Media Type: Audio (0x00)
          Media Codec: SBC (0x00)
            Frequency: 44100 (0x20)
            Channel Mode: Joint Stereo (0x01)
            Block Length: 16 (0x10)
            Subbands: 8 (0x04)
            Allocation Method: Loudness (0x01)
            Minimum Bitpool: 2
            Maximum Bitpool: 53
> ACL Data RX: Handle 12 flags 0x02 dlen 6
      Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Set Configuration (0x03) Response Accept (0x02) type 0x00 label 12>
> ACL Data RX: Handle 12 flags 0x02 dlen 6
      Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Discover (0x01) Command (0x00) type 0x00 label 0 nosp 0
< ACL Data TX: Handle 12 flags 0x00 dlen 7
      Channel: 77 len 3 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Open (0x06) Command (0x00) type 0x00 label 13 nosp 0
        ACP SEID: 1
> HCI Event: Number of Completed... (0x13) plen 5
        Num handles: 1
        Handle: 12
        Count: 1
> ACL Data RX: Handle 12 flags 0x02 dlen 6
      Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Open (0x06) Response Accept (0x02) type 0x00 label 13 nosp 0

Signed-off-by: Zhang Chen <zhangchen01@kylinos.cn>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
