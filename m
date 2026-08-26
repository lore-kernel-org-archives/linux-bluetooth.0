Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C24429CE7
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787751664; cv=none; b=iXR0dIRPNLtHj0yGgIV7fSnmyTihZmSyP2I/WzqBYu/lxkj0zGzObvISo3ACrBuW+cp4QjjW16QuMPVCv69TaR2JBKF5ynYmTZXeaNHzMOACNnyS5qsz+plZ6wpgcxD7XBXwX9R4qvowpg6iXyE/WIS7M+W2Eim7aoeYd89lHsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787751664; c=relaxed/simple;
	bh=4Y4lZg3++UyzRcctNGzaqjK+UPKO8gWQ48Afdpt2iMc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=D6RhmoUxUKGiUCaH3e3XXcHB8HFxf4uPUQ+4P8d/Xy3zsZNsGnmdas30vd0C9PyJ0q7eFa59PXloFTxap0F+O14Rey/WkGzLUFlcDUsQmK8JJfm80E7Xd6dVnqioL2jPCInaEy8jmaBRqIf4CKgDaBZvli1HxB9V8pRRdsjvJAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=htYZjNZm; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="htYZjNZm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787751662;
	bh=y4ogHc9YY9vh0sCIvGZLfKeoB22XAC7HOiv6xF3IQEk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=htYZjNZmoQ0/LOMZWadJIUJd8eSxcaGEIEp7l/+XpJSKPHcHBcR3+MFjVQQ6uemH2
	 2I8DlFtIKpEYQLULl1VSHZAtahswsx062H+ORUmN3VK4MCC4o/7Fbm3IOg35PzYng4
	 pRC4ASJvTkjTnTEmA2Mm0hYinZ3O4KGl8kusWVn4=
Received: from github.com (hubbernetes-node-9b9aefd.ash1-iad.github.net [10.56.79.34])
	by smtp.github.com (Postfix) with ESMTPA id 16D4136055B
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 06:41:02 -0700 (PDT)
Date: Wed, 26 Aug 2026 06:41:02 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1152091/000000-c03654@github.com>
Subject: [bluez/bluez] 962b82: SECURITY: Add top-level security doc
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

  Branch: refs/heads/1152091
  Home:   https://github.com/bluez/bluez
  Commit: 962b822924d38541933664c740938f72aba02f86
      https://github.com/bluez/bluez/commit/962b822924d38541933664c740938f72aba02f86
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-26 (Wed, 26 Aug 2026)

  Changed paths:
    A SECURITY.md

  Log Message:
  -----------
  SECURITY: Add top-level security doc

This will replace the existing documentation written 5 years ago to take
into account the new tools and the new rules around dealing with
security issues.

The new workflow replaces email-based reporting with the GitHub security
advisory tools, explains the CVE ID assignment process, and places strict
limits on the amount of work that can be demanded from BlueZ developers.

It is customary in 2026 to have a top-level SECURITY.md file which
explains the vulnerability workflow.


  Commit: c036545fa7a17b3a3759d2c34b9ec168959b80db
      https://github.com/bluez/bluez/commit/c036545fa7a17b3a3759d2c34b9ec168959b80db
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-26 (Wed, 26 Aug 2026)

  Changed paths:
    R doc/security-bugs.rst

  Log Message:
  -----------
  doc: Remove obsolete security-bugs.rst


Compare: https://github.com/bluez/bluez/compare/962b822924d3%5E...c036545fa7a1

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
