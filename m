Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44368254853
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 May 2025 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328212; cv=none; b=KbqDYk1qBJKvGNc/bB6WUu2khSaGWbdWb3h/t/o+Eun/3wBsV7YKgu1LBj44svZ8pwbn1OdP2FocMJifaJuBu6imqbc0E6T7BPSy3RI+DBNe2UiwdG2KabNXwQ2DN0zPnVR0/T3sIWu2pMFRYsoGebazW3a2tM+LyqdNDRAzm0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328212; c=relaxed/simple;
	bh=/uXlXVtrJ3SXGjs2BlG8ZyQC8QSRslhLzuH43SnDlp8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=u60cYSCwlE+x7BUGcdoEbasU9PDZav5Un5QsLkAhmWJxeykWKKx/Gf2ZfdbFz8aXH3SFPU8MWy6DZpBtexV+5xK6LEdCzmKKp+WAMakdkmudHtMxHislIpkY370+dqY5SFgWL1fPg0WN8VaON4q5MnquUTpCIOVUMHsEDAsN4eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BsHoMnzN; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BsHoMnzN"
Received: from github.com (hubbernetes-node-baa80f5.ash1-iad.github.net [10.56.192.46])
	by smtp.github.com (Postfix) with ESMTPA id 49D4A920AA8
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 May 2025 09:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747328210;
	bh=t/jpNsRBCOC+xvK0v4x/Sq/Fosrxwl7IonLjKSP/FT8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BsHoMnzNh9Apt9bQgttkwdHe+wshhfYKetU/nUGTYxpxQu6D6G56u3m2yU3oOFvk1
	 w9nWTHoErRleEJ5HVneZ5+JoA5Ga5NmLVEKl4/Mv1djiO8DxFQEuKcJXkAi+lv76gg
	 CgFSm8JOTSUQ+PytUztOjLxEt8/eavziwpVEaIWw=
Date: Thu, 15 May 2025 09:56:50 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/962794/774258-000000@github.com>
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

  Branch: refs/heads/962794
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
