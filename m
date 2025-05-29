Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A74233707
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748547769; cv=none; b=Wd5/BVCAsfkdYn23yWW1Nh1/lJlBEupK1hDIYm++QqHwmgWsALfhCTWOKppalPGfsfgut1d6seg8J9ZwoJQdzFKjegRA4MproK4iB7zNbFcM4nbsT4vfMuzONDZElwLDfDG7CayS7LoKIL0CwtS1q6WidhEbfL798eg56n6ZIK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748547769; c=relaxed/simple;
	bh=A3v8+SvBM9KtZBuIuaWr8QiAV9TOvSuJFvWaTmZa0Zc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GjcOY0o7sPqdnyQL6wN1czliZa0DmyyPJe7q0HiKjftRQEOocq/ZsIJhdw9FsYWCHCvjUnj6hdcg6PzqgAJA+FykGR119AvHmD3TceFekvmy0nW7h0lUDKrP3YjmDjtoAopW5KTHMlsFlxVsN00itaMmO+t+CFI+9O45AGByV8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GmfsEuCY; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GmfsEuCY"
Received: from github.com (hubbernetes-node-9e4ee79.ash1-iad.github.net [10.56.187.43])
	by smtp.github.com (Postfix) with ESMTPA id DC1CE600CC7
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 12:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748547765;
	bh=kE1S+A+zd2g1XsqeFgd0DONncLa5XZDEM//7XjMvw34=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GmfsEuCYQ86rOV/ssUV0tWqvMqlebCtNXzsLz6VTPA6bt78b1q/MQ/0xqHmOZ9gbF
	 ElZ4LEp0Mm5OWsUGmP1OvwoltAbyOEWt1On6Ed3B3kVGoKLe0fVY2xKEXqNk8Be/LY
	 IUl2k8+FU6nTmIiohFpotoswBr8jKg1G6z5si3ao=
Date: Thu, 29 May 2025 12:42:45 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/967405/23db68-000000@github.com>
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

  Branch: refs/heads/967405
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
