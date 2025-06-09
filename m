Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FAF14A4E0
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749484141; cv=none; b=OtrVRVeb4f0+at7wZoqH9gYRSlw28pOXZQyDowTZzgmoP3MxknJB8DvYMik3uiMMiAA7Sw/E+lGUO3eitRZ4djKZ75gCR5ILx7cbzPEndGLvYDvjQXyf5noXzsXM+YDFORPgtsUMRoS5T0qo7xRxBQd41gX47ERtxDpX44bvm+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749484141; c=relaxed/simple;
	bh=HaUaA9Y+2kXSbEPH9fPEKtGy7NjJFK7OcLm+sllRujE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jp92FKYwbAngr5nzX9D4Kc5HvoXqdJC/xzfZFbJ8y9dAeuxOhhf2vFgMOUWoc7OWpuEJOKnPLgW7UlbpT3zYg7Y6CbTAvNnrKURBMQPuJrPCwu7jdacNvtv7qdt8yigJWsJR+ruGx0yAqSEfiaGYScGmq9cfHQvwqSjuA7/QZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KokQzPwa; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KokQzPwa"
Received: from github.com (hubbernetes-node-1eeca9b.ac4-iad.github.net [10.52.139.40])
	by smtp.github.com (Postfix) with ESMTPA id 82EC3211F1
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749484139;
	bh=1nukHTRa4Msmua8h6lcDWDjeJp74jICBYeU3kt8NdZE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KokQzPwaoBocXPOW07du4EFGuqAjCBI1bW4c4ix4ZYYe/FEFjJT9HGFDO+2kFtd9R
	 SM/ZwK+em6S7V3oh+2zfKogzfU6QMXU7N+HLmJNUNHa/GCWeJ4A0y6Xb9k1gNX3N+u
	 Ya0fWru0MzEWwQPh4wbhaQxhUOjBX2yPVGE6UVo0=
Date: Mon, 09 Jun 2025 08:48:59 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/969619/a2652a-000000@github.com>
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

  Branch: refs/heads/969619
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
