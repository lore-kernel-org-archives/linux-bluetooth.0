Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947923EBF1B
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769500845; cv=none; b=A7UTS+N8kMIMcHjflTkDCWAU+8X1E8b9fExjSbEQkmsJRTZbKA6WfvbApqalIWF+gJ0o+Pr7w0ivOvC029RMz2Qs+zbzWLxRtPj+9/BIvm3I5nY4sIBbXNSoKjyGgxukn9uwpmPi0GtWgxZdXoxONg9uyNvMYAD1aFjH9XsFNvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769500845; c=relaxed/simple;
	bh=HDWPGik1bCeg2T+Kx3orpDkS8P5KOxud4gBb7nKGApk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=O4eRxjkviNmtacEEtFOtJg/p+XOS4RQ0+1cQvDBkyxNBfZ//BpB4cKD1oyvDSWT8mN51ffOGxLwc8ODrf73UEITl8W8JxtfeeyqatvWEE/1DCh24kJKDEEGteuLu7QJJirKH7ZA1BAjlAfn7X7bVDpKRtkFaJSTrdS1v+1vpk8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lSkxCxav; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lSkxCxav"
Received: from github.com (hubbernetes-node-808eee5.ac4-iad.github.net [10.52.152.38])
	by smtp.github.com (Postfix) with ESMTPA id BB2BE202ED
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 00:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769500843;
	bh=CG5RQtNYiHbzYFnz+be9s7pJXTbxgEeu5DwTU1mU7pw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lSkxCxaviQ6YdBmpoiBV+rngj+uoijw9lMxDKWJCebpN6bsfqDCcYNee2/x6/vyL7
	 BODUbk9tAY588acwSwhJqwpdolaP4BZ5KqMKge5qHSv32Bej0sywxPPImUWamHK+da
	 cm6oOCAY2XU50uNjZekFOSviQNHKjvJMDobNPpS8=
Date: Tue, 27 Jan 2026 00:00:43 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047390/0d38da-000000@github.com>
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

  Branch: refs/heads/1047390
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
