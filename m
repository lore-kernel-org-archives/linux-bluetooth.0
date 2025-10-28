Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCF833B964
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662973; cv=none; b=hZDrykA3O/pcq+lxaIdLrAvzUF2Rpbqbf6rjB7gdmJzvNE7bW0veonxGBhaQlsApBFHZIZmWqu58/D2pwNSyv9KQtk3IEJqwuVHhEZevWtT0BQH8GYMxpTzQBmp/LmiTsdiUgXqTaHTRosA622qhZlypIjxozhiShiaUmkWdOHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662973; c=relaxed/simple;
	bh=qjTguqxjLC9QWU9yYDqsUrA3u16nq41+nuxCLMtcYos=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XWVvEhcXhMvKl8OwFT3VePzPzQfyTPjVbPmxjf/4ZZr2U6HxtFTOwIKB6xOTyC9ZCOf/5f0Sx37BR2u6PwGK5XJKfi7FFTsRrfzXbkbAQBy8hFJMbnDEYmfVmfOdRORmWKvyGNDZciI2zSCM0DZr/tYHjGsq++ZPxaPpHgzEya4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kMCTAGpk; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kMCTAGpk"
Received: from github.com (hubbernetes-node-0d50b5f.ac4-iad.github.net [10.52.205.61])
	by smtp.github.com (Postfix) with ESMTPA id 70DD664095F
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 07:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761662970;
	bh=mAV+fsZmXlJ0zP80agr2O6k2655Xgo6FQz7400Q0jgM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kMCTAGpkWs4/yU2wI1AIzfx26uZF7L4TCDEIm6+1rn2iRMef85xlwy2uXAk3DfgdA
	 nDiMxiXGVboJnVagTYjzd3+g13iVfMcPkScOuUlbz82/lGj7CxxEL+gXX5XtyGxAD5
	 yrvj54z1ByFpPGDi+bCEFo67rAnBVYt1uWQw8xe4=
Date: Tue, 28 Oct 2025 07:49:30 -0700
From: RSmirnov512 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1016771/000000-c4c1a7@github.com>
Subject: [bluez/bluez] c4c1a7: battery: improve the display of the charge
 level
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

  Branch: refs/heads/1016771
  Home:   https://github.com/bluez/bluez
  Commit: c4c1a72f2470a0d0cd51281214eb0e2569bc4074
      https://github.com/bluez/bluez/commit/c4c1a72f2470a0d0cd51281214eb0e2569bc4074
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2025-10-28 (Tue, 28 Oct 2025)

  Changed paths:
    M src/battery.c

  Log Message:
  -----------
  battery: improve the display of the charge level

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



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
