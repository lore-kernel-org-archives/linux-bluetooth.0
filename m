Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4463B1EC6
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791623265; cv=none; b=NWR8kjvZqqCBLjJ8uHmM8qgZCD6gGqiwme3mmpLdlcQerFLRtOfxL9uKoiCQxSiRvvRv0NTAbCqXNvaXzbpwLIYH3BaF4bMQx9yy0EvEFMrpWj//i2gLkOs2bdmrXjTtF2Jy0NVTo923AOltcr5nNNa1ocgY95adJKZHDHdZi9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791623265; c=relaxed/simple;
	bh=+W1dpMRv9TPD7D6ANjONufmu2VsMVxKcceI4I0xcw9k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KjGRa3/A18qaXUse6j9+VmsO09fro/BP8iNAICPZgMFZKDbquJ1unITnN/0eYkzvX46WeMMfhogh1slGGIM2erMD/RIbZMgiFQW1RJ0hXpFUA1496Cd0mm/mhNzGyyTJjLkgeXrmwYNgd4duQao/NByBJllIc9NSuvCG1UGgfLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=kVqb+Lp5; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="kVqb+Lp5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791623263;
	bh=L8t6g2lBJ/cAVo3V8aEKLy1eXS8Zx8/czwA1h+vTRFo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kVqb+Lp5yJzgqtB6FfOVV56j8DQvtN38uOPG1E1lSv90c4fbUaJcza8VS/TIWAshV
	 NMFDCXrrVps3w5y0OsVW1I6HO6hFPrZ8CP+N/MREMwpck/qIfptRYOUpXvcqG/CuoY
	 IOWFo6vgg+vrx5CEhFuxsnDgIr7850zEkSyygOlKiHvN02l5y8EFKzOZP6T0uLBXaw
	 CaTG9sDaEsuCY++TosEYxoCRurRtRaAJqzcQ3nm9QCStkh/P1/8OBnk3zIVzzGYcNr
	 8ca6mG4yU+tT5a038RC2YtSc78uDac8cZOfqQJpVlxOFqI3frM6/yFljUZtOkKnYQK
	 p2HCFGqATVC1A==
Received: from github.com (hubbernetes-node-3fa07df.ac4-iad.github.net [10.52.211.51])
	by smtp.github.com (Postfix) with ESMTPA id 6027A202C6
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 02:07:43 -0700 (PDT)
Date: Sat, 10 Oct 2026 02:07:43 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1182837/000000-73dc1c@github.com>
Subject: [bluez/bluez] 73dc1c: bearer: Cancel disconn_timer upon
 btd_bearer_disco...
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

  Branch: refs/heads/1182837
  Home:   https://github.com/bluez/bluez
  Commit: 73dc1cf9ad9987461e80f5f2f5342543d6504ba6
      https://github.com/bluez/bluez/commit/73dc1cf9ad9987461e80f5f2f5342543d6504ba6
  Author: Ye He <ye.he@amlogic.com>
  Date:   2026-10-10 (Sat, 10 Oct 2026)

  Changed paths:
    M src/bearer.c

  Log Message:
  -----------
  bearer: Cancel disconn_timer upon btd_bearer_disconnected

If a fast reconnect occurs after a rapid disconnect,
the 2-seconds bearer->disconn_timer may still fire and
tear down the newly established link.

Fix this by cancelling the disconn_timer inside
btd_bearer_disconnected().

Signed-off-by: Ye He <ye.he@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
