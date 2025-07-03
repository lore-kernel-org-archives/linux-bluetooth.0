Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4167B2F3623
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568327; cv=none; b=OBan/MWALN6XPL7NJ2itnK4WHI/m0p5kK/h+XOjy2DywFtwJB63XSb8Znpki3Cvjo2nTol76M6WwXzKTWunC9vFuMzBwkPXZvnMYWlGGiPiJU4EUDoqes7urGu3uZWb2XGkvE9r9azfBV6r1CVBZepaL03hZ8iXyPlItQQyPaCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568327; c=relaxed/simple;
	bh=z+I0bHKKCvfCVsCjKGihA9KCXXbR1AKXRVm1Xpodq9w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UJMkOnbVwYcAnmSHWzfeuzBQDrp50EGaAEz7uESqvbllv2ktjrL6ECGs9kp/8HihhMpE+bMqDnpiCBR5GqSU66wof3C0h6eC6H9Wl2QspLW/svcGzTGTr2S0ADpltlaBkVesEUd6HQvFpVqdZ4HsSnT3ltHZR0sGLvIPFpWLo54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CVoja94h; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CVoja94h"
Received: from github.com (hubbernetes-node-60bf947.ash1-iad.github.net [10.56.188.36])
	by smtp.github.com (Postfix) with ESMTPA id 4C62260114B
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 11:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751568324;
	bh=EuqWpjEdbcpAX+Xas3c2ncPRzGOj1UmeZQEwV2eNz14=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CVoja94hDq41zfILD3fkIBFo2YKRsZAM3lSMrIx01R45NLLe3vxnHdIld5RHsV8rW
	 68AarLL2Bavg7fn3rdokvBRxorCpJSVWu04aDyEH2R7RXBCbI0nXodc84N3k3kcVtm
	 AV7GqkxtGu4giUVTgf1yhsIYeH8hlYaQ/VDoItOA=
Date: Thu, 03 Jul 2025 11:45:24 -0700
From: Alyssa Ross <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/978771/000000-037065@github.com>
Subject: [bluez/bluez] 037065: build: use pkg-config to find readline
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

  Branch: refs/heads/978771
  Home:   https://github.com/bluez/bluez
  Commit: 037065879468c0418d2cda1565a6b34275132718
      https://github.com/bluez/bluez/commit/037065879468c0418d2cda1565a6b34275132718
  Author: Alyssa Ross <hi@alyssa.is>
  Date:   2025-07-03 (Thu, 03 Jul 2025)

  Changed paths:
    M Makefile.tools
    M configure.ac

  Log Message:
  -----------
  build: use pkg-config to find readline

Hardcoding -lreadline won't do the right thing when other libraries
need to be linked too, which is the case when static linking.
pkg-config can take care of finding the right libraries for us, so use
it instead of checking for headers.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
