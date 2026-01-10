Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1279050095B
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Jan 2026 04:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768020623; cv=none; b=aeL8LXoIEvM4A6lArkU5rq5ocYMEZYPC4XHrWhBzi5aF9S6TREp8ylp8VHGpJ/h6P9uUe9g5FXtC+hvVW2TvTI6JZ04Pj2VB6NAxrF7+ioNHEunHW9RcgYJlhiQftcjdf0Fd0coXA8m2fwogYJVlMQYtNdLxn2MLpLDQCPuoH5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768020623; c=relaxed/simple;
	bh=1fJAVwGxgSCDt2oAdukUuxOOHpashmZfHuWQ38yZI30=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Sjdah1xcGCMAOU2sGndOPiIAbxEwumYiZgvMTzcCzp6Ua4YovbEinreUFavKaOuRKkAJuLB8QnmHgQbDWKr7f6M/d31Ez2DU67Wsuf34X65QwGwm+Td05wAnw82uVQDVy7oUZyp5RBJXISbsUjhkfbSKqpYgOfijyGEJuPzshBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lSeHYrfR; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lSeHYrfR"
Received: from github.com (e90cd75.inventory.va3-iad.github.net [10.51.99.27])
	by smtp.github.com (Postfix) with ESMTPA id 379A84E0348
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 20:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768020619;
	bh=f4B6OgGsWEj0COUlGnrLUdiWAEKzTPzhZ8BPLZDqX/o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lSeHYrfRHbkohrDNK8qz93cfHWs4Q/3+bLQOTnCJPwawTQVPXUgOJD0yUbD9Ro9SQ
	 ogw1zIM6BBLG/8BJL9nnYBEh1b/b/DqyccRR5FJRF4QBT316k8ZaSuDfDF87rQnJWE
	 WG2I3Y+aBwsMjo/6W43l+ecjRvXYeaK8+K+BU7eM=
Date: Fri, 09 Jan 2026 20:50:19 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032159/1dcc63-000000@github.com>
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

  Branch: refs/heads/1032159
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
