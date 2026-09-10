Received: from out-8.smtp.github.com (out-8.smtp.github.com [192.30.252.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537223C09F9
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065846; cv=none; b=Ya5RB6Byg8m4B514tT5aOcY/BGXPc27JcCxRT74XNANwe9xW2KtwcDQkSItJ6gbJGgJ2j/rVjlpM9QNRl89hdLY/e/QW5md7XibXYdsvd8S22Upc7h2xD/d/fZccy80y0tNATyo74kqGD+HdGnxipZMA5tUwC4Jvfxk4nxw4c/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065846; c=relaxed/simple;
	bh=I0uSXLr81ojzcunQUdB94gNsD9LgiG9kQpVoUop2XvM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GgflUmmJTqXwxzJ4F+Q6v8Lql9KvaCOIX/7TxtSMXiaUvGcCvxXOX/QZWrgt4//757kmim+RAlK70nKAmChiYjp9x+BfvrdLUpPBy3pzoWkBTijLHzKN9yrudE9TQo5K+ETuG8yS7URqPArQt0+sZ1QmTbr2U1uL2SyTfgw/bK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KyUx5yIp; arc=none smtp.client-ip=192.30.252.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KyUx5yIp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789065844;
	bh=PEcEMG0RDxl9ksyoIcIvytHgJbFrIRGBj6I/g8HngbM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KyUx5yIpoDtgnVYbRgO8B065Uu8n4e5GZHsM8J9OVGTxM033kukdLuOzlvxp8S19Y
	 LU0uxsXjdjtsMz/I1ZeHZML177HGn74351HL7ADyYWwgtxn23NkAtLtRFCy3YqvU8H
	 mzOTuVfVLUT/LUTMSJRz6MdQclfskow5blWlgqEE=
Received: from github.com (hubbernetes-node-1691b26.va3-iad.github.net [10.48.139.15])
	by smtp.github.com (Postfix) with ESMTPA id 28DEA78119C
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:44:04 -0700 (PDT)
Date: Thu, 10 Sep 2026 11:44:04 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1149924/8fa503-000000@github.com>
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

  Branch: refs/heads/1149924
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
