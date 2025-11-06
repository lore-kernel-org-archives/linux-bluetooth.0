Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B4330AACE
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 23:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471067; cv=none; b=N349ixTkKjAOdZqKnA9YA4VoHrTNaYHCbJ0CtAZFCNRzRJdNvevvBauZV6X+jPhhx4ydtUaZmqmILZEeB7wwM2a8VWJaTHjeizsRYwJR9Ao8SP6WkgTcX71spR44yciCAfIZqtTLHDdDK2COrHfv9qWt5JkCqVk3Uiv7XBiQrms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471067; c=relaxed/simple;
	bh=lm7yrmHF9BC/Vjz3zfFlUe20ulSEuyRTnKtayi98HS4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hdFtsU0/1TAoi01o5QMkW0x5Czl6zeK0oay5/RozvAnb6emquvUzM3o4tPfbLDAmyUn7oeHXPx/KSHm/S5cCv2S8Wb+6uCZtrgByb5lrSkRl/WM0Q/SV4VXKiLB0TMVJDYAMnbdZHV0wpbLn2KV89k9RkVNVsCY8smE0zeNzSaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ahY1oV4Z; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ahY1oV4Z"
Received: from github.com (hubbernetes-node-5cb694b.va3-iad.github.net [10.48.222.54])
	by smtp.github.com (Postfix) with ESMTPA id 09C613C11D0
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 15:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762471065;
	bh=dssyrZqMyS7JB+DQsWzOgci2YoYOofFmm+VkislH5ig=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ahY1oV4Zjd/4/MrSVggLAzppLr9f5rDmJ6MzLQuK/WWVLf2G8RlDPbS9I+G1KSfeG
	 Ex6yD5rK0hkjcVmcCp6wRVaP5TkAumGrh1lMgKZ/0DzeciFqFPdaokDNxHjfmdnF6U
	 sB+t4y5BEpU/iJNBTuCSOZnrgL/w3S1UXl/MAUcI=
Date: Thu, 06 Nov 2025 15:17:45 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1019482/53ff16-000000@github.com>
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

  Branch: refs/heads/1019482
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
