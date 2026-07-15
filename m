Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788C142F70D
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107895; cv=none; b=EQKVVd68oVgZf3fzgZr8/+NY+2NqSK4glBsFojQ8OcFM/B/LZQDyy9xxbYXpK1eX2x59hDWQpWq71wrQyXuzZqq4LG7Un2fowW2hksFkP5ysacfJYqu1/NrgkOxw+MJVvzw22uxI9a1TIa07ZzoT6Fpk6M6nImMMjfWsRg7QsIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107895; c=relaxed/simple;
	bh=AtE7XR8h03blolVnto220it5aSUeCEfWuiDOok6UXOQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PuYPPVNhZYGRfGr+zEC4Q5zO8dTyyvIEJ8F3VVWnXAVZHmAthKyb9g4UXhut1RltBTj1Yluuxje7H2VW969J31aDQ7VkMNyYEWJGXrlDKWxpZo1be17bFryT3rUI7u3wi14v1pGUKGoS5Gjcp6uBeQSFkiMVnmD5yeTEHRwkqzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GwnZDW/1; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GwnZDW/1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784107888;
	bh=o/gWnUyUHY+7UyectQW5bD2hvYfolATe9rboZXG/T3E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GwnZDW/1PjcsmCA61VnXkPdO4GOS2Gz2LZdl7FDQM/ifxs/RxqJVNi5iZuyopdtgy
	 DhrXctAzaSKPYioXZWMHL2bsBAyakg7NoYxLzXZ+Wouk0DoBxHCOugifo8Y7kADs2A
	 HmBTgUwgmgp9+Tb5Gf6yLVLavuJgS8qrXje2OffE=
Received: from github.com (hubbernetes-node-4dcc7e8.va3-iad.github.net [10.48.175.38])
	by smtp.github.com (Postfix) with ESMTPA id E9DA580032A
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 02:31:27 -0700 (PDT)
Date: Wed, 15 Jul 2026 02:31:27 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1127251/76701e-000000@github.com>
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

  Branch: refs/heads/1127251
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
