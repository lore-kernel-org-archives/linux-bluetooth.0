Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB8213957E
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985279; cv=none; b=iOcAgDwIxPGeZUJMUWwVM29ecwJkGQRjVT7Vvk64lCsFvRsK/E6CZnrSkdbOa7K9ZyHakyF5+81d3nOGiKmUpYA/2OclYvh/sCNIr609ZYWiNvdaK+nKTIMfVCgK8DEoe1ALRhzdn6C1m5RJNCdRf72ZxlRv6pFRpQ4B9L5sxEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985279; c=relaxed/simple;
	bh=Vo12AFWpjBfocvshlKzrImbfGIwRrT18xRgSp/wN4Yc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CqttDM3lAIhXV9rEnMZIZzT0vFJ/ADe0b1IltIeH2Ikj6lZIMqmthJrmIltC8UzBNXfvVL95GSAw3VrBzdY2IDZz0AiL5KncVrBe3VbekvYy9ywfpB2fL2F7mSnqgqKFRh9KhLypfy6WTjd6yIdRTWNsFppd7zJbH1Nas0dEVsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SrVL2H6Q; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SrVL2H6Q"
Received: from github.com (hubbernetes-node-006e911.va3-iad.github.net [10.48.133.43])
	by smtp.github.com (Postfix) with ESMTPA id 641CA8C13AF
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 07:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751985277;
	bh=BEy/3hLaj/tI0rOTfFhjG3QtEfGGBxdJvO1RHQeVWZU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SrVL2H6Qx4OWFOiNvO+cNf31d2jlwDOa9B0zSTPlZJGcdlJgg6g1bNf8LjAyYf9NG
	 HMvWZ7sp+jyaOsTYTAsXWAh/eSiTL73wnfDiBVkeBzwRYciL4bFvivOr3y5+S1yv6d
	 TxyCouCMon/BSNh43mrfr65mYFMeSPCWQU4SmP/U=
Date: Tue, 08 Jul 2025 07:34:37 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/979993/c99487-000000@github.com>
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

  Branch: refs/heads/979993
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
