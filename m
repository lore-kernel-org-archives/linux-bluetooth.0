Received: from out-44.smtp.github.com (out-44.smtp.github.com [192.30.252.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90EF384CD1
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613880; cv=none; b=lHVFw65KFunpJNbQA57A6o437A+95xAzc/XwrPw0690tp0PEelcjCyVZoful79/ZkWbZK43sVij2SsWFzDZii6niWT4svK4oRITMTkO9ZoY1a9DydZdlLzprSh9d55NzMDRIebWBlvf9n74OJqwMHJoLhhGMWOLhS9OLarEC4dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613880; c=relaxed/simple;
	bh=Jz9uLpjqOyGFMrc/hF3nArWbdK6LiXETk66YG6AvIfM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hdX62NmoqHqu5m7Wz8/y4RevzyylFOei+228iScByzpzg0j+pYAPJ67nbqumEFX8Ulq2/IocUW5ItSfUp+eYOEoGqxSjWAGJAt5sV60llzBXo8o83aE0iu2moWQKmAUngBPJ52F97spBobFjTcdFFwkHy6LnGXsU6hqvzt0LNak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CEZEhBGe; arc=none smtp.client-ip=192.30.252.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CEZEhBGe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778613879;
	bh=odkJRYsGB2vIlEwErjIHePRh+2aK5Er+SqFyJnJP4Qs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CEZEhBGeZZpJ7S4HfaTWW5ziSg2EfndcycIhkm3do7s5kz1d/N/OTt1TSKKVdiGza
	 JK2MBvYGPnXloQIhZhDVRzO0BbtciPRmrypHcyye/iQMk0FAEbWsClFlvKSr1S6+Rb
	 kT9HEtJISgK8seqjCY/4IeRjpVAbvqcdtb7xnp/U=
Received: from github.com (hubbernetes-node-c0e0cf2.ash1-iad.github.net [10.56.203.92])
	by smtp.github.com (Postfix) with ESMTPA id EBA2C84104E
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 12:24:38 -0700 (PDT)
Date: Tue, 12 May 2026 12:24:38 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1091796/b58ccc-000000@github.com>
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

  Branch: refs/heads/1091796
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
