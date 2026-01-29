Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFA32032D
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769693749; cv=none; b=afUg5Nj/xxXZxPTmaRgG7VlbuKrSqGjmTO2KUchDLZT8aCYukyA1PEDJiDA+vsTA2aEA+XewUngIW5Th7xlegKAIDXxzOuL9NijNiAepbz1GuMomr80N9yFeoMTVHXXx3QRQa7OutUekdUfsgaeA/AbKV4CMWYNttdRL8CoYpyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769693749; c=relaxed/simple;
	bh=OmBqPW56BFadpjqxMUqLZWTANKs1BjiR/ZdTmGGJVOE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MY3peVIxpIOCmxdul3LE9xQ6AwbSxVx0GzlQSQ8qXUlwLsn8PvRff5usTkSMwGZ4T+sIWGJ+fKxCyr7/rZOeWOuWFILmfWlUjxmZHzZiBt4NnDoTINMeNL/cr0iA62TlqgtOtHexQLqO0F1fhLG6aX2F4gpc3YGf0SvKhZfYHt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=L7yHeAOW; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="L7yHeAOW"
Received: from github.com (hubbernetes-node-2fbd351.ac4-iad.github.net [10.52.180.40])
	by smtp.github.com (Postfix) with ESMTPA id CDFBA213EC
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 05:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769693747;
	bh=Lsh4o2YYsbV6Evil6pdve9x02ho4CZ84zag7P5Nf9q8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=L7yHeAOW4r+xEYcJ0qtXJP2mZHk+E97f7Hkeq14MPj791Wn7b0ae9zo+lkGrrSUhL
	 TLjp3PgKCd06IPCzWFLL/l7jXYc3xZYCsTkk/tAQEsNeW0WvO99ddxE8YlFs0bG3OX
	 GLyosMq4SlfFJGIRNj7P5/gtPfbYykMNtPcruC6w=
Date: Thu, 29 Jan 2026 05:35:47 -0800
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1048529/000000-a78f42@github.com>
Subject: [bluez/bluez] a78f42: build: Don't install btmgmt man page as tool
 isn't
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

  Branch: refs/heads/1048529
  Home:   https://github.com/bluez/bluez
  Commit: a78f425dbae965efa2ffc1144b7372815d476f3c
      https://github.com/bluez/bluez/commit/a78f425dbae965efa2ffc1144b7372815d476f3c
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-29 (Thu, 29 Jan 2026)

  Changed paths:
    M Makefile.tools

  Log Message:
  -----------
  build: Don't install btmgmt man page as tool isn't

The btmgmt tool isn't installed through the Makefiles, so the
man page shouldn't be installed either.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
