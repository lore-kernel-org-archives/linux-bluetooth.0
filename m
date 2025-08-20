Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C96299AB3
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755705455; cv=none; b=VenaTE7KWCF0H5Qggqdq4tHeHPV2K4Clo4qvh0EquhW5ebHMoApbx5aD8FEtKBynRbJNHXZBWdFQQamnNkG9KG0p5vejPwd3RNpvfGUZ8DcfQwXWP3WfQ1Tt1LrwjbL++Ap7sCZ/qtF2Iq8M8tZM3AUcyok18QNM0vA3bYPWWx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755705455; c=relaxed/simple;
	bh=WbJuEYKq4rAqzwZGzVKo/m0DWIGZyJ2LywhsQkHGCuk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=QRYZS0JBKWp1F1c6yLWaCn6tSNxMcDqBSmWbqyYv3dl5HYeci4gUCHGetJaC59ZR2/0uUx3QzC4YBFLzzppoA2ZoWsZOEjQx3dG+sm9EyQ1es3f4Ku/FKYKfRkjzql0CYmB8ipZajJ2uXSZWq4RG/JwR4tIFO8jiKjddg3nzeV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ay9KR2Ta; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ay9KR2Ta"
Received: from github.com (hubbernetes-node-f7a2b96.ac4-iad.github.net [10.52.180.46])
	by smtp.github.com (Postfix) with ESMTPA id CE51964044E
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 08:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755705452;
	bh=Jj+XUsRxfL3ORvqzwZjWXdwo0M4jlfbVKFLKhf03hlI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ay9KR2Tab/Ftv4rYTpAAltFWo/rKLGhgrkr6orol0hjrnkcdX81pWlsIcERpJlsmA
	 c8lZ8/lsg6AbLPIVy/znmRNtSd7q4bOkmpSAyuDNayHO1TtSyP71oNWBVnC3B6Mpu1
	 cLkarCFIHX070Bho6LRMAlpQy139z5cv4ImUyx6M=
Date: Wed, 20 Aug 2025 08:57:32 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/984366/3be9f5-000000@github.com>
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

  Branch: refs/heads/984366
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
