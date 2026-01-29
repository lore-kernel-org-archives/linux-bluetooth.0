Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AB133557C
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769704165; cv=none; b=Q2+EtCzomlIJ7V2/nBYkBLpenqQiGop8To5GQfHDvlra93MRNRvXHafnA6MZ8XHYYT1G6GkC8WZVxXNCO2Ubw++jxPhdcKeqU6ZRSwUbhPzyKuwKO20XwB1dVe0NSa8R6fqGKXfjmqN0n6yxr09kQZ6sFYQiqB2FDDhUKysCU44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769704165; c=relaxed/simple;
	bh=vJoIGo+V3NJjc3QA0V7MGtxbeqknWU6OkC5x3M4PXOU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qxIFo7du/Kukk6hQo1Q+swozPLcodsRgUA51MbRgtsXN78mWF5YczstZhQm7yRaNInvgcVyoTjGqz6Qtmv9nTMTu8F8w/U7VdvJS/bYT50AHfstHeX/t22gy5cbbDHreXDAh70QBO6uEjX9X8i15ZNAcbPhNurFiTlfv+COPL04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OwyJZrht; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OwyJZrht"
Received: from github.com (hubbernetes-node-702b401.va3-iad.github.net [10.48.166.34])
	by smtp.github.com (Postfix) with ESMTPA id C5EB03C095E
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 08:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769704163;
	bh=cBZY+p0rOtUjUUQhA/I8g5VGFMiIw5odhd7h9aXask8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OwyJZrhtYz3oPUxUfxSCtfj9J0CmIP7fIe4/mfpTMcLVrgwzwydzFREvOtbM2mpJs
	 Ss1IXv2Ec6VAQs3JCzhV0np+VBeoNDC1SoLM/ge0jV/6hioS9XXvGKKHaym9rtsFF5
	 7Gk+K2vsGGcc/k7QYLsjNcvp1i5NV4BGZhojua1g=
Date: Thu, 29 Jan 2026 08:29:23 -0800
From: Arkadiusz Bokowy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/e2551c-ebb331@github.com>
Subject: [bluez/bluez] eb37ac: build: Remove left-over of health profiles
 removal
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
  Commit: eb37ac9488b42c0f384b9822f8cc6db002774c1a
      https://github.com/bluez/bluez/commit/eb37ac9488b42c0f384b9822f8cc6=
db002774c1a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-29 (Thu, 29 Jan 2026)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  build: Remove left-over of health profiles removal


  Commit: 9bd859ea4a4c08f709ed12260898eed81dcdb4d0
      https://github.com/bluez/bluez/commit/9bd859ea4a4c08f709ed12260898e=
ed81dcdb4d0
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-29 (Thu, 29 Jan 2026)

  Changed paths:
    M doc/qualification/avrcp-pics.rst
    M doc/qualification/gap-pics.rst

  Log Message:
  -----------
  doc/qualification: Fix typos

This fix the errors and warnings found during HTML generation.


  Commit: a2d140d70b1c74f2c6ee248f5d1f3838dd68c930
      https://github.com/bluez/bluez/commit/a2d140d70b1c74f2c6ee248f5d1f3=
838dd68c930
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-29 (Thu, 29 Jan 2026)

  Changed paths:
    M Makefile.tools

  Log Message:
  -----------
  build: Don't install btmgmt man page as tool isn't

The btmgmt tool isn't installed through the Makefiles, so the
man page shouldn't be installed either.


  Commit: ebb33150ba76f3b20280bfd30e410bf45e052dc1
      https://github.com/bluez/bluez/commit/ebb33150ba76f3b20280bfd30e410=
bf45e052dc1
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2026-01-29 (Thu, 29 Jan 2026)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: Fix G.722 @ 16 kHz codec ID value reported by transport

The G.722 @ 16 kHz codec ID is 0x01, not 0x02. The 0x02 value comes from
the ASHA ReadOnlyProperties GATT characteristic which is a bitmask with
bits corresponding to codec IDs - setting bit 1 gives bitmask value 0x02.=



Compare: https://github.com/bluez/bluez/compare/e2551c5b9809...ebb33150ba=
76

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
