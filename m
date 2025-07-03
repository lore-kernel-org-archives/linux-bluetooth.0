Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8BE1369B4
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751564824; cv=none; b=KRkyYHzHIDpfEPG/JDOf3nxXippw/0RUAdMM/rtot8DiAY7AbYpWxw30p3nR1c72HEFrVasbLPo43moa1UVO6ywQp78JdjeQkTGjrIUfIj2z3QxI4JjFh6Z93K2u4NppqEz/ABXWLkCHmHAle1IDyC+oOEJyE8Ru1mozKXqJ4UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751564824; c=relaxed/simple;
	bh=SD6MVRYowtHp25+t09H2ZZ7PHuO+A1xosZ50uCRlTH8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=sI/zlb485GOypTeU1PVk9kt9+kCUaniu8voe6aBBD6Z9zN5GNQhHkcXa+JqcTE9wbq6lXBWTqKlHVh1HFEY0pKvhIitXomDHfFetaanxMWYHTBFX79ePMEQpoIyn0jWzhBLA3szcYGmDk/9x/E5pTuqGERAHo1swEykIq3zud+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=arSv0B9u; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="arSv0B9u"
Received: from github.com (hubbernetes-node-8e8e964.va3-iad.github.net [10.48.178.31])
	by smtp.github.com (Postfix) with ESMTPA id 0C1BEE10C5
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 10:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751564822;
	bh=80JDTRt3TJN3CMFAhKMGWCkL08lnf2xqY1WaOlsLcOs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=arSv0B9uzUsc3Ot3hnLonmGXwJ51v8MmsSnhVCYtXzi9K1+BwwxsUR4fUwlrJl0LG
	 6I1UA//6fCUfEIJFnawv2NOWms0Y4ecnNrdxvCMqQz3tzP9dzqdrEe3XUhmNG4/BO7
	 8tzy6L5ubcKPZX2kkC+Pu/Y/EfKerPNLTaVYd64A=
Date: Thu, 03 Jul 2025 10:47:02 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/978742/000000-1f2db9@github.com>
Subject: [bluez/bluez] 1f2db9: shared/shell: Fix not calling pre_run for main
 menu
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

  Branch: refs/heads/978742
  Home:   https://github.com/bluez/bluez
  Commit: 1f2db9414cc9c8835c91b0311bc719ede5c963de
      https://github.com/bluez/bluez/commit/1f2db9414cc9c8835c91b0311bc719ede5c963de
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-03 (Thu, 03 Jul 2025)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Fix not calling pre_run for main menu

When calling bt_shell_run the main menu pre_run was not being called
which cause tools with just one menu to not work as intended.

Fixes: https://github.com/bluez/bluez/issues/1319



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
