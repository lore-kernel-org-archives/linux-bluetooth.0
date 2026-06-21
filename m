Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD9E26E706
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2026 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782068866; cv=none; b=WOwNLpMAJbTEYt6gNlmfpVb/aNSGq/hKh38uxEJgCp6vJudWZKPy6u/q/52Y7e9vAFpU9ZAMcIzDHchTDbQpQcLo+F1hqYk/ZsI/REL5P3UE/ICyTnFJDDGOqWFE2Ggw62tm5ODX2dxn3qyI6b+xZnl6eKuceQUeGXQTVyGQ4aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782068866; c=relaxed/simple;
	bh=58pP7jzx/Hf+6pLGOC/Z8GbLGa7K7xSAb5jZPVJAjhs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=snqouY1yM0cErb0tBdUaSHkG58ys/M0hvqQLL7DHK45pR5VeQf6847TtBCjtK2mjnZUEJWboXzDZpo4dEIA/b27lQMtw3sJSzHPzJare64yUyEdqPkRSqG+dL2ziIxKPk0CPI0QVaaySS3s9ElOoqnxcqXjm1vfzUEJmmEnWX/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cRPR5Hc+; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cRPR5Hc+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782068865;
	bh=+Q1Sfekvs0+jIy8Qkg7XRtvRbOxEDAyURZlXhhwX88s=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cRPR5Hc+wWT9fYGbVjrIRkZfj6Z3dsRLZdB4/SHNKyfXvmu+j0uHP6UtU0u6LpU9T
	 8RYOiO2ny6P5imqaCwsf+SpXL6ZyD6Dbs/JTv2iDktcA3YLkEYB190l4+AxnoFditm
	 wtgfHwLi/fgSeJLTlvDJquTtcH+D2hZ9Eux4YKLo=
Received: from github.com (hubbernetes-node-1d4212a.ash1-iad.github.net [10.56.152.34])
	by smtp.github.com (Postfix) with ESMTPA id 22443600E2A
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2026 12:07:45 -0700 (PDT)
Date: Sun, 21 Jun 2026 12:07:45 -0700
From: Arnav Kapoor <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1114380/000000-64653d@github.com>
Subject: [bluez/bluez] 64653d: src: Remove dead assignments in batocomp
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

  Branch: refs/heads/1114380
  Home:   https://github.com/bluez/bluez
  Commit: 64653dc2e8ca4dc20ea5f3b0c22fa2c5979dbf13
      https://github.com/bluez/bluez/commit/64653dc2e8ca4dc20ea5f3b0c22fa2c5979dbf13
  Author: Arnav Kapoor <kapoorarnav43@gmail.com>
  Date:   2026-06-21 (Sun, 21 Jun 2026)

  Changed paths:
    M src/oui.c

  Log Message:
  -----------
  src: Remove dead assignments in batocomp

The return values of udev_hwdb_unref() and udev_unref()
are assigned to local variables that are never read again.

Remove the unnecessary assignments.

Found by scan-build.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
