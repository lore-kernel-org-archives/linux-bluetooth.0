Received: from out-1.smtp.github.com (out-1.smtp.github.com [192.30.252.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885E2372EFF
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783440118; cv=none; b=LXurNcDuf7yJ3aPPLhAD7as3nLK6S4SYhHC0BLXm7FLqozQ2XZ9Pgnd777IjLbC/kJtuG+BsY62vYqKXMsAOYzmE79zpVcxfn87oV+YkuuFgaNg67BORENPFotfVof3uqubd0OE0agyTcfsIhGpsuqT0lHjKap4lRQbXt3fkwXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783440118; c=relaxed/simple;
	bh=MTozccKX8wK/5On6k9ZrITnK0T+gv10h8ttUZ4hTGB8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VfCnPOG/KqJN1/MvMD6ODas/WiOA6PvL/FLJwu/DwvexwXEs39CiZZ5Q7RYP3Bytu1YTmZUCbNdsc9/kv2pGJf+VKUVHRt8O6wlM+wDXLfMDXNyw6smXLe+HbYF5AYuygVBflcIt+r5gTDu+94UPWaQe32kciSYc4odp7EoQfk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EUTrem3w; arc=none smtp.client-ip=192.30.252.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EUTrem3w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783440116;
	bh=J9qaerGhz0Hy2K3TD5okgvfXoCOX1fK73BMfe/YpC4g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EUTrem3wjCVQMgSAwyEdwN+Rcl6Kdik7BvcriKK/XDaHfKN0++3ZGosXA7Ss+yO0V
	 7HbCixKWpWMHXgDnPypXsUo3utNt31oaVHFRx3anFiEiKN2UztZjqqwPRMBYuO0jeb
	 KhtAQCaD+qeSNgcNfdov5zxm4URSo1EOa12Jxlsg=
Received: from github.com (hubbernetes-node-9de8535.va3-iad.github.net [10.48.160.10])
	by smtp.github.com (Postfix) with ESMTPA id B443934E7F5
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 09:01:56 -0700 (PDT)
Date: Tue, 07 Jul 2026 09:01:56 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1120587/a6ffa5-000000@github.com>
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

  Branch: refs/heads/1120587
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
