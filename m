Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9A22F39CE
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153202; cv=none; b=rO0zYU7sj73PplULlJjHXTxKAGfSY+sqYWwQyJ9i4knIlr6Y+5YCQxs4JOreV/NRGaRj+dizPzQkRDdGiaqo8BPL1oDPBjLSBJZ9xhskD0V1PYF0s97HZ8deJmNDgSSOfuMejqNfgHUxh9eNJs1HZyVY/rpthm18DQ5GhErizd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153202; c=relaxed/simple;
	bh=iA+uWgrsKsxLYDw8MdcUR1pH1MuO+SvkjqP/sInPm3c=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tJIthXHXXfCwf6PYCp9D+L8Rf8YQy5vqd9IA2Sunt7G9Z3ofj/0VX1viOvDoADgSPxhlrx6Q+LfOX75ZzqFYWHAEXXdfJe/qBSeFgFCs5WBo2eZzMO78zXnqSw7BUXhlsgMJzUJVvAlEKv/joV/QbdIOEV6i3L2Hr51DT218P4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GkhDj6if; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GkhDj6if"
Received: from github.com (hubbernetes-node-a1d53a7.va3-iad.github.net [10.48.168.28])
	by smtp.github.com (Postfix) with ESMTPA id 57B844E03EF
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 11:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775153200;
	bh=N2JPdt3k08gZOBM2mlfnujSoU+IT7dUOQRSAoOtdzJU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GkhDj6ifk8c5BTQ5ea6EA27tFLFur9CMscS2bOqqMX1jq+WCX2/eKpf5uBIjqIQDN
	 Fo3q50j3CLT+jdzqmNFjWaRzGag4FJIkMMcdq3TE3vFsuPRSv9Gjuig11AbIOfoviE
	 N5Xu8hIMfVwWikcbog59ZdQuGxFL+yRMtnk2WbG8=
Date: Thu, 02 Apr 2026 11:06:40 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1075991/15844b-000000@github.com>
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

  Branch: refs/heads/1075991
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
