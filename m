Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B421531C8
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274769; cv=none; b=n6YQ2k92hTifZbtoEuxFSUgYpzUzl+F/AmjpDeDalrbWo0scD2y05vVbjBQ2DofI3zGcu31UPsxF+00DTZVtc1QB5HNiyHve6d2syVl6bVP1lten6r+fCqTxzlBI2hD9YGbN5LEnovw6VHGVYXZwOHNB4ab58O/ynTF3HF43C8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274769; c=relaxed/simple;
	bh=oh95yJPL7GwzYUZTEa6nrt0Qtvbap3kpAKexGQDTbg0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JI/qskqqoJ8GKk2ByIU8MkUoDbCAuzoameVgqao2AnMZathIia36ena/fvegxU3zTTWapPUSdSM8aSSng2oAmOdUBWWsJGp16zN0Rtl1m7WMrfHqX6m3EBY94JbR07uNmB2ZkMLwt9BgB+nPcdHGGj8zkTfMGU534ywwms8kxh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GoIO/KKK; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GoIO/KKK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790274766;
	bh=/lTiaDMjjDNeuIEM0ZTEwuKYoEHb9MP7byIGjKR2R/4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GoIO/KKKTDgikWZuHIr2JLCP35PaBnQLScGG+eZpazOJ9U7geXd7+cnr/Q60KZC2r
	 x4v6EfP/QfIucN1VJrsBLlKq2DvcQ5kvqgtMkHhLin24dP9pnnDMCrddmJpX9Iv3Fw
	 874U6i+qadTp1WV8dMae0oARAF6WuZzrnFHuhwIw=
Received: from github.com (hubbernetes-node-60fc855.ac4-iad.github.net [10.52.148.36])
	by smtp.github.com (Postfix) with ESMTPA id B8086A1261
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 11:32:46 -0700 (PDT)
Date: Thu, 24 Sep 2026 11:32:46 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1172525/b0c89b-000000@github.com>
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

  Branch: refs/heads/1172525
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
