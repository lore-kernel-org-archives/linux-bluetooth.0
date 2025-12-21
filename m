Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7055A6FBF
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Dec 2025 09:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766307668; cv=none; b=FjD+neR3c+h7117WWBCyZbAPxg0riq0VVjhxXAmIyFwIF1grwjrll0VC+gOkotx9MObFflUndjC5W1o21+NPoVHYkB6KyTAbqbonmVEQ5Xa2koR/dZXyfjmb/dNqYdy1XsabdzE7QJ/CshbF85WLYynn/nkViUvHYmOcsMTJlCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766307668; c=relaxed/simple;
	bh=Vqd8U4Gkvy/7AyMHUnFAVvd3BdNYiqak00nphCSihro=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FHQ/2e5jEuDCqggIMarirRanRwt8H3It0skgdkem2pNr6SltTFrBt3e8NbD0MWgwdhUwfqpjqgiERXKzvzN/WvkRyifomMayMq7pXpY50RpWMkkIeOrgVFBEAr4xgkjEsFdz4GXYwuBRPNaFlellq7sKqWKfvsMYVrAtxU/9B8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=N+4RMZnS; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="N+4RMZnS"
Received: from github.com (hubbernetes-node-0f6c2b1.ash1-iad.github.net [10.56.167.41])
	by smtp.github.com (Postfix) with ESMTPA id 9BA02920B87
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Dec 2025 01:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1766307665;
	bh=4rLZoEnGOtkyXaQzwPD+YpmDDk/9Y2LyLuG+SH7s71Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=N+4RMZnSKPjSFYG1by631UrJJuQtkDS1C0mv7u7AtCm7yH1oKLYEwGKNtgQx9cbye
	 o94HO9UfUJ4TMKw6XhhfSDk1D0yFr06zlxwwH1g2M0+9VeF9/yful2+KweUFJj3xPN
	 yH55yQ4m/9OwYJ9oHhYBY3GbHUELM8bSCUxrcC1E=
Date: Sun, 21 Dec 2025 01:01:05 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1026215/347570-000000@github.com>
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

  Branch: refs/heads/1026215
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
