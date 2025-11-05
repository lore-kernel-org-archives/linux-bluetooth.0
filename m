Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2925D8F0
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 18:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762368408; cv=none; b=l5xDU8mBE9VM+M1pAqIBSUAEy00H3+uR1MalQn485iR9pW2wQmQVDxYxJ3PNujfLFGQKMAsEBsvy++e1a69g/N1de4D9LI7i+ZRuP43nhTZnGHyt7koTJccmmTn2pszKBRnjdu9RMuPXwmozWd1pDQHKNdAFWdbSLrRZbciRU3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762368408; c=relaxed/simple;
	bh=znTe99m24xV0TbSGsPIsyLOljNqX3WqZrisHhMIfBbo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FQAbwkcY/RsCr2EPowZs0+KI2sQc6/q9EUb434RBkDoa1O3XDA3GXgnBQv3/anUdNhZ0SZTBtHtmUGfQhqqc4UlF91fK6axWZiuu1N8OhJLhSRC0qFrSEkZz7NoiSklu2eRm2L/C2GnMlXOOy8y1fC93kC10rwlHWxHoc1DK5Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AB5aEUos; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AB5aEUos"
Received: from github.com (hubbernetes-node-a71454b.ac4-iad.github.net [10.52.163.36])
	by smtp.github.com (Postfix) with ESMTPA id A39552050E
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 10:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762368406;
	bh=UtSumebzPdCvg7/UmC00Sgf88HuW1C0TZty5wZMf8nE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AB5aEUos1Umamrc7bkTzOQUVHnV6y2sz6NiPsl5a1L7/xyBTaB3VrunrJdE5RBnwO
	 FJY8EZ0HBv458yiXKCQhgoiU0UoELy2plHOhXRZrMjn7cne/CIHbLK2vZGgM+mdkbo
	 uE7DnnNxSm4dlZlGQzMeJ6dV0OVHHC7ZZKwzuqwk=
Date: Wed, 05 Nov 2025 10:46:46 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1020034/000000-1812a6@github.com>
Subject: [bluez/bluez] 1812a6: transport: always show A2DP Delay property as
 sink...
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

  Branch: refs/heads/1020034
  Home:   https://github.com/bluez/bluez
  Commit: 1812a687d59058bcf834b85bc1db4738fa23cf07
      https://github.com/bluez/bluez/commit/1812a687d59058bcf834b85bc1db4738fa23cf07
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-05 (Wed, 05 Nov 2025)

  Changed paths:
    M profiles/audio/media.c
    M profiles/audio/media.h
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: always show A2DP Delay property as sink if DelayReporting

The Delay property is currently not shown to sound server unless remote
side has acked delay reporting.  However, when we are A2DP Sink, we
reply to delay report requests with the current value, so the value
logically exists and is active.  This behavior was apparently changed in
commits 05f8bd489fd1 and 5d4efe960fd.

Show Delay value for local A2DP Sink endpoint if it has DelayReporting.

Fixes: https://github.com/bluez/bluez/issues/1541



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
