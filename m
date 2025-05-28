Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33EA1F473C
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748443009; cv=none; b=JrRRH/66oILpXEJdg8ugVDE4kCMj+LlvlrebrC+0Mu0+e0JSey4XQ684mXHowVcHd7NcGleee62K3rSJMat0JiY66vUyOKfYKbffN83goGihvPH4r/rr2rMctwi8H7gWiEUzyntPHIe0C7v8Yj9qLncKaubAWam53xhPeqydZQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748443009; c=relaxed/simple;
	bh=5i4eVJpd33+qNB+c3/vqpMCCV1Vwd/pL2NEdGnpuPHM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kdYjIigDLE2XZ6iZyS5PXyyeeQK1RBZfjSWqqo1UyMKHb7wqhhsTenMwUmYJv1r8ZrtJJ3vU51T+MlLIUQxttpFYoyjBVSnUm5Q5PnTVFClsm6ybOQhXpZgOosrPHE8urzMH7JkR1tBN2iKtIr2W88b/DVWx7bw7y2dGdUrHD7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bzF6lGml; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bzF6lGml"
Received: from github.com (hubbernetes-node-07d14a5.va3-iad.github.net [10.48.143.40])
	by smtp.github.com (Postfix) with ESMTPA id C819C4E0953
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748443006;
	bh=Ohi7Nfbg4xPIASrLQv6v/UAXfcasnRjm/2tmDSggym8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bzF6lGmlCI3a0CqwQ2RkMBcLhHmnV4Kd6HpCHSnsD5VBc2rdFDyI9+Mr2p52Gml1E
	 ex182vYfnu2AUvTCKWpBPaYbjU7w5R7gLteWoNEmhoIsiyCx3R+cMtUg/84rXLQcuI
	 RG/RCopbu0xj9V5s5wHE2/dOJHT7uHBwREGy+ASY=
Date: Wed, 28 May 2025 07:36:46 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/967039/000000-c2e4a1@github.com>
Subject: [bluez/bluez] c2e4a1: audio/player: Fix not being able to register
 playe...
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

  Branch: refs/heads/967039
  Home:   https://github.com/bluez/bluez
  Commit: c2e4a17a6789e9bbb86a2d84e302c51dfa947a3c
      https://github.com/bluez/bluez/commit/c2e4a17a6789e9bbb86a2d84e302c51dfa947a3c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-28 (Wed, 28 May 2025)

  Changed paths:
    M profiles/audio/avrcp.c
    M profiles/audio/mcp.c
    M profiles/audio/player.c
    M profiles/audio/player.h

  Log Message:
  -----------
  audio/player: Fix not being able to register players of different types

When registering players both AVRCP and MCP were using the same object
path making them clash, so this fix it by adding a type to the object
path so each profile can register their player in their own domain.

Fixes: https://github.com/bluez/bluez/issues/1290



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
