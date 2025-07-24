Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066B8223DFA
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 07:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753340645; cv=none; b=ZRTfWBdA4ixa9hyNtXqS598yKfQzEnOG+sJvqN8CdcRwKQvH4Zf+1cauoz8/8ZVWPsL5/GAHY1L/2ilhkDvqIy1OjUFd3TC8iHnQmEyB4CCqBO2MHSBVJqYsoCjpzr792v00meYsRliSq7LUgB8USimAxoVpQeBy8R0jXTmah1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753340645; c=relaxed/simple;
	bh=CFIJRABmddzXaInKUOy3xmxXQN6k4tjBZn4ZW+L4Dis=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LsX+6qmyFN6pkxBRF8gpEgqll0Wy6IJKK+xKEQ7hFYVWTxwkm549+eHvdb9AxaBWfemEuWH2KlP9JzbRHSNCnyv3LbK3s/P+/PXxMmhB21OUSHv8oiA9ssYUCgtwF7VSiFMJIAAlWfkN1vBWmO55i7p5Nk4IcWZc/cS+uX3xj5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=h/QgrSM4; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="h/QgrSM4"
Received: from github.com (hubbernetes-node-10b7308.va3-iad.github.net [10.48.153.30])
	by smtp.github.com (Postfix) with ESMTPA id 136674E377D
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 00:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753340643;
	bh=hVOd+eoBHxC8dIL25tsKVRKBHmnO6OEKtOtOTVIh05U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=h/QgrSM40nYYRz8CAD4rJw6FxRGJ0NNpUOpvRnkcyufybZGGQgVlxfkeeEH4jqALM
	 h1WnMWW1/EOH4STLfc/ofWCFg56zbwCjQQEgZnD8Tm34f2LpzVcCfESHyFiRpwn84Q
	 F/s+e68XVG+6cJxPuoyD2R0LQTSN2iCC3R1RTy94=
Date: Thu, 24 Jul 2025 00:04:03 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/975123/82ecfe-000000@github.com>
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

  Branch: refs/heads/975123
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
