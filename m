Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C383157A5A
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 03:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765422938; cv=none; b=Fso028nJIKpa/VzmgTRo39Wr2CfxteTisVwzsQoifxW5qReg6RBGtSobmvu/BULi47j5Sc0mMYer4vAe3GQx7P4A3fh+4HeekcqPw5IhcR29qSklWjYFCYDNqbKJHeuzW7WI5mDC/Tnk38+sEKr+lNzsRAV6rsEW9p1jPspTERo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765422938; c=relaxed/simple;
	bh=A6OeU8fShBNx+UkoSfXoRhCmhAjRCH/9nxtKRjnexRU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BMhS8M0UCk3Nvo+T8EL9gtJg8oqsMCF/lOOCrAJqzsDuuCQlyOWwrR9ZrB2Zy9M9vXr+TjT7lRIK5cTZWI+s2aPw4DGzs0FBsyoS8rnWatLyYab9wp0nSYg3BGY7q1eutNhHWRWKb+cYlgt5cr+49tKzglO68JO5Ksj3K+QPXTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eK6C9/HG; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eK6C9/HG"
Received: from github.com (hubbernetes-node-a66a568.ac4-iad.github.net [10.52.207.54])
	by smtp.github.com (Postfix) with ESMTPA id 25FCF20416
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 19:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765422936;
	bh=7MCh+9tV/mYjgVXrwJays0MYLSmubdFgPxJ501EQ3n0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eK6C9/HG7ItRojyFNZAIedWo2bmZa3VjsCHWUkZSLCXppaBPTbbD05L4nj+864hx9
	 BQIvOUttmhse/M9eKBGJni6lWU5pXBBByNmhF9dkw6kVdcJaj3ZITtq2FC1LqGhl7S
	 E88Vvqt2zSJW4Id9tZmvtc4Frf1ffuPxgcOp2eZ0=
Date: Wed, 10 Dec 2025 19:15:36 -0800
From: michael kong <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032159/000000-1dcc63@github.com>
Subject: [bluez/bluez] 1dcc63: shared/lc3: Fix frame len in set 44_1 The frame
 le...
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

  Branch: refs/heads/1032159
  Home:   https://github.com/bluez/bluez
  Commit: 1dcc631fc79089ed0047688a5a63974ec5eba86e
      https://github.com/bluez/bluez/commit/1dcc631fc79089ed0047688a5a63974ec5eba86e
  Author: michael_kong <kx960506@163.com>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

  Changed paths:
    M src/shared/lc3.h

  Log Message:
  -----------
  shared/lc3: Fix frame len in set 44_1 The frame len in set 44_1 shoule be 97.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
