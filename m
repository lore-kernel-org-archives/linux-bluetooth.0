Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914EE21ADB9
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Sep 2025 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758402040; cv=none; b=iaOcy1qmUo2pjbMFCuVOwqhdQLJObODd+ri7qx29ZxCuJSIt17xls+FfjvgAfkOtqj0VuD/q9JjSD/NHd6zXrMzFESK9iDndLPeNCYZYpkrNeXkFo9g3qmzGFej/Ywaec2tXbf1Qm/qaRz6i80BZyYCuQNIi/IRayobVwdSMP5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758402040; c=relaxed/simple;
	bh=I/eVcH9uttWdJgFnMPUggExEC7T+g4DGjk0AjaTXMqc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OslIIlQWct+WJyZFQazn9el9lZZCjQjYmex8ZgAKKAQWlB3bnsGWZ9547UIFcFR3dcB+somQbzehMFtuIz8ZL/eGddzVUzZ05h1V18U34DF7T7lwLQiQxGsHL+x9QUZzOrAWCHyYsZ+IFNQQyUxQyiWkYkOShSSAVsSJBsdOLLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=F8ZfhhPN; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="F8ZfhhPN"
Received: from github.com (hubbernetes-node-cb94559.va3-iad.github.net [10.48.14.15])
	by smtp.github.com (Postfix) with ESMTPA id 9B57FE0883
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Sep 2025 14:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1758402038;
	bh=p4t/uV7jU8rzqh3/LlaVswrZKz+c59FFAtR+o6Lcbms=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=F8ZfhhPNfrsB0eInY6YFxT2htnDfWLtvji8V78gnMgfaUzsurlJ7aSfI2ltYMVV2s
	 Xjex0KAFevKysIAdUeySoQT6qcPJYBBkVUlvCfhBkWuBcB9yrIYgrZYcCrM7s6755P
	 zd2akB4DkWoN1aw59ay2WNPcFWzRkm1uhhcxFe8o=
Date: Sat, 20 Sep 2025 14:00:38 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/994230/9081c9-000000@github.com>
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

  Branch: refs/heads/994230
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
