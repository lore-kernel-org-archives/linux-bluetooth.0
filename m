Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C392E6CC8
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Nov 2025 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762700249; cv=none; b=YBUjTAli8kNlHgBuxxfJBRXW9OdZyXxKpEvscN5/W5I8WQNY+BlrfvjUORH73hl52nunSdZhAGnz1AZ+72zrNj2Ye/CevZYt+UJ4Y9OLkpt0Bu83+eeSvsnyq+FZcpNgYkSZ2VIei0nenPSohmIQz8io342GL6zHn3jHyvOvL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762700249; c=relaxed/simple;
	bh=evVp2kWMdRbr/9tsN8BiQVbzBch0OS4QjLzsH60NaYE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HGUlEdoy9vo1O49JIFh9sSJ0js5NEwfa+ALl4xmySTxKr0+SdWfsD9B6BjxwDpr+LBUrqWTCtO74Ob2seE76wRmxvXvo9SyDyWvjLRRpt7RiyxIcG1GtnKkoiZrp2msQlNI8qilluk2gJalHFzlNzbbIK6xtObyPHfFjCyFgr3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=h81W2ztY; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="h81W2ztY"
Received: from github.com (hubbernetes-node-457d05d.ash1-iad.github.net [10.56.158.56])
	by smtp.github.com (Postfix) with ESMTPA id 5DC5E140190
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Nov 2025 06:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762700247;
	bh=hekfRURsMeusPaHr0E2N+m3RYoRoRYGP6rrUBbQNxb8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=h81W2ztY9F+sf3Zfxlm2xkez9RxMyxYPQEaVswnQ/s3o4QF8s9Gm0xCW5Z2cMmhBw
	 euRDNfpdXN9hUQzh7bBgVbGRBDW4XllUpbHO8bptx07pZgynqi3kUoAuJ1FJqpcx/F
	 1jmbopS9u9LcwrCJAzcjYasc6iJ/mnASM1HzENHU=
Date: Sun, 09 Nov 2025 06:57:27 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1010113/a0533d-000000@github.com>
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

  Branch: refs/heads/1010113
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
