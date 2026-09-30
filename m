Received: from out-30.smtp.github.com (out-30.smtp.github.com [192.30.252.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE5C3D25B2
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 19:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795884; cv=none; b=uJJ3gR5xAhdaXbHGc4v7KtecffRkiITSQrGjP1OlcLi9p8d9q1XJBz+lDAi4GmhUMjbyJQKMLLJ5Y4RobJmY/L/CmT9Qv14MaaUv/H/z06hy8T87MepjZ1lO4PBFsFgDU01Dc+IZymukPMwW8Hr/RJVzZMABoli12BW7iXhQqRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795884; c=relaxed/simple;
	bh=KsVA2GgmMHc0ktynjRTXMMT7f3Xy+C1dgr7uOYhD6dw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=I6fgEyu9QTSCrcPuriQfH4yGv/ZQ58JajvWgKoeA73opejFilm14BukpblMSWr2sb38678Tvo71bq/Kw/L65OUYw1/VS+/3AJTEoMzoXDX94JbDV3M5TKXYcH0SvYvJGAEcPrYl/QVeZlRZzpz8mQ+8R/lUQZYQ1aQh/r3uiyVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=KFp9XGMs; arc=none smtp.client-ip=192.30.252.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="KFp9XGMs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790795881;
	bh=LtJFyeKL+og4oNdLKuR7YP9M30feZT68QuN9YCSdztg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KFp9XGMsu9JAnsu77EZK0rd1URcXUGDeQXzFO87ZBklQzVWi4aI47kkMlInfklKPW
	 hgfRkx1XKwtRdv2zbY5ars5wgNRPM5dp8tzLTH3njJgqhD69XcQHU12sGY1039akCC
	 Wx0v1Lg9leMto1wfUzsGlXa75ERsVcNlQB6cmXUfYLKhLr7dS92VD9xLljWb6ttHT2
	 02v2HEeUR6KV9s2CMvHkvppS6bv8iBR093TlYgrCeW1NnqCBELxNoWEoFwXRNBIhuV
	 KmzuyQZe5pXXFKN+VX9tx4eJ1G0a0IZ7OvnI9Mo1VO8E1OT2gV1MtmBca6ENsOwTjw
	 n4N2+B8mSj40Q==
Received: from github.com (hubbernetes-node-13a3a83.ac4-iad.github.net [10.55.89.37])
	by smtp.github.com (Postfix) with ESMTPA id 969D63210D3
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 12:18:01 -0700 (PDT)
Date: Wed, 30 Sep 2026 12:18:01 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1176540/952b53-000000@github.com>
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

  Branch: refs/heads/1176540
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
