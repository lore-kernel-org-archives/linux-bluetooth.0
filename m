Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D4B221F00
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090771; cv=none; b=sNcoUpV4ieJkQ3a0zDVs1qhc+tzJVcXDu5fYNhBXDzVPDQhTLsHENM+oV5Dy3zYpquSIWC1az/BJCLKAjxyTKLAhslipwUW9SlukusonBlYe/xVQVjsV8W9OQ1bVy40WJAH8hk/Li4W0kOu7iXHUC12p3dPyFPZMDjETXajv4uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090771; c=relaxed/simple;
	bh=z/O/vTBsw9QukLvaoAHHaP2buAiKh26akfMT44qQe/Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=sH75iLab7fjOucY7Q/gtsfeJtClMroPGD0NGtScIGuH1vMgZTRJRdiGumhmYDwp5gbRgOvXDRTcN+HUSqfSyDO7MaVfBKYJlVPiqvbOrayU1cxbNSG6cZ3mel5oX6xgrV9S5Z5jRy1/B+X+J8zqT4UJ+4QYxN21xMoM/SpSPri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eRCgJjx/; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eRCgJjx/"
Received: from github.com (hubbernetes-node-6b75a85.ac4-iad.github.net [10.52.201.79])
	by smtp.github.com (Postfix) with ESMTPA id 18E78641057
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 12:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1766090769;
	bh=9X2wDKXkFN9D34nQntaCBZ1yHKVVHU7zolQ4mCflq28=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eRCgJjx/3LdiUqrSJ/fHVzkYoJaVZ3getnFmWJsv5eAx4SO6Im3E6kMuHgIcq7XdD
	 Qdn1CJ75DM3VKhZX4i9kwyRQ/kqLsn4IKNWpKIXzfr+y2maVaolEQArQm87eZ+01Vd
	 gXrDf3AGVprIXwVDG8EuhgRDENUWiqB1JzLyfL/E=
Date: Thu, 18 Dec 2025 12:46:09 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/2edcad-a43170@github.com>
Subject: [bluez/bluez] c59900: emulator: Add support for
 BT_HCI_CMD_CHANGE_CONN_P...
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
  Commit: c599007776a8e2ce06aab3768c507d3e63390496
      https://github.com/bluez/bluez/commit/c599007776a8e2ce06aab3768c507d3e63390496
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-12-18 (Thu, 18 Dec 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Add support for BT_HCI_CMD_CHANGE_CONN_PKT_TYPE

This adds support for BT_HCI_CMD_CHANGE_CONN_PKT_TYPE as well as
emit BT_HCI_EVT_CONN_PKT_TYPE_CHANGED when it completes.


  Commit: 87bafc8d2dd559ba52635cd758cdd7c096c01395
      https://github.com/bluez/bluez/commit/87bafc8d2dd559ba52635cd758cdd7c096c01395
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-12-18 (Thu, 18 Dec 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Add support for BT_HCI_CMD_LE_SET_PHY

This adds support for BT_HCI_CMD_LE_SET_PHY as well as
emit BT_HCI_EVT_LE_PHY_UPDATE_COMPLETE when it completes.


  Commit: a431702e9ec28831bb11e48b488a3d40604074e5
      https://github.com/bluez/bluez/commit/a431702e9ec28831bb11e48b488a3d40604074e5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-12-18 (Thu, 18 Dec 2025)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  tools/l2cap-tester: Add tests for setting BT_PHY

This adds the following tests that use setsockopt(BT_PHY):

L2CAP BR/EDR Client - Set PHY 1M
L2CAP BR/EDR Client - Set PHY 2M
L2CAP BR/EDR Client - Set PHY 3M
L2CAP BR/EDR Server - Set PHY 1M
L2CAP BR/EDR Server - Set PHY 2M
L2CAP BR/EDR Server - Set PHY 3M
L2CAP LE Client - Set PHY 1M
L2CAP LE Client - Set PHY 2M
L2CAP LE Client - Set PHY Coded
L2CAP LE Server - Set PHY 1M
L2CAP LE Server - Set PHY 2M
L2CAP LE Server - Set PHY Coded
L2CAP Ext-Flowctl Client - Set PHY 1M
L2CAP Ext-Flowctl Client - Set PHY 2M
L2CAP Ext-Flowctl Client - Set PHY Coded
L2CAP Ext-Flowctl Server - Set PHY 1M
L2CAP Ext-Flowctl Server - Set PHY 2M
L2CAP Ext-Flowctl Server - Set PHY Coded


Compare: https://github.com/bluez/bluez/compare/2edcad4c4312...a431702e9ec2

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
