Received: from out-43.smtp.github.com (out-43.smtp.github.com [192.30.252.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D3B175A66
	for <linux-bluetooth@vger.kernel.org>; Sun,  3 May 2026 10:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777804553; cv=none; b=HG3F7LG0bFaklpEzK6RRhgBjZf0aQxusHQyuQ2gPazrZI7JKW1h3luPDTUYFVWC3ubscCzox8swtpiP2B9RoFskzwUqXCjVMzzNmaxUvjPBV1+cX20qIJQnt8ENv/3ndTsUI9w0viAvM463lXF7A2HRjkojzkk+9RULsWrTp3Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777804553; c=relaxed/simple;
	bh=bpKsW6RAX7kRVsd5CpY86HicXf+IRNOexLBA9yiobAQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Uk/L1NsUTTMsfeTiZFV6iCgaUP/VLdXuECiW8ldu35S9wF4lqbCpe/9AzZYX+3hABkMqHybOUTVpnQ+w2O27zetJnnMQ43BWuyxjyGIIQGlyGmEeh2NZD7eXyteplar7p1oTBumkL0oxGEl3XwLuHmZVPPDrfWC2CpI7OFFUwV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Pvp9h3an; arc=none smtp.client-ip=192.30.252.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Pvp9h3an"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777804551;
	bh=3eNnhI0mIXN9oKqWsSPbkfnVYgFetBpOibJ3TQI/ke4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Pvp9h3ano63TsQD8RWC1DCu9IZ2v7qMAKlaRhZQDoBbG+Rq13ZnJj7BzSCw1uMIY1
	 bezbWz0AiXDz806RQOtiWjCU1uQPYCYkyEmsC8SgcN+C0Jy1N6ZwY3frG7VjOLPYaz
	 EFJV6aXyJmxysRwDNBvrGjwEWvZLX1T9WFR+yQ9A=
Received: from github.com (hubbernetes-node-96a5e0e.ash1-iad.github.net [10.56.226.43])
	by smtp.github.com (Postfix) with ESMTPA id A2C5F8410B3
	for <linux-bluetooth@vger.kernel.org>; Sun,  3 May 2026 03:35:51 -0700 (PDT)
Date: Sun, 03 May 2026 03:35:51 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1076884/275d48-000000@github.com>
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

  Branch: refs/heads/1076884
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
