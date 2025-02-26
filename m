Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBB910F2
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 20:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600925; cv=none; b=WIYu0P5e7kKWdW9Y79q1DSr+89qhK7wP9qaUMGSHjbpZxll3D1JitUYHsucshtINtV7piEJY0oKAH7tWKrPhh1P3MFCc3ilnCE+VBMb4XDoY+psYh3Qqmq2q9FI2UQFfMUp12tVr/34o7yEOi9BtVCQoRd0jZpeT43D3whq1UN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600925; c=relaxed/simple;
	bh=7tEs9XBRScfnVSak49/26gXvoPxPH0zWV5sCZEM/o4E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AE42mxNEeXZl9k1MbgWO8/mwFLYbduumyFe1eMQKYhSl0z+NAcGAiUvu/27EarQazMjUv9nJcBT9zN2O7HYFk2zpMlRgeEQqdhnbvYNc8xeKeYRY6iWb4VL9PEPJ1TazT3npWUQwZIRtkNw8oTy9d4kfbw1Crg4svTi95lbrExs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PiOpoNt8; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PiOpoNt8"
Received: from github.com (hubbernetes-node-9881bb6.ac4-iad.github.net [10.52.211.80])
	by smtp.github.com (Postfix) with ESMTPA id 5678E211C7
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 12:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1740600923;
	bh=h5XP5pqEG6847d4DOu0fhFAWzYtQxfz+/aqT1pvH+hc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PiOpoNt8++KARRV+AhV+rB6FhLMzxuKjZo6R77Q4q6lcI5yIiA7LPgl1d1Bo1pFJF
	 6fqWSdRKa7m5U7AXAskHUoR7Q69U6XQlL9Lzj13P9ewFxufksq6e+X6AQf/4uqgVI0
	 W08tIyKrVqcZBKb90COTBzxtlaBNdpf0ySOqnza0=
Date: Wed, 26 Feb 2025 12:15:23 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4465c5-173045@github.com>
Subject: [bluez/bluez] 173045: bap: Fix not generating releasing state
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
  Commit: 173045553c156185ba1bbdbf39ada139cd4bca65
      https://github.com/bluez/bluez/commit/173045553c156185ba1bbdbf39ada139cd4bca65
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2025-02-26 (Wed, 26 Feb 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  bap: Fix not generating releasing state

CIS sink need caching the Codec Configured when releasing by Pixel,
state machine is releasing -> Codec. If streamming -> idle, CIS sink
was silent after resume music.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
