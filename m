Received: from out-31.smtp.github.com (out-31.smtp.github.com [192.30.252.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FFB349CDC
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783964239; cv=none; b=ltaCSTAtKPjPrBxB/kOkvF+1l7aG1iTNN0VzQLvt6SlKrp10NW6TUfvEPJnTWCAd+vTOTo38l6iwrTl4xzkMRVbjxUTXCXHLTqo/+OZSL7Iu6I2leFFHOQXfI5k81j7lVeXNNGONC2WhlNKRXfw5lhiXTH+yGj8kWuuP2lXP928=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783964239; c=relaxed/simple;
	bh=bounpToCJUiUS2ux7E/xo+VkwtXGno0mS8Jd9BnJEDw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=J/LxiTo+1rOjNqsrLYukUv7l3hb7bTFCpibZn2WS+6oYMJKPmEuiVPcPxedXA2Z/jCggO1kXhuxjbDcqY9OLLZvckZVuVZk6azFpaDGwSRsKix3CBbD+6/lfJqaLz7r5Z/HrT73BvEbTlrN89rMGOsP1JgnnAJGps/zAbP43tZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DVOPdWyi; arc=none smtp.client-ip=192.30.252.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DVOPdWyi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783964237;
	bh=hvBSgCwZOEHpEEFY34Qs2ErGvtpwWxXlhCiZKUKQ0gI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DVOPdWyinLOSDirX4Syf+66MZwuubOeLZrhSZA2myJrso0GSsoUImITWhezEq98v6
	 JG6QUbm5h0N2qNfD86AlbL4gJSe6OEpJwqJi3Gb91LEv9IUdZ2kAIxQjtBY9YaeehP
	 JBJ9etmcnbNhJz90h3a/9XgJ0ndSpDosBRB7pYCk=
Received: from github.com (hubbernetes-node-e337204.ac4-iad.github.net [10.52.170.22])
	by smtp.github.com (Postfix) with ESMTPA id 2863C3210EF
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 10:37:17 -0700 (PDT)
Date: Mon, 13 Jul 2026 10:37:17 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1111062/13b4ac-000000@github.com>
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

  Branch: refs/heads/1111062
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
