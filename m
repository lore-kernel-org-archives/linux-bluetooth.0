Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108391EDA1B
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309294; cv=none; b=Lp5C0oTvNusXuAknaQWk9YOSF7mQ+BaGcOnEM+lKCd3EjLOAYagXC5FSYHitlf7lvngA/hh3Z7YsPLdzghZ7AVxzc2q8Qmd4yovUBeG3CCJM5w/ByROgejsYOLl1dtf2WQgBtOQSlxsG+MyjM/JhZLIf0JMFA3ScjQBF3OwkKyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309294; c=relaxed/simple;
	bh=fjGkvwLlqP7jAMeGe/1wLb+au8R/d8eJpg1pa7X6UjQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bUoQwZ9ERGCqGXlhX1pdpL2AoPiM4iI2shCtZKgocOUXP9SjomXGkjImM7tf70kAQHtGCbOU8ZDlMR7FIYrV0m/kPd9hzH8LF9RCUpB3NUPQN3YpnmAnic+IyHpJ4Rf4PRBfWVIXdConylkiNTX1cgekkWG4bIJKmSqe37WzKJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OwFMfCUX; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OwFMfCUX"
Received: from github.com (hubbernetes-node-7c57316.ac4-iad.github.net [10.52.125.35])
	by smtp.github.com (Postfix) with ESMTPA id 11D38640AE2
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 08:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1756309292;
	bh=cxaH6sbcwLJ5YIOz1Qhy1vh8Ke5Kt/OfVzHwZxQCxGA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OwFMfCUXJO9Ia4ymLgCFU/u6rYqnP/v4ubfCSs/VZkch5znISHlVbXc6E/BNaDHXR
	 YTcIa+k9R/38WuJ9L12GmF3I3NIb20dWjuOtwOndfUcdx9ibd/wpMRP99SXDtYZlVe
	 1aWBmYQ86uwng8jn5VQeBpC0HQy27RLqmM7eBYsE=
Date: Wed, 27 Aug 2025 08:41:32 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/996079/6b5b35-000000@github.com>
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

  Branch: refs/heads/996079
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
