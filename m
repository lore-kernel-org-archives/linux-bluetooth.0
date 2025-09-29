Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0EB2AD24
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Sep 2025 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759153735; cv=none; b=HCAOTKIdbeCvHaitlk0Qc3zYb4Wg2+gnTl+lL5jlg7iKaDwOJ+uEnxfU3crsAemL/erDTvsFps73KGBFX6ZsbDS/rPHrhkmwhKtO1mizH2UPcX0XlT/jdhj5cbKyXqmoNtr4kGKRCGIPzq9FP3d0m66UWrhgoeW1i+N3DRVIKVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759153735; c=relaxed/simple;
	bh=CBvdTMv2Rj1IwjviskeiqPa6iJKHH/qNRv2U1rUYvRU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ny3kwyGwr6XnADFMpM7YiLH5oCzIa+AhvLeuxGbMRPYz8dLBLA7iB3aHlOdyUa4ziIU31+cG/h0WlTCI6NhFMznExzj7l14PGfD/WiLFBagg3M+tUzLZuGmHCkmiYdCUXtnsic7LSBI/+eWCtJHEVe9X49wE3ZFCpYqPetDsuLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Yx5eRN6J; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Yx5eRN6J"
Received: from github.com (hubbernetes-node-7e508d7.ash1-iad.github.net [10.56.224.74])
	by smtp.github.com (Postfix) with ESMTPA id 1CB54921370
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Sep 2025 06:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759153733;
	bh=jJm/zDeojWZ9z6nZ/rCRe6kpamGBmOG4Bzrrl9x5wGk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Yx5eRN6JbyhX4HeAvfaTEbdKfLUYMWWChl5mGA87WEnDQ3FGKpY5ck4U3gkViIgz1
	 cN2pQXe3mKN/y8jT8j3BEFgAQJDJ0v6AU0oUMi9y7oLXmLQjna2VJIVW8W7TO9yMg9
	 nQG3cMEYs95DxgI5xrqAdiu3u9r0ngT8tANUH3lU=
Date: Mon, 29 Sep 2025 06:48:53 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1006636/8afd5b-000000@github.com>
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

  Branch: refs/heads/1006636
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
