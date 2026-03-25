Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B556D350A33
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774466889; cv=none; b=bRz/63O8BjrWMPuzH8b4ZrCeSaGjmT0sqXp5zchoRLGZ+uP5YRtGPN5E52CHDnL/xNcI321uZKIxeErCG45//mdcjypQ2tOMBmCJiCEmskDREr+xFGF2siapIzfaH3levoPASXkvSkTPbXO9ZfCO620yh8imjdneWkIWXyTbF98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774466889; c=relaxed/simple;
	bh=01mWvkYjGbm5tHCLlAcQpmGO/FLIprz/mxOagKU3bGU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=G4VbXkC+iPcCX1iq0JQ1PrKok5FGRQ/xMvbtv9ExNFMlkxdo0Fn3K2b4R41iyE491WeDicn1o7akLSJR0n640D1D27rtJHqLBBOIGUzmCE/EKWp4YpvBErLubGYPnDuZCNXcUOT43h/uOCVwD2656QBpo3o8xr484a++AHCw0Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Uz7b46Ql; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Uz7b46Ql"
Received: from github.com (hubbernetes-node-9c81543.ac4-iad.github.net [10.52.166.22])
	by smtp.github.com (Postfix) with ESMTPA id DD2FC21379
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 12:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774466886;
	bh=RAENEoq2dDu7lZnodtR57L2Xx8J7jBKJssydNFvPf0k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Uz7b46QlNOnnhQci/wSug3Ci7tbQ9zvmhfVqKb+nA8HWcthPfLv2NL5Xxe+OQwMam
	 aEVXAybDPsHbf5AA+i3Iw9YRTBuCeG87dAQy3vLx4gA6qz1Dene4Iw5acEB3eK2/Oc
	 XyhkHzVDSHiIHPtPp5Fkplrx6vksoiSvQ5RMoxF4=
Date: Wed, 25 Mar 2026 12:28:06 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1072496/000000-67b764@github.com>
Subject: [bluez/bluez] 1282f8: doc/btmon: Split Advertising and Scanning into
 btm...
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

  Branch: refs/heads/1072496
  Home:   https://github.com/bluez/bluez
  Commit: 1282f8515a6b8055bd2cc7ba7cffb24e8c9596c4
      https://github.com/bluez/bluez/commit/1282f8515a6b8055bd2cc7ba7cffb24e8c9596c4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-25 (Wed, 25 Mar 2026)

  Changed paths:
    M Makefile.am
    A doc/btmon-advertising.rst
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Split Advertising and Scanning into btmon-advertising.rst

Move the ADVERTISING AND SCANNING section into a standalone file and
replace it with an RST include directive. This allows the
btsnoop-analyzer to load only the relevant documentation for
advertising/scanning focus-area analysis instead of the full btmon.rst.


  Commit: 9a26d0d5a347019ecf70a3b3d3680bedda22d577
      https://github.com/bluez/bluez/commit/9a26d0d5a347019ecf70a3b3d3680bedda22d577
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-25 (Wed, 25 Mar 2026)

  Changed paths:
    M Makefile.am
    A doc/btmon-le-audio.rst
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Split LE Audio Protocol Flow into btmon-le-audio.rst

Move the LE AUDIO PROTOCOL FLOW section (including CIS unicast,
BIS broadcast, and BIG sync flows) into a standalone file and
replace it with an RST include directive. This is the largest
split section (660 lines) and was being truncated away in
context-limited analysis.


  Commit: 3b54050bac68029b72d070a731f8427acd202970
      https://github.com/bluez/bluez/commit/3b54050bac68029b72d070a731f8427acd202970
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-25 (Wed, 25 Mar 2026)

  Changed paths:
    M Makefile.am
    A doc/btmon-l2cap.rst
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Split L2CAP Channel Tracking into btmon-l2cap.rst

Move the L2CAP CHANNEL TRACKING section into a standalone file and
replace it with an RST include directive.


  Commit: c94a2ddc2f512580e76078ebef69895c95756550
      https://github.com/bluez/bluez/commit/c94a2ddc2f512580e76078ebef69895c95756550
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-25 (Wed, 25 Mar 2026)

  Changed paths:
    M Makefile.am
    A doc/btmon-smp.rst
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Split SMP Pairing Flow into btmon-smp.rst

