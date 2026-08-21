Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A48381B15
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787332464; cv=none; b=sNCfRGCrMvGXi2k6QrT+ZWj/DKzDgghO+4DaquC4A/2DLkNuXU8hjGce2Ypkg1HLTxl+mkr3rOPZl/NpipiXTV+gl3nTqbQihLO9F5CFGvvNVWGMd4smj9wXYEV4NxVRaaS7ZBwjfkfRBoxrN2J1tj3ijCJ1Vf5Pa2r6/a9tw6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787332464; c=relaxed/simple;
	bh=7nwmjoizFxotWiDOa8xxZfTePnr0G/6gzo1h/kYPqBo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=I5u7sgplAlCnWcqAMMoZ+NyyJirL/nwT38Fg33nIRpDKFHaOfpK4a8xnYSdi2raCorXawjy6le07ayrrPgzO5slUdmvWPFLWlWbw+t3E4gzqm5vA+VBmG0H6KLKIKRHhROS/FzWGzzcMqe97lx7ChOSo6gNjqqjPmO+bf7gjN6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EpKdvtMl; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EpKdvtMl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787332461;
	bh=Erf4EI/qETXbRj+V9ZUzF8qHGYnI6Hj8fXrU5tMZvbg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EpKdvtMlZMZxlcVH0Omx5flOQpd5r6TZmyiS1kdJwjdkzs05QML2NvmoM4IMPRK/D
	 2HjnhjT+7GlNQCG639NNfJFTRlUNaI1kl0L7R2A6wwpd5YhuE2ieYgWKwNMn/O4gtt
	 DM3EFyA8cv3uvbatyen4aGMZHs1pcfexSxUFxcto=
Received: from github.com (hubbernetes-node-1f523b8.ac4-iad.github.net [10.55.94.42])
	by smtp.github.com (Postfix) with ESMTPA id 80828941441
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 10:14:21 -0700 (PDT)
Date: Fri, 21 Aug 2026 10:14:21 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1148725/1b0576-000000@github.com>
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

  Branch: refs/heads/1148725
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
