Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DD035F5EC
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055977; cv=none; b=q4AqkCS40kNG59FTQWebG00daTylaRw/oKq5XXs27fYKQi82si43jDfjQ+2Fvte9IfODRTbKE12zUIqvRPj9UV1l/4vZ49MeywyWVhORyNXFKta+S3NxvLyA/lwjzqJGzlMJNnbGXW4vFQwvAa4/xRqqPJkOT518VA2azv1XrC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055977; c=relaxed/simple;
	bh=o7t6uNxztten+A8XG2CsErSmx9I6AeLunE8YzdYATbM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PLRkxW001Dpx51R9oU2z+vY5+TruHZ6WekpeQ31f5owuE45MOjDHPPFZwrxHoSYJ/YdU+lyGbTZrbPz4PLpWKkDSta8wbUx4LU7GZjQLt2YEK/U4QJyKeW777Gpbq6Q+ibN+AqK5mviAcuB6F8z9XAqDL6b0ZEZ2FrwU05njSoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Z3Rud84T; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Z3Rud84T"
Received: from github.com (hubbernetes-node-f6856e9.ac4-iad.github.net [10.52.220.71])
	by smtp.github.com (Postfix) with ESMTPA id 66F5E401270
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 08:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775055975;
	bh=0//3hoNrPev9sCMcesURh5I158ArVePpHAny9mw6PaU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Z3Rud84T20MDM2Q3fFxL7esO9cR4Bv2mTwKFExRGTyLUQEh5R+llBBa4U9zIObidP
	 ttOLVPgbtrOh2Fexfj6mziQITC4bVuf6E/7/LyEqYmScbKATJCEUCrbZ57akKoMEDG
	 +1ww7sTs0rTonfU2BlME9hGei4scEC8dQk8fAuXM=
Date: Wed, 01 Apr 2026 08:06:15 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1075787/550632-000000@github.com>
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

  Branch: refs/heads/1075787
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
