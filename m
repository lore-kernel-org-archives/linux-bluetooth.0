Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E403C9ECF
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373956; cv=none; b=TDj9IL+5wA8FNvzWCWsoVq2RKByqxTRMt/YJmOB50FUcdJOfDyuNpjF/lN+ZVHJx86DL4e+p0kZ1kSs0rR8iym5FctfN/poq7gJV4xekZ2qjAn+dPKl1BQzE0k9EWJVHoGzgLN6G3qxnXymP+NyAJt9s+G7iYuA6b6zvS0HqQPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373956; c=relaxed/simple;
	bh=JOve33N7oY5x+xePb7zQ8gfyraoIwUObvGlHJjns5AI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cNE3FszvMM/ZsdwiA7r6gAARTW/apEj/APUUh+T6LGLplzfajQ8gHMrTEMcBpYhc6+j9wchAc3BqS2mXiOKiqgarBv8mEJedbD+PwHbHC5B5taEhqb3KaXwJaaDyGewtpbU5J52TXdhIIrWqhBTWhUque9Zdz+o7iNdxKs7mmnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DNnBzIjG; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DNnBzIjG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779373954;
	bh=iJSrozX9jQmlJxS8QtGvj6Ag1ntUTb8jjrMx8jPtUtM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DNnBzIjG4U3EWqGZI9pqsOma4eF8aXFsbx/G/jgoPvjsx35Ybf0LW9mksyftrNA2k
	 9IxfDQP1D5QgsGZdt4Nfxs2VdgR7yd+1fj5SZ+uMUmUCYZCHYNtdrK0rVWxy/YAGPJ
	 o9hfwUBLzk+DkDLeoDZ5k/yAqSG/usVSt4crPwmQ=
Received: from github.com (hubbernetes-node-6d55de3.ac4-iad.github.net [10.52.175.52])
	by smtp.github.com (Postfix) with ESMTPA id 80890A175B
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 07:32:34 -0700 (PDT)
Date: Thu, 21 May 2026 07:32:34 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1098419/e58872-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1098419
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
