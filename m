Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5A32E284B
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754938513; cv=none; b=Rz+yn5DgtMeKjZrPPWPZSzsHEuY7SYHfqiZXeliyA9Qka2zQTjn1+Vkb7qYYkzIk8adFAPAlmqxqxgJr8aCB+/va5bgQKqEMhiVTrGk3N1bzEa+xhnvYcMVpUYiZyr6McmK5v+1rUQ43fCRCpdf+Z0JlkbXzlkl/XvCPthobOY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754938513; c=relaxed/simple;
	bh=maF4k/oH0HQvUIPHAaOmGRS5WUbpl3JvXDSr11YK5Jk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=s1U1QpxVEZWrnbayUavEQy642Ww9VOOIEEKs357ruFvCLELOELkB4lUk/QEpKgqi6qUR13jyItgqv/uVR6MZwqd/Ljmim07aeMgSWTcB/if/vy8lIIuoeoOtUbmssFyeKaKpgDt8yXkDJpDdm6MXVjPrpMl+zAvnluLA2v8PJsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GBQeax0a; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GBQeax0a"
Received: from github.com (hubbernetes-node-1cf423f.ash1-iad.github.net [10.56.169.38])
	by smtp.github.com (Postfix) with ESMTPA id 06ECC921158
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 11:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754938511;
	bh=8RH3Zw5pS+z6GkvAKH+I8gvzRQ0SOfWBdPdNS3zYPWQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GBQeax0aMkSzy3Dwvxq2cM/l+LdzCxVskgOZ1jH2IzrnDfQa6Of9z3fLe+tEYV/qx
	 A8ACDXT/xYLF4jfVadIkMOeOvFXDp5CqMO75d73lLnBfGhYZlMMYY5amNdnfp5jXTv
	 9uKBk8ZmkPVsUSjCDbhDWmVSkloXw7JKYT902NeM=
Date: Mon, 11 Aug 2025 11:55:11 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/990189/000000-020772@github.com>
Subject: [bluez/bluez] 020772: shared/bap: reset local ep state on stream
 detach
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

  Branch: refs/heads/990189
  Home:   https://github.com/bluez/bluez
  Commit: 0207723b5472cff51698cdfbf39e3c559ac5806f
      https://github.com/bluez/bluez/commit/0207723b5472cff51698cdfbf39e3c559ac5806f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-08-11 (Mon, 11 Aug 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: reset local ep state on stream detach

When removing streams in bt_bap_detach(), they are detached directly
without going through normal state transitions.  As BAP Unicast Server,
this leaves local endpoints to the state they were in, so they persist
if client connects again.  This is not wanted.

For server streams, clear the local ASE state on detach.  At that point,
the ASE is either already idle or the session is detached.

Don't modify state of remote endpoints (BAP Client streams), as only
remote server should do that.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
