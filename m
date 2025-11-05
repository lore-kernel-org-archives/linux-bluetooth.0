Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063D7322DB7
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350156; cv=none; b=r2tk+J6N7QRJ6AUCSwyQi2PqG53o61n+b3exhtCMgc+BDgoGEbWAZ5dBQ9A97oPns6e7V7M8qxHPwyydiMWQCyDuriTLXXf+kN24VQPae2jUYV9AzDPdtnzdHqw/KzZ3Fvoj3QC0LHCZahoQPW9OveVI9wP1/jy9k4sW74mvyho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350156; c=relaxed/simple;
	bh=jyqgHZCZmJsXnNRljop5yG9+uQEwXnjz5pP+21ioI/A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SDhAdPkpcT9s37aAh8xvZJOb8gP+7sbVo5wq/Y96lWGFfk3S3YaA/3tKCZx2XzQ/O3MTVgRObScjAwKpOE6wfT0stCkJPpIkuIuBK5bPYotqgC1mQ9vSS8I/V5chZvgdoQyQvUK+SQ1NqkGMisE/sbnp0t84+8nB3ZCviBQ5064=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=A0QsZYkq; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="A0QsZYkq"
Received: from github.com (hubbernetes-node-253d3ec.ac4-iad.github.net [10.52.208.105])
	by smtp.github.com (Postfix) with ESMTPA id 07D302135B
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 05:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762350154;
	bh=ZlZNBVSCFGgkn4qI6eKA2YtqYcRKUGNwwcIR9MGV5A4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=A0QsZYkq8E2CUqaYqV3KvJfTv0AJjIOOpioXBUSJLLkkLdM9U/p96bd0Jxwkjsrw3
	 1WdM5J8w7F7x0/+ME3h9Bbyt45lz0n8BMh3tIOKdjwsRPY1Us514lxoAjE6EL6W/aS
	 oYbt2QUd1/eTwes27c2P/o9FzLVUe1/ahYHA5Dj0=
Date: Wed, 05 Nov 2025 05:42:34 -0800
From: RSmirnov512 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1019882/000000-6b2859@github.com>
Subject: [bluez/bluez] 440bd8: shared/battery: improve the display of the
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

  Branch: refs/heads/1019882
  Home:   https://github.com/bluez/bluez
  Commit: 440bd83b9629c78cf2a42d97421960f7df55a116
      https://github.com/bluez/bluez/commit/440bd83b9629c78cf2a42d97421960f7df55a116
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2025-11-05 (Wed, 05 Nov 2025)

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


  Commit: 6b2859929ad94f47935d171bf845676e9601dddd
      https://github.com/bluez/bluez/commit/6b2859929ad94f47935d171bf845676e9601dddd
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2025-11-05 (Wed, 05 Nov 2025)

  Changed paths:
    M .gitignore
    M Makefile.am
    M doc/test-coverage.txt
    A unit/test-battery.c

  Log Message:
  -----------
  unit: Add basic unit tests for battery charge handling


Compare: https://github.com/bluez/bluez/compare/440bd83b9629%5E...6b2859929ad9

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
