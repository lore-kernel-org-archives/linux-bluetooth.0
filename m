Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28383CF21D
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 19:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787169488; cv=none; b=qxq88ybsORIJziVV/Z1KlEaUxGSj+UfGceer6nqBusYFGpl7mZmfLsIXP4K4ivDu6PJ0VXTQNQNx27hn1DPFIDLW1s+vX2ozPaFcHiCpLOZ5IdBxWTtkI1J/ccjq6dcG8lpuL4YAYc8KlztYh+vt8PwX5ghs2APpijoXHkulzA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787169488; c=relaxed/simple;
	bh=8ekNpuUN5Xp5jbMZukMQTB/UFcs53HILwDeCDoFhWTk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TmPfirjkuuNtUK9tM+FHDT1V7IRUMsp6h8esQw6xSxbFguudpiaUWKr/GwbeltDnUF6qaC+kJlKyYKckeZYBBvts99nnQ7XV1xxFgSo2IOUhGgtgyoteP9k4E71V2WEWoVVJwUPX+Tul+w7hIIZCVXM0tiLgwQC8dk1Ij6GZMc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NXLjJfX7; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NXLjJfX7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787169486;
	bh=vqNU3ZGCdb0i5saYQowwutbYmFH5a6rJOvHv7n/FYEw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NXLjJfX7J3f+Tc5TBHCCG/CSXBcBRvV8xmERAyF4Hh5vz6SFOGpfQ9NbxAO1we+7T
	 VnI2zT0QUL0H4iCx6YNwX8NnM5/ur6iZswNBxXlRDw28eB9RrLYkiRRZOVjk4qKKWJ
	 bVQM+V0v6rwZzGfAeEVRyx3QuFypmhvVrBoHvEDY=
Received: from github.com (hubbernetes-node-5c90940.ac4-iad.github.net [10.52.211.45])
	by smtp.github.com (Postfix) with ESMTPA id B931C780FE4
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 12:58:06 -0700 (PDT)
Date: Wed, 19 Aug 2026 12:58:06 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1147758/0e3336-000000@github.com>
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

  Branch: refs/heads/1147758
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
