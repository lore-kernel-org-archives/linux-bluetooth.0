Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2B030DD24
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339953; cv=none; b=UNZSQml2LZ6huk8a7dfF7xHBSwq5D8432izcGCYB//WGMckQKW7gotBplEx6uFofXJRmB0Auh4tflD0KCK9emAo/Gj7HQ9dgIu0y029JTjRX3VB/5NVYk3zFurLVSxhqGIKcYZ+8s9OWirRmF1yDUxkL1MSwDJfYTzZMDQqh1FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339953; c=relaxed/simple;
	bh=CsVzIxXnm/CkpdhGs+zCRMZ+Uv3+nGOuTqKxdhDJrBc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iBTY70ZZu7anCcOaIIpAJzeDeXO5lpWB/6RSEql66e/20wjWZUiovG2OdmSs6MJ4oK8zYOXLnafR+aAZ3g1xcvZp00wGX8ZuGbkXrKRUyQ/IOwH1Xi+J13+gG6809+Wq7s3S2iwVQAve7YA6XoyWqlqLMX4MQv0kyLSOOLk+B0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OGCLrcKk; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OGCLrcKk"
Received: from github.com (hubbernetes-node-9a7dd51.va3-iad.github.net [10.48.204.69])
	by smtp.github.com (Postfix) with ESMTPA id D02CD4E082B
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 02:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762339950;
	bh=ZGKOYH9jy7J1CojP+rOhWmh0BoOh6re/K03wkcOm0GM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OGCLrcKkcljG8W1aIbb+dSD6xVEFRRPojxGS60KgFtud9uxxyZBV68qpgk9dEkngg
	 7xsuwXdICf+5iGFncy2r4K7hzVN2KO3zi4Gg8l9pA0HqZWoAImWSiviRd/z6VwWK5Q
	 Z1JTJ26p0HU04ptfPQwolKJdXNOF4HTyvf9wx3TA=
Date: Wed, 05 Nov 2025 02:52:30 -0800
From: RSmirnov512 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1019829/000000-18e86b@github.com>
Subject: [bluez/bluez] 0d052a: shared/battery: improve the display of the
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

  Branch: refs/heads/1019829
  Home:   https://github.com/bluez/bluez
  Commit: 0d052a4623c6986a0f3f34c7a5af4fc5d0b5c2a4
      https://github.com/bluez/bluez/commit/0d052a4623c6986a0f3f34c7a5af4fc5d0b5c2a4
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


  Commit: 18e86b1931bd1d60132567a23eb8885fb1e9ca6b
      https://github.com/bluez/bluez/commit/18e86b1931bd1d60132567a23eb8885fb1e9ca6b
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


Compare: https://github.com/bluez/bluez/compare/0d052a4623c6%5E...18e86b1931bd

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
