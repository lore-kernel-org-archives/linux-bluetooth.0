Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1780522A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 06:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748328961; cv=none; b=jPJBDtywFMd0t/34lBy+swS3SiVY9I1llSjikddQQsiVlOmcFiyHHq05UUCQuuFvbZ44oEfwcqfUaPahOV99/znQcLBLR/hr8eNPS7uSv2xjrJyTDPXtMsBaMY+QOwDoyWBvnO0OwlUHBmxdoXNq/JUPN8xulsCqs4CpCJ55cLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748328961; c=relaxed/simple;
	bh=SixY2VLC0PRR5qG+il4TckkqWBJdM5oTdU4mG6zfDfE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hID5x0wm9xuCzLK5PS5dU5jBKrJyPz75QTFeurlygxoQZ70Nb/97E1ildbiimbQfSJAX+v4qzlfFx94MRmFkmMe7D9MfZsz3Ju8p3MM64XS42NtlgzJjT4AslxanidkEHJMNR8Kd19I2Y0bRwkh2XCf9CvjjVj6H+v8X/Mzb6Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YD+s5Mu1; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YD+s5Mu1"
Received: from github.com (hubbernetes-node-b0c1f8f.va3-iad.github.net [10.48.145.23])
	by smtp.github.com (Postfix) with ESMTPA id AB08BE0527
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 May 2025 23:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748328958;
	bh=Q2hs1rzbXfJqrr8eb2yJTdeD+PTQNzFx5OUBD7ZCTbo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YD+s5Mu1gpEgglcle42MsyzNVFH+da4bDK/CeXSaj1YRSSxKf/UD4aT8h9ka+B5Uh
	 tDKH5BH9YMw3KcJwv6ZeiP3dI1ot9831UH8KHp23RTOqhlute8njuQ++p9YfhQjjQ0
	 nkMD2agbTy0NPWchrvfHNKUJUUnVdkpiSv58jayg=
Date: Mon, 26 May 2025 23:55:58 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/966556/000000-47c788@github.com>
Subject: [bluez/bluez] 47c788: audio/player: Update track duration if
 previously ...
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

  Branch: refs/heads/966556
  Home:   https://github.com/bluez/bluez
  Commit: 47c788f650733e7a40b589594a6c7f79145ca6b4
      https://github.com/bluez/bluez/commit/47c788f650733e7a40b589594a6c7=
f79145ca6b4
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-27 (Tue, 27 May 2025)

  Changed paths:
    M profiles/audio/player.c

  Log Message:
  -----------
  audio/player: Update track duration if previously set to 0

Sometimes some stacks may set the track duration to 0 in GetItemAttribute=
s
before updating it in GetPlayStatus.

Currently the track duration is updated only if it has never been set
before. To fix the issue this also checks that the current value is
not 0.

> ACL Data RX: Handle 11 flags 0x02 dlen 102                             =
                                                                         =
                                                                       #2=
87 [hci0] 4.537033
      Channel: 71 len 98 ctrl 0x0202 [PSM 27 mode Enhanced Retransmission=
 (0x03)] {chan 7}
      I-frame: Unsegmented TxSeq 1 ReqSeq 2
      AVCTP Browsing: Response: type 0x00 label 1 PID 0x110e
        AVRCP: GetItemAttributes: len 0x0058
...
          AttributeID: 0x00000007 (Track duration)
          CharsetID: 0x006a (UTF-8)
          AttributeLength: 0x0001 (1)
          AttributeValue: 0
...
> ACL Data RX: Handle 11 flags 0x02 dlen 26                              =
                                                                         =
                                                                       #2=
96 [hci0] 4.589649
      Channel: 68 len 22 [PSM 23 mode Basic (0x00)] {chan 4}
      AVCTP Control: Response: type 0x00 label 9 PID 0x110e
        AV/C: Stable: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: GetPlayStatus pt Single len 0x0009
            SongLength: 0x000255a8 (153000 miliseconds)
            SongPosition: 0x00009256 (37462 miliseconds)
            PlayStatus: 0x02 (PAUSED)



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
