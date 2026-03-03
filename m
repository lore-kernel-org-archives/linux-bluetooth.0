Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A916374E7E
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Mar 2026 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772528628; cv=none; b=NJKWQc9DgCNerFubJfXamZe1dGo+UGzaq3W6DcOPoL+pGVtsVO6gPQjm4PeonGVHEMIleUINaoD8ykbPAyx/UOy01CUE6t1R9aG4k7o8QGfl1T5FVNs/crSjRmrieWzRG0y/wlzeODRYfIeOXTzbZBqkZ8+pUCk+nfWyiVgmNIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772528628; c=relaxed/simple;
	bh=ATAVUNCxs6yCNrHFGepJ4d/PjzlY7for+NzikXL4w54=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IWr0ZjLLLZATIsivGFa+XOjJC4jhFaF8vx1q+3kBfyCVjBdXoNRGe6lhV4M18cM4LFhZiE/utMslj8uq9FoX4jH93+65pcOx78zDdg0rgyqJ7J5R0SPlgB+bNtjyHbWMlsqvgG/Y+uUdmFVugyAg7G5bV9ikAKHDYfrEg7oxv64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jVrBR79C; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jVrBR79C"
Received: from github.com (hubbernetes-node-b8dc33b.va3-iad.github.net [10.48.184.53])
	by smtp.github.com (Postfix) with ESMTPA id 01FDEE134A
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Mar 2026 01:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772528626;
	bh=PX3WBW02hhVzaaQcQnrTFUxgjg3ntiTrKtf9Qt2pDQo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jVrBR79C4JY4JGnDMniGNCe5GA2FpURPIsQMyzOXd94YOOPJZLkF5xNYdJPK1IeHG
	 59DzDHG82Gc+ReoTHQ6Ts2eMY+SpDgAb61royFgipgIsfm1tVfphIQeGjWB3RGLDoc
	 9ObNeO9PEMXIi8lxtIGyhcAhba9DcV07R+7d4f2I=
Date: Tue, 03 Mar 2026 01:03:45 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1049427/304d78-000000@github.com>
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

  Branch: refs/heads/1049427
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
