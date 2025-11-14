Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBBE2D23B6
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140716; cv=none; b=cyn1+u1EQTL0rnlIb6D+YHWEagfEIfSdOYneTEUZaWcQFgx7ZcXWlYmHyH3nZDWgm8iM2dVsslemmcdsTvGxWFUetZMyClE/gjF/dvzMMdLRehxp/+Ac5RVFBf2T6zZPvT2AYKJWm6o5fY/fA+g7PpVGSJzGQTJ5V87FSFAqVNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140716; c=relaxed/simple;
	bh=YYSwJI6di5T35UMMrMr5NlcZB4rhJqu+RSao2dVJO5Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pf5TjoViK5sWbCId5d0U7ypm1Bv3a4Q0I2cEC1WfomyW2oPLBIexYZqmPYhVgHQz7MTuyQoN484ICJYHvRszRAiigWIfDTuWJNJc27znC6J6a2pXg6oGySpWRmGyYsnEjg6RuWIr6pFJXHS7ahTLJ/0K0DAchJbmT0IFScmSPXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MCjaIDnx; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MCjaIDnx"
Received: from github.com (hubbernetes-node-1de05e3.ash1-iad.github.net [10.56.128.43])
	by smtp.github.com (Postfix) with ESMTPA id 81E6A92111A
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 09:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763140714;
	bh=BRAVg3YAWLjJIhpz7h4/m4AaTClJEtJXIIceLOUetlQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MCjaIDnxZ5NbiJOVQbbM2MInbASe12F7sKvUWvJbF54Kib/qQRyOHPQD2xRJ3Zwo/
	 +K3B7XHzefA3vYkMS7BJ26Og9cic5VsS+uVq+5Xtyk9ozzJPuxdjIyOKf9YTiqBgjm
	 E86f+XKdo0MpOdJ+AuGoyyTtuCVuNGBYReAiL3lU=
Date: Fri, 14 Nov 2025 09:18:34 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1023061/a834d1-000000@github.com>
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

  Branch: refs/heads/1023061
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
