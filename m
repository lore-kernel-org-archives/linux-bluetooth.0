Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E098D23BE
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747246495; cv=none; b=Mj2prMnYKPwyJxt+xsSLt2lyQuoIhn+euTUa75alGUUsjY0zUALicyF/RvAbLSqB8EJOr7aq75+U2y6fxTxs6lKKQ/mj3mLxOEGF0SlgqnBV9pNR1cSTFxcUmCqjj6/6mvGD+dAFyCMPsKu4TnGc9WJPdSPGDeVArz9js6GwsOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747246495; c=relaxed/simple;
	bh=t3P60CyEnRhZYo2s6kyLd7mm2Oo3d6djpi3MdP4E5Pw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PO3++QHPDrSMpCSAYFyaWM2ioW4x0oTFh9RR5gkJdbA7tfhDGHCtXrhDQxYci9hAPaTnSmTThGpw/qYxrwcT4DL5E4PcXz/VVNEwfjR+Ad6lEsLn1Ya+3hYL4hfhxQPEB288dh3i9sPJAwRc6BEpGvhT3TioUuua15ahSjx7QeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=E5z2GyuX; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="E5z2GyuX"
Received: from github.com (hubbernetes-node-ffa7aac.va3-iad.github.net [10.48.170.41])
	by smtp.github.com (Postfix) with ESMTPA id 10BFF4E118D
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 11:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747246493;
	bh=QI7F9qh0CTL7JhSdVaPiLSmVWlDOZ/xBpKGjaqA/xEo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=E5z2GyuX2cJf8u7dT7i+VDpTGMHQOXKDbATCV8hw+rTDPbwH2x/WLvr9z11ahwVHn
	 Fvjci1Q2pjzBN90fpfSJ2kFxqiO26aLihiZXCmmzK+n8s4l3m8eFRPnj9uv7QRymrb
	 dO3k+/NveTFQNDZxBlJlQG8mB/gCk+JfM4RVzoak=
Date: Wed, 14 May 2025 11:14:53 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8154dd-080174@github.com>
Subject: [bluez/bluez] f02ca9: monitor: Add definitions for FSU command and
 event
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: f02ca9dc8d54c99d1babf05e7b2f7a41dd4abbca
      https://github.com/bluez/bluez/commit/f02ca9dc8d54c99d1babf05e7b2f7a41dd4abbca
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-14 (Wed, 14 May 2025)

  Changed paths:
    M monitor/bt.h

  Log Message:
  -----------
  monitor: Add definitions for FSU command and event

This adds FSU command and event as defined in the Core 6.0
specification.


  Commit: 080174528484ac744e656f2ede525b964eb1c930
      https://github.com/bluez/bluez/commit/080174528484ac744e656f2ede525b964eb1c930
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-14 (Wed, 14 May 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add decoding for FSU command and event

This adds decoding for FSU command and event as defined in the Bluetooth
Core 6.0 specification:

$ tools/hcitool cmd 0x08 0x009d 0xff 0xff 0x00 0x00 0x00 0x00 0x01 0x03
< HCI Command: LE Frame Space Update (0x08|0x009d) plen 8
        Handle: 65535 Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Frame Space min: 0 us (0x0000)
        Frame Space max: 0 us (0x0000)
        PHYs: LE 1M (0x01)
        types: 0x03
          T_IFS_ACL_CP
          T_IFS_ACL_PC


Compare: https://github.com/bluez/bluez/compare/8154ddbdd5b2...080174528484

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
