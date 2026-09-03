Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BC8339363
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469502; cv=none; b=dnux2+gdjYR9BqKcEoho7Vs2bZFqdbObdG57RxP0QFRx7uB3iKPvqyG78OR0zV6DUaecCX7tdACpONiWTNbN2G6SUkVyrRWbU3CB+Ir1CeXpLaZBT2Il9/tWXAuZS/4MMZb2IKWRPcLsLFk0xp19HvPMWZCQukWM4ZQD4k1tFFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469502; c=relaxed/simple;
	bh=a9hr4re+zyvK+368W6zNi/c1U+x/K+5iGg6EFyNGCSA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=F/g2jfFNJ9z5V70ftEc5greDH02u28cqkaxtR9vz4P3i4bvGiUjFYmfV3m/5WpgCkpnJBUCZzwXwSgY+kj4MTNq88dJvD6CVdVhsGitnMVJkVol7mQeqJIPJKmca9NVE6fgAWFyRPR2K6nOJV3DQkwlljtLWHcKdDeH53pcf8Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=R98h0+bH; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="R98h0+bH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788469497;
	bh=0lbT7ioobibtjgQk4axbsMRCerpoTSZV1q0LPB6OVvU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=R98h0+bH5YNRKNSfPnRo5CPRnj+rBaL+W84Woj5TnPp21zLZ6hbHlFwRppjx6K6WI
	 NjN+aewoenUVa9bBKkNf0oIbYRgY5eldayA7aW0uLbRrrb0Ub/CYRgrcg7sL+w2Mo0
	 8zdgsXRfMKRPq6SyfkjLA+aa2YI+PorZF7Ur0Vmo=
Received: from github.com (hubbernetes-node-499e777.ac4-iad.github.net [10.52.161.22])
	by smtp.github.com (Postfix) with ESMTPA id A2785780588
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 14:04:57 -0700 (PDT)
Date: Thu, 03 Sep 2026 14:04:57 -0700
From: Aaron Brice <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1157334/000000-c32d5b@github.com>
Subject: [bluez/bluez] c32d5b: btattach: Update for glibc 2.42 compatability
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

  Branch: refs/heads/1157334
  Home:   https://github.com/bluez/bluez
  Commit: c32d5b29b1bd8dbb7b6c049afe614ddb941c82b9
      https://github.com/bluez/bluez/commit/c32d5b29b1bd8dbb7b6c049afe614ddb941c82b9
  Author: Aaron Brice <aaron@embeddedts.com>
  Date:   2026-09-03 (Thu, 03 Sep 2026)

  Changed paths:
    M tools/btattach.c

  Log Message:
  -----------
  btattach: Update for glibc 2.42 compatability

glibc 2.42 baud rate constants changed, use cfsetspeed to be compatible
with newer glibc.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
