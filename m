Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDDB2701BC
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 20:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745439519; cv=none; b=p4syjPywTd6dVJMJsT0MnjXYyJ2LrZhSYduqbvMcDtupTRiPx7FwI/tx0gTZoPmGnP8+QYRYxGd/rh5aDYCT4CNG7oAdEI9VcKZzEvTOGeWKrC9tNUrdQmBtPOMqLwzYAoDgy8mpOQeoDsPmMIhU35uzB7HjA0XJiVIVBvt3OCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745439519; c=relaxed/simple;
	bh=C6yp/dggXsVGDnXKc+FXWCOrq4q1mgLTDz/ZZvZW4hI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kHMJVa3CGmuzMX2d1uWUAmeaXDWeGk4RhJgCp1AqZr1rl0T6Ce/figFaOdMSoLXXXM6f88eXjaNc62Hrz3NAVsB4oGpBd5YQuAkfTNi4IPnt3I0kAzmXmXx4vHSZjcAmNWAtWvfK2NhMJ0u84Ml1sH13370CIrVH/PRKn70xUdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FcdvzDKK; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FcdvzDKK"
Received: from github.com (hubbernetes-node-42b5dbc.ash1-iad.github.net [10.56.164.41])
	by smtp.github.com (Postfix) with ESMTPA id 4A650600C1C
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745439517;
	bh=OgwcfFYlIfWAJSK1D6smPj8Qp6O5RNIVErtn2o9xo8M=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FcdvzDKKzzNHQ5JnCriMhgKi1zPMxs64OvvvFBVkbOeF7cmgC1SGPmnw1jA3aAHo6
	 bZv32VgH1JGj2H3f9HVK9Whu+zt2hDBDKdYyG8eeH7LbjNSVWCMq5S7cBCANsFzjOH
	 F38lNv6Av7QOGslsltqrX6A0rlbv/tInHg7JPfDg=
Date: Wed, 23 Apr 2025 13:18:37 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/e06ed6-2d98e0@github.com>
Subject: [bluez/bluez] 2d98e0: workflows/sync: Fix action
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 2d98e08d2f01dd450123ec3a4790dba9495d24ab
      https://github.com/bluez/bluez/commit/2d98e08d2f01dd450123ec3a4790dba9495d24ab
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-23 (Wed, 23 Apr 2025)

  Changed paths:
    M .github/workflows/sync.yml

  Log Message:
  -----------
  workflows/sync: Fix action



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
