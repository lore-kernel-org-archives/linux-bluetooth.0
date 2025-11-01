Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DF928C87C
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Nov 2025 11:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761998370; cv=none; b=k+eJL4ZXeiQ3wOBMt07FWnuoVBziVxN5NWOXM9cVPdHzJBRx4k5u3NyPaPM4zdccPMmB6rofw7R9FtWLTiFpXOfuiPf3Pqm5ARsJiK2YBNra1j7nd4/t9hM3DeGo9QqIR9yS+z+gygzrZVE/b4RYmfqzf0N6TUYhCsNJEKxXLII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761998370; c=relaxed/simple;
	bh=oHIMvf+FJAykwKYaGNfalc59GNnkp69Vr8Se4KXvXJw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cFA2Oh1Vkjhv/7bvxn110ZaO1LeIao5Ufcu1Rqmiq9VjUzlrry7nIQyoZ7qQcqS6tv5005IbfvogUtl8d0QuBJEvL9LOu7o/wWAitFuuoRUDzo/KETR7bus3rTjYd2lNdlCkFfbMuDF5S6wHUf8nyVAXfRco91qV6FNMbVQ1l+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PLakhh4v; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PLakhh4v"
Received: from github.com (hubbernetes-node-0ae38b7.ac4-iad.github.net [10.52.200.117])
	by smtp.github.com (Postfix) with ESMTPA id CCB394010AA
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Nov 2025 04:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761998365;
	bh=XSbzu2TKwJjQ5H2BJHrZ1+xQdn6+XIkvbuEkLXZDJNo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PLakhh4v/55ExKcYPOCYMzrg3+fQEMl8I20gI29uEQwrDoWyGEf0/ZDq36Z13LOtE
	 wWN9czctY4fhYhf7IKrywJ0byI4UEPeoWO3WGGiHOWTKDlUHxfLvm0Vi4rzKMI0gxp
	 bFd6tjfrwu1dbCDJYSIg/xj/4XYrG6rL/G95mRv8=
Date: Sat, 01 Nov 2025 04:59:25 -0700
From: RSmirnov512 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1018486/000000-f507f6@github.com>
Subject: [bluez/bluez] 0281f3: shared/battery: improve the display of the
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

  Branch: refs/heads/1018486
  Home:   https://github.com/bluez/bluez
  Commit: 0281f3d75bcb1ed9878d54c94c560dc65c508b3d
      https://github.com/bluez/bluez/commit/0281f3d75bcb1ed9878d54c94c560dc65c508b3d
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2025-11-01 (Sat, 01 Nov 2025)

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


  Commit: f507f63d6e63a165f6d2389822f5b40ee9be83f4
      https://github.com/bluez/bluez/commit/f507f63d6e63a165f6d2389822f5b40ee9be83f4
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2025-11-01 (Sat, 01 Nov 2025)

  Changed paths:
    M .gitignore
    M Makefile.am
    M doc/test-coverage.txt
    A unit/test-battery.c

  Log Message:
  -----------
  unit: Add basic unit tests for battery charge handling


Compare: https://github.com/bluez/bluez/compare/0281f3d75bcb%5E...f507f63d6e63

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
