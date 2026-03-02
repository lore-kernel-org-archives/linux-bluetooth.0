Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCFB3FD13E
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461669; cv=none; b=BVMXUmHHxKmS9lNy1sLhlyYQ4rOarA+yHV/VgfuECqfVASHLikscVkc6pfq5cUmo40c0eAq72lJjULL1YTBUyc+i7QlXM3jWijWI90W4rJT1b6YmRRXaZ0975SMMe85+YilwnRv5VWKB7+tsyyfSpktyAFfO+xKv0C7Icfedeaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461669; c=relaxed/simple;
	bh=cX4QU2fcxKvQvLXVh87gTPMfOiPzxj2k+uBzSUBcOcI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nV4B1QYrg5g5QlmWwZmgBrj6QNRFWOIiDhj05012Gs8mmUTG383k2bVtorIQEEb+dlLz+upwrsuXYhqnPt73rL/mEvGbQTWFpbXC4Hh6KWMG0X0I9DWUZELcjMAyoZlMWfthlnPV0u8VX8Za9lAetOPvYm2jWLl/L88CBC+F16E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TRor/Y2B; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TRor/Y2B"
Received: from github.com (hubbernetes-node-be2deb6.va3-iad.github.net [10.48.15.62])
	by smtp.github.com (Postfix) with ESMTPA id 5026E3C120A
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 06:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772461667;
	bh=iJinqkuRz/bk72UGsxZ7d33VqPzfanGfBh4tn89s8iM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TRor/Y2BvV85jp/kE7YzogQQ2wtjUV0k7ABMz9k3ZojkRRte2yKbKH2QdN2geVtd9
	 oYyiqEbCG2zWSRUMrYcpYInlQ+sgY8bjh39h6V/eKt0ZDXMgIu7Zi+qGjOsi7yGiOf
	 UoIWKpkQSbVGTr0ZYLr63vbkuygrO/H8p+W+sMEg=
Date: Mon, 02 Mar 2026 06:27:47 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1059103/8b909d-000000@github.com>
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

  Branch: refs/heads/1059103
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
