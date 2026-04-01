Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DC238B158
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040195; cv=none; b=qNLCnXxiifpr3S364EJlp5Ng8agGevphOFknP7Gp53g3mv+QxKpIt+N+ITP2pLSpJjwts8iHY0OxpdJQ6v7yU8qs8csaBWVR0E+HbAsNN8CZJt6acGTLCkJkFo15xuZmJMIza1ED2edXxEAi6HBu/nAbsaFgn1FROMIGLfCTb8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040195; c=relaxed/simple;
	bh=LBzzM/mJfT/xNgjvR1vzHwkgN7rf2Ry5DDbjwOpf4ug=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CWm6vAN8kz4mzwJ6nev89wJ/WcsH0OEyDYrAEHCs0bOoA2FahCQrloiTaw9V7dCgxJzh9cdKnHeWAVIiOxqA97kYX1EZnZKWcHcZjlUGinL6YJc5RMXcHdaZz6927ajndbWqau+DJ5GOCH7bWAyEPEImu2NhN6JJQBdKVgN2QnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hqhSJKP6; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hqhSJKP6"
Received: from github.com (hubbernetes-node-1ec2f1e.va3-iad.github.net [10.48.124.78])
	by smtp.github.com (Postfix) with ESMTPA id 3F9DEE1147
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 03:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775040193;
	bh=2MIQBqsz9348bxFnAjKJB5O9L1EJNT8H7qCt+tClyXU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hqhSJKP61D5eHfkj+1T5K+Afra9ZhwNErAKT2ASJ/17YGKGgkb/vcr1rdkRC5+W7P
	 9ljbQM5U2qLxPjFjMSPzP/NqBxQdaVwQdBD/kZLKbkkiliidNIxP+PjundAV1RcFtr
	 7+5P5lRzMrZ9p4b/E0aSElSuies2BEeXKwp5Pwx4=
Date: Wed, 01 Apr 2026 03:43:13 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1059867/c456c0-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1059867
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
