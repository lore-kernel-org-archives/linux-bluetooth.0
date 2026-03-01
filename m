Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8025B3382C3
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Mar 2026 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772395194; cv=none; b=nX7To970CcGdIZNfJnFzcRpGwmcxSQICr6MDi8qSiDA+iPhJzzkY8c93tk6h+errbDEjQrTWu90lp5SR1lWVzTCEbVSlAZnquFlESpuNf1xHAPWQzLSzGSGt3sNu9ZzM7peapzYJbPlO7aCDr0ZAwyfIrfYqoLdq+f+etxNWrnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772395194; c=relaxed/simple;
	bh=I3Wvf4LFz28/nlytMSFiF0j6HXDVw/Ar6PWFhEZDuDU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OWrjmAJ3aBD0D+I0tF82lFmECx/mQ/7EbWMW/zgRcTkQSD0k4zABhWpXbu0SZdLKWJKuZ47+X4swYHZvb7Xba2nvcShGtTXMPy4lCbjQcp9yGHnrXBk/ttjg2LPyofnAFkkYSIbAMS3LhLhQfsfTbsiecyiRKk17lCkFBITTMkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Df4mLxns; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Df4mLxns"
Received: from github.com (hubbernetes-node-d106b86.va3-iad.github.net [10.48.175.13])
	by smtp.github.com (Postfix) with ESMTPA id A01D24E0413
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Mar 2026 11:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772395192;
	bh=F3FjFF9dteX49J03ExbYBYwxZ1mBfjY/TGw/hAiXf4A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Df4mLxnsz5m11+PhatFu3r/J23WSB0GGQA/31/GIeoNeqE339RUeXuDH7jAVBza5y
	 /h7Z9+Vrld5qV3uDnFfLe52Q6YC9I+d4n4QCNUa6CTuU2zv8MPm0tHoEskSdgPykwo
	 V3Low1gk/n3KBtjStJLDyNVf/QLmZ5NCRXGi+O+w=
Date: Sun, 01 Mar 2026 11:59:52 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1049133/b520ac-000000@github.com>
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

  Branch: refs/heads/1049133
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
