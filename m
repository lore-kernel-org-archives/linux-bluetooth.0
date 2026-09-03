Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480104BD0E5
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447616; cv=none; b=A1pVt9w9HWsvc9KtVjBGij0cXr9K9vszrE5U7SRhAhctu4W79GPJpob6oDyjqfC0552F5S+HDA2earuQObEOEJXNr1otR3rr1q7QTL36x/nxrI+5PEi5C4ifDpOSUzOeOmR5c7e8OfCHM8mpVitObjCKry8jp74XskuS66QBzjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447616; c=relaxed/simple;
	bh=u9ZosPx6NFfoQsJgLGK/nse2lcposQdVqDsM/Nb8hpw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MIOzoI4/qTmeeDK5/EgiRoy4rScuh7VBEqjKQrx7m5hy10eeaMYndEP80gwpchfyifwKSB+fD5JiGJJbPjUfztaHOSXtqEL+8eJmmmt4uHslAirXiLKRpl8Hc5DRyVhpjcLhM1jHJLocrvKebUyTidfSo3l9ZHZ5jGfPCN7dNAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SKzbiUVb; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SKzbiUVb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788447614;
	bh=nIMsjPKkWC6oj6DSPSOmiFxZRf4zA0+sILK9narsKuI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SKzbiUVbLstbrR021qJkWEpmnQTp/1Q9Sc1zRAhpnW7RIr5PFIGHqSaBJzTtZ+XjP
	 mhbF1RYFvTJkIVhhH1Pf7ee6nxJakvG23lyJJLPmGQm8f2TDw5t8wCCO5/vBfvELUU
	 SP7OTD7bv2H2OJAy4j9S6mmKUE5pcSjFAZmzKAVo=
Received: from github.com (hubbernetes-node-4f05717.ash1-iad.github.net [10.56.171.50])
	by smtp.github.com (Postfix) with ESMTPA id 089DC3603EE
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 08:00:14 -0700 (PDT)
Date: Thu, 03 Sep 2026 08:00:14 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1157193/000000-dd7a28@github.com>
Subject: [bluez/bluez] 4dc2b3: doc/hci-protocol: Fix missing & on mtu argument
 in...
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

  Branch: refs/heads/1157193
  Home:   https://github.com/bluez/bluez
  Commit: 4dc2b34bf4ada36a7cd2ae77ee4da817457291f9
      https://github.com/bluez/bluez/commit/4dc2b34bf4ada36a7cd2ae77ee4da817457291f9
  Author: Zijun Hu <zijun.hu@oss.qualcomm.com>
  Date:   2026-09-03 (Thu, 03 Sep 2026)

  Changed paths:
    M doc/hci-protocol.rst

  Log Message:
  -----------
  doc/hci-protocol: Fix missing & on mtu argument in BT_RCVMTU example

getsockopt() requires a pointer argument, but mtu was passed by value.

Fix by using &mtu instead of mtu.


  Commit: f54ff046366829d150f63bbc10bb4afce69193b9
      https://github.com/bluez/bluez/commit/f54ff046366829d150f63bbc10bb4afce69193b9
  Author: Zijun Hu <zijun.hu@oss.qualcomm.com>
  Date:   2026-09-03 (Thu, 03 Sep 2026)

  Changed paths:
    M monitor/broadcom.c
    M monitor/broadcom.h
    M monitor/intel.c
    M monitor/intel.h
    M monitor/msft.c
    M monitor/msft.h
    M monitor/packet.c
    M monitor/vendor.c
    M monitor/vendor.h

  Log Message:
  -----------
  monitor: s/vendor_(evt|event)/\1_vendor/

Kernel include/net/bluetooth/hci.h defines:

  #define HCI_EVENT_PKT   0x04
  #define HCI_VENDOR_PKT  0xff
  #define HCI_EV_VENDOR   0xff

HCI_VENDOR_PKT and HCI_EV_VENDOR share the same value, but are very
different, as the table below shows:

+------------+-----------------------+---------------------------+
|            | HCI_VENDOR_PKT        | HCI_EV_VENDOR             |
+------------+-----------------------+---------------------------+
| Defined by | Vendor                | BT SIG                    |
+------------+-----------------------+---------------------------+
| Hierarchy  | Parallel to           | Nested inside             |
|            | HCI_EVENT_PKT         | HCI_EVENT_PKT             |
+------------+-----------------------+---------------------------+
| Direction  | RX and TX             | RX only                   |
+------------+-----------------------+---------------------------+
| kernel <-> | HCI_VENDOR_PKT, ...   | 0x04, HCI_EV_VENDOR, ...  |
| userspace  |                       |                           |
+------------+-----------------------+---------------------------+
| kernel <-> | RX: 23, vendor packet | RX: 3, HCI_EV_VENDOR, ... |
| monitor    | TX: 22, vendor packet |                           |
+------------+-----------------------+---------------------------+

monitor is about to gain HCI_VENDOR_PKT support. To avoid confusing the
two, rename what deals with HCI_EV_VENDOR to follow its pattern:

s/vendor_(evt|event)/\1_vendor/


  Commit: 186e847ea320de52b5324cbb9f02e9c1d01f6187
      https://github.com/bluez/bluez/commit/186e847ea320de52b5324cbb9f02e9c1d01f6187
  Author: Zijun Hu <zijun.hu@oss.qualcomm.com>
  Date:   2026-09-03 (Thu, 03 Sep 2026)

  Changed paths:
    M doc/hci-protocol.rst

  Log Message:
  -----------
  doc/hci-protocol: Add BT_RECV_VENDOR_PKT socket option for HCI_CHANNEL_USER

BT_RECV_VENDOR_PKT controls receiving vendor packets over HCI_CHANNEL_USER.

Disabled by default to avoid regressions for existing applications.


  Commit: dd7a28aebd5577709585647958d4d92357e58db4
      https://github.com/bluez/bluez/commit/dd7a28aebd5577709585647958d4d92357e58db4
  Author: Zijun Hu <zijun.hu@oss.qualcomm.com>
  Date:   2026-09-03 (Thu, 03 Sep 2026)

  Changed paths:
    M doc/btsnoop-protocol.rst
    M monitor/analyze.c
    M monitor/packet.c
    M monitor/packet.h
    M src/shared/btsnoop.h

  Log Message:
  -----------
  monitor: Support vendor packets

Kernel include/net/bluetooth/hci.h defines its packet type as:

  #define HCI_VENDOR_PKT  0xff

  - Defined by vendor
  - Bidirectional (RX and TX)
  - kernel <-> userspace: HCI_VENDOR_PKT followed by vendor packet
  - kernel <-> monitor: vendor packet has TX opcode (22) or RX
    opcode (23)

Support them in tool btmon.


Compare: https://github.com/bluez/bluez/compare/4dc2b34bf4ad%5E...dd7a28aebd55

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
