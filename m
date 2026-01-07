Received: from o3.sgmail.github.com (o3.sgmail.github.com [192.254.112.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E5BF4FA
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.112.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767820831; cv=none; b=Buh3DzxMX9fFEbDFM0AIE/v0gZ/AgpJS8bAaB0omnoKx95sOZzzYjAYr1DA1KRzfe+Nr2fVpEyZde8lQXHSUGj4l0V/oWBr5Q0I2bRp9FrJq2u/6k3fkzPYVdBemX/7gXosClsMHp8ch8gP1fVmEMs4FCz1FNIdgdSL4lzQvAoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767820831; c=relaxed/simple;
	bh=mWP4OQiNS26nMxzUBSdlb0NpNRp8kjwjO8cXNuRfelg=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=pv2BEMAqFV/FoU5uy9K+WzrR1wII6ADcn4e27iM6jQe7v3ojG7qjZcScLFPg5Osch9ifLKk5fKx5pQmmauiqHP07ZWf6s/k9gyrX6hcFukVS/0RMHNmhcGnll1UnA3T5D4Tg4/LzeDcMYysBtVjfIadt1uZKoY1cfsbIuxAzhwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=r9zEXsDO; arc=none smtp.client-ip=192.254.112.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="r9zEXsDO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=3uYeXdHCLZgxhm+MeWH/PkT+Cv1DRBkdQc44U2Wqm1o=;
	b=r9zEXsDOKiAOmkH7/5Cg2V3DInc1BJVkTgJv/YY8/2GTdIJe8pvtVkTBq6DI0Jr+SvUY
	X7Oh5ohe/GhJNKt22O24r63gLwff+TIauGV05VkMdmf88FKVb5EuN0XPRPa6AvpQcOgUh1
	LXSM9C9qX86AFOVMtd9KeCqOQZ4I9RwWo=
Received: by recvd-948c5cd45-xpwtl with SMTP id recvd-948c5cd45-xpwtl-1-695ECE1C-8D
	2026-01-07 21:20:28.819123487 +0000 UTC m=+1811492.104879312
Received: from out-28.smtp.github.com (unknown)
	by geopod-ismtpd-30 (SG)
	with ESMTP id X0D40HX3Sia_ZFiEdkLcqg
	for <linux-bluetooth@vger.kernel.org>;
	Wed, 07 Jan 2026 21:20:28.810 +0000 (UTC)
Received: from github.com (hubbernetes-node-51553c9.ash1-iad.github.net [10.56.206.39])
	by smtp.github.com (Postfix) with ESMTPA id BF81192129B
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 13:20:22 -0800 (PST)
Date: Wed, 07 Jan 2026 21:20:28 +0000 (UTC)
From: Luiz Augusto von Dentz <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/master/38ac68-561d4e@github.com>
Subject: [bluez/bluez] 924762: lib: Rename bt_iso_io_qos phy field to phys
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
 =?us-ascii?Q?ngWQlMPxccS8u9EBUyRL9UmZaAIAnT8bkKEyjHd?=
 =?us-ascii?Q?tRlILOGcD+fl31sk=2FqsVQHwAmqykEALZZv=2FJ0y=2F?=
 =?us-ascii?Q?KCBSdOkKbLB67E7ZYBzPrcJGYoanMoOWq67rv9e?=
 =?us-ascii?Q?RPUkU0FGk3A+wAPIuWOaeWex0ZcTIBf7Hrl7pzc?=
 =?us-ascii?Q?8ujRBmiMeGn0LwVWmAJbIzsGWkKyiWamQrqLgAI?=
 =?us-ascii?Q?BYvil7LiV2qLM+36ksznnBpExg=3D=3D?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 9247623a8d148230af3a80db751cda67acecc536
      https://github.com/bluez/bluez/commit/9247623a8d148230af3a80db751cda67acecc536
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-07 (Wed, 07 Jan 2026)

  Changed paths:
    M emulator/bthost.c
    M lib/bluetooth/bluetooth.h
    M profiles/audio/bap.c
    M profiles/audio/media.c
    M src/shared/bap.c
    M src/shared/bap.h
    M tools/btiotest.c
    M tools/iso-tester.c
    M tools/isotest.c
    M unit/test-bap.c

  Log Message:
  -----------
  lib: Rename bt_iso_io_qos phy field to phys

This renames the bt_iso_io_qos phy field to phys to emphasize it is
actually a bitfield rather than a single value.


  Commit: 561d4e815f288b570ad283692291f4064d52f586
      https://github.com/bluez/bluez/commit/561d4e815f288b570ad283692291f4064d52f586
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-07 (Wed, 07 Jan 2026)

  Changed paths:
    M client/player.c
    M profiles/audio/bap.c
    M profiles/audio/media.c
    M profiles/audio/transport.c
    M src/shared/ascs.h
    M src/shared/bap-defs.h
    M src/shared/bap.c
    M src/shared/lc3.h
    M unit/test-bap.c

  Log Message:
  -----------
  shared/bap: Fix PHY fields being treated as single value

BP PHY fields always refer to bitfields with the exception of target
PHY field in bt_ascs_config.


Compare: https://github.com/bluez/bluez/compare/38ac68e23909...561d4e815f28

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
