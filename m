Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B2E35E4CB
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Sep 2025 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080712; cv=none; b=iwVUwYsF3c2xpnwtr2OrXGWqI6AUeSx6E/tacyf4zAHo86FkNGg/u62XlV/wJzjxzxqA1BRS1O2Jkrpy9v7VBDq7YFx/PsP34vuqLDdUpsz+95y5WZzSKsnkUdkML5mo6qUJ6gaxWN6w5Skqz2dHpEBP206uZHFkY4jb8VORm0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080712; c=relaxed/simple;
	bh=Csh1ANyLzqFTTM5ia1oXr3iC3JM/UJNzXCI3A71V4uE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qYo+Do0Gu3JO/Zn/bYHD1HOJlqJhRm9md1aB6Y6spIZkpnlxpvupftxKsNWXy6gHiUUT5DCZt0Lr6hFvBkS53sJ/bHlgIHCnGQRhzffHsgqmX36AGFL21ldpgXM44Ki4a16ksRZcgPnnCt+W6lv/6zMZGLnXq3AzQQRYlTLV6YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EmEEutcB; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EmEEutcB"
Received: from github.com (hubbernetes-node-af0b63c.va3-iad.github.net [10.48.168.35])
	by smtp.github.com (Postfix) with ESMTPA id B73FA4E0853
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Sep 2025 06:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757080709;
	bh=eqh1gFxODD2xqAVpLW/hDmuxh/I+8hM51JPx4OKNjmw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EmEEutcBhtxYPOX2YIGBy7zAV5LrYUhD9I26v2aB8wNLsilnp2ReDT1lbdyg0XPH3
	 kPbS4LyHO5kctW5RA2/nfM6cIMQtBwE/TQRYm07/fqUQXF3o/FkpNSnq4Onj/hV1tC
	 yZuBArnAZjMlUuQJiiiRPE8PqwqAWscV4NQ7AB18=
Date: Fri, 05 Sep 2025 06:58:29 -0700
From: RSmirnov512 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/999352/000000-288d4d@github.com>
Subject: [bluez/bluez] 288d4d: client/assistant: Use strnlen() instead of
 strlen()
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

  Branch: refs/heads/999352
  Home:   https://github.com/bluez/bluez
  Commit: 288d4d7297f881a48334ab3a12a4b04067d04027
      https://github.com/bluez/bluez/commit/288d4d7297f881a48334ab3a12a4b04067d04027
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2025-09-05 (Fri, 05 Sep 2025)

  Changed paths:
    M client/assistant.c

  Log Message:
  -----------
  client/assistant: Use strnlen() instead of strlen()

Using strlen() can lead to undefined behavior.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
