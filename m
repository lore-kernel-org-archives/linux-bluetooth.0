Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2322B2FB97D
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577440; cv=none; b=mDGynjIuAGK+9hMjGi2mK0sOy7S8qffiQh3mSgjBMS6DO65JhJl48fD0AK/I6uM9b40sL1eoRdRWSClPxUPFePe+B+WWN+hEAMjwtg8igcV25ss3Fy0yoTxeXPyHK9xHsR6GKODbAIk2lm/eS3EBrD3N+mMMcyZ5f6N8osh+L3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577440; c=relaxed/simple;
	bh=iixjpXEEX0Vu4bhogJ3zLYnOfj2avHccqTouBy4YwRw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kfMeDQZfuYGrl6KyfWBEX9jCAbiwwagWqDxRTvXHltallwJV4kvIJwGbck9mO4y38cu1xRigbM9dCWc7bdgsxOCfzJ/hmF8YRJtlsVIP4HOQTRUTZqtSfYRqWidHU1OxNoEehOPkr9PuejvDRI7SpQVwp9PECfE0Oy79NvbB1WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kLc/YNS3; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kLc/YNS3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784577437;
	bh=FAN3dQXyJdJPSxrsYfRlAfFqmO8HrpdGz27P8y4rh1Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kLc/YNS3BNGLNu7aMXkBRenw+Qafw8+W/OrNjTxDReuVbrgluWsqvK47LijtNLRG+
	 xKqCDcZudaJDEOu7oiwaegBt6X7yhNBoLRnnEFF4vn3ZooOnNs6DNXyVOby5CEqfE2
	 nYult2X4aTQNwI6KdItgqvDoqQr+j+uBy5bf8j7M=
Received: from github.com (hubbernetes-node-3ba581b.ac4-iad.github.net [10.52.130.37])
	by smtp.github.com (Postfix) with ESMTPA id DE4D0A08B0
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 12:57:17 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:57:17 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1114241/dc20a9-000000@github.com>
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

  Branch: refs/heads/1114241
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
