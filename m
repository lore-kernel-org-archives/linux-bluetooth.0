Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7833132ED2C
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597491; cv=none; b=CHgmm/8FshHJzwwjhHa+D2kzdkdiJiTT/FnsXW/o6efAgYZJkRqwkOPSloT4zfBoTOtykWGrkJG+qvRtcBUHSFPOHmqoPAUfQ8jptQqL0tNBH5ieP2H8VfuX4oRC0NW9TL9CUmDMRzYFrtpERTwGDYlo9bZ/Ql1Sho/1AOGXPpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597491; c=relaxed/simple;
	bh=Scu0SBL6R/gSf3p+dXCOankmT1P/zCqJc6bimEMSbxY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TkP+Gcb+LEna3Bg3XqDTv+ky8PcsPZbs0Lllndv0bZp3FoiflsSvAszf+n7g2u+uRDJAGGXVkHV3TotVBqfKsymIHL7L8ezHAxqy6qcp4YsLUKN3xegHzhpIiUZ5ffe6L1Fbhxd8bYnxUAYqwysholPaLgUA20FlzAWlbLElQ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dytQf8wy; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dytQf8wy"
Received: from github.com (hubbernetes-node-b4cc794.va3-iad.github.net [10.48.171.24])
	by smtp.github.com (Postfix) with ESMTPA id B4E0A4E12A4
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 02:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769597489;
	bh=LnoYtuQ2rPyk+IDgtNg9QCy/2P5nchpRZEUh+GjtIAo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dytQf8wyRfLNpzAWmay4FbXDpDVjwyKMpnakdxWYyU6faoFUg8wBHA2C1QdB9qiCn
	 3qo08KvDKRkT6HWSFbHcPPJSBTKYFxr2ZaKZ0JUaYYnBiFKf8dL9L1icSlQ5LNby+5
	 S5Pg3+VzlJGsCudJcbwV37seGMmgkCIaSD9O8ch4=
Date: Wed, 28 Jan 2026 02:51:29 -0800
From: Arkadiusz Bokowy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047987/000000-0d2a4a@github.com>
Subject: [bluez/bluez] 0d2a4a: media: Fix G.722 @ 16 kHz codec ID value
 reported ...
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

  Branch: refs/heads/1047987
  Home:   https://github.com/bluez/bluez
  Commit: 0d2a4a8da832711a561945281600dae8da162548
      https://github.com/bluez/bluez/commit/0d2a4a8da832711a561945281600dae8da162548
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2026-01-28 (Wed, 28 Jan 2026)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: Fix G.722 @ 16 kHz codec ID value reported by transport

The G.722 @ 16 kHz codec ID is 0x01, not 0x02. The 0x02 value comes from
the ASHA ReadOnlyProperties GATT characteristic which is a bitmask with
bits corresponding to codec IDs - setting bit 1 gives bitmask value 0x02.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
