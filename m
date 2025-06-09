Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F147E9
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466616; cv=none; b=ErVucoyTuSIxkt/RADcwPBct07xH55D801oVGW8enVNHuS0pRVpccRetVOQNnMx+FzpY+Apc1UGwONGzvRwFLM/XhxZLZM6VNBdy1WjoMQdK5BdTakUryjptU7stE7XS7AXmWW7TEzW3pAiZMwDoWuh77Csk93JD6LcECZ/mNvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466616; c=relaxed/simple;
	bh=VbJVMYP9Ckm+yZKbDk/27JYFZjCXifCu/YfkX4/x+14=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ai539m4gjGj/73sX4aPOK/08X9Vm58jSuwNZCkr8nCz2i/BL57y9wlhZcUjraq3Y/CBhUyFLz9Sn4DEXixfOgPKo9ESOthzYohG37QD65CMipLYNmDssTJbmI+gTd0Sw3TTPliklXczBsX6Ti/pz9N9RqnkfBikU0EZBqzYQh4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KtmipXZt; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KtmipXZt"
Received: from github.com (hubbernetes-node-30e868f.ac4-iad.github.net [10.52.13.91])
	by smtp.github.com (Postfix) with ESMTPA id 3EE3670083C
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 03:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749466614;
	bh=o9FpjzJ0184cE/ZdOFLVFnUurfL9O4MTXvzPZjXAElY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KtmipXZt5wQL01wdxVGWR6ZW5EGDN3d0kxUKHSfYjxTx49sf7oySNdQ2Fa6rGBEmv
	 5wUzr1BiV4Wgqv8snKFBQ+IS517mKsarfpQP4uVXn31bh7vqT/j6wmghbcwDBsDZ0x
	 qb8FzGxzCmodmrUdXvGq4WJiT3OWZ01BNzYoZBpk=
Date: Mon, 09 Jun 2025 03:56:54 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/968983/e16134-000000@github.com>
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

  Branch: refs/heads/968983
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
