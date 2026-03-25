Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54792388384
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472369; cv=none; b=hMpmphKUyHX/7aWBv+AdX+l4viv0WkehPDUbDR0XK6DmaJIa1yBlC76ifhXr81XppFlltcBOa6g+EkEiTYmjtKOyNxA7ZqMEVv6gaCCZOz762vM6YsacSaye09l31XpcdKzFsYmPXniHboIcVpYWcSXgFNsHOaubtKwQEGdwV2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472369; c=relaxed/simple;
	bh=zomqMtrg42X37L1qDJGeKHvGabNwAQ8eKl2HN9F/VqQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bnrMv2KkQNQ6zZ6rAXATiCRTLHaRctSf6hSZAczidiBlak8EFcnR8EEi/5mcBDs4+wHNIaF671E7yW5iUFITIYS0ENxbrsTF4l29sQU302nr0nR8WNEVLY1LMy8Wnic79k9gip8J35rEwffBmHBWL9BwQPs8y1cVThq6lffIThQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GnwXy2Hb; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GnwXy2Hb"
Received: from github.com (hubbernetes-node-85b5099.ac4-iad.github.net [10.52.81.27])
	by smtp.github.com (Postfix) with ESMTPA id 6C06164121A
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 13:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774472367;
	bh=ZJ/t8En4bZBF3jpbEgUOdR4pUj73qIdRrN9QzIjBnCg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GnwXy2HbdWzK+y3N9j4vOc0niURzM3ZYJ2iJ7FbQDtTgEay8tSorJRZlJU1tOEBJL
	 Tc3Z5TrW1s5ebv3LVtD33fKemJ3DsabuNREaSsA3pMx79fW7cq006IbEDWdF7j61FG
	 Aa6PaF0PkuvBmIBp1ks3Ho8h9o/x5A5N672DeC88=
Date: Wed, 25 Mar 2026 13:59:27 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/1436ea-097196@github.com>
Subject: [bluez/bluez] 6ca24f: doc/btmon: Split Advertising and Scanning into
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 6ca24f69351e0b97df96e843fe9e557a407796fb
      https://github.com/bluez/bluez/commit/6ca24f69351e0b97df96e843fe9e557a407796fb
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


  Commit: d6e2bf9a3a2bebaae12cc633aefea6e9b72f9bf7
      https://github.com/bluez/bluez/commit/d6e2bf9a3a2bebaae12cc633aefea6e9b72f9bf7
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


  Commit: 042e211cd0219b554f707bc6369118b245575329
      https://github.com/bluez/bluez/commit/042e211cd0219b554f707bc6369118b245575329
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


  Commit: 2bcd75cd75eabba5f9ec1fc37a0a83b55ed24965
      https://github.com/bluez/bluez/commit/2bcd75cd75eabba5f9ec1fc37a0a83b55ed24965
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


  Commit: d991284294f4243aadd8f3475352221d7a905da1
      https://github.com/bluez/bluez/commit/d991284294f4243aadd8f3475352221d7a905da1
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


  Commit: 838c717f9dfbe5dbca24dbb258e269f939d59647
      https://github.com/bluez/bluez/commit/838c717f9dfbe5dbca24dbb258e269f939d59647
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


  Commit: 60a32f8c7517485d7f615bc605b81524e22b3c11
      https://github.com/bluez/bluez/commit/60a32f8c7517485d7f615bc605b81524e22b3c11
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


  Commit: 173fad8fbe9f254ec1da51c793e9b5315610b16c
      https://github.com/bluez/bluez/commit/173fad8fbe9f254ec1da51c793e9b5315610b16c
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


  Commit: 097196bf8a299d209681892ea74618e4bea8c4ac
      https://github.com/bluez/bluez/commit/097196bf8a299d209681892ea74618e4bea8c4ac
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


Compare: https://github.com/bluez/bluez/compare/1436eab1d0e5...097196bf8a29

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
