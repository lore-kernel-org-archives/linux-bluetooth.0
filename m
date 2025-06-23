Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533442C178E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750699978; cv=none; b=jkIaAbsyr2E1ZtEiKA4F4efn8f0J+pUg5HPdT+Of/SXnrk8UvbtcHfZ1V2VpujrB2w0NLOCBtPdozAIwvFBQ16GUTwVhFz+8vkLys3/r3VUQyYSaWEzf1BRJpM5CMxn27hCo+vt0UoxAK5NxyqmhXoOgVqXhgSiZYDdH+cygQ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750699978; c=relaxed/simple;
	bh=H5FyI9qAz3x0YWSsUDxxJcRFtplUm1XruvzZQ6hs3cM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Hmlj2rIFRaYDVOYGJiF3XypFa+jghptjdzy6fWWNZNp/1W4SOf95McPkISWQRLY9pBCc9c0KMWo7NxEdnSoQJjejoW19aDY+Rg5+SdZr0bXIVFbALZvcbiuL8YODBL5iEQkFZp0VazWGlk/eQoAyRZ7dOTejC2KRKXDb7U3PROI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hZXEpG8w; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hZXEpG8w"
Received: from github.com (hubbernetes-node-66f490c.va3-iad.github.net [10.48.183.49])
	by smtp.github.com (Postfix) with ESMTPA id 6F6C98C10EC
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 10:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750699976;
	bh=i3s8ooVMxy2hM+D09eZVf+fyr+dnlo4VwbiUS77r19Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hZXEpG8wmeNobK3X0yL3+J1icgqrw+e3llhDAfNvbNuxGpiwJyS1PZpG0l23qgvpn
	 tkPySIklvdMkCkZRBSrCjeWASmFmLz5V/GXLLDotZkevLwz5qfSsCcTKKQbwilSMxP
	 +hDjA57vVfRCmo/bLNEQjKAUIBAmr12luSANYA78=
Date: Mon, 23 Jun 2025 10:32:56 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/01f3ef-ae1b7f@github.com>
Subject: [bluez/bluez] 560147: configure.ac: check for stdarg.h
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
  Commit: 56014755a3e7df37056cf5efff8732e698fd4124
      https://github.com/bluez/bluez/commit/56014755a3e7df37056cf5efff8732e698fd4124
  Author: Til Kaiser <mail@tk154.de>
  Date:   2025-06-23 (Mon, 23 Jun 2025)

  Changed paths:
    M configure.ac

  Log Message:
  -----------
  configure.ac: check for stdarg.h

Currently, there is the following compile error while
building with -std=gnu23, which is now default for GCC 15:

src/shared/shell.c: In function 'rl_cleanup':
src/shared/shell.c:1435:9: error: too many arguments to function 'rl_message'; expected 0, have 2
 1435 |         rl_message("%s", "");
      |         ^~~~~~~~~~ ~~~~
In file included from src/shared/shell.c:29:
/usr/include/readline/readline.h:410:12: note: declared here
  410 | extern int rl_message ();
      |            ^~~~~~~~~~

This adds a check for stdarg.h inside the configure script so that
HAVE_STDARG_H gets defined and the correct prototype is picked
from readline.h.


  Commit: ae1b7f6ba805f82742bbc32ff275e268248ef9f8
      https://github.com/bluez/bluez/commit/ae1b7f6ba805f82742bbc32ff275e268248ef9f8
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-23 (Mon, 23 Jun 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: handle inverted order of stop ready and disabling->qos

DISABLING->QOS transition and Receiver Stop Ready reply may arrive in
any order.  BAP v1.0.2 (Sec. 5.6.5.1): CIS may be terminated by either
side after Receiver Stop Ready has successfully completed.  However,
when we get the reply, the stream may be in either state.

Instead of client detaching the IO on stop ready reply, rely on
detaching IO on entering QOS, where Receiver Stop Ready has then
necessarily completed. On DISABLING, mark stream io as not connecting,
so that it gets detached even if CIS was not yet established.

Seen to occur with Samsung Galaxy Buds2 Pro, when it refuses Enable for
32/32kHz duplex on one of the earbuds.


Compare: https://github.com/bluez/bluez/compare/01f3ef3cd9d6...ae1b7f6ba805

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
