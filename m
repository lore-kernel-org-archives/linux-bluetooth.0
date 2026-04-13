Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9343619ADA4
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776110080; cv=none; b=M6/TutR72roKtYHUkN0hqwd3Ka3nrxWQXpeWB7AwBQoK2hTH7UF7UBCvowZIGeLwt12anWyWM8ePVdScGuFRGJ21hwAr5RHpsAvRgWSU+TbFmqormiR1Db0eVNeoj/6cX829FSwaNx4iKG3iLuXMOBSFlC3hzVGBQRLZKalyNBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776110080; c=relaxed/simple;
	bh=YSioBfbL8kN++HovAZ0fSWhQdZ4ZCMgQHHZcBrVPuj8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BTD4aymt8+JGTan2zsvYo7wxCEr8hXVbjozh3Xg3JeUbhP/JNwd/SRFs5YPewcYnmn8FrFOFHL5InVfWi4y6iGf8AAECIMgIO4YjNo8/cXtkeCWLztCs0Jgrp1nFxR24wJC/KJd+pE0CaW0LPIyUueI7DHSs/CL59T33Ikqrnbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=f75o8ihe; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="f75o8ihe"
Received: from github.com (hubbernetes-node-8378db4.va3-iad.github.net [10.48.124.21])
	by smtp.github.com (Postfix) with ESMTPA id CAC2C1C06E3
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 12:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776110078;
	bh=hiW0BBKj8jbElUTSdf4xYlDgdwyfVmCzR4niOSO3olM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=f75o8iheQWCZCrgaY59kAtkor2Uy7LudzgfyWxbZyYLAHq+GmllhSOcy44VyWTKZx
	 ab3uGncEeKw3nE39lJDlFxpc7DU8twsUzRQw5AJlJOd7fp/Z+6JUD1JjyZH4eTQrG7
	 N9DzUkPB7lefkab8I4a0i0MiU5lWbMTfNuUvkDyI=
Date: Mon, 13 Apr 2026 12:54:38 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1080516/fe6f51-000000@github.com>
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

  Branch: refs/heads/1080516
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
