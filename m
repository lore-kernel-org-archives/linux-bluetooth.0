Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FEB34C127
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736286; cv=none; b=gDtSdlV3mxcMFZdJ5c5rmz84l5QnWNsUjhPhHcEoqztQG85FWkerB9c7Ji9YHx+IsKbDbub1S06nlkZQeYUVkvccrW3oT0sVCVHapHwazZdITaH3a2N+OExQ6152RGQ9tVyndxO/jaZRDtg+B1uK9M0awMWlJ/0yXrmKzxBCG3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736286; c=relaxed/simple;
	bh=mbkR5Hw10E9UB+cA7Hk5wNiR1LKZzC2eYQjGdOovpH0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gBGU4bweoBF7lbx0UaVcfMic4TceD5GSqdfiAwrKINI9vy6VTFm9zjyMtuTIW/xvzWh0FOngHar2n57OH82dc38df5fn4OWUINo3izMsVgpKFIF6xMUsz8RniH2FucO46f5d8MZwKU/uz1lQcjVD9ysTliL+J6um1xOddfR03BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OKGi7oHJ; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OKGi7oHJ"
Received: from github.com (hubbernetes-node-5611881.ac4-iad.github.net [10.52.205.57])
	by smtp.github.com (Postfix) with ESMTPA id 69D842110C
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 06:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763736283;
	bh=FvIsmENkJsapBjhOEo0xQWJ5m2gMiKxZwtdTmOewS1I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OKGi7oHJQoVPsdVk2nSpWMJvg8Th5863AWpk9oSCRynZcVSzpmkm7xVZx85HALID0
	 ZhYM86h0aEA+ps4PoomZVaFRB/DoBgfkY7yNt9lXo5FfeCOwpdJNr4eaR7kf0zYWSU
	 2F0ljrNPiO4y5RaiYg2Q9MdG1/c6+jrIHKcFKxxI=
Date: Fri, 21 Nov 2025 06:44:43 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1026231/9dc877-000000@github.com>
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

  Branch: refs/heads/1026231
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
