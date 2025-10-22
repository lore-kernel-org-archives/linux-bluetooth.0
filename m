Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418B03590DA
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150380; cv=none; b=jbLm7LNbVBU7I4DtjegD8x1HBYU2R71yoWEw5GB347WXVly3KYNUrvBFYdl7EoSfeqzhWL4m7ium5M45Ygi5aSSWIihla7D0ukrfM2eHrT0xYOAk13osWwkhOrkjvWg97cJFQIJlRQtDiAuTo6fMUVM5EA+Hvt0bL8iVMItpeEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150380; c=relaxed/simple;
	bh=1tWinUCCgi7z+RCM5dUgR1QkDs1nyz43rLn3G3iwTNM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PLDyVj8PvbzBf5FkXknUzDVPM2dkl63FOjr0BvK6l5TccFz3oCWOXeZcte+U6SwTPkCjUhOB9ETCl4mWcipzlSYtKCAF2yl7aNBaHq2qQGPKTGp8uQ5fQMsA+4+uK5T6ghl1ZgfQ5Bl5SuFFEochxr7zaEXAb1CmyIcr8EG4N1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EHARtsK+; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EHARtsK+"
Received: from github.com (hubbernetes-node-3d3a7bc.ac4-iad.github.net [10.52.153.33])
	by smtp.github.com (Postfix) with ESMTPA id 55D5021173
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 09:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761150378;
	bh=V6vVP2CgFrH/xtUKJ4FHq7dRzzqCmXSDISO0qQXKdmA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EHARtsK+NB1jDN5Ssp7zHqCf9PbYImTne5+losImf9PhDmwD0ehtMg9XuSlFuVE49
	 pg7yZQK+9I+6gYC9oW0uY17YAIPsqDOG4YawLfOKQpWVHQXJP2nT/pYub5DjMJqNoy
	 cAJF+SveNdmMJQiwn5kMXvuLKc2kmGii0qGjI6z8=
Date: Wed, 22 Oct 2025 09:26:18 -0700
From: RSmirnov512 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1014597/000000-a17d4d@github.com>
Subject: [bluez/bluez] a17d4d: battery: improve the display of the charge
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

  Branch: refs/heads/1014597
  Home:   https://github.com/bluez/bluez
  Commit: a17d4df6d9c914de446ffb2603dc434a65dfdee7
      https://github.com/bluez/bluez/commit/a17d4df6d9c914de446ffb2603dc434a65dfdee7
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2025-10-22 (Wed, 22 Oct 2025)

  Changed paths:
    M src/battery.c

  Log Message:
  -----------
  battery: improve the display of the charge level

At the moment, the charge level of the connected devices can
fluctuate in the range of several values. This is due to changes
in the conditions in which the battery is located (for example,
heating or cooling).

Save the last 4 charge levels. Choose the lowest one.

Fixes: https://github.com/bluez/bluez/issues/1612



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
