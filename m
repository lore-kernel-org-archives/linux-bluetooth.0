Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354BC1C84BC
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Jul 2025 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753628242; cv=none; b=Zi1LlxLVkKklgbI1G5zZjA/FlSvucCGAMPXF211hXU4yep3AmTcnFqoNy074y8L+HExB05ITrjIYAwVa5bI/zxKmvNv1ZzKgaJ2g0qIAixjcMM1foD9icxcnebx65V4YSrWGHlrq/9sH1CxyYDpVo6nX8N2GnlZMJxr6XKEOwpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753628242; c=relaxed/simple;
	bh=bbitXP8vjIAQnUAmUPVuG0QciGBl2u7NpsOLQ0P7qIM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fbvlpC+jU86aH3GV8MIQfWM+jRkN6URJSfMqFiqpu0P7wB5qQsnPzjdZNBbS5aq6IvsCEioZ/bGX3UQF7COgQet0Q3c4V0D4QRpmOmXwEy3wOZeqazPk5XHcoWglnzy3HHIBtu53QChnn32ECSOzVVttehVQsRKZapQHwqQZgD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=efIxnKSf; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="efIxnKSf"
Received: from github.com (hubbernetes-node-b45e4e8.va3-iad.github.net [10.48.175.35])
	by smtp.github.com (Postfix) with ESMTPA id 371B74E0153
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Jul 2025 07:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753628240;
	bh=sjesdgP9BAZOsM/JqulSKCwBCz1Dp4My319H0N89dC8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=efIxnKSfXuST7Qm+joS8JJ3dpbz3U7wnvBWrr/hBe4UkbffP1qBIPOH25hC5kEvBY
	 lQ2Dv7+Q7ghTV9FMeFmgPI2KRaaKZZUhts6a54Cd72l1ZXQzerXUkM3WEZkjiRr6er
	 CkfKQF2VXAlf4XRNIncY7rb8Yipc7FIDSFan7SzI=
Date: Sun, 27 Jul 2025 07:57:20 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/976686/15a4e9-000000@github.com>
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

  Branch: refs/heads/976686
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
