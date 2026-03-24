Received: from o3.sgmail.github.com (o3.sgmail.github.com [192.254.112.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1973B30214B
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 20:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.112.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382728; cv=none; b=K3CcrchyMIPIvdPba8VUosv873AiBztKvZDRSh4rKeOoqo3NfIRj6g3aEKzYbjCsXk4aFu93JU4GcnR0J5lMTNZn4O9iKkTi0O8l9ZOv5CLys/OSn05tpVTg91FavZqYT1t4tRYq4zVmirlqoeL67f/Ft5kWD35igJ4C2gPHX5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382728; c=relaxed/simple;
	bh=6PWpFOcCmPFBF0U36RsHHhHM5G7hJu/A/Rtx0hoqcqM=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=VBs7P8tRuFiLKlr9Lpz5zHAel/au3LabMLanTqjdnd04E+45riEuko3hm2edGPbBdfuVTF0XMJmHIlDBYS5kvBgupxRHbzkAZ7KD7HwiFG/jWL9LCGnQHfVOVcbjDw2fikqrtUDIkCo44ohhEAl3RJe95+la0Tx/I8H1mLxgLnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=z4n5NjyG; arc=none smtp.client-ip=192.254.112.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="z4n5NjyG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; t=1774382726; bh=/qqDK/QOHwUFZjmq8KbpIr4wWRTdmlX3xYvguVho86E=;
	b=z4n5NjyGqyOHQh4NRi+lHXoF187MmpocHBLNWGnkY+HlyuFyjl96ERpjfnZbDDMqStCF
	C7/PjSI0Qf1BEYDxbipWYpNWIr0hzakb6+I2QMSu7fDpicTFbdeg5Nkc5POP/x4L1kT0lm
	nfIQuSeBluHFMy61I7PV6gdPbXAyh/EGo=
Received: by recvd-canary-c77774d4d-bhhm7 with SMTP id recvd-canary-c77774d4d-bhhm7-1-69C2EE86-F
	2026-03-24 20:05:26.094822862 +0000 UTC m=+1300284.450998717
Received: from out-23.smtp.github.com (unknown)
	by geopod-ismtpd-58 (SG)
	with ESMTP id 0DpqCWIeRCuRrABmOmw_mA
	for <linux-bluetooth@vger.kernel.org>;
	Tue, 24 Mar 2026 20:05:26.063 +0000 (UTC)
Received: from github.com (hubbernetes-node-3c3fe03.ac4-iad.github.net [10.52.175.49])
	by smtp.github.com (Postfix) with ESMTPA id 5F5DF3010B3
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 13:05:19 -0700 (PDT)
Date: Tue, 24 Mar 2026 20:05:26 +0000 (UTC)
From: Luiz Augusto von Dentz <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/1071883/000000-13b9e4@github.com>
Subject: [bluez/bluez] eb7a7e: doc/btmon: Split Advertising and Scanning into
 btm...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: 
 =?us-ascii?Q?u001=2E8ki=2FFbqwlQO04QBiriT34f6qhM6wd38+BQvADylPPTIQmeZqt0Mdj+E9P?=
 =?us-ascii?Q?ngWQlMPxccS8u9EBUyRL9UmZaAIAstwUPMfpEiM?=
 =?us-ascii?Q?=2F9xrsrK2kdnXI=2F4ruO564S9mfF1E4e=2FjkTGtRN0?=
 =?us-ascii?Q?+CUnQWO3=2FrpDfTrQqNpZ0qW+0tB3+GGkGo+d8Fp?=
 =?us-ascii?Q?gNK+jSLJD7WtZd0Mg9i6v5v8EcHb+VoZIlgbbzJ?=
 =?us-ascii?Q?C6wNwxxAbTWQHc8OxgQaraotsFCkdk6sOSRVYOH?=
 =?us-ascii?Q?xTYRVPW5u7rD+ORbPZp=2F2YGauA=3D=3D?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/1071883
  Home:   https://github.com/bluez/bluez
  Commit: eb7a7e6998a48e72cda42dc637149477d3fbc872
      https://github.com/bluez/bluez/commit/eb7a7e6998a48e72cda42dc637149477d3fbc872
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-24 (Tue, 24 Mar 2026)

  Changed paths:
    A doc/btmon-advertising.rst
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Split Advertising and Scanning into btmon-advertising.rst

Move the ADVERTISING AND SCANNING section into a standalone file and
replace it with an RST include directive. This allows the
btsnoop-analyzer to load only the relevant documentation for
advertising/scanning focus-area analysis instead of the full btmon.rst.


  Commit: 2d9cf97a25f731a27b3cd0cde3dbcafb0a8e0d31
      https://github.com/bluez/bluez/commit/2d9cf97a25f731a27b3cd0cde3dbcafb0a8e0d31
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-24 (Tue, 24 Mar 2026)

  Changed paths:
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


  Commit: a86b216d894e2400cff7e381eb806f12a9ce6ca4
      https://github.com/bluez/bluez/commit/a86b216d894e2400cff7e381eb806f12a9ce6ca4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-24 (Tue, 24 Mar 2026)

  Changed paths:
    A doc/btmon-l2cap.rst
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Split L2CAP Channel Tracking into btmon-l2cap.rst

Move the L2CAP CHANNEL TRACKING section into a standalone file and
replace it with an RST include directive.


  Commit: ebc0a766aa4011955d447512bbcd4e5e14952ff2
      https://github.com/bluez/bluez/commit/ebc0a766aa4011955d447512bbcd4e5e14952ff2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-24 (Tue, 24 Mar 2026)

  Changed paths:
    A doc/btmon-smp.rst
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Split SMP Pairing Flow into btmon-smp.rst

Move the SMP PAIRING FLOW section into a standalone file and replace
it with an RST include directive.


  Commit: afa55255ea6b913a6f392c938edf7f6d05526e96
      https://github.com/bluez/bluez/commit/afa55255ea6b913a6f392c938edf7f6d05526e96
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-24 (Tue, 24 Mar 2026)

  Changed paths:
    A doc/btmon-gatt.rst
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Split GATT Database Reconstruction into btmon-gatt.rst

Move the RECONSTRUCTING A GATT DATABASE FROM SNOOP TRACES section
into a standalone file and replace it with an RST include directive.


  Commit: af4f2ef299bc8fa9351f11a775381228cc2521b1
      https://github.com/bluez/bluez/commit/af4f2ef299bc8fa9351f11a775381228cc2521b1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-24 (Tue, 24 Mar 2026)

  Changed paths:
    A doc/btmon-connections.rst
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Split Connection Tracking into btmon-connections.rst

Move the CONNECTION TRACKING and HCI ERROR AND DISCONNECT REASON CODES
sections into a standalone file and replace them with an RST include
directive.


  Commit: ea519686db961e0ced656577da50c7457851a42d
      https://github.com/bluez/bluez/commit/ea519686db961e0ced656577da50c7457851a42d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-24 (Tue, 24 Mar 2026)

  Changed paths:
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


  Commit: 5119b7e45b280c836504d0277bd9c5c1958248af
      https://github.com/bluez/bluez/commit/5119b7e45b280c836504d0277bd9c5c1958248af
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-24 (Tue, 24 Mar 2026)

  Changed paths:
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


  Commit: 13b9e4ee5722b431e5aa336ec189a10ed6875685
      https://github.com/bluez/bluez/commit/13b9e4ee5722b431e5aa336ec189a10ed6875685
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-24 (Tue, 24 Mar 2026)

  Changed paths:
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


Compare: https://github.com/bluez/bluez/compare/eb7a7e6998a4%5E...13b9e4ee5722

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
