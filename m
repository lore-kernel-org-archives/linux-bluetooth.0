Received: from out-37.smtp.github.com (out-37.smtp.github.com [192.30.252.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190C333BBC5
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Apr 2026 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775306480; cv=none; b=j+ZUM/Ld9Oi+x31BdwqXeTTu5Sk82VSGvbnMfMeh4oiuqO9j4nCcu3gAWQ9++Pw4UKKoFzGuR6jgM2EIOthgmXK2ubZEE9W0JiSWKh97hWyTpI0znAXuEE+eeZvSQqni1qXFRU/P+zR7DawVxH0ojNwToZVFyC0oBLOnmRwLmOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775306480; c=relaxed/simple;
	bh=mcZe+01m70ZmQHvG67417j6WQh2ZH0zHBKDbN14SfQw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IM6sQqPCyo7CRx3y/O34799HReAMWeL0Zj3Lnm++ou2P3ZfciLVrBZiLZCAGaaSQBI5I8TBfhpPipEczw9wQhuIPtT3I/rS5+XHSArvUCOOb4D8/bjUSP91w/161Sma8ZforqJ6eUx8SvV61n1PrsW8Rxu4b3So7usApqGq+u+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Gcu4mdeU; arc=none smtp.client-ip=192.30.252.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Gcu4mdeU"
Received: from github.com (hubbernetes-node-023bc09.ash1-iad.github.net [10.56.128.29])
	by smtp.github.com (Postfix) with ESMTPA id 4DCF286005B
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Apr 2026 05:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775306477;
	bh=1WGsiZzQDXkK5az0tNWxygJYYmd1kewgQA+fEHW+QQA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Gcu4mdeU51G1nNXhr2xyv+qGsD7bMSWYY5v0/5mFcA87aKQSyvH0aOlPiYPPohpBR
	 glV2UAw7idZB9+DIwcXXZTWQL/+I8C7sb34etnJxBg5Ok/bYds/yNR/aafBKcF10mH
	 /ECtq0k7Pk4Li4FlwgRFkoGzh/yz+rGPP1ODIf2k=
Date: Sat, 04 Apr 2026 05:41:17 -0700
From: Marek Czerski <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1077281/000000-075831@github.com>
Subject: [bluez/bluez] 075831: sixaxis: DS4: use 0x12 cmd to get device bdaddr
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

  Branch: refs/heads/1077281
  Home:   https://github.com/bluez/bluez
  Commit: 0758318bcd1683a3c10f3256b616b6fdfaa8bc3f
      https://github.com/bluez/bluez/commit/0758318bcd1683a3c10f3256b616b6fdfaa8bc3f
  Author: Marek Czerski <ma.czerski@gmail.com>
  Date:   2026-04-04 (Sat, 04 Apr 2026)

  Changed paths:
    M plugins/sixaxis.c

  Log Message:
  -----------
  sixaxis: DS4: use 0x12 cmd to get device bdaddr

This change is required for Esperanza EGG109k ps controller clone.
EGG109k looks like PS3 controller but presents itself to the system
as PS4 controller. It does not respond to 0x81 command.
Command 0x12 contains both the device mac address as well as
configured host mac address, so it can be used to query
both. Kernel driver also uses 0x12 command for that.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
