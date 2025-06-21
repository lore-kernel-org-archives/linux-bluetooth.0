Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA9D26AD9
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Jun 2025 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750503469; cv=none; b=YzIrLA1SDSbQzeWX23FhSrbg0y7a/ijc4LNLVvyHWH8wplM7ea0N0+5Qr2z2B9Hd8a9vyeHJf/P8/XNxIgO0Sm13nHbVeMxFeeP7g6k02ait5CukJxS2nJdHISVbMOE6EVl5cDZ+EzLUnCR6ctTp9A0lBWVOrPARULeqVwVnOCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750503469; c=relaxed/simple;
	bh=pu5GOR7exriv3LOyAenJr9aV6Pc2gyaYAl30Wnk8rFQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JJGmaDJtlzqV0mNqi1zFr45gP+prUEuXzTZuq0iMi8SMamfGn69Ztra7Vjzm6UD80yMMqSTPES1Bo5vhQwZBBN5iqigXvTPghjMwwQMVW7naBfmC5MBwkfF7RNMEQ6qFHBtqbJtZ7aHiyQG1TPQGIFQ6cn+La9iQBmxSmqBlAt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=li6jA5+q; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="li6jA5+q"
Received: from github.com (hubbernetes-node-1c07a78.ac4-iad.github.net [10.52.173.40])
	by smtp.github.com (Postfix) with ESMTPA id D59F5640186
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Jun 2025 03:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750503466;
	bh=miAHSqLVXqoQPLRHtVMpboIb1i83ZehPu0wkRitKasA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=li6jA5+q9HTTS7/ZIHW4tzVzd+jXa8QefemhosIcKEni4Fkl7SxyrFrgVwX7dfmr7
	 Jd0i/7FUf5SBR1xytFJUrUW87CsRNUO13J8O/xvJTNbDno97kbwd7s+W562VNmrfnL
	 4N2ov/qZ5sQ0pvkeUGskcPpsHTDxXbkx9x7vk/Jk=
Date: Sat, 21 Jun 2025 03:57:46 -0700
From: Til Kaiser <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/974481/000000-fccc3d@github.com>
Subject: [bluez/bluez] fccc3d: configure.ac: check for stdarg.h
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

  Branch: refs/heads/974481
  Home:   https://github.com/bluez/bluez
  Commit: fccc3d434d4c98c2784523cffdb4d5a11ce3a565
      https://github.com/bluez/bluez/commit/fccc3d434d4c98c2784523cffdb4d5a11ce3a565
  Author: Til Kaiser <mail@tk154.de>
  Date:   2025-06-21 (Sat, 21 Jun 2025)

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

Signed-off-by: Til Kaiser <mail@tk154.de>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
