Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354075FDA8
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 18:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033925; cv=none; b=ug3SMPybhEpksxcmg8Zgwdc5K06x1QJjppHtqOsLG/SW/3qc74SEB+hEOUZhZrCdTJqOqJkadESdcl0HplbCI7TdmmP0+tbgoy83c3h0fdqlzsJcm2XP+ts0ebBJEEvvL9NnjAjBzqsHIUy10eDZV1GTOtDAVAeUdpgceC+hijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033925; c=relaxed/simple;
	bh=I+NWPdYhapuu6FJOGl4H3CmXvmXKG8ckEat5E0f9jKQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=H7+U06q1GpMZkiId1kM1THXsvokqWmmnjr1eASAgLuIffsHLPEVGHgXihrlBu+AjVaZxR74o4P+hibIunRU8dg8IJKU21Js2Ubg/YHns+KjXandTtfUy59UV7W57WL1w1cuj2upiUPnD6RlGqLLOt2iC7v0rCcv+sDjt547r3YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OmDapD6l; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OmDapD6l"
Received: from github.com (hubbernetes-node-e5f515e.ash1-iad.github.net [10.56.161.41])
	by smtp.github.com (Postfix) with ESMTPA id 3770E34076A
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 10:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1706033923;
	bh=hX9PCoiplEDaFFrKf6KERlI9miw3FK3nb2KUVUogt0s=;
	h=Date:From:To:Subject:From;
	b=OmDapD6lyHupJDysojkJM0XZBLWRtXEKV+qgaZ4v+6558Sj25TYJrC8QMBYh/C2F5
	 2PSStKqabi4IOa8R3/HrmzA7xJvaPX8GaKqRU4kHdFwYuTIKoxGG5NzDvqLJC6pinA
	 6FEop9kUJw9UEkQ5i+Ty5vinWTo6enBEP/13LWIM=
Date: Tue, 23 Jan 2024 10:18:43 -0800
From: silviubarbulescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/a9d1f6-15e7d5@github.com>
Subject: [bluez/bluez] eb0578: isotest: Fix not handling 0 length packets
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
  Commit: eb057846cf0304c5faec30f510965f9071d45e57
      https://github.com/bluez/bluez/commit/eb057846cf0304c5faec30f510965f9071d45e57
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-01-23 (Tue, 23 Jan 2024)

  Changed paths:
    M tools/isotest.c

  Log Message:
  -----------
  isotest: Fix not handling 0 length packets

It is in fact possible to receive 0 length packets since that probably
means their status is not sucess.


  Commit: e4a35bc1e2cdf5a57ab24c08d36412154603ff52
      https://github.com/bluez/bluez/commit/e4a35bc1e2cdf5a57ab24c08d36412154603ff52
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2024-01-23 (Tue, 23 Jan 2024)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Code to generate bcast source BASE

Add code to support dynamically generated BASE from
endpoint configuration.


  Commit: ba943aadd0e27db720a0e0848542b675c01de899
      https://github.com/bluez/bluez/commit/ba943aadd0e27db720a0e0848542b675c01de899
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2024-01-23 (Tue, 23 Jan 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Remove hardcoded BASE from player

Remove hardcoded BASE and QoS for broadcast and use the information
from the preset instead.


  Commit: 15e7d5a4d24a22c9a3e3d317ee45c39f482991d3
      https://github.com/bluez/bluez/commit/15e7d5a4d24a22c9a3e3d317ee45c39f482991d3
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2024-01-23 (Tue, 23 Jan 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Use SetConfiguration info to generate BASE

Use the preset information provided by SetConfiguration to generate
the source's BASE and not receive the BASE over D-BUS.


Compare: https://github.com/bluez/bluez/compare/a9d1f6f6a625...15e7d5a4d24a
