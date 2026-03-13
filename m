Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF761DF248
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395955; cv=none; b=BQJ4K5kbpOkFU02nK8eCrDayZ76y8doYNXMmno40j9JpwfrV2oJ8izCGEJULagQl/Wh8VhCG66jyLJqhY0XlFVRTqbp7+KD8mc27HfXd8wbNuL/ygKsLRY09r83Qs8sjGosaE2sXuJk/cbcj3gFkJMYg2cCkZ8USvcndF8H9Co8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395955; c=relaxed/simple;
	bh=UNvH/O1in6FEjlZ7DghI9xUztn+lXlO5Mrf6QmBkh9U=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iXvDk+jmvTLqXsxak264tnbuVVNvEtEx9t90zdXK5wHCmDxaX12c9WZdb70CTqtCP+jUTWrztAEfzUxiSP3d7zrtiDfFY5njNNSWK0QUsaOnbIr4pRePaoFXu+1C75GhlZTS1yhw75K9YVmeWdzOH2exbByKvOt926vFTWJ2/hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dylpD0Zv; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dylpD0Zv"
Received: from github.com (hubbernetes-node-b416239.va3-iad.github.net [10.48.200.76])
	by smtp.github.com (Postfix) with ESMTPA id 7879A1C11D0
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 02:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773395953;
	bh=GgqbQ61QjjPeH5NvyIf7yVEuwCE5hzeuRIU1dHyExfI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dylpD0ZvKeyS7ncInpvOUh6mY1tbii/A7oh8kwepnEyjlPOMIRG/SsD3HjHaZl2XX
	 Lc3lHqY99VNmnSqyBAxZxpcZLO5uHl27jtqCJdmlqLnQIgZRhmwGXPRx34A4cDOM4p
	 SU/Qrm27FnnSB1mx28EeWYeCoCGSxuM1cYmd4QDQ=
Date: Fri, 13 Mar 2026 02:59:13 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1053057/95aab8-000000@github.com>
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

  Branch: refs/heads/1053057
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
