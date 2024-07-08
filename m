Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD5B1E86A
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455467; cv=none; b=IZ5MYZGZfVMe0n14ih2YCNYcjJdzvUOdW5nK+lOttbA7Z6+2wDpVbPTrWUDZeCzh0Pf6AqKE2zkLaQthdYoDDjnuPcFlwPGWi1V/ZhZSh9uR5XbmMNMLGM0xp19TNj3nusekBPJRkxXCtVhHoPcLz6CG/GjNFL8IfOLymeGixv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455467; c=relaxed/simple;
	bh=aIz8HuIc4M44ImzTkrcIjWR2akbu/WPNkpBRbTdTBV8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BpTK2qiFFI9S+byP0X2wIKKS6IDTsuE7EOHs8tsXAJRDIk3dCk1lVvm/2BXn9HOJfAuzxN+oPoJiFpLDr8QfCzD3g6H5zRenmTrSZm6KnQcjTjDWOCLOgBDhCt2Tj/ncJ0BCJhegnm6UQZrl79klOTlJT7Pqnh+UujGKoxP14lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MRxXUt/F; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MRxXUt/F"
Received: from github.com (hubbernetes-node-0649097.ac4-iad.github.net [10.52.146.39])
	by smtp.github.com (Postfix) with ESMTPA id 665B47006F0
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1720455465;
	bh=NpI5lvkUNsNJ78/bF7mhOuKZWmcnycGMpfszBtnHpHw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MRxXUt/FEFWZXkZs5vOK3BtrLzavdy3aVLZpn1SaDcGSOttmYbnkQ/PHrOEVPWSjd
	 phYYvNzIKlhJ9ZcvVLoXRtJg3hsJa6Hk3Scc+QSZ9npc2JaPPg1829wArxOo4Ol0XS
	 lE28o+1CYNY3f/VfpjZWb+3jG9DLICDZqksu0HxQ=
Date: Mon, 08 Jul 2024 09:17:45 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/804696-42d43b@github.com>
Subject: [bluez/bluez] b2371f: Fix discoverable property not emitted on
 updating ...
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
  Commit: b2371f9f11340232c4ba0a256794323b147cdade
      https://github.com/bluez/bluez/commit/b2371f9f11340232c4ba0a256794323b147cdade
  Author: Prathibha Madugonde <quic_prathm@quicinc.com>
  Date:   2024-07-08 (Mon, 08 Jul 2024)

  Changed paths:
    M client/advertising.c

  Log Message:
  -----------
  Fix discoverable property not emitted on updating value to false

client/advertising.c:
Allowing discoverable property to list in the parsing
function when discoverable is off.

Test steps:
From DUT, bluetoothctl go to menu advertise
set discoverable to off and then advertise on.


  Commit: 42d43b28428f93f36febdb4969c0a8526281d9ab
      https://github.com/bluez/bluez/commit/42d43b28428f93f36febdb4969c0a8526281d9ab
  Author: Prathibha Madugonde <quic_prathm@quicinc.com>
  Date:   2024-07-08 (Mon, 08 Jul 2024)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  Set BREDR not supported bit in AD Flag when discoverable is off

Fix for GAP/DISC/NONM/BV-02-C
As per GAP.TS.p44 test spec
IUT does not contain General Discoverable mode and Limited Discoverable
mode in the AD Type Flag. IUT shall send AD Type Flag to PASS the test
case, thus set BR/EDR not supported bit in the AD Type Flag when
discoverable is off.

Test steps:
From DUT, bluetoothctl go to menu advertise
set discoverable to off and then advertise on.
In AD Flags BR/EDR not supported BIT shall be set.


Compare: https://github.com/bluez/bluez/compare/804696dee795...42d43b28428f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
