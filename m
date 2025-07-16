Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B7621A445
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752674475; cv=none; b=F7chPnkKuO5v/L/1IlrZvuImaYmQg+J7yqSCWlB4YLTL1da7E2J3H1q7BdE68qEn91ZZ+K6GL7gHiRZpO+6Y+yt1D1UdZ1L6EhgwYo65yM9hlsasWjckI+OgZLXU6FA8x70rewsOOC4SsX+1BVYFbOy13yxz/3aPTLoKN6UJZ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752674475; c=relaxed/simple;
	bh=nkqkoVmiW/ui4417bg13nEjSM2WaPgcW5HMad4G9XYA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pK0RFDMkqb3E6n40lPORuCTm0Mgc304JwwwMJjXpugC1JBf6W1J+odfqGi9jxVC9lTmHfuTtMqRRvJSiyUwhzPx3T3uil6ikPblK8yKf6SFgrJqLRXAO/PkLnJmBDaM0KiJsPl2fOFdaONt9BZNeFRx/tnLc5+lyvW95lRyenaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eUCQ/OY1; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eUCQ/OY1"
Received: from github.com (hubbernetes-node-cf66bc1.ash1-iad.github.net [10.56.172.15])
	by smtp.github.com (Postfix) with ESMTPA id 0C86314126A
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 07:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752674473;
	bh=I+89vEkUCYZJdkYuIVK4wS8W0ea+OEbJMv9HUv4/sUE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eUCQ/OY19cfGWdeBkJV3xIzqF2mTlcL3v8UOR9DHmR0s0VbdFQkFkh5Vro9xFLq/R
	 mpAHRqMLCzVM2XbUzVi6yaw/MTIO3y8tdbllnp53EAVTKjfaEf9tWVYzV7VgOIhXLY
	 Iow4CrAGCno3P+oPlFLZgK8ozcKS2JyxBNqwoqSQ=
Date: Wed, 16 Jul 2025 07:01:13 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/972538/a6939d-000000@github.com>
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

  Branch: refs/heads/972538
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
