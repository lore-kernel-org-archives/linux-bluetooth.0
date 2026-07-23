Received: from out-7.smtp.github.com (out-7.smtp.github.com [192.30.252.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CF2417BFA
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798075; cv=none; b=n9o1p2p9A5oK9ftg85WJlF9XZJCJo7fx7Zr4axuvuL0XiHxc6Bl3msWWqF2t0AJGw+UN1RAtLtbuVdP7IKoPeuoJnPidIUejFgBGV8+DsG0PbvY4ZDhKTv3ryRPjwvXFhqdAXllZmnR9xARG0kG8jihRHwV4erDQyT+ePG6/eDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798075; c=relaxed/simple;
	bh=da5trWq2WGGtVaQYSnmpYbg5JYe14/3MMOCNVDUxx2E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Nk7StrV1QAcw03FCRGY+ttHcqPdCqALHAI56ruVGkwQqklqcxFToZTIJWD+DY1QIjbGuacTZfZaJyHzBIXgpKC5XO3EBZQ8EcuF9PoOtu5p+xZwA+h7gyGOJfADDjlRvEl0YUIGM9k6bmumfxblRkhdxJfhlq6Xeo/tU8iYfzyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fG4XDqxz; arc=none smtp.client-ip=192.30.252.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fG4XDqxz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784798073;
	bh=VB8+iu2z7x3AD/mrNpU6lE/AlujwvKJrqZaNpDrz0Os=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fG4XDqxzhxGl0lVZ0t4USGcmmQGUA16l1dPB9NKQHW3FXhL2qX+twTg2iY+s6GFD6
	 e9xK9YHRQAm8+SnXBQABsPiqxoSAvDYo/bohvxkq0AF1L9aiGkcdbq3qEH5qttc9zl
	 shDHv3ZgAMjP7dPsySoUfToRuXPNZcehs4URJk34=
Received: from github.com (hubbernetes-node-77beaa6.va3-iad.github.net [10.48.70.70])
	by smtp.github.com (Postfix) with ESMTPA id 72B32781029
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 02:14:33 -0700 (PDT)
Date: Thu, 23 Jul 2026 02:14:33 -0700
From: hudsonzuo <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1133054/000000-e4a8a2@github.com>
Subject: [bluez/bluez] e4a8a2: gatt-server: Fix integer overflow
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

  Branch: refs/heads/1133054
  Home:   https://github.com/bluez/bluez
  Commit: e4a8a22f7a2886300bf881a292d793143fecd109
      https://github.com/bluez/bluez/commit/e4a8a22f7a2886300bf881a292d793143fecd109
  Author: zuohsh <zuohongsheng@kylinos.cn>
  Date:   2026-07-23 (Thu, 23 Jul 2026)

  Changed paths:
    M src/shared/gatt-server.c

  Log Message:
  -----------
  gatt-server: Fix integer overflow

By using size_t for realloc len and rejecting allocations exceeding
UINT16_MAX , to prevent truncation into the uint16_t field.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
