Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3801940B0
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 00:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787876990; cv=none; b=KGtIY7xU9FZfEyGfb9b3tQP9rT28TK27ChGoyhjWm21I4Ad7/CXL9qb1sI/ZfrO9ebb1x3MgjByGLKvvoRT5WV63irnwt6AkKngeRegRhSfpEu/5267szcJBCfPn+LCKkfOdditLnF8UDU+mvaCO4C2x3Z7lWaBpG/X4OUWerLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787876990; c=relaxed/simple;
	bh=tXMXduQ/92sCHHgaf70dacX0t9j3c1BAsSG3yV+HDsc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZNYEEpJ9CR9uqffF19JjDhUoQebJsEs7uIxxgBGfcnPf4luTdfCpKRPdGLeQMFB5gVM9ikhjl0YAJQF0+WsStbzJ8DRqRHek/no1D2wmyUEiv6v+cpsLMvVWMbtdjcwNJbaBQ5bhsJxyeeKw7DlE6BdcX6oLUFByTteUdRllq9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UgYIOWg6; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UgYIOWg6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787876988;
	bh=45B3lW5GVIzgGu0ZyPXi1Ri5i7d6jj2R7v0BCFlVNi8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UgYIOWg6D2Ssie4Xkfe0Q+NAxiJ3lmzdl1TMruJl3HcBIO1qxxrjn69tQu0eKob/K
	 TyXzg/wTR6l38nMGrc3lQFdvkbi3Ddw+m3r1oSOoiK/BNI2TqWdOeCwH5vrSpCwg7k
	 MKo54sj2B8vd1YVDSNpvTbEgrMMIG664McDBx0+8=
Received: from github.com (hubbernetes-node-b1ca5e1.ac4-iad.github.net [10.52.206.37])
	by smtp.github.com (Postfix) with ESMTPA id 97E3F780557
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 17:29:48 -0700 (PDT)
Date: Thu, 27 Aug 2026 17:29:48 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1152689/fb092a-000000@github.com>
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

  Branch: refs/heads/1152689
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
