Received: from out-41.smtp.github.com (out-41.smtp.github.com [192.30.252.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D96914A619
	for <linux-bluetooth@vger.kernel.org>; Sun, 16 Aug 2026 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786886238; cv=none; b=I1piRX/cVssI3diZyIFeXH1WCtJyiO0bpn1VZb6OJ3GpVq9Kd4V6zPqH0RXt1Ti8zcxFGCmT5bmqQABqnYNRsmAWDMeKZr80UMLnfYEHSeCKO8Ihst6UIeEiDkp57AGJbGpjUsNnOYK2CGFKprWRBfZsl4uxgA5YTIzX6BCtI7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786886238; c=relaxed/simple;
	bh=yOEGmrTmluPQSZyRm6PFNMx2DNMyOna5HYpdKsZV+MU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SfIuo2PYJXwOhlHHKZAwFZaL+AhJ8u0O4F2HmZB1J21DjC7OT6saNaj2djK1c9H2uVlGx15XIe0DBny5o9PDY5iiyAAzaXrOx37nCM7U74vDAVDLkz0U6pmpgxebWjWJ6k1knw1+km0qhGUJrEtkbBtU1jTZOlzH60pi/jj4JOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BBsqbmrg; arc=none smtp.client-ip=192.30.252.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BBsqbmrg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786886236;
	bh=+hTK76mNHduEX/LUJAMk3a9MpfGf6IGoQgLjl9AzQUY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BBsqbmrgh+GVN3Ch5Er82WXOxUqe9e28IjFuCQgPvLibTvQExzeLFRWhaz3h4LVaX
	 456Um4J/wkFE0KlS0R/WSb5N3EuhiC20Z8O/JG/t2s8WSUPISs2uwjiWO+AnrjJDZC
	 dsLATn27WwAbkb2l32VIIKwDeiS6XqmVrOn+l+OM=
Received: from github.com (hubbernetes-node-b6a9851.ash1-iad.github.net [10.56.155.34])
	by smtp.github.com (Postfix) with ESMTPA id 180AD8406B1
	for <linux-bluetooth@vger.kernel.org>; Sun, 16 Aug 2026 06:17:16 -0700 (PDT)
Date: Sun, 16 Aug 2026 06:17:16 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1129585/b519f6-000000@github.com>
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

  Branch: refs/heads/1129585
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
