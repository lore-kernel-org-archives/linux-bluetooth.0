Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F4D2D3A93
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140719; cv=none; b=qTRoh0EPFnxsLRCYylU9Oyv4ZfRPG4mPSK6Amc38RqgfnFyhSYAuNRFIkA2gred4hdwqMvQCVOuixsWCO6fKcPNdKvgLTDrdgz6HaRp22Jk9EDWuSSnTiOHQRm25vEHLVYu2k0kuDiEH8DPVKdvtuT1OYVsdiAfRr0FqRfjain0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140719; c=relaxed/simple;
	bh=UTXMgA8B+2TO/3Odc+wDk+P+qCI9F96CNjmieO93fBg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kX/IEdDNGMeaA+UfpDeAoyX20VlRTkoBBFcoCMM1VZFFWsne8Zat3qIHRyOlSB9gwrhxrLPUCzYYt7V86aPFNcyIyvOdML5le6JhEsJX0psEXDAmvsWi6k6IiV5MtBJGknKJ5Ac8i3L86U/QVdJlLKlO9GdKZLL6oZIS7+UIiTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WEji9OQa; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WEji9OQa"
Received: from github.com (hubbernetes-node-d9edb56.ash1-iad.github.net [10.56.191.34])
	by smtp.github.com (Postfix) with ESMTPA id EA29B9212E8
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 09:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763140717;
	bh=Q0igpbNyva2qcImvmjWK7PFZ/AzlDfsQPL3QkyLBhZI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WEji9OQaP/P0Q600vYmGk/8S4jvLTg+jlQko9cVbqvdSYsGaLgd+K7xYONRw8wKRc
	 /5mz/+RXxzHAYl/f59p34H+8bq8y0FTyxkiqSoaFxOQKegzn9+DVdt2kas9XjlgQiE
	 yGNFEdeKfxIpXrtOeEzx+b1VO8oPG455dbJGiBd4=
Date: Fri, 14 Nov 2025 09:18:36 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1022376/500893-000000@github.com>
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

  Branch: refs/heads/1022376
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
