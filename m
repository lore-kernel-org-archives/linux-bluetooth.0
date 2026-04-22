Received: from out-39.smtp.github.com (out-39.smtp.github.com [192.30.252.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBF035F610
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776872627; cv=none; b=HrzxAt9IoDjzhphSpW6PSWk/CSwn+WpoLmNQm+gsLr9oCba5UTMCg2f250bWGdA6wQ4joHcHX+096jRh4tCIWUBto7nvJyOXU6j9feZgacJeBg7VcpBHp0v2bgC2fVddFIAzxuspduUDhRCpoKPAVOg3gRz92sjl+2botwvmJcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776872627; c=relaxed/simple;
	bh=iZAqF/IMRtRWBDyu8PKdPhToFGbDuMXsV38mYyXo3GU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bi5uAc489a53VEkyEaN53g3L8RLbzzDoPfzZcX+ZQXmnLxuKgjnYpLsGdCqzsfA2COdasvqTlMz8Ecvk+kTTnx+etwnOoVeglbYCc+E6U+h/oiF6PEGUxOhAExul7TUk7CT5WOSx57px+ETW0mnTTHq64Md6xzFt17R1I6EOmtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UKcOZRTT; arc=none smtp.client-ip=192.30.252.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UKcOZRTT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776872623;
	bh=BRGIXEPQYX+vuRGtXlURA2AYFIi6q310FCzudjADrJM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UKcOZRTTXJwCM2MN+tZaPnbTMsXiACO4d6cs6uSs3SLUUMqAP5x/kelqtXGGm25TF
	 RSBq4hxKV9mvfshBzMU1Yjoc80/5ui6K7xPXW6nxDxSMhZgccQ0Hs8t4KtE32Pwz8A
	 6RKgVXCYhuhDKcxCqxKIeMUj7MefNzJlDyQlsCNc=
Received: from github.com (hubbernetes-node-39f6692.ash1-iad.github.net [10.56.212.102])
	by smtp.github.com (Postfix) with ESMTPA id 7BD68921161
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 08:43:43 -0700 (PDT)
Date: Wed, 22 Apr 2026 08:43:43 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1082082/a1228c-000000@github.com>
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

  Branch: refs/heads/1082082
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
