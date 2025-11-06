Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5E22BDC3E
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 17:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451507; cv=none; b=sd9q7NbujQl9ZOE8a8GA0XewgI4gwdxjN2jerIwoMpwbclxwmewM7Bl2GWV+4leefYzPmd7YOCi1HmsXKvgAuPGjAJJfhnLv1xLz3QlOyxPz7uv1UB+8N9oR7sBoh5vHwk2Ky6SkNgvwCcyWhcnM8sotaZ9Bfm9EAYfqKzQOR24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451507; c=relaxed/simple;
	bh=Np70fRGAm0etZfZzFb+ahn6keBw4Ae0WUXleg086U74=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bfKEXQlPecPfHvE1nbf+sCojlfsx5kcRIsg8XhI4hq38TShJhUaC8tCj4SiZfKOpSzQUAlpzdkRWCk3Hm5lm+N+PhMlSK7xO3C/wCMPJlOX5GnPZkeONNPuzVRkuJWFAsfn+bla35JkUgxCQ7Ygjc72m0qdMifOPZbGDuHn8LkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=V7piTJmE; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="V7piTJmE"
Received: from github.com (hubbernetes-node-a8b9263.ash1-iad.github.net [10.56.203.107])
	by smtp.github.com (Postfix) with ESMTPA id EBB1C1412EB
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 09:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762451505;
	bh=oP3k+gNELifs7Gcpxd/vSyUx/L0PGIxtB0rNDXMDras=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=V7piTJmECkO7dfp1LDii7XqrmIU4yHaoQrKKJTZ+K9NNOdvwH1LUkC8BAHScD6aT/
	 FNQn972Cg2Lfn0ya0VfTzYpfooqdS0g+COrY/T/6c+RoF4X5ByKe3zZHXqBVrwrg4t
	 EAyjoavTLrzNDiyuEwdGJLMGfCcN2e8lpm/SF8+U=
Date: Thu, 06 Nov 2025 09:51:44 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1020579/000000-873523@github.com>
Subject: [bluez/bluez] 873523: github/issue_template: Add basic issue template
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

  Branch: refs/heads/1020579
  Home:   https://github.com/bluez/bluez
  Commit: 8735234805d2297c7e19559c5b1d23b7f8540b9c
      https://github.com/bluez/bluez/commit/8735234805d2297c7e19559c5b1d23b7f8540b9c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-06 (Thu, 06 Nov 2025)

  Changed paths:
    A .github/ISSUE_TEMPLATE/issue.md

  Log Message:
  -----------
  github/issue_template: Add basic issue template

Add issue template that instructs to use btmon and indicate software
versions.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
