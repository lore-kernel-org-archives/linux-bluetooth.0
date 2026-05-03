Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F3812D1F1
	for <linux-bluetooth@vger.kernel.org>; Sun,  3 May 2026 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777801301; cv=none; b=uMAKx0CSRvsqxL5OBhh6La2wsv2hJVutPKpnWtDPgjXqUnhB+DjY6wbplZQT3OywVNCQrD6HDAAQD8Bis+t82DjA0gL7k4031oOJOWRx0qArWlJvR5cMb5DTn5h4/ljonh+0VrT1EcZ/Fshb7NAgVG0DhqzrHYOYXytV461yUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777801301; c=relaxed/simple;
	bh=xq/VGTqxMSJcTCqDZYg4KlWLVzieQQW8cUtrbITsEUI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=i5eGx43L2/9nqBoKzjXOwBTxkYpFHMpdePLu/UtH6AmQDzwMYX2KfUYxUxjfjo2saORkMdJ+Z2l6sqiOxx1Yjds1NT8KtMUjfJ/mA+ou7jyl+58KqNDFRIlU0BTp2b2sGvaeFztw6lL+mNyqxdp29i39QwG80TrDDbhkFipwOq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YZOp7oDL; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YZOp7oDL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777801299;
	bh=fftabv1QInOU4hsmwPabbBf+ykK91RoTv59OYm+uD2Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YZOp7oDL2e5Gq4iXLPes6utSuU3Xfy4Bk4Pdrz22RXeHk68xLvKnOAxykeF3bParO
	 E0kRDNKuyClO8DdBMJmyozbbW5i9Ws5FF7O+YgUOJR21txgRtOyuv9U8MGt/dDNCAr
	 Xu28+u/HZXPsn60gJK1P3kdjnELTpkF+eX6m7Twc=
Received: from github.com (hubbernetes-node-f3ae0ea.va3-iad.github.net [10.48.12.48])
	by smtp.github.com (Postfix) with ESMTPA id C37182810D9
	for <linux-bluetooth@vger.kernel.org>; Sun,  3 May 2026 02:41:39 -0700 (PDT)
Date: Sun, 03 May 2026 02:41:39 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1076877/3f0f9a-000000@github.com>
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

  Branch: refs/heads/1076877
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
