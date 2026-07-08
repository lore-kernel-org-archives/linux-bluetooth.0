Received: from out-31.smtp.github.com (out-31.smtp.github.com [192.30.252.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17925432BF3
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 10:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507764; cv=none; b=MP8BGBYB5DT4EcIU4yx1fp1OnJO3yALNkmNZ58OfDklPB4yB4vQK3D/hxnJ8dZch7WmK0RFXaR6uMCQIC2V2DlpoDFO3bB/iKB0VNtfS9Wr0YispJjar2Tzkxk5m6gFDWwoBjSvntnOpI5RvJF3ogv+Q+T6CoEdYqsTyljISvW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507764; c=relaxed/simple;
	bh=+4WSDGTHyvLEBemMzpzg8k4EFuYfPPVuddmIUEccSx4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=U+ahTDeX6dB/95/P4Yle1LyHe45YCF4rHeNhl0iWg/L3SgGlOhicesbpGBLk7QUsyc5T6sGUxGVhmXWgrljQ6QDVoj+kcuOgJqiRdWlYilsO6FLj1c8ENhAw2XG0ouVL25tutQr/f1G9i8szFTSk2ZyX3X0q8ACMa1eXkLi7EVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fSd8DnW9; arc=none smtp.client-ip=192.30.252.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fSd8DnW9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783507751;
	bh=Whb113IzWgSUAl4HI6PPc5OL3WXo+BRsIjtJ96gljp0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fSd8DnW9A4VBB7/9DYUsgCRZYRJn5kS3OsBasa1poENExN+4P3AwW2XWot5XM9b5f
	 DzSxBpFWJgL7f//zePew62tPM9pQMmJwkuKYXsLzx7FzG08r385n2jQIiSOw5WP4J6
	 JWYtRtFeberhDCpMa0CTCUozl5KNG8ZUlkNsBvdo=
Received: from github.com (hubbernetes-node-6e94e5f.ac4-iad.github.net [10.52.183.59])
	by smtp.github.com (Postfix) with ESMTPA id 43E8032111F
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 03:49:11 -0700 (PDT)
Date: Wed, 08 Jul 2026 03:49:11 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1107612/671363-000000@github.com>
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

  Branch: refs/heads/1107612
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
