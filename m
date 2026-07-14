Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8E6371D1F
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026704; cv=none; b=hZMIknun17FMdk/AZ5023J8U9S1gCnYJGqZydJYhZ3wHdKn26UcTbp6ioKY5kXIwtG4dBlswWByNL1zHV/nB/9Od1y3jWgl8cFG8IDLSExhBVazPl3+D5AvqqOnxnCA2LAkVBDE4Rce5tbY+a0gL8SUwhLB1gdHV/xsv1xYFjMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026704; c=relaxed/simple;
	bh=2tE7kR8NyuGBaQkPAmOxzMeeCXqvmopDa926Ujidv2k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XEg+kA+snWm9lG4CvD6JUZ1GAPWRp01qzXI8ENnP2VpO7FKyzWyp8s6zy7xpYZXnxFdCZ6dy5cMBqF6FMol08QPOvQ8pdTO0jdA1ulki+Uac7lGAE4kNnIswLf0R+9IsbdhU8yXGdpjcLMUqJKnCGkAGWshnQ/lhwgeVmLaDeW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=K5ql6iJt; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="K5ql6iJt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784026703;
	bh=lEdMYphkWAyfmD8kVqQiwmE3u/qfyo0HzU6xSd0h2iA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=K5ql6iJtg1STv/djj2eDX9iRVaL8R3w7amOhGskLIFVq4DEA7+Jt2ZKtm/9dSBzQG
	 4acl0KUsEIvWueJT2XxtQ9Koic6Qg5x9dB+MFHokdWancnEOJNv9RtV3jcXv2YH6ux
	 SVniyvXMFhNtyDrx3uLfdGJ4lDloeBB29c6qW3UA=
Received: from github.com (hubbernetes-node-2997083.ash1-iad.github.net [10.56.78.22])
	by smtp.github.com (Postfix) with ESMTPA id ED2F636105F
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 03:58:22 -0700 (PDT)
Date: Tue, 14 Jul 2026 03:58:22 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1111255/062379-000000@github.com>
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

  Branch: refs/heads/1111255
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
