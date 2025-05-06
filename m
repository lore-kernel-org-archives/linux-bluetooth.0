Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F51F25F78A
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 May 2025 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746544321; cv=none; b=fZdbaPals04FTk8T2m4NHRFJswacQ4xvSXaRrOT5Vf41Dcc3nWjTr9rINWAQ9y3kEnvPm5/Ae9XudkK5wYoMlJwtNhW5dbfDL9KMYdqptiEo39MrkT70bVaUQifj8x2aTxQWi73ylJm1ZF3IbinoDRBpklBclU3zYFR19uzULow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746544321; c=relaxed/simple;
	bh=yXHR2ARMNhh4paWFl9Y1AbnVxXVFYb8Sngu8fNG7yFQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pcpuk+j1+W52UaftuPKO137g/IC+GyVz4M1MMRXczsa3R3zQfekYUOuZfSBqDkztTRMrHd8BV5PwixWcWzgDBYnjG/7kz3hURTl2wyzzrzRxiVF2qx/ah/sr9wVST8DUiliENhK0knksQleHks0zD4E6UY4miIrRJ4nftatRsM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=V25xNZzt; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="V25xNZzt"
Received: from github.com (hubbernetes-node-dd59358.ash1-iad.github.net [10.56.156.42])
	by smtp.github.com (Postfix) with ESMTPA id 81F88600D3E
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 May 2025 08:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746544319;
	bh=al+uBB2bWviyhy4ntKD/E7rFmVpNGgvZ1x/IPt1Gvv8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=V25xNZztk4GDMbgeVU0Brl0zliuU3nQTGU4e8rxzKEPrE3FjLDszQkt5+EJvl2eIc
	 KC6ReVPxPgtrJCsXMFI0lFl0mHbHAGmF+VHWhW1bRJxO4em44di3jo2+M4mJBMabi8
	 yXjGelUz9iIUsR8C+vMHWyEwM0xOzydpsuh4A40A=
Date: Tue, 06 May 2025 08:11:59 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/960073/ad14db-000000@github.com>
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

  Branch: refs/heads/960073
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
