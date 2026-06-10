Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4CC36923F
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 19:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119361; cv=none; b=h2CTHp/jmTxW8eqzbSSIVn+/A5upJ5NFvS/64DwoWLuvTitNzw4HC+HtoaN1GMnDez2kNKr+d7KnI4H5WTcprSONN+SoR5OQKGznLQVbZiiH96kLdY1oKwzzikWP9aXOQ3hlLVo4ezMG/HTkY5xyFCdSR9YSC6Y/2FmQ9nLi1n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119361; c=relaxed/simple;
	bh=zwQbU59KYFeYWAHHMwj3g/KW6i3v1tEjmnMIE0FJHY4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pag6YqEdAMcEoEisBnFnBR2K9NrUS43uMKNoudUr0EpefI8chf0qUQPyTojDaLM+sguPvhMa9JxcTCSEa97bjwICJSD+gY5vkBI9alxdmr46LYJcCDCeZBe3sdZiZIy83/myfU913WXc/FGMufKirWCO/4eqZa7P8FwqGZ0FCLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=isX6gn0q; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="isX6gn0q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781119359;
	bh=WqknMxjWYh/hh+cZvmVq0emKEB6tEpdTce+kZ70ip38=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=isX6gn0q9KBwMCvqSzJeExI3E8BdlwHqAapNN0JMVcjjDfd8MWDtF6Qug2UfyDZsk
	 v4845uTjUPWVqi4uh174ZrkuQo2sUo6Nw3F2xY8VafhkuKiviWSmFfF5OkqEX0v2M0
	 NB/xAz44sOduNtdX18II7zfzkqHfLprnu4P4JNO4=
Received: from github.com (hubbernetes-node-146cc1d.ash1-iad.github.net [10.56.160.36])
	by smtp.github.com (Postfix) with ESMTPA id 8A39A1803BC
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 12:22:39 -0700 (PDT)
Date: Wed, 10 Jun 2026 12:22:39 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108834/da2011-000000@github.com>
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

  Branch: refs/heads/1108834
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
