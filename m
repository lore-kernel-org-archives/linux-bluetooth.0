Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0251E47C7
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 May 2025 20:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746824380; cv=none; b=M0XC67wmRlwF+DjJqU6mgZqxby8MqNBA3/6Zgd+JT326D8EJqem7g0VEcYXUcpXeJTIh4pXrRbC5UdnAa1a+Ul5VcskUWsT97gQmjChWcrfXckyCFi91FwWZw6uZY70ZLRbgnItPz26DaoRMwjEUhNH55NFgH47OusAR2Lx9mrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746824380; c=relaxed/simple;
	bh=jT7U1728cEiuH5ymGlV5Q8cf6XH7u/sebDO+CMYgYDc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Kz92RTHWQF7XVQgTLjC8Z/8cknJIVM8KcOGI/1e5WSHeDdYphiRqtIK9PMRcg3S9u6ODfV+VlmmBeisr3U39lunfk9LzD7kVhmMddn1VXW5Vj0Rw1Hy0wHyBFIZOT1MQ0T/Jur36vZZBh/DtgwKCHI1aa4UQvMt3i/X41JIAfLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HeXR24E8; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HeXR24E8"
Received: from github.com (hubbernetes-node-87ff4d4.ac4-iad.github.net [10.52.181.48])
	by smtp.github.com (Postfix) with ESMTPA id 17106700AB4
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 May 2025 13:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746824378;
	bh=0Werhk2aH7T4nfJ4uCy0hO8H2MahEN1z5pUr63AiqxU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HeXR24E8v+Fc8m9bPeGOec7Rt02PwB8RO0gyMtRBtqpmUIepSGOYtQfwyWsGeXfoU
	 JFaf/vvO6nJ/kFl7+VfvYn0VYdUSnJ5gNjg6Ls4pPAeBqT3i3YuiyuBvdJABpjvMlF
	 eQu4y6sW9pLtYpepffNvbK5n0ay0ncBy0PIxwxYM=
Date: Fri, 09 May 2025 13:59:38 -0700
From: Arun Raghavan <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/961533/000000-31e40b@github.com>
Subject: [bluez/bluez] 31e40b: shared/asha: Fix bad parens in a comparison
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

  Branch: refs/heads/961533
  Home:   https://github.com/bluez/bluez
  Commit: 31e40b3db9c282ea1b0603f9a44ebbb2fc6ab2a0
      https://github.com/bluez/bluez/commit/31e40b3db9c282ea1b0603f9a44ebbb2fc6ab2a0
  Author: Arun Raghavan <arun@asymptotic.io>
  Date:   2025-05-09 (Fri, 09 May 2025)

  Changed paths:
    M src/shared/asha.c

  Log Message:
  -----------
  shared/asha: Fix bad parens in a comparison

The last parameter to the memcmp was incorrectly the result of the
comparison rather than the sizeof()'s value.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
