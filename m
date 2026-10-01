Received: from out-36.smtp.github.com (out-36.smtp.github.com [192.30.252.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339FA38399B
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 20:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886923; cv=none; b=XD596bbeeyr5FTWOlJRJL7FHY0ZA4mucX+8hfei88v2VvzBOTNzu4PwTvF0D8KV0xSUBsmug5G8pGiEU9BOlft+0cp5qJEVbEqiQG6W2SmowLVn8ntxG2QjKEyEcl6qr4vvF7vfd8C11P40/RdCyUMI178/5SR1oNm85MZNlya0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886923; c=relaxed/simple;
	bh=6kNRoP8NkyyRxYGHnBN2653Dc8hvdIWHGeF16Css2k8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KOn4dfAxdbscZ+D1jXRrWI5rUwqBpHJREQqAQgXTLNDpt1Sx4k3ZP+eyuaTmDSrKJEDPlYc9J2gpuIISPfQLbIrCvFH6L2ODcB1FqDTLSLjm7kMFfvujtePTVkL3jz4yWlySa+2gIfxQB2HuSTEyEi+s0OX5Yg1+7hh8ec+4npA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=UfQbIvzd; arc=none smtp.client-ip=192.30.252.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="UfQbIvzd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790886920;
	bh=7QCmnk1kYXhOxPUrt6MaHSHVbEMFYsKBLxXVClOsWNk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UfQbIvzddtHNSu8x/SgX0psdXCO2GlhvQM4tUiTOjL/zZod9JBSqmmKTzTQQkrDYP
	 xCnqA2BcWZZ7RICOsQiu0dFYEYTYrPDotS1Y7RVS56Lt5OcTjPO81dm8gNGlLtS8sS
	 CTFFMEn155hmcv5Cz9i1pywYDn1pL7wUkPG8MSUXjDChBpknDmkc+QYj9Y8X1mMcka
	 DnEmdu9XJVI0/33WTO3RefqQrSoK0VJ5ft47QClBvGXYoC52ZSppVr5LKdkodG7XBH
	 PzHv/3Z06nlztDnC6KRC4IuAHMPFjRbLpBWf8rbjmZa03yxnw0KCUBjVYNbL+zZa/s
	 xr/Wno/b0/GoQ==
Received: from github.com (hubbernetes-node-7e664ac.ac4-iad.github.net [10.52.173.39])
	by smtp.github.com (Postfix) with ESMTPA id DFD82740166
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 13:35:20 -0700 (PDT)
Date: Thu, 01 Oct 2026 13:35:20 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1175995/3c1e78-000000@github.com>
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

  Branch: refs/heads/1175995
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
