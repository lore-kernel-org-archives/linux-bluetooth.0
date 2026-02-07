Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA705FDA7
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Feb 2026 11:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770465163; cv=none; b=aC+hAOnItI5z+2nPCjQgrbuPr9CHBIWa0zfo0/UzPPVRHxsSpwg6sox9s+Qwp/dWaBrOk5+9taOG0ZctkWPcC8xqwJF9hBXxMZLOUpSdFtc3wlusTlDv1eI+Xm74/hJIrgYpFkRpBj3zUPNSJXi9/GQVUbF1ylX3JYEfD1M5Vsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770465163; c=relaxed/simple;
	bh=Tq9MKmBPiHL9pCOv0/LfMufcw8nldcP3TMpROWm5aXQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VQhP6n0uL77+REZ98/8ZxeM0t83HHF3m6/MkRouKp5wSAdA2LO4/Mfe7r7GOg832468Dt7y/uXxQSlDjh1jx2/hq7Wyucf3ioAlJSooof0Q8ilB5f99K3n3WMjHeGf8SZ1uOr8dIaEg5uHqEbKCGbKyK/jEiJt0bKJW9sKWk9k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=muDoO5hR; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="muDoO5hR"
Received: from github.com (hubbernetes-node-730cb87.va3-iad.github.net [10.48.178.32])
	by smtp.github.com (Postfix) with ESMTPA id 3E2FF4E01B0
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Feb 2026 03:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1770465162;
	bh=0IgjNvp4JvhCtOwmxxgc3tpsrCj9f2mFF7u9fj0X9EM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=muDoO5hRrUDbIuzcrAj7TygCigtF/nxhBc/T2X6yVi6BnEwQk6fhjRPPwCmMXg4DO
	 LSxCuAI2zEz6u6fRqOjNahSXZ6whuDM8Cr3SfmDK9HCeP4D5uON8/jMPpG/p9nAPyn
	 DH8FzTRrkTuHxoKQbKzxx97SQPPNo4LWYE8lyVH4=
Date: Sat, 07 Feb 2026 03:52:42 -0800
From: Rudi Heitbaum <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1051861/000000-5b1c5b@github.com>
Subject: [bluez/bluez] 5b1c5b: src: retain const qualifier from pointer
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

  Branch: refs/heads/1051861
  Home:   https://github.com/bluez/bluez
  Commit: 5b1c5ba90054d0b5884b15df401e56b551bacaf3
      https://github.com/bluez/bluez/commit/5b1c5ba90054d0b5884b15df401e56b551bacaf3
  Author: Rudi Heitbaum <rudi@heitbaum.com>
  Date:   2026-02-07 (Sat, 07 Feb 2026)

  Changed paths:
    M src/shared/shell.c
    M src/textfile.c
    M tools/hciattach_ath3k.c

  Log Message:
  -----------
  src: retain const qualifier from pointer

Since glibc-2.43:

For ISO C23, the functions bsearch, memchr, strchr, strpbrk, strrchr,
strstr, wcschr, wcspbrk, wcsrchr, wcsstr and wmemchr that return
pointers into their input arrays now have definitions as macros that
return a pointer to a const-qualified type when the in put argument
is a pointer to a const-qualified type.

https://lists.gnu.org/archive/html/info-gnu/2026-01/msg00005.html

fixes:
- warning: assignment discards 'const' qualifier from pointer target
    type [-Wdiscarded-qualifiers]



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
