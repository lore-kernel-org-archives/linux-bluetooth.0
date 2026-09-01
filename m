Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D42647D448
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255544; cv=none; b=QVHyp04lZqFeouN0yaTW5fWhEIj+a5BOcMGDtfY43fK3QWnAXua9k4dD0iBiWbFoNzguhhJO3sWUQUVPg8EjIzZZVokB4GnYLSvDEdbNu1RUJMYTuoqE7Mx0k3sRl9v52Gl+wp6NDwqKT5FF1K+XrP1YWV9ScrwggUpwJGXNSXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255544; c=relaxed/simple;
	bh=2runs3vXASA4s5GzjHFLiO86c4nlQpzaWscmITLgHOo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tPQcP5zOL54zR05jcHJF+aiSbJP2tFDyjeiwjklNXpf2h+8er8gI9s735O3jsaITJcqK/x401zhqyBqWmwF2rHdtGdVnSuMlqLVRNUunlMISz9OBorcfanvIMoBKHHKq9ADBGRoYzAd5xJVUrNJJ+2Psxe3VuCbUX4fDj1k5V4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PSxO4uyf; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PSxO4uyf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788255534;
	bh=vJw1J/x9GGuHfCYY0w9HOgJ6u5A1M90BLuzPNvaEDwg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PSxO4uyfEH/W2QYnbsSe/a08ZiR34SzUr9F9CKQGhKK6aKDjQ2dGFxDEMP2cTXUcm
	 1vQEPmslYYhJNFtY8kITck7jOHR2NuhE+q3588EWOLlV1qTgqDpvYuwOpvNJWYMe6O
	 C0O1RGj6JbnNzzOZYDx/iCO3LPYUr6IdW5+UZnBg=
Received: from github.com (hubbernetes-node-3311d00.ac4-iad.github.net [10.52.147.14])
	by smtp.github.com (Postfix) with ESMTPA id 662F8A114B
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 02:38:54 -0700 (PDT)
Date: Tue, 01 Sep 2026 02:38:54 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1138845/51e23f-000000@github.com>
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

  Branch: refs/heads/1138845
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
