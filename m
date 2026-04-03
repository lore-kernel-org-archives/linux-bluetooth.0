Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DF0368263
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775222384; cv=none; b=jx8ITPouhEmbaoJkd7o+pgf/538UyM6ahmtxEtCWghGZK0IgKK1xMeVQMzhj8oAvk41/luHTDVdRLcz1mbSNPpIMem1cUOdHThsDbpS3OSVpKs/X6z39w2y2CnAMA0dXbGJp1vrj/f1jmQfawjptDRXIj9YN5wQD4Vy/lrxlwpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775222384; c=relaxed/simple;
	bh=zrJODFl24I4kYWMpdRbVmH216CCvCPt9ddIkvyfenNs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=d5XWnmak5zXcF4nBcOkUIcAqKLTADPEr550jUvZc84MUnjHpmhxbRtOxehpRB1XqR0dLJt1HHF97+ZKVu2Jel6kAtlFjGPFgZEZIJSon+uTJzWAvZtCdWZqnHXRmTbpBVxA4HO+1z4dUKawwTOISddl6dGk29NCDZLqG9H+TA6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ycf9ef4E; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ycf9ef4E"
Received: from github.com (hubbernetes-node-ea1b3d6.ash1-iad.github.net [10.56.225.30])
	by smtp.github.com (Postfix) with ESMTPA id 45805C1154
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 06:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775222381;
	bh=JHK2DBNbKp7fEwrmHImDwJ2weJMn7AMSnRFOVS2zkYA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ycf9ef4EzA/1ecnxYdrrNLP7ec37n21z1CUhg9kw3l6JGLja2SYQ0g0YxheQI92ri
	 kUtSldcnZlBrytHXbj2AFhhLNIGvsl5hUJOf9C+HV0gqhVyllUnEi6rGDip70gpGeA
	 cWfdWeFHjxTtinoA9Y1cjSAQ7c4McDKncHsIsPOI=
Date: Fri, 03 Apr 2026 06:19:41 -0700
From: Kirill Samburskiy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1076973/000000-59ce83@github.com>
Subject: [bluez/bluez] 59ce83: audio/avrcp: Track TG and CT events separately
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

  Branch: refs/heads/1076973
  Home:   https://github.com/bluez/bluez
  Commit: 59ce8354e6118f1a0456089773eeff87b163e29c
      https://github.com/bluez/bluez/commit/59ce8354e6118f1a0456089773eeff87b163e29c
  Author: Kirill Samburskiy <k.samburskiy@omp.ru>
  Date:   2026-04-03 (Fri, 03 Apr 2026)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  audio/avrcp: Track TG and CT events separately

Since we support both target and controller AVRCP roles, we need to
track events for each role separately to avoid confusing events that we
registered for notification from remote TG, and events that remote CT
registered for notification from us. This change is only relevant if
both sides support both CT and TG roles.

Fixes: https://github.com/bluez/bluez/issues/1997



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
