Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6E63B8BC4
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 21:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200266; cv=none; b=a+6vd99yEv1NEV9MXUaMmcUFKN/l06Ki2L2MduqRv+onVJRB11joRsY7hzvRa1ek5Y9MG/4OVL0gOEZ9G9eVlljNMI5U9slTyHP+5JRPPx9ve69IMxsFyRmtjSXk7JBdvDUnXqJhJ0BW7itEBIDbewEhtTj9L5RNIHwi/dUbLSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200266; c=relaxed/simple;
	bh=SrwSnlGgKUG9SyX5SOlwp50LRZRwmj6Tv0I1sbQPIFQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VXx6WtJuflYJ7gVzNOAHMq6WIgcUjcVlKm4WeaZDkFUjJP11ueRJwb9s4O+yMONNof/n2v6Fcg2rbVn4oTf3d+TLlC0cuFvJhSq58I+eRE+1DXE+xyi60fP4P5/1YgwKkw9/cAac7+UZoI9ICgwxdeasMxl92rN21mbwVKciJUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=k/Mig/oB; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="k/Mig/oB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790200264;
	bh=mzb4uqgZQx2rz5HntHTfAhzmGuKV11tbSAa/2250Dwo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=k/Mig/oB8z30pMxOQ2cpMypQvd6/RoFYRDKqUu4eIUUWNH6p6fxb7AATzHgDod2Eq
	 IoQHsNKUQ/h9eLk2BzdmWKG5f/6Si0I8PFZggwiR8w4uaKwURupBxXSPIYGoAonHa/
	 x3RGtGce8JXomBo2qRm8NHyzZqXCYn/VbJzkZXm0=
Received: from github.com (hubbernetes-node-62341ad.ac4-iad.github.net [10.52.14.65])
	by smtp.github.com (Postfix) with ESMTPA id 1BEE1780A73
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 14:51:04 -0700 (PDT)
Date: Wed, 23 Sep 2026 14:51:04 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1171825/3dc313-000000@github.com>
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

  Branch: refs/heads/1171825
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
