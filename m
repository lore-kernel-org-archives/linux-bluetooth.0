Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57243BD622
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810687; cv=none; b=YcyxZPpfn1BIYuScsdb47EGdronOMvERTAnMrK67Orjsj7MzQblBJ9Alo6pNe5i7A8hWZMabngi3bKemrfkBfx6jQ1FtmVzxFxoXoDkejyU/m4ooRdW/MjHUPSMpBjqpij5PRy5xx12o8slg7PjnZR2YyWICPjIDY/RaFtSVvnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810687; c=relaxed/simple;
	bh=EC6YnHMmJvUijo5U65GNSvku6xgp27SaQ7AIHzhpSQ0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LqhuPQvB5+k4VGPn90yUQ4dHCAJv5G5gwogdCMTpmZqc0rsR0+V3f8RtVB+bz5xO9SfTtumVxyZRCCi3Pcnz2c24KlP1Covp4DUm8rhGBb6XzKR6qelYxIoGb9mH7/1UZhqmToJrPZJgxsbQdw1Dc+vYJHdiUorWPcDWX7mKH1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RLRXCW+l; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RLRXCW+l"
Received: from github.com (hubbernetes-node-67576cb.ac4-iad.github.net [10.52.13.75])
	by smtp.github.com (Postfix) with ESMTPA id AD60A301184
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 07:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772810679;
	bh=jrXKLbYTJ6oQpkLjDzA7q/FriYcn/0DpTfeJlHf2a90=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RLRXCW+lzP/0Vi+lweF9nwh6qhMok7NWYKx5qn8/GNCzQuefiiJD7G2q6OffSBxIN
	 NaTEuJnAByCOaBkhBvOV5E61WpBnV7pUoOM8jpv43hMA4vsrCCkpMax3kfhvWNxlQd
	 Wia5yxixtV+JEUZEdzt3AO4Kqe/1aQUDEu0XaVuI=
Date: Fri, 06 Mar 2026 07:24:39 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1055133/3890e9-000000@github.com>
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

  Branch: refs/heads/1055133
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
