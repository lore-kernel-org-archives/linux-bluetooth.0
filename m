Received: from out-5.smtp.github.com (out-5.smtp.github.com [192.30.252.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A9534E746
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779704342; cv=none; b=vFHXtQ9/vSNrl4a4cGa8/vk9/ym2Udcd7i2me19uscEPJKuYLAncaXx54xoWQX/5bhY7TP7gSin2J2b20XU2yGORpA3LxszPmCyOsMUo4CM2crhzc6hZA6svdSGSm+GwIR0jXJ0l1iqrWIVwt53Tu7JLlnLDuK6Zy3WL3gogcVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779704342; c=relaxed/simple;
	bh=0P5SVMNuHQZBOdzCAuTMUSZTctEyGNCDkERB8XS4wL8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Oh/v52pRW3+EeZwU4KyRL9HEWNPwTWQ13h+u9QIEp5xZeGxv2Dq3bqd5bxXT+IycwOdiJfF7aZL2LHELres4zGGGAljAgcHYi9H/p/RqF6xDu4srlB3+bWxF7mSzYppCzmnGbnS2KQpMHTQXBrfRTpRidRqoVEoAOaCKEkUAmrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jWHO8VA+; arc=none smtp.client-ip=192.30.252.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jWHO8VA+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779704338;
	bh=44nUDEk/CDMDwhkQ0UIYUD48hAEKVfUDx/XVCp8d95Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jWHO8VA+hIxMm8J7tSxKegxYhMfx7XOB1h406qTsQvOKqI/wxK8flKfNktxJ3BLH4
	 CZzjPy2XKEcNWlXEz0FYmZfHm2e/ija0fAfp3DDnZin9SSOl0aMfakcKxZh20Zq5tg
	 0tCOg5ppXORFWpqWQvQ06RkpbLyMqLqk4sTjH3QE=
Received: from github.com (hubbernetes-node-bfe67fa.va3-iad.github.net [10.48.221.34])
	by smtp.github.com (Postfix) with ESMTPA id E4D5C780D2B
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 03:18:58 -0700 (PDT)
Date: Mon, 25 May 2026 03:18:58 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1100107/4655bf-000000@github.com>
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

  Branch: refs/heads/1100107
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
