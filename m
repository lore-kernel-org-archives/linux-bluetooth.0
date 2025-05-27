Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292BB13A41F
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354271; cv=none; b=h62KYefF8yqNrKa1rq61FJv81ZsXT0m2hso+WgFoYgBS6xVEXNCygHGR1B9LLctEAJ+tgjJbW7Ni8YbcWVayByS/Nv3lZKY77595RIK0XNJt5HrsjRzn+3CYSDt+AjmNEwRjwNOzzOxFnfpWFpRuWoZlvKVdYVV/tdimdwz7kvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354271; c=relaxed/simple;
	bh=a1WF/iC7x8uJx62p6XgYbJNb+O2/+oSSQLzyq/2RamQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IBnuAiHLiZ3Zu4wkw9aGj9ZJMzQAIaN+PEBNbsKBZnbfcEnhsxxqOUAGL2WB6r35qXn6IRl9n2NjVFzyzyLKqOssaTp9rjvT7d6sILf0qJhHENstdy/tuO04GeYoS9EnXb6xmWJL1i7qJH3nAeALVuiq0tbV5189B3qC/yMolBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Xts8nY33; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Xts8nY33"
Received: from github.com (hubbernetes-node-8912840.va3-iad.github.net [10.48.175.23])
	by smtp.github.com (Postfix) with ESMTPA id 46A568C0A9E
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 06:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748354269;
	bh=+GgGUjfS+4VimXdFTOYUdCueF7MwQtt4iUtN4ky11OQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Xts8nY33w4vvRw1J0f25CeDj2ZzqX76BoCUL6X7i8FAGF81G+QeuaHIYUIEUPhCyA
	 OKsldNnB2JiuYj3nFyruDmq0RQKJXvLMmpeP5aMdENG/vZ4Fn9en96XheqbO9A7RZS
	 VV88S+O1daIxFjxj2Ocw2ez4HyllwC+7r0etx74I=
Date: Tue, 27 May 2025 06:57:49 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c888c6-f8c669@github.com>
Subject: [bluez/bluez] bea5cc: audio/avrcp: fix crash when NowPlaying changes
 whi...
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
  Commit: bea5cc4d12b48edb58c851c7e9ad9640bb7cedee
      https://github.com/bluez/bluez/commit/bea5cc4d12b48edb58c851c7e9ad9=
640bb7cedee
  Author: George Kiagiadakis <george.kiagiadakis@collabora.com>
  Date:   2025-05-27 (Tue, 27 May 2025)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  audio/avrcp: fix crash when NowPlaying changes while list_items is in p=
rogress

The media_item objects are owned by the player and while we keep
temporary pointers to them in pending_list_items, clearing the player's
playlist destroys them and we will end up crashing in the next call to
avrcp_list_items_rsp(). The crash is racy and can only be observed
when skipping tracks very quickly in an Apple Music station (where the
playlist changes on every next song)


  Commit: bcababe6050d043f871703750657332497ff535d
      https://github.com/bluez/bluez/commit/bcababe6050d043f8717037506573=
32497ff535d
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

> ACL Data RX: Handle 11 flags 0x02 dlen 102
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
> ACL Data RX: Handle 11 flags 0x02 dlen 26
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


  Commit: f8c6693139de446efaf98a30117eb9fd1ac7ceb2
      https://github.com/bluez/bluez/commit/f8c6693139de446efaf98a30117eb=
9fd1ac7ceb2
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-27 (Tue, 27 May 2025)

  Changed paths:
    M obexd/client/transfer.c

  Log Message:
  -----------
  obexd/transfer: Send Transferred property on transfer completion

Currently the Transferred property is sent each second and not on
transfer completion, this leads to get no transferred size info or
without the last packet size(s).


Compare: https://github.com/bluez/bluez/compare/c888c682fbd4...f8c6693139=
de

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
