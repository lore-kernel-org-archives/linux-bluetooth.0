Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35715BA34
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787392841; cv=none; b=GRRwgLVSJe7PoC2Nog68x8YmKDMvZEWC+WyyrqnTNJMDUy+F+te2E/RbR21YNFebd1YidQO5nFE6jkiahuhdFBpTomBJGYjZxINxvs24GabsMCmE+jESTqWf/DOa847MHjxJB9eDpCQ5fpTZeqwHu0MhhIxdzKC6z0v2IJebOVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787392841; c=relaxed/simple;
	bh=wDr6uwgStmp0DH2xPhLS2PCegbuj4Ypy+hQbpas5yyY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oKpolyp4NAm84KQdeyBZbgqLLy8hiExaAH+s8uhBRuDNDzOl1fb3zc+GlgGMQc98FlbeSOm5TkLOL4eaeU8jMTYvFwy4x73QudpbbdalR/R7JBSR2A8e8bRPTsY4FS/ZbXKfeWnzo9eSXjpwM55iggT/ZemJnYIZ6Ndid6znnc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KYN34212; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KYN34212"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787392839;
	bh=y8kz94jPrFyvwdLVgMVYl0qTUadDI7FL2ep1ZZEnkvU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KYN34212L/ton0axGVPnn2KJ2KcNwJmtTvbb6SKvTt5OT6xrG3XZH8TKi13Ly5kLm
	 M5BC7zTiGrAOPB0OMerEJk1R16CtaLE0xV+DoZjW/YBRG4Ea650c1fDL4vjWxgXM3g
	 op/mZlqt6UaU4blxDt0mh0YtBdoq04W8aQErCgzQ=
Received: from github.com (hubbernetes-node-13a1287.ash1-iad.github.net [10.56.130.18])
	by smtp.github.com (Postfix) with ESMTPA id 2F40D520CCF
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 03:00:39 -0700 (PDT)
Date: Sat, 22 Aug 2026 03:00:39 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1133205/1300a0-000000@github.com>
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

  Branch: refs/heads/1133205
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
