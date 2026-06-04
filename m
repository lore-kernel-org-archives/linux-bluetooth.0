Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E42B3CF97F
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780607647; cv=none; b=LkZ7hAPeCCAu7Ncn4dENFur4nt2EivIikp9SsYv0tcN+CM59xWQktYD5jIxnDPFQC6G5FUxggEy40vvkVzqesj++xq+XsZPUnibWuOt3iwKQoqiFhxkAEYb6cI+upWpV/4YBTanlJowSKwyPXKjRiHnQ2WVPEkEC+PIHOPz75Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780607647; c=relaxed/simple;
	bh=DARZMPZ94LfV6NG+DRv3BWIoudUOXv8mkVAesEwJZL4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Ki3dRd39X2zxE6WfL8w+UDGX58T15jX0KxclmZVnxo+xf9pVYhdWao6jParoBOlaQ4aI6DopJl+iHz8GtMjOQuhhNXAsAHz4Wo4tCA3U2FiyJTg6i9lKCMTWtVGWZTH9kJOaYNObYhY0uOjEdAa+8zLIfPWKAX0IWAC1jhL/D0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ws1dK1OI; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ws1dK1OI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780607645;
	bh=s/qU+Vb51zlonJhfmJNotBPzkFtE5uFAiDYLjTbhtpg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ws1dK1OIpqE4wZe6uYzoHFsfEbkSakVu3J8ZkZPoshA0bwaG7adF5Xw7P/5QItY4d
	 r4KSq0X3PHxBCBKg3xkLLDgP3Z093rzhKTbc9dxOJnPvu2tdEwTlmW2FjJCosDDMQc
	 aH4DDJSzh2y4Ilw3lV4bY3pftCTqcpNAzP2cmVck=
Received: from github.com (hubbernetes-node-cd525c4.va3-iad.github.net [10.48.171.37])
	by smtp.github.com (Postfix) with ESMTPA id 79A722810E1
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 14:14:05 -0700 (PDT)
Date: Thu, 04 Jun 2026 14:14:05 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1105806/0b64d6-000000@github.com>
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

  Branch: refs/heads/1105806
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
