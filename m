Received: from out-6.smtp.github.com (out-6.smtp.github.com [192.30.252.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536F83F4841
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786961011; cv=none; b=bsn9xNUG657BQPTmfF1kNO3ilm1NiVl0Oq6eSq80zIPypBXYOLpklKfLyufVyFiYf2oMHRvywicOULN8X6E4iR0yzjl3hvct6LYOLogbm9FJlNvaRv2xQfPi/YIZc0+tPKFdiAVr8UP7vuWWo0andPeq3nW0tFE4OsLB/GFHbH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786961011; c=relaxed/simple;
	bh=9KGNbsvkPv1oAMOYa5r6T1dE0d076T3V/sGN5gwvVb8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cmO5i+DIWS3N2PIeKWajOSotQV6WZUwfXWsIoWLD/IqY6rAqwHW30yHn4wC94qjIj9Qvv7m/YMABNssxvOFAxmNtkGS83qo6HaMMWa0ixu4kXyqn8EG7bKHMzjNcjHU/sCAJDo/gT633SqIy4dHSQE5yuopRExYXiw0V4zGMFu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DojuN3os; arc=none smtp.client-ip=192.30.252.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DojuN3os"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786961006;
	bh=uIuBqyE/g0SpwrNWN/vLqgeL5dC7oOF9KX85GcmZwUU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DojuN3osldK6CPJgyRSA5wCJbVQ6SmWsDhgPRPRsr2b5s6WTWNSWOAXArR+DSy0kE
	 bYMiMwiyXO0nie37qYYrKGP26RyVGipocofwDx0Qn9iW0CT9/hb3L6Vs4UQo23yDFz
	 JKTc2lavXuwLKgsddfNiFZ9bBmNYvNaf2htrhDak=
Received: from github.com (hubbernetes-node-f506961.va3-iad.github.net [10.48.71.99])
	by smtp.github.com (Postfix) with ESMTPA id EAC487811A3
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 03:03:25 -0700 (PDT)
Date: Mon, 17 Aug 2026 03:03:25 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1147094/000000-bff6d7@github.com>
Subject: [bluez/bluez] bff6d7: avrcp: Fix media/folder name not being set
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

  Branch: refs/heads/1147094
  Home:   https://github.com/bluez/bluez
  Commit: bff6d764989be510665d5f16055e70de13dccdf2
      https://github.com/bluez/bluez/commit/bff6d764989be510665d5f16055e70de13dccdf2
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-17 (Mon, 17 Aug 2026)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  avrcp: Fix media/folder name not being set

*namelen was used before being set.

Fixes: bd8989620ed6 ("avrcp: Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing")



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
