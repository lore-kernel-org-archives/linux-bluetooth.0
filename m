Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D2270814
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763123387; cv=none; b=Pxph8L0iXWnRtlReFFEFhYjUATYonc6fEDuYdbiOM6lQ13pkkIkw/3LVQROzxIJZgix9ggO/fLciDTpHyHrYzvsrOBSYAQOji2eQtuOFrVE80TB2VjmYgCyZc7MKGXGFjKYWM8uTVxFTZ8yVRHvPvPNYHSB3XVgWo6ZV2C0a6CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763123387; c=relaxed/simple;
	bh=xBT41GG4pJydn1hSO4Bi2usen/303IRIELBY96B2npQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PFcD/P25YFM5ReaMeJcpSnc1Rd59MRQPWxomzM8xL6qI9Io3Hk9bbLpuP3D15g6kavDCI9RTDqwwXULCWN/LqzPIr+c73ovIqnaNjxl6jzz0YqrMo9q+6+ncA99kKI3QBcLvKCOGy4d3zbJrTbQol+mBzk0QS+8BRotWJF0kSHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EBaFcJBY; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EBaFcJBY"
Received: from github.com (hubbernetes-node-9427cb1.va3-iad.github.net [10.48.158.17])
	by smtp.github.com (Postfix) with ESMTPA id B701B4E0960
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 04:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763123384;
	bh=RG9RU8u9wsR0jBjdCnXWj8ZUiv3leBTfBkg0NnjoGDw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EBaFcJBYFJNvaE2NYpPWnN0QDX3UV2xNsiHJjqHThSrHxisw+JBzUbyVhPC+5T4La
	 Jj1CIrZef8J0y4Ul7YfPYW/ztJ0/VR4BBgRqyPKkuePA0cyoZ0kCEUNiSriAswCY0b
	 yhy7kJSPfG3I4e/he6dvoZlXwt5dqj92K2ApOPw8=
Date: Fri, 14 Nov 2025 04:29:44 -0800
From: RSmirnov512 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1023520/000000-32be33@github.com>
Subject: [bluez/bluez] fd4645: shared/battery: improve the display of the
 charge ...
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

  Branch: refs/heads/1023520
  Home:   https://github.com/bluez/bluez
  Commit: fd4645cf58a0dfc075e84a74451f8867ab8bb885
      https://github.com/bluez/bluez/commit/fd4645cf58a0dfc075e84a74451f8867ab8bb885
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2025-11-14 (Fri, 14 Nov 2025)

  Changed paths:
    M Makefile.am
    M src/battery.c
    A src/shared/battery.c
    A src/shared/battery.h

  Log Message:
  -----------
  shared/battery: improve the display of the charge level

The battery charge level may fluctuate due to uncalibrated
sensors. Commit smooths out such fluctuations.

The algorithm for determining uncalibrated sensors consists of
finding the number of changes in charge direction (i.e., "spikes").
If the number of spikes is zero, the device is charging or discharging.
If there is one spike, it may mean that the device has started charging
or has been disconnected from charging. If there are two or more spikes,
this is a clear indication of an uncalibrated sensor.

Check that the battery charge is fluctuating. If the battery charge
is fluctuating, use the average charge value, otherwise use the current
value.

Fixes: https://github.com/bluez/bluez/issues/1612


  Commit: 32be33120cccec389d0c5be8833554407591285a
      https://github.com/bluez/bluez/commit/32be33120cccec389d0c5be8833554407591285a
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2025-11-14 (Fri, 14 Nov 2025)

  Changed paths:
    M .gitignore
    M Makefile.am
    M doc/test-coverage.txt
    A unit/test-battery.c

  Log Message:
  -----------
  unit: Add basic unit tests for battery charge handling


Compare: https://github.com/bluez/bluez/compare/fd4645cf58a0%5E...32be33120ccc

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
