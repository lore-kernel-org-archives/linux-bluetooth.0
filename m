Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A541AA1EC
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601236; cv=none; b=JuTXtTgkC2qTYjjFMGWKFN4fFwXcrSEbJ2vbhScUuGx3fmg5Rs9tXIuWL2WEQL2ezwVwVfMybZkR8rbovItZLWAz5t06R2lG3n03xuGPIo/B4/namZ9ywX3UAjyEmnNBIxa6jtohr7cKvlOGWE0GOGkdGWSOi8pH3Zr4rOknxvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601236; c=relaxed/simple;
	bh=FH4lYBxbHwEfGqfHim1Qj5ILLZlh1Rh0E+P6djUR8Zw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=a7dae59lx26/kK4OqfxcX2CP3v+Z3FDY96yfRQZvwQofaO9NDQ6/5XtXxH+8lI+wvSCd1AW+qPixmO7jLANBJQLDpWy+MJvK/bZgs5R26bor2KOyZ6dP87YGsfqT1d3+pIrf/QGKh/ySNxWlgzsv3UIhQ11rLpQ+p1Du5mXHUBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aA0p4cvU; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aA0p4cvU"
Received: from github.com (hubbernetes-node-c799e02.ac4-iad.github.net [10.52.12.74])
	by smtp.github.com (Postfix) with ESMTPA id C6B54210FB
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 10:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745601232;
	bh=OH1EY+SrH2iDpAfB1PNCySDt3cxzxhIeFaHiZuI7kyo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aA0p4cvU+67v+o9BfcMQMNkpLsn1mXKxE7A0AU1WP76mYgmjqbIiuzbR/oBnzKrZu
	 1C2VPPxoOGpXP/FCRB6mlYwyjc0eUG79V8JUPc6jNO+zEjmQ3lzqXyUXbLOv4CcsM7
	 oL3ylSn5owgFwhnvBlWK87aOwLhjwB3f/KQG0zD4=
Date: Fri, 25 Apr 2025 10:13:52 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/955880/000000-5962f5@github.com>
Subject: [bluez/bluez] 5962f5: workflows: Add sync-repo action
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

  Branch: refs/heads/955880
  Home:   https://github.com/bluez/bluez
  Commit: 5962f5eeab32b0ee7f979801b579b7156bd8c6a0
      https://github.com/bluez/bluez/commit/5962f5eeab32b0ee7f979801b579b7156bd8c6a0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-25 (Fri, 25 Apr 2025)

  Changed paths:
    A .github/workflows/sync-repo.yml

  Log Message:
  -----------
  workflows: Add sync-repo action

This adds sync-repo which was part of https://github.com/bluez/actions/
but it gets disabled every 60 days due to inactivity.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
