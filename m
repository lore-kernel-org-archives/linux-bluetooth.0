Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16BA285C89
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765573836; cv=none; b=WngNf/aaTL4ucYTXVfBTCakUTDgENNjDkELIDUL6WGYuWyUEGUdK5XepncSNkeA4jGOTR9eOhz35n/wXm70c9PDkRPNKSUzD/Cxhoer+iJQX0SwVPQ0/1DxULueLT3Dm259vIDH0ejgRr3tY7lcE1jU0M4J84n//royAWGh0BUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765573836; c=relaxed/simple;
	bh=juO5PnHg47sx9Hrfq0mtIQgNWu4J21U0r20SYn7m6SU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YxLvVWlaKxN8uV6gJrZ8tsXzO6UoOeO0jg/E2KI6WzpcRhkrxwFYQWkpGtlq2svRF815QYG/AKFsA5pN7Jx2Iqtg7zA+HP/wjB+f2keFj2bfQU6fMXjlPHxpOT+4oDKojbtJgsMbX+aUwBNvvkkYx+lq1R2Qk/PVXA+4YXkUgrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=e7wwbbfp; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="e7wwbbfp"
Received: from github.com (hubbernetes-node-f1a8d8f.ac4-iad.github.net [10.52.200.51])
	by smtp.github.com (Postfix) with ESMTPA id B64134011BD
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 13:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765573834;
	bh=UGrRGj06Dj7izgDXAINZLXIYIVIiXCqNOYC3BaxFWKU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=e7wwbbfpJeW3J0XpOi5812FqA7zI1IUFPEWdAPf5H0nfBuX3h0Fo8Y0E+7ql15pji
	 25qAY0t8oKiJ9cfQ8gH0Gq34bBi1+fTGElFWsHf3ki3QWmfTe5L9gU8mC3XGUUVOPL
	 vzAK0WFk9iM3GP7dFWUcPCWQclnQ+/C1AbIMfh7Y=
Date: Fri, 12 Dec 2025 13:10:34 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032730/b00b63-000000@github.com>
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

  Branch: refs/heads/1032730
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
