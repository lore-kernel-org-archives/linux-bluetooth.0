Received: from out-7.smtp.github.com (out-7.smtp.github.com [192.30.252.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC7B393DFF
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943021; cv=none; b=HrVzYAsa0rEtBLOwzKYOJi6XqKMQRqxCsan4VsTS041dIdV0At/JPxz2+tuJDICTJnltD627/CEqAYArYE+mSqTgw1q8FRupfMNGwRXStJkSEvW2QS9efkBYhA/quEXK23Tj60ctnscmm6tKdQRsjhlw9DV/UZv3U4ZLp8mwxg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943021; c=relaxed/simple;
	bh=DvrNSznRxUVsVyrWY2eq4t3dlP6csuvdgzc0xHegg1g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BSlcy2/5KgJm16aYcKpMU8WRcsJiyOkONjEt2f03oLPzL1Bp7nNmwnk2JIbIOLt40paGoQEqQvBxeYGktXT9Uf2Mr8KhBoTn04aDgz2LeHzPpAvASKMYBZxsbXEjfv9bD44ItKoOVgxZTL7JoeqLXqNbiVZjZ4WttoFSmt/lw4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SWGIxxkv; arc=none smtp.client-ip=192.30.252.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SWGIxxkv"
Received: from github.com (hubbernetes-node-bee1b51.va3-iad.github.net [10.48.130.45])
	by smtp.github.com (Postfix) with ESMTPA id D53429010DB
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 10:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773943018;
	bh=Xq9SwTCKcl+GduEwu3JzwRrKxRE3CGbi0n3+3QImAyI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SWGIxxkvi5aKUqDL9ytdnNvhan2pCv4QVqsv0mG8xn5itFWI8Yi49nbqcqnLpV24Y
	 kQv3G5XcxzN0nYBYp8pvShQ4AmhO9IvHsyMA1UZC+MqP5sQerhX6GcvZ9tiTX8XwX/
	 imFTqPLJZ5o2rYGQaYDcPzFuVKB+CgsveGVIwLj0=
Date: Thu, 19 Mar 2026 10:56:58 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1069318/183f1a-000000@github.com>
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

  Branch: refs/heads/1069318
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
