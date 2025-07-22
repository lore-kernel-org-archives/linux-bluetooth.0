Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A24225A31
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 20:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753217360; cv=none; b=jAkx8yQEcl2MkOBA/RjufAcwX1GV2qAxepI4EpKXSRhzY4i5Md/4HU6S3++WT3PyKxw7gc6ofU24TkN1RSE72ufDCPzABkD6492rRvCyl+cp5K4vGuHVFKbxBXbj+bk960AK8zTwHRMyD1osLI7gVKPvsokEaE06oGnLWgH+Zb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753217360; c=relaxed/simple;
	bh=+069cyOwf051cMFTthW5RBv3F1Dpdb/k8W9oUpKNc0s=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=J161t39AlkMmo5UII00hJYJNhGNtlPMeXlwA1YjrncPuHXX5sv/wfwg2rkQtg7GAR3/ITvco7/crep8S1uJi4+LJib6sBFUv8pDCAvvVjrjzt43WcyqxOwGYvyhGURJONmqThiCTXabtvEccyWNF3/I+ro2PpiQFulqQ+5z/GbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jN5bYYbc; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jN5bYYbc"
Received: from github.com (hubbernetes-node-0144f6d.ac4-iad.github.net [10.52.148.35])
	by smtp.github.com (Postfix) with ESMTPA id C84D9210EF
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 13:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753217357;
	bh=6HP0qh4rt3J42Ar+fnG2f3AmP37O2mDjfSUsGb2Gl0Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jN5bYYbcCnmyjKSrpuuIzVxA+krN8Tn/mVb6K3/KdQnKyh+llfmzgh6RjKp2q3w2t
	 kEY4slOykdjv94p2q10OxJV8Z3odDVfrlEO441ZC1EFlJu0+fR0hyOTExhsW8Vtcvx
	 8zUIjOzO83Ale37Y4g8VfJkRfjZVnum/BJsrbVkk=
Date: Tue, 22 Jul 2025 13:49:17 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/984872/000000-90ab18@github.com>
Subject: [bluez/bluez] 891f57: transport: Add write support to Metadata
 property
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

  Branch: refs/heads/984872
  Home:   https://github.com/bluez/bluez
  Commit: 891f573532f09c840b3a8f3a9cf5de9b742d0ade
      https://github.com/bluez/bluez/commit/891f573532f09c840b3a8f3a9cf5de9b742d0ade
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-22 (Tue, 22 Jul 2025)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Add write support to Metadata property

This adds initial support from writing to Metadata property.


  Commit: f40498236393270496f712884296a129d6df3ee5
      https://github.com/bluez/bluez/commit/f40498236393270496f712884296a129d6df3ee5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-22 (Tue, 22 Jul 2025)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Fix not updating MediaTransport.Metadata

MediaTransport.Metadata needs to be checked for updates when state
changes to Enabling or Streaming otherwise it remains blank.


  Commit: 90ab181e07a73e35b7e55044bac8d94440c4dd64
      https://github.com/bluez/bluez/commit/90ab181e07a73e35b7e55044bac8d94440c4dd64
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-22 (Tue, 22 Jul 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client: Add transport.metadata command

This adds transport.metadata command which can be used to update the
MediaTransport.Metadata property:

> transport.metadata <transport> "0x03 0x02 0x02 0x00"
[CHG] Transport <transport> Metadata:
  03 02 02 00
> transport.show <transport>
...
	Metadata.#0: len 0x03 type 0x02
	Metadata.Context: 0x0002
	Metadata.Context	Conversational (0x0002)


Compare: https://github.com/bluez/bluez/compare/891f573532f0%5E...90ab181e07a7

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
