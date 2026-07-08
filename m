Received: from out-3.smtp.github.com (out-3.smtp.github.com [192.30.252.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8B0433BCA
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783512563; cv=none; b=lY4gjG9HZHRduvv4J1Rrl+uXpl0Y5dq4R7c/bw/P8xN1I1nmelZwVR5aMvdCmXbzW7G6hLsjvfYfmNObUX7wgkQZMGzNt6f1QU/j6jpN9RYhLRyFAWyGLEj6jnkyx5E0KfotTfabFBqUUP9JfTP+Hs42Vymji1xhgdMirMFF2nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783512563; c=relaxed/simple;
	bh=QtdsKbh8mLqnuRbtZNfq+fmURObwfXvtkFR7WSQQTgU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cnDJaeLaFoD8HsLwZOvE30aZ4geQS751PB/Srv987XIOtFw/qiE6DC+PYaQZ6Zp17cyE3COHo2NXHTFRW/lBK/XRr+3uH4Q19t2neFyF46BTHEtdet7fzfv2ZZdacwmSmfMwCKTe+o4bG2aeFiEML+hlNJ/WAMHNK1TveHEguwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dtaPqqcg; arc=none smtp.client-ip=192.30.252.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dtaPqqcg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783512561;
	bh=w7Hj8YC0+M3eB5SRoL/Zwc6lxW1qRgTi/UK2TfhOLBk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dtaPqqcgx0Kaah8jvul3NrCiIrkkOkpeKq2vxvuRr5awNaGZaUnLMpFO2NPOTBsVc
	 sm5YRyTy40Avj0rAavProIZ4b63er8Nv/OHDsdRyLlQGI5sCb5sFdIB4xTMxL8NzdE
	 GHsOQFQTgiqxxz9XVNBqTHJ0bRLq6ka/5qx4wW+g=
Received: from github.com (hubbernetes-node-a86a589.va3-iad.github.net [10.51.94.23])
	by smtp.github.com (Postfix) with ESMTPA id 66C2B34E384
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 05:09:21 -0700 (PDT)
Date: Wed, 08 Jul 2026 05:09:21 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1107774/fa023b-000000@github.com>
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

  Branch: refs/heads/1107774
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
