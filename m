Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22438BE4E
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 20:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731616773; cv=none; b=M5qhUAG0N21gka0Fg58n9XvlYNrwejE5rBmscgqszte85qMJCm0kt7DwHD1AGMbSyC8g0WrOCxitSzbV6HnGadgTeGf9z3t2gKDn8ecWrx+hLsTFGU8Q9BytOl2m8WGTGgh0IL/yaTkKKwiEsUGi1CgxZM2Xdwi7w8/mpcBE+6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731616773; c=relaxed/simple;
	bh=GAqJMVVD5ToxD/FHbWAGScyN2RDGsKqSWpehd/2uqAM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ig6q9nJgEtLtqdImk9vwUPmQX4iVEybymisIxsrXpG4cEKjcxoIAxhY52BXT95dtWdQwmxB1pVI8/YFR3zTQP6lt+J6TpvHm92IjP5eM01Wq4pWtvBwZSl239pUSNG4bjnA8UKj6AQWrL2skGZtIC9RnmlHKLjRwN9v54nru7kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jfWyB2pp; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jfWyB2pp"
Received: from github.com (hubbernetes-node-e3a920b.ac4-iad.github.net [10.52.134.27])
	by smtp.github.com (Postfix) with ESMTPA id 48BED70104B
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 12:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1731616771;
	bh=RANIA1m+RSa+OVZX4pCQMqOkwUSlURWERlIESVCrSLQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jfWyB2ppHf147DeDlsOCW0oKaNKmwR6itjFeb9Q6rGwDadJmKlcTtfTOEjGb+BuCu
	 qznEpN3z93BoUVZzOh/lZXDyaLrsm0vU4z8hcng3NiN1Ihox2Vc9eEg+4kNY0IWggS
	 x5lHOkAGiVyh1M14HI5RDskN0gpJYs9S2Q7lOPRM=
Date: Thu, 14 Nov 2024 12:39:31 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/63f1ab-95e89c@github.com>
Subject: [bluez/bluez] fe1296: mgmt-api: Add Send HCI command and wait for
 event ...
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
  Commit: fe1296cb1156f252e5011bb00fe1186ddfd19ad6
      https://github.com/bluez/bluez/commit/fe1296cb1156f252e5011bb00fe1186ddfd19ad6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-11-14 (Thu, 14 Nov 2024)

  Changed paths:
    M doc/mgmt-api.txt

  Log Message:
  -----------
  mgmt-api: Add Send HCI command and wait for event Command

This adds Send HCI command and wait for event Command initial
documentation.


  Commit: 2e981e1a9498448a05900ccfd891ceb320e81034
      https://github.com/bluez/bluez/commit/2e981e1a9498448a05900ccfd891ceb320e81034
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-11-14 (Thu, 14 Nov 2024)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix opcode for MGMT_OP_MESH_SEND_CANCEL

MGMT_OP_MESH_SEND_CANCEL opcode is 0x005A not 0x0056.


  Commit: d395c6b1c7d4087ba6de7641c5932dc91cf1b210
      https://github.com/bluez/bluez/commit/d395c6b1c7d4087ba6de7641c5932dc91cf1b210
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-11-14 (Thu, 14 Nov 2024)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add decoding of MGMT_OP_HCI_CMD_SYNC

@ MGMT Com..nd (0x005b) plen 6  {0x0002}
        Opcode: 0xffff
        Event: 0x00
        Timeout: 0 seconds
        Parameters Length: 0
        Parameters[0]:
@ MGMT Event: Command Status (0x0002) plen 3    {0x0002}
        Send HCI command and wait for event (0x005b)
          Status: Failed (0x03)


  Commit: 0580dc4bb64f143da3897f78f7734fbd0f64df1b
      https://github.com/bluez/bluez/commit/0580dc4bb64f143da3897f78f7734fbd0f64df1b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-11-14 (Thu, 14 Nov 2024)

  Changed paths:
    M lib/mgmt.h

  Log Message:
  -----------
  lib/mgmt: Add definitions of MGMT_OP_HCI_CMD_SYNC

This adds the definition of MGMT_OP_HCI_CMD_SYNC and its packet
structure.


  Commit: 95e89cd2e4f84773dc78415bf33758a7456827c9
      https://github.com/bluez/bluez/commit/95e89cd2e4f84773dc78415bf33758a7456827c9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-11-14 (Thu, 14 Nov 2024)

  Changed paths:
    M client/mgmt.c

  Log Message:
  -----------
  client/mgmt: Add hci-cmd command

This adds hci-cmd command which uses the MGMT_OP_HCI_CMD_SYNC:

bluetoothctl> mgmt.hci-send 0xffff
bluetoothctl[44]: @ MGMT Com..nd (0x005b) plen 6  {0x0002}
        Opcode: 0xffff
        Event: 0x00
        Timeout: 0 seconds
        Parameters Length: 0
        Parameters[0]:
< HCI Command: Vendor (0x3f|0x03ff) plen 0
> HCI Event: Command Status (0x0f) plen 4
      Vendor (0x3f|0x03ff) ncmd 1
        Status: Unknown HCI Command (0x01)
@ MGMT Event: Command Status (0x0002) plen 3    {0x0002}
      Send HCI command and wait for event (0x005b)
        Status: Failed (0x03)


Compare: https://github.com/bluez/bluez/compare/63f1ab560c42...95e89cd2e4f8

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
