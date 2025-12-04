Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4371398F8E
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Dec 2025 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865502; cv=none; b=rPcY6sMUnbPYfcuIqBTLbOlSetZUYxBrjN1oeZEcjDD0BkUEFi1yZA6LazeqoqE7YiyCnph31MZZf60CuAe0RLJxLcB8M9TZXFct87I7jDXsc+sZSDEtR4r1TmHyypva+NgDJB/g0JBV1e0QDw6HXDC4+/de3sCiOWAa0g8fvS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865502; c=relaxed/simple;
	bh=LDBQaIL2BMJ9e8WLJJRMcTIEIEHnL8m+1xn0Ef6qOHo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MwPRfeQ5JEKgSUJr4urxH8mMMp3dfbAV/9zPa18m8rXS/GLAEII9t86YDOQBH53rIb0WQp4XmNPY9xEPXo42CYzCD/aMj3612Q3TdGn/UzglAKQmiPKo0MbLmjwVCX1sh4Trnh9UbtqwYRZLM5N17qME0sc9rOKtmrKOZDno2SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hF297q9C; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hF297q9C"
Received: from github.com (hubbernetes-node-a1d8989.va3-iad.github.net [10.48.125.35])
	by smtp.github.com (Postfix) with ESMTPA id EA976E036A
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Dec 2025 08:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764865498;
	bh=LHw5uXfOxoLmV757Pu1wf587TDYRPEmGHBaIqDC5gXA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hF297q9CkiUDFeFxFA0EkXrJ1straeFoWpqwuvZMSBjoMs6KoMv4zlpxeSZQ2YTtN
	 cCKdD/x9mLWTc+yaby5P//xfqcZe0wjJGCM7LXiAlVnyURhOeHKM7eF1j6nz2uttgC
	 qfabTmO7x+qEm/obdtQgKICmmJQoEwcgaPTO5ung=
Date: Thu, 04 Dec 2025 08:24:57 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1029860/6f115e-000000@github.com>
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

  Branch: refs/heads/1029860
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
