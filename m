Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1107525783A
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 13:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775396275; cv=none; b=ZwZuFADsmMkqhSinWCsyn3emP2WOpoS5Rxkm7QX1v5L80K2Uxp2mItiuiK5YPGxcoxTFhKjHGRPLegqnxda5r8bkWVEO3xnwc4hOfmJgeOVgLMjnAd09LEFEAnSt/+4YrDNONMwvTnUIl9PuozzwXz6dBRsYs7kgVIONIdWVyLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775396275; c=relaxed/simple;
	bh=ArRNqYMSgZwqPpt0kLBsGggro8ig/goW4fqfoRCnWUo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Sf5JW7SS1rQ4rXJ06uEeLECvKpk0Ozh5P8TiYPZ/DyqTvLfNTGDbmLPP5Ye37fOCFpTg9pFBJPWxCPL728YSZkzNac1AU/zUdIBlx2m9tDukG7cU7zAJ5hO0kivTVFD76sOlfwt+VEN+TUyPgdHaWp1fm0f+0AKXJjXkXR1Cf6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YwR+YlPl; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YwR+YlPl"
Received: from github.com (hubbernetes-node-59f398f.ash1-iad.github.net [10.56.203.119])
	by smtp.github.com (Postfix) with ESMTPA id 60FA814043C
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 06:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775396273;
	bh=lRpzfJ83Le41Qcy+gsRcVecbJcPdKoWhcfRMQGi8/Vs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YwR+YlPlOfRVcU5Jm/HI6MzuA0aiuUOyF70SUUoOmr6VkjI4ybuRf74sHTR0fOzZ6
	 C/1ACkYUwvGuvLgf5ThrjEbJmSUnuPkc0lvW8fTRIj/t5Bubrk7LNTD9nSr4lcW8Q3
	 xgVSa5KLUbhK3yM99obg7PvjZH3psBdbpJxVaStQ=
Date: Sun, 05 Apr 2026 06:37:53 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1070560/4774c2-000000@github.com>
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

  Branch: refs/heads/1070560
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
