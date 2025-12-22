Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ACB1946BC
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766432664; cv=none; b=sjGTtW48v0ySg6gw+wwB2fI/Qzki1/iM2gonKTnIeaZIFoHILs+A0ev3QtXy3QMrMiR1599+vRK4N0n7oKpC24t9AACqbReJk+k5kJPEFhLNNRz5X3t4nOKZzLek0hw9X7VdDyyCA2tx+Yg0zWSJAATuL/WenmVm/mlJi+xxoxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766432664; c=relaxed/simple;
	bh=A3Xjge3hQ7DOn3F8cSnrpgaQeP6ufEUM8RsNrTpjWNI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AQFJHbFk490bHjgywKEplzK2dniKv6OZvTRG1Gjo0ABLc5u/smd8F9fr4iyrD4Tj8pLmTEUgYiq9FZ8M/+1rvC5tTrcabm+z6WcrwlLnC5qGz1T8FasMuuwcAJPwuwE1Rb/Ikb+6JeKW3GF+fvC3nPyO7r3yhczOnkJo1Uiq3Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eq4raTRB; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eq4raTRB"
Received: from github.com (hubbernetes-node-22d2b4a.ash1-iad.github.net [10.56.150.32])
	by smtp.github.com (Postfix) with ESMTPA id 9EE006008D6
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 11:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1766432662;
	bh=qOKO2x+iVHrodeNDDejUSycFlkY6iTCINfmdbPIPWAY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eq4raTRBkJo7G3YCrxoTHCuVLlI+KNX3aDGjNkTFcohc/GwOhKYzfrZi8JgLd/S6h
	 Btlt+1FJTc1Kw3+0mMFiusm3CqpH/VV8V7mtL6iit+n6jFlNE6ItqjqG05gQd9Osj+
	 /5FcThklP0C0/cyE7vpmipM2wbZKzmbp7J6HpadY=
Date: Mon, 22 Dec 2025 11:44:22 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1035801/000000-b707db@github.com>
Subject: [bluez/bluez] 2fb0aa: monitor: Fix parsing of
 BT_HCI_CMD_LE_SET_CIG_PARAMS
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

  Branch: refs/heads/1035801
  Home:   https://github.com/bluez/bluez
  Commit: 2fb0aa22d80c296d88da566edd71570a7788e426
      https://github.com/bluez/bluez/commit/2fb0aa22d80c296d88da566edd71570a7788e426
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-12-22 (Mon, 22 Dec 2025)

  Changed paths:
    M emulator/btdev.c
    M emulator/bthost.c
    M monitor/bt.h
    M monitor/ll.c
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix parsing of BT_HCI_CMD_LE_SET_CIG_PARAMS

The fields of BT_HCI_CMD_LE_SET_CIG_PARAMS are bitfields rather than
values, so this changes the fields to phy's' and fixes the parsing to
print it as bitfield rather than value.


  Commit: a6679d0338cde5682e05f8fd5d225c0d327c2fea
      https://github.com/bluez/bluez/commit/a6679d0338cde5682e05f8fd5d225c0d327c2fea
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-12-22 (Mon, 22 Dec 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Fix using BT_HCI_CMD_LE_SET_CIG_PARAMS PHYs as values

BT_HCI_CMD_LE_SET_CIG_PARAMS PHYs are bitfield so they need to be
converted to values when emitting BT_HCI_EVT_LE_CIS_ESTABLISHED.


  Commit: b707dba6249130050c716b6cccd46d1e57d34ca5
      https://github.com/bluez/bluez/commit/b707dba6249130050c716b6cccd46d1e57d34ca5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-12-22 (Mon, 22 Dec 2025)

  Changed paths:
    M emulator/btdev.c
    M emulator/bthost.c
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix parsing of BT_HCI_BIT_LE_CREATE_BIG

The PHY field of BT_HCI_BIT_LE_CREATE_BIG are bitfields rather than
a value, so this changes the fields to phy's' and fixes the parsing to
print it as bitfield rather than value and also make the emulator to
use bits_to_phy to convert when emitting the likes of
BT_HCI_EVT_LE_BIG_COMPLETE.


Compare: https://github.com/bluez/bluez/compare/2fb0aa22d80c%5E...b707dba62491

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
