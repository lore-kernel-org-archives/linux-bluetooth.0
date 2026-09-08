Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74D456B866
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887885; cv=none; b=ShNwZvyBjEz/+uOohSwhT3mRpqxMbO6VImnbbEesHPBhbQD7g1tHD9al+6Vo0AVuyYAoPxn63JiVpPvEuP6MrLotkVReSx87BDkPtZR9nyfHu283Mpewub+RSzPm97CeByGwSK0/AM4ATl4L4imf8t0QxXi02ibiT4wB9iKBmzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887885; c=relaxed/simple;
	bh=1TeAlk/rKd8xMm4z9CmpZiyfxYd5tLTsX8+xvTZt27w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lg2+gkG81IhIGJmjWwpR6THq5nluhGvgAqlKTLY0IN+0AQ1vpkc0o9fSsQxWTUmBfWJeWwN3kmaGt1FzSi0Ccs23X7lxTaeWwAKGVvBIIHMQBS5jBZFAw+hNto+IU0ZrrPlB/d20V/AZK9T5jRRawVKZXwqWIm/IUgyjlQkR6LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=M5drJUll; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="M5drJUll"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788887882;
	bh=YcKPTX9cnbM1se1uBLHOA8lgpPpx5J8KKtaaZ+EqUSs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=M5drJUllVACbAGW15GsWMdvp3n+1W0ugANDi1UtzY//uX6E3MCjgEUDmDz2fRi/fC
	 AHe6J1UKHI1gwUqNn8LeV0AG3KYWBOqLsuRkcA6YyZ6FeCAdCf8jyGLffpuLQTHCjI
	 MYjp/wJcTwL+SlzEzzNfFisgwBd75udmSnLbDdyE=
Received: from github.com (hubbernetes-node-4dacaa4.ash1-iad.github.net [10.56.183.27])
	by smtp.github.com (Postfix) with ESMTPA id 9FCEA180AA1
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 10:18:02 -0700 (PDT)
Date: Tue, 08 Sep 2026 10:18:02 -0700
From: Jan-Michael Brummer <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1159982/000000-f564a3@github.com>
Subject: [bluez/bluez] f564a3: Add cover art support
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

  Branch: refs/heads/1159982
  Home:   https://github.com/bluez/bluez
  Commit: f564a391812ee22092d379939d4d55ca74a44afa
      https://github.com/bluez/bluez/commit/f564a391812ee22092d379939d4d55ca74a44afa
  Author: Jan-Michael Brummer <jan.brummer@tabos.org>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M Makefile.obexd
    M lib/bluetooth/uuid.h
    A obexd/plugins/bip-avrcp.c
    M obexd/plugins/bluetooth.c
    M obexd/src/obex-priv.h
    M obexd/src/obex.c
    M obexd/src/obex.h
    M profiles/audio/avrcp.c
    M profiles/audio/media.c
    M src/profile.c
    M src/profile.h

  Log Message:
  -----------
  Add cover art support

Add bluetooth cover art support based on the existing code.
Tested with VW head unit and Fairphone 5.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
