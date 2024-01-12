Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C17915AD8
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jan 2024 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GqA9qmZe"
Received: from github.com (hubbernetes-node-99988c4.ac4-iad.github.net [10.52.149.31])
	by smtp.github.com (Postfix) with ESMTPA id A9CAE70116E
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jan 2024 10:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1705084661;
	bh=iL9jcl9vzi22kjcERtuUCukj8/VkDm/aBeOzKst43fw=;
	h=Date:From:To:Subject:From;
	b=GqA9qmZeRnBUmot3kABTdKFg7LlRvfm7WpzJdHrXCWt4xYNkPS2Z1kwYsculiCe5s
	 /zPczLBQehIF4adc71RHprotSndlSktsr4I/Tuu3b28QtuDJ61+CiHVDA5SeZbDjky
	 i0zINs7JGdp4gepPE8KVy5OoilOYfxUZpfZA+mUg=
Date: Fri, 12 Jan 2024 10:37:41 -0800
From: xiaoyao <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/ba5a1d-1f9ff8@github.com>
Subject: [bluez/bluez] 1f9ff8: avdtp: Fix potential incorrect transaction
 label
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
  Commit: 1f9ff8fb4048189c762ff83fa20b1cf3ab2973ad
      https://github.com/bluez/bluez/commit/1f9ff8fb4048189c762ff83fa20b1cf3ab2973ad
  Author: Xiao Yao <xiaoyao@rock-chips.com>
  Date:   2024-01-12 (Fri, 12 Jan 2024)

  Changed paths:
    M profiles/audio/avdtp.c

  Log Message:
  -----------
  avdtp: Fix potential incorrect transaction label

Currently, AVDTP commands and responses from remote devices are all
stored in session.in. When one end has an ongoing transaction and
immediately starting another transaction, it may cause the session.
in.transaction to be incorrectly modified, so we need session.in_cmd
and session.in_rsp to be able to handle outstanding requests in each
direction.

After applying this patch, the problem no longer recurs. Apply this
patch to android/avdtp.c and run:

> unit/test-avdtp
Test Summary
------------
/TP/SIG/SMG/BV-06-C-SEID-1                Passed       0.004 seconds
... ...
/TP/SIG/SYN/BV-06-C                       Passed       0.001 seconds
Total: 62, Passed: 62 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 1.76 seconds


