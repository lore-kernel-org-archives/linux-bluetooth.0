Received: from out-39.smtp.github.com (out-39.smtp.github.com [192.30.252.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50013ECBE5
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789246761; cv=none; b=gvjbH+Z9DemHUW7HBdD/NLfVIE2zvp/tyViEbeqqhUm46QjdcuVR6buy9Yto36XyuuZEwFK6C4GkMhOAw0WNzNKhb2Q/ArCg2N2ZjKc/kIHv3cncrtH1BCekAPv2+ARJ4iAm4DxakBdBuJyVMnKWwzHPkekqghKHt9Wl+UlFnFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789246761; c=relaxed/simple;
	bh=KgYpEhJ0JpevPh4fkZBONBNkrJojo3/qUz8mvzvgpvs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UV1PJJP1qVuYSpFOKd864yVG+2l4R+5Js6H7JW0ObklWLFJn70tpfj1re+syK8Xv0P0Us8ZWoOp1BHuW0odzSjsixtAh9zSsYggzC+/KD1l813iO+h0SFy3u5gCnch8pLhTBuSvfycztPj6jhoGja1obsUr9Ccg19ZUoZ51B94w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aLq/kDzv; arc=none smtp.client-ip=192.30.252.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aLq/kDzv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789246758;
	bh=t+sipTEtpzbagVbwjjlwoUyBhNLEoPuZQ9fhsw5Pu9M=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aLq/kDzvVxyW/abjgpSdko6qHn7rm7NBYECicYzQNmzVPALyc1yfNbC0SKLh+tT5T
	 HPGXfUc/k6zmT25I+cgUOBYj9UKQfIki0KPt9qJTpQN2ByqxjxX1Ej4ggqTLs+00dl
	 Oh/7sUQMQ4h4U0SL9nqTFsgz8rLuTsjr20LvcqOs=
Received: from github.com (hubbernetes-node-b704772.ash1-iad.github.net [10.56.211.78])
	by smtp.github.com (Postfix) with ESMTPA id 7FF46920734
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 13:59:18 -0700 (PDT)
Date: Sat, 12 Sep 2026 13:59:18 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1162236/86f64a-000000@github.com>
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

  Branch: refs/heads/1162236
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
