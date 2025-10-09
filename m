Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F3225785A
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760038956; cv=none; b=nHgMh5t5zRW2HioGvi6DG8X9BQPaOhryLZRrpFTfvvLj8H6TNh7AqZM7dJ2+sratfuyKfmO1GnbvFPzOxdKAf9K7zUNJayAuxIZxRRYByzuU/zbtefYU0DMgPQ4V5exUmDFtpUjzdyWo9ZuPhwOt93UluTQTaOQM/9pELPmmdzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760038956; c=relaxed/simple;
	bh=Mxl/4q3phryAmQilxcTQ2L9YieVmxIHfPJ1z4kQ303M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dDY/OEgF57qYC5BMQGfUJbwIWHWeJnAZNycJvl04GjrYBGi1KuAHRiR/qdufu6nzwFWQdlcAAEQ3ZtDnWNLuU04tGqJqQPuM4+8eCgxl31Gu8aGWN7cgs4tNLz52i8QpTTSbrl3+3Z8sjv/GrZ5t5dTSjNI/Kkg6l0oE94itWac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cmpZQVRh; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cmpZQVRh"
Received: from github.com (hubbernetes-node-7d77bd0.va3-iad.github.net [10.48.220.26])
	by smtp.github.com (Postfix) with ESMTPA id 83F284E083F
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 12:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760038954;
	bh=r0Oy3GsFYZHzeuZ24PeC2IKV63IhN+9ld/3LvEwfgiU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cmpZQVRh5541gqjmm4RWL+81QW0PmiKaMF2rxqtKD3ijNsL2e0wA2JOSCFvFJy9nX
	 W15IqXq5UZ9MrK71K6vg9swXeSZtZedovw8SKviHB5MwuOnb1vOOGJz/lfco47jcCL
	 M7+GtiM6exIcuWSpPgjnd6XmKRS4x71HWwvFyGto=
Date: Thu, 09 Oct 2025 12:42:34 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1008059/5172bd-000000@github.com>
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

  Branch: refs/heads/1008059
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