Move the SMP PAIRING FLOW section into a standalone file and replace
it with an RST include directive.


  Commit: 5b9bfd6be1307c21b3f24b9a86262baa4d877eaf
      https://github.com/bluez/bluez/commit/5b9bfd6be1307c21b3f24b9a86262baa4d877eaf
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-25 (Wed, 25 Mar 2026)

  Changed paths:
    M Makefile.am
    A doc/btmon-gatt.rst
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Split GATT Database Reconstruction into btmon-gatt.rst

Move the RECONSTRUCTING A GATT DATABASE FROM SNOOP TRACES section
into a standalone file and replace it with an RST include directive.


  Commit: 2f0dd9bd9221498d4435cc256c7c1f8ce1d499b1
      https://github.com/bluez/bluez/commit/2f0dd9bd9221498d4435cc256c7c1f8ce1d499b1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-25 (Wed, 25 Mar 2026)

  Changed paths:
    M Makefile.am
    A doc/btmon-connections.rst
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Split Connection Tracking into btmon-connections.rst

Move the CONNECTION TRACKING and HCI ERROR AND DISCONNECT REASON CODES
sections into a standalone file and replace them with an RST include
directive.


  Commit: 29a7e2047da34d5a5c67b0931a437f7ec82d62b6
      https://github.com/bluez/bluez/commit/29a7e2047da34d5a5c67b0931a437f7ec82d62b6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-25 (Wed, 25 Mar 2026)

  Changed paths:
    M Makefile.am
    A doc/btmon-hci-init.rst
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add HCI initialization sequence documentation

Document the multi-stage HCI controller initialization performed by
the kernel (net/bluetooth/hci_sync.c). The four stages cover reset
and identity, capability discovery, event mask configuration, and
final setup. This helps trace readers distinguish normal init traffic
from application-level issues.


  Commit: 52908e879b272b3c8dc078992c6f4db690540f30
      https://github.com/bluez/bluez/commit/52908e879b272b3c8dc078992c6f4db690540f30
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-25 (Wed, 25 Mar 2026)

  Changed paths:
    M Makefile.am
    A doc/btmon-a2dp.rst
    A doc/btmon-classic-audio.rst
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add A2DP/AVDTP protocol flow documentation

Add btmon-a2dp.rst documenting the A2DP protocol flow as seen in btmon
output, wrapped by btmon-classic-audio.rst parent file. Coverage
includes:

 - AVDTP signaling: Discover, Get Capabilities, Set Configuration,
   Open, Start, Suspend, Close
 - Codec capability/configuration decoding for SBC, AAC, aptX, aptX HD,
   aptX Low Latency, FastStream, LDAC, and Opus
 - AVDTP media transport channel setup
 - AVRCP control and browsing channel overview
 - Delay Reporting
 - Automation-friendly grep patterns


  Commit: 67b7649e004ee3e5b2226bb182cc8582b604cce5
      https://github.com/bluez/bluez/commit/67b7649e004ee3e5b2226bb182cc8582b604cce5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-25 (Wed, 25 Mar 2026)

  Changed paths:
    M Makefile.am
    M doc/btmon-classic-audio.rst
    A doc/btmon-hfp.rst

  Log Message:
  -----------
  doc/btmon: Add HFP protocol flow documentation

Add btmon-hfp.rst documenting the HFP protocol flow as seen in btmon
output. Coverage includes:

 - SDP service discovery for Handsfree/AG UUIDs
 - RFCOMM channel setup over L2CAP PSM 3 (SABM/UA, Parameter
   Negotiation, Modem Status Command)
 - AT command exchange for SLC setup (noted as hex dump only -- btmon
   does not parse AT commands within RFCOMM UIH data frames)
 - Codec negotiation via AT+BAC/AT+BCS
 - SCO/eSCO synchronous connection setup (voice setting, coding format)
 - Codec summary tables (AT-level vs HCI-level codec IDs)
 - Automation-friendly grep patterns


Compare: https://github.com/bluez/bluez/compare/1282f8515a6b%5E...67b7649e004e

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
