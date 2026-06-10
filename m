Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CF1349AE6
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119364; cv=none; b=HKvDLPlBB7dh0uy9Pf5j/WWsxuhCzPuXmBhGqgBvg/RRn4Vj5ujVnckyw04MkmNbhq6SOF6KVJFLL32eHKiu816D9OdCrC3AREV37ShCxvFPa4a/jG9+msUAlSIxR7DTMRoCaFRpPVsgbc5oCuQFvbgQzc3f3DnGRVqbaeM0VPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119364; c=relaxed/simple;
	bh=WTR1xAerAx+1y8jps2P+rH4SL5jbdgsBd9hMNm81bKo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Gn2b33dQACiBTdFFcm8mw47vHQ61RuMUJAvJgJkZWFfgKSYGeYm5agkGgV3aGf9fIrI6PcwE0CwleBvXe+dXjNppXPOiNbylQsWJcyjkHFcYWLh6ejtB4KUtzXa/FrjKDOrIyRRU52y+NuA4naw5pWDiIf0YBVvCQLCeGckI/ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RUkl72PD; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RUkl72PD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781119362;
	bh=iLsidMpZSSv6Td/CN0ZY4ARMGeQLRsl/RyWpMY6wsmk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RUkl72PDAQK/c1XunmbUeanvK03Dz/y37rQbdGBAk9ijCo9qnG1LWXLedtWkLIjRu
	 h/xRYFVKY4tkqBLHcQg2jmzTgoXO6qk6Krl+7i86kuZcAIVVJ5mMnt9YQcVZ7qGIO9
	 CBbZ8+AzkT1PDWPSh/hUEFI1ZfNGh1sENciydK5g=
Received: from github.com (hubbernetes-node-771f6c5.va3-iad.github.net [10.48.221.62])
	by smtp.github.com (Postfix) with ESMTPA id 428F150086A
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 12:22:42 -0700 (PDT)
Date: Wed, 10 Jun 2026 12:22:42 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108830/029590-000000@github.com>
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

  Branch: refs/heads/1108830
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
