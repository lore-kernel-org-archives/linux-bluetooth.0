Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D10D1F418B
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 May 2025 19:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748289441; cv=none; b=URF9FKMa7eU7KNL4DIB7pvIljdpGtx8RAMx6pFNzMWQ+zNHLPQwi/KUhbzrMecB+Y6ZNFaylidKBVtBKVWbhelm1PhJ2Scpc8dKdzlR5e0CGXtPXspv/599Bgcv05dOf7630ew4U6m+AEHhKgS4YSEBOdPryBrlEFBrVBVqjZ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748289441; c=relaxed/simple;
	bh=c8WJnjp6t+vVGDV940aMGN4H68Kw1YOAIb/JIJxKQZ4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HEj13W2TN6qpcB/dGIv34mh2BZAzLMlryXgVHZNTZrPvf+fIor1j6f84Erot3IVCjXUGklDi/VIZS4OZOWK1NtFNaO8SvWDdvfFzC0Yimmf2wErGIivGmwYG2RNSJl0qMc2jLtJhBB3APUT9p+SJCnSoqAuF27XRgUKCxd6CNUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=m3ZjmPul; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="m3ZjmPul"
Received: from github.com (hubbernetes-node-79f8c1b.ash1-iad.github.net [10.56.191.28])
	by smtp.github.com (Postfix) with ESMTPA id 59E8B140C61
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 May 2025 12:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748289439;
	bh=TD7kp+SQpnG4OlbzLppSvd34Nka8UQQg7mZTIm3E9ug=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=m3ZjmPulKTOK4RJusXLFFqwPH/SUxcv5jkLF9t2+mSYkR781DiteKnhw7k97xyFVh
	 FUzWHgD9EhHZ6utQQjyyS2p0xFILkdvPKIKW1Qkk2wiltTBgmASEREHdc2kHab6Pyr
	 L6layZaqLihS0L73GesL+pb+ZNJSlco0GgHaz1XM=
Date: Mon, 26 May 2025 12:57:19 -0700
From: Remi Pommarel <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/966495/000000-c56e70@github.com>
Subject: [bluez/bluez] c56e70: policy: Fix reset Control/Target/HS retry
 counters
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

  Branch: refs/heads/966495
  Home:   https://github.com/bluez/bluez
  Commit: c56e70c7e1f66b95e064e3952fb56415de4d704e
      https://github.com/bluez/bluez/commit/c56e70c7e1f66b95e064e3952fb56415de4d704e
  Author: Remi Pommarel <repk@triplefau.lt>
  Date:   2025-05-26 (Mon, 26 May 2025)

  Changed paths:
    M plugins/policy.c

  Log Message:
  -----------
  policy: Fix reset Control/Target/HS retry counters

Control and Target retries counter were reset when service state
goes from CONNECTED to DISCONNECTED, but usually an extra DISCONNECTING
state is reach before going to DISCONNECTED. This causes retry counter
to not being reset in this case, leading to service not being able to
initialize on next connection. HS retry counter was only reset when
limit is reached.

Reset the counter as soon as CONNECTED state is reached to avoid that.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
