Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68202E65D
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 03:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773891498; cv=none; b=sJWbUR1xtWwHj+33MlqV9InclczTI3WeSLlRF23FkN0pGDIMalYaQsf7msWeH5A4Wmi4ZRm0D74V9pbOUhw4fDecXqk9I0VnlRow/VADSB252KAgZJVKdwk4/MUb39S5A2CHcc/jf+tijY+/zLQKxzZ8XkrAwr/R3DuiBQ7+35U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773891498; c=relaxed/simple;
	bh=eS6aDVKpNScIg7LxEWLFFAs/igMMAdTQfgN41mWJTsw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NX1lpPpnFT9CS3p9zBv7H4pnwhwf18Lqmm0e+TVNmqyUQ5JkftrzL+nLCLjNDkCuwZG59E/74zaxmTnANZYoHJomdp+8eEffZ182UAq5mYkHBnhL4OX5lOTP1GXgq5Cj2i3yNRzs+W6TNLAkoweRgzKj54wLcvrw6mzj4x2NN9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DLtPa8Yd; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DLtPa8Yd"
Received: from github.com (hubbernetes-node-4144358.va3-iad.github.net [10.48.15.71])
	by smtp.github.com (Postfix) with ESMTPA id 0FFB04E037C
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 20:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773891496;
	bh=kIwfEIDq5EIlEWnoTgKEhRDdYiRdKumfmTm1cAWMiII=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DLtPa8Ydwcabx60lEZIxBKwDGtIWUpVZwfrDPFswba0aWjq77FNCywF+TYYGjJLQP
	 LHVHGMmf2D0y8MmwR6MwQ596tc7BUWx3rZxw/NGCxaprVYVD0FmOTKr+o1uskuShJg
	 p7Wj60+Pii/aOCcuSbxX8/o0t/9vtefJNmT5YiSs=
Date: Wed, 18 Mar 2026 20:38:16 -0700
From: Wouter <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1068955/000000-bb6234@github.com>
Subject: [bluez/bluez] bb6234: shared/shell: Fix SIGSEGV on invalid input
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

  Branch: refs/heads/1068955
  Home:   https://github.com/bluez/bluez
  Commit: bb6234006c0af44bbb2f575d7f87a3b995795784
      https://github.com/bluez/bluez/commit/bb6234006c0af44bbb2f575d7f87a3b995795784
  Author: Wouter <wouter@xesxen.nl>
  Date:   2026-03-19 (Thu, 19 Mar 2026)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Fix SIGSEGV on invalid input

This fixes a crash when handling "<space><tab>"



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
