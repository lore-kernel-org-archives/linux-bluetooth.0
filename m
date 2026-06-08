Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4645B3002A0
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 01:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780883993; cv=none; b=WqUr7MuVeldEHaJjRz3r+jBbHslzo0euqGOEBZ5U6BxkGO90HkJ1MOq3zm77T2A8jW+JKp9F4fMVsYzoHjK7wgYNR+Lkz5t44NcAdqv7WwUKTBYgysEnmk8a9v2R4IThTD4fwRPUy2f/1HPULqaY5aqTOeI4yzuHYF4dUzcD17A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780883993; c=relaxed/simple;
	bh=/hW2xwfjD6dRYYjzVKufZw7wFQzfjp5J2DFUIqh+IN8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ArIrxuinRQ5oMl78foxAJN8W2jGIiWnnX6vVssu5MK3gVp/hr15NfDiywzuRymJsgOdU5ZGBt8gYp6lh8+ypD3a2OgHIB6T/39lq4R2+2Akp0+Syyn0M1nT2o/g+2uWrVC5Qf+URU3BbonAP7PRhWMHFc+Vk++e0WOO9b4k33i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UNI8fvRN; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UNI8fvRN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780883991;
	bh=9agAWDiQaJ4dQ7+pfHTCwTloXOkAw9sc4NyP0DlZrP8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UNI8fvRNSJL5rDebJSu0Dwq35BnNQWoF+Q+y3QiH0qatbARvHVB7jez6Xhq04cooJ
	 Yx1nn0nOX9swhocaqlfLLHhx/pFGBDZcwDOBYKwNrUY1LRo9BxW7S79TRUbpTCwNWG
	 mYacKG90RAhg/lEZWCdCaSjeXl+AVIqZWB+Xky8Q=
Received: from github.com (hubbernetes-node-2060f93.ac4-iad.github.net [10.52.222.42])
	by smtp.github.com (Postfix) with ESMTPA id 7FBDB400FA
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Jun 2026 18:59:51 -0700 (PDT)
Date: Sun, 07 Jun 2026 18:59:51 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1091848/078adb-000000@github.com>
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

  Branch: refs/heads/1091848
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
