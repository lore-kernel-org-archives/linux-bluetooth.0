Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449B734A3A5
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Feb 2026 21:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770586135; cv=none; b=X29pA9pEPCkC2ctbL49rDT61snCw/X6Nh5darxFtRqsElbA6aKNfcjIRDpy5EcGVQO5Juorr4n7TYU8AYRhiP6LM1Kzun+exHN2yvmbyS8aKBqn4nrMgYF0tOwgL6oo0ottmTaf/FKJi5TNDYCZFGa1fLWEPhxhBuKj8dkTUq3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770586135; c=relaxed/simple;
	bh=Nq2/9DCVeAGB1sGxofdVBjtbjuq6WxUWWsQmu0HC0dc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jFLe4kjpJB8eJblRUUdeuX0Kg/svaUyn8uK7ONkLggG7P/P0wj8kN1VypcsY02PHOExOeGmj+qJCACz4lPhHWCVfTrqouCJqCyxp/T6Mu37bA3nzFd+phcVqmCbSUVZYUBXPhC0y8bq7AmZ5BuIFjkXKbz8AqlCrS/00FPk7P/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=A7HR1ZuX; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="A7HR1ZuX"
Received: from github.com (hubbernetes-node-a0ed000.ash1-iad.github.net [10.56.152.25])
	by smtp.github.com (Postfix) with ESMTPA id 6FB8960025D
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Feb 2026 13:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1770586134;
	bh=vzVNywvu/LZK5exrglrq9IMLo8i04CC8VdPGYa2ZpPg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=A7HR1ZuXZ17SB16gVnTjzatK4qKCI1rp1k0tkwcGyrKKAe0NJWNKQGFn+j5T4x57D
	 ishqUeGsTgyiIS5RJgRhz+eNtgcrhnGKoVqm7QnRwWuVS8LHM1MMTKI5CmJY1S/U1V
	 IuO8Biq4sIzzA1HPLxJLjpQBmhvhNrXwMy2DnTGo=
Date: Sun, 08 Feb 2026 13:28:54 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/tags/5.86/000000-6bc24b@github.com>
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

  Branch: refs/tags/5.86
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
