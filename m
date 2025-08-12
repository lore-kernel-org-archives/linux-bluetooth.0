Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510A81F3BAB
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755011627; cv=none; b=pwzm3opzABRcQ6OwP3Ino0aeIfGZ3cxbNgKXkzyMHTtThu1xTMdmgwR7r7l5q88Sc8pbvmoyn/XKOlxkco2VWxlPbXbMcoE8OnhofsFQ6/u/T7ydLV8YsQSkEdet/nOu93HsNxQPJK6zbiKmet817BdQkLRwCSU2rVC1CZmf7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755011627; c=relaxed/simple;
	bh=1xNGxJQf8GsKcQnE1XqE3KyrHzfpcdYOgYy8fiFosVQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LMxrW0zEe/bTD3ECNUTBXMNUTqGmtfJwcWUw1+Fp5PVmitEmshuSlnB5RABSfGzNSnNFkoYer6r5utDM273F7+7hdRwK7ZXwPVxphWYNyxofcKXuyCuA1TqgpiXSdGpDvaQfWZjfCyGSo3q3l1pP+mZ/KeTmKvEAAjozWdaaNQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ABR3ODwv; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ABR3ODwv"
Received: from github.com (hubbernetes-node-4211de3.va3-iad.github.net [10.48.143.10])
	by smtp.github.com (Postfix) with ESMTPA id 6F75B8C0819
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 08:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755011625;
	bh=udzabz2kNSrrJEl9Vn3ukO8i0UFLwjTQshCkVTK8LOg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ABR3ODwvFy/x3Yx1xEPx77cyT5y7mAkB2Si50UnodowoQWv/Xhkk8ajjBTiJTtTU2
	 bD+CJbrodBoGh9Zm7iHtIhKSYzcEm4a7wwehJt/tRbqQHpHAjY5czYBC4X6cW0K8uh
	 uLYFQZ/Mdsm7WLvGBWXrsmy8u/EvUuOthuXHrBEc=
Date: Tue, 12 Aug 2025 08:13:45 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/990407/d1fe80-000000@github.com>
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

  Branch: refs/heads/990407
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
