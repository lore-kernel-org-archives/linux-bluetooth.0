Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7542E1D6DBC
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746020882; cv=none; b=ZsscqaOhx3qywQSojWVhqLEdsh/Zm3n9aH2I2WQaRR3/6QHVD2YB6yrPByL0a/ZL4Wb3moUT5xvhhyusl6hwM+7g0GIOhtrH6Zfxr3mqR4X1qY9FMbZDTqlg93xuMOIIIZyxEhnyr0bQzpDaMvmAmY2cah4kC4k5JqcFQuuX6dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746020882; c=relaxed/simple;
	bh=dcFPkPfuqpQsJ3Ptk/yVQ7BnhV/TDMS5qt5+Jvg8tt0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=D5I0xoEyEhUh44Nnv20OgJD+yGh/Kuc7/6kRb4SysWYcY8hs3eq+IV9za0U9UgKmHuC72UXM39xsNgJxoCkdzFayGiuW7eZonmf38OEn8sgr2aOwzSUQ7DuiqaXovwFM/p4uAGOjQ42qXVBGmniTI08STNqHcbD6sR1WvhDtsBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HOgJ2lQv; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HOgJ2lQv"
Received: from github.com (hubbernetes-node-bcd697c.ac4-iad.github.net [10.52.202.94])
	by smtp.github.com (Postfix) with ESMTPA id 62ED6641340
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 06:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746020880;
	bh=iFCQyJq2P+oREWIx9Afp/DSfXGGafCfpWLrDPnqUtbs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HOgJ2lQv4qEUPKfC+xpZae3TOlutFyMprRhfGVvat5RhrQE8l/ARnESU3xXC1OdW8
	 EE4Dh8yI59qblwTi+1e5uuof4g7pjivJc0//8EW4JKhGNC6DMkdFtaUbCwBSDF1KGw
	 mfsswHBX4azjHJfKtQf6bcLX+Gr6ivhMEYDBecqU=
Date: Wed, 30 Apr 2025 06:48:00 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/958207/46c2aa-000000@github.com>
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

  Branch: refs/heads/958207
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
