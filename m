Received: from out-43.smtp.github.com (out-43.smtp.github.com [192.30.252.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BFC26056C
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094914; cv=none; b=Pv+mKbzWzDjDW5D363LVMnmpoAolnBxU6DxszFC3zskbF9beYd6+7WjWS8LqtOer20b/6dqKnIFcQhh0OKtF614VILG8Rvc1LDdFW/uso5ilt2+yNWYTAmvwSJy6xwvUiAqAyGiABQYJ02zmf95A92H9CEoPoP/LLQfjCOAuARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094914; c=relaxed/simple;
	bh=bvFmmH+oRjJv8PTqR3kBR9fkjmVKERJ5ROBySZ9Vtlo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=In9Fizq9X81sZSL/Gmo/pRTHOw86rs5S7MZYIeQwwcK8gjmgIw4a/iXNoBV36kkJghcPr3nKbeqGkvH3cHGHZdH9dqhlVVRc8GH7si2613DKPYY0Qt6iQ290EmOvcLsxSISH70nWw3TgCffgeXjqRI+wMVxdr/Iy3ouUJBh1l38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WTOob5Px; arc=none smtp.client-ip=192.30.252.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WTOob5Px"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779094912;
	bh=VVroNVm11+WKvl0crcwmjXucQago8tA6o2gt2tZLrT0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WTOob5PxZ8DyW5luIHK8RQi14zinM14nmYZ+qRvMwrEuQk77l1LH9nnKjvyFNI2zQ
	 l+QqQJD/9hzlj+bEBYAh5XyI7ETvWOn0rvkIPjQIVgaKsCw3vVWE2/cwVo+qgGA6c4
	 iJ88vZWXUz2ifRuCN5Fq/6zrt7I3QfLFvJcgaCug=
Received: from github.com (hubbernetes-node-936873e.ash1-iad.github.net [10.56.151.17])
	by smtp.github.com (Postfix) with ESMTPA id AB47284129A
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 02:01:52 -0700 (PDT)
Date: Mon, 18 May 2026 02:01:52 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1096236/83e927-000000@github.com>
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

  Branch: refs/heads/1096236
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
