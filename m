Received: from o4.sgmail.github.com (o4.sgmail.github.com [192.254.112.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331B22673B0
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 20:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.112.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766004752; cv=none; b=YgaTfMA0yL2L1QtxYrgn+88KiHkxn477Ygcbm9K/U3XiSz9kjkPBOA47fcSkxY2bjcEGWciYOxTOTYjwRxZOeoggKKs345PjefwVqmxoIRgwnfc2OxbtqwcKbrHM7QLJZtHJlGsRLlw33249fcLJaWw08gQgD3GrccGXBzTjc8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766004752; c=relaxed/simple;
	bh=guZ2s8xlXT1bmg4yrLuYmR3KxPILA9oXpjBugHf/wsc=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=AoRtBuK1pyJOwjzQfe0x0i3hHfcefphUnEA49YU56L1gne2Gs5t+5YBa2Rl9xabodQ5pVyuoWJFu1S0pxxuq9Rx3RX/mJPXVXMwycg+iMyplzE92ubSrEbHtAuvJFWYeMKEk7l1y+8QuxjZlQuTAzyFOqrJa6fYTMKWsf7Zigtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XvVvXFDE; arc=none smtp.client-ip=192.254.112.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XvVvXFDE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=wtFvcGCbCWcxXY1Cx4IqcnVudODygzPgrTr7N84mtGY=;
	b=XvVvXFDEjx5dR7V69hybZuVX4kFh2Eh0lx/IVQKFu88IbkQ3nmEZDGmislMgtuYKMMKI
	pjXpd4NhWlKZ2j9oc5SY6N07RtfhC9F65HqDM6dpLpV/UcRhOSm+ZMx6fZr6jukvgQKR8R
	CR1geRFPBHCS8EeygDjtWBODImoGq8Q00=
Received: by recvd-b6bf78b66-jb2fp with SMTP id recvd-b6bf78b66-jb2fp-1-6943180C-4E
	2025-12-17 20:52:28.923722655 +0000 UTC m=+2591768.227314942
Received: from out-22.smtp.github.com (unknown)
	by geopod-ismtpd-56 (SG)
	with ESMTP id V4j6I_18SHSFaQEyL6LCmw
	for <linux-bluetooth@vger.kernel.org>;
	Wed, 17 Dec 2025 20:52:28.899 +0000 (UTC)
Received: from github.com (hubbernetes-node-1a12d55.ac4-iad.github.net [10.52.211.58])
	by smtp.github.com (Postfix) with ESMTPA id 9F6E520C67
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 12:52:22 -0800 (PST)
Date: Wed, 17 Dec 2025 20:52:28 +0000 (UTC)
From: Luiz Augusto von Dentz <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/1034336/000000-0bb525@github.com>
Subject: [bluez/bluez] fab092: emulator: Add support for
 BT_HCI_CMD_CHANGE_CONN_P...
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
 =?us-ascii?Q?ngWQlMPxccS8u9EBUyRL9UmZaAIAsHm3dJCt0Cp?=
 =?us-ascii?Q?gMxLLrkbWVpzXHa+r5c6RTM02IcRoOMsglp+VWQ?=
 =?us-ascii?Q?AftEXQw83TqvWSwzsXcxw+gNTbpuF73zsb8vXfM?=
 =?us-ascii?Q?YTqwJyUFCHHoPPYlwfkvlSuV70bmMK0khnIVLCM?=
 =?us-ascii?Q?h2uWYMKCBl369MVd5kumJOp9eZi+wB=2F+QsopPAP?=
 =?us-ascii?Q?YXXewVCeQYKXJXNzc5VXUduSAw=3D=3D?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/1034336
  Home:   https://github.com/bluez/bluez
  Commit: fab09262ff6b2cbaa3f20d2b7f524b1c7cf4d4df
      https://github.com/bluez/bluez/commit/fab09262ff6b2cbaa3f20d2b7f524b1c7cf4d4df
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-12-17 (Wed, 17 Dec 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Add support for BT_HCI_CMD_CHANGE_CONN_PKT_TYPE

This adds support for BT_HCI_CMD_CHANGE_CONN_PKT_TYPE as well as
emit BT_HCI_EVT_CONN_PKT_TYPE_CHANGED when it completes.


  Commit: bf34978b41bbb008d455aaca2993f8ef721b4e5b
      https://github.com/bluez/bluez/commit/bf34978b41bbb008d455aaca2993f8ef721b4e5b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-12-17 (Wed, 17 Dec 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Add support for BT_HCI_CMD_LE_SET_PHY

This adds support for BT_HCI_CMD_LE_SET_PHY as well as
emit BT_HCI_EVT_LE_PHY_UPDATE_COMPLETE when it completes.


  Commit: 0bb525c2c763f3a0421f2c6d020e4db3f0dbad02
      https://github.com/bluez/bluez/commit/0bb525c2c763f3a0421f2c6d020e4db3f0dbad02
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-12-17 (Wed, 17 Dec 2025)

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


Compare: https://github.com/bluez/bluez/compare/fab09262ff6b%5E...0bb525c2c763

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
