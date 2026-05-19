Received: from out-36.smtp.github.com (out-36.smtp.github.com [192.30.252.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CED334C27
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191281; cv=none; b=mDtK+VyugSd4Mo1fypci/72Z4iTrgxHKyT/Koy1KgGkJIR73DWrMcL4cQucr0RBqCcC2rHyKq/f6Cv4auielkctTQAuCdq8j97EAUeiXl1Z62wtPYAQUV3taw6XWwfKt6EeEE/rLATc4INAksJzoJ9YMtPdLUk5EVF8X+SP44Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191281; c=relaxed/simple;
	bh=UZefDfXw7S3y5OqiQlr8xMnXYj3naojVZ/MwMfHAacE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=M6sbVJaJ5t06JDCbUuILsqJXecV8WzTRcJdgnTF/AXc3aMhu2NBTe3VhZRZ4e8fSzv6x5g9Z9W7Su2GvEe5Mff5darSkU7Rv583+YL3RVqLSRuImjW7GlawFvdzOwE4By/ZWbyN/woetEQPFcuClysfWvn3kDG+9qHKDV0bXfn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hjxsxefe; arc=none smtp.client-ip=192.30.252.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hjxsxefe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779191279;
	bh=cMIAvmAgQS0Q0g5u1Dq9UHilzD4YsuhkbWdFISxlYpc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hjxsxefedK19Oy5WRj4zpj0Yxqh706pkX58Q2Z0knbrkfWrI9jocKTNvpxJCR6NyG
	 xTmkpDI+1bXu7ivnALWqrnriYQirD4iznvmAyZr4Ig98JYlxvfNigNNvruIdElRS5A
	 z6H0tJeW1mRYTvZluviOZfJ2VJasMotXM9hs08us=
Received: from github.com (hubbernetes-node-d447cbb.ac4-iad.github.net [10.52.223.73])
	by smtp.github.com (Postfix) with ESMTPA id 4BBA3740615
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 04:47:59 -0700 (PDT)
Date: Tue, 19 May 2026 04:47:59 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1097183/000000-05e977@github.com>
Subject: [bluez/bluez] acfd19: client/btpclient: Fix GAP unpair command
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1097183
  Home:   https://github.com/bluez/bluez
  Commit: acfd19a5de7a38247784c005d61c45b0f4c3c9bf
      https://github.com/bluez/bluez/commit/acfd19a5de7a38247784c005d61c4=
5b0f4c3c9bf
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-05-19 (Tue, 19 May 2026)

  Changed paths:
    M client/btpclient/gap.c

  Log Message:
  -----------
  client/btpclient: Fix GAP unpair command

Fix unpair_reply() because the device is no more available on
RemoveDevice reply.


  Commit: 05e97748b101c0c9d656c0d01f67b8877f2dab67
      https://github.com/bluez/bluez/commit/05e97748b101c0c9d656c0d01f67b=
8877f2dab67
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-05-19 (Tue, 19 May 2026)

  Changed paths:
    M client/btpclient/gap.c

  Log Message:
  -----------
  client/btpclient: Don't remove all devices on GAP Reset command

Currently running auto-pts remove all paired devices, instead of just
removing the PTS devices.
This removes this behavior, expecting auto-pts to explicitly remove the
PTS devices using Unpair command.


Compare: https://github.com/bluez/bluez/compare/acfd19a5de7a%5E...05e9774=
8b101

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
