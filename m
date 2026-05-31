Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F223655E7
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780223713; cv=none; b=cvm6evGi07J+iSZBoS8B5XbMMCveL9GQ83SR0AzlM8UbN3WsJC1QzEjbNBFhzG3ANNYT1iWGNiTuzuJ5jyQWFWOJjt4p/jgrc1dkWiXenbD3eSUr7R7nXhGZ4Jg4KYcjim9haDNAWALmsWzBPpmSsmpNBiLGKQIzM+DTS67742I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780223713; c=relaxed/simple;
	bh=A/bNg2bbDlP0YD57FUsMmfc5bYcfR0xfQkEYQDvnrfU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uJxv9bQQfjMKwOAKG556dk/1UcSvQw4OIkYtnivBxFZGRDNUZQGTIos2MH15eJkF+djRyX+qEYJOQPfGZ4ovOMzlljbfEzq9MG4wd7lq8ebYsJ6wopcTMqWkZqmRcoVEjnryMBctOOQaLM0XxDFjB+J0SGRMETprc1SapPg8/8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FGg9C9C3; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FGg9C9C3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780223711;
	bh=GZ+rrs3Wu1sVs8zWLPDsfDBRJSdqZqvC4f14Qm/CTFs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FGg9C9C3NIsE96vCbiiHlBlZNFVgC7MrmPMjjUECxrsa1OU5RjzmeB/qZvCsh67Gk
	 kewUjRdx71+6bk/11/1g6bxIGInjEacFE3QEajJ/4gKmaLSe0/R849wFh/Mglf6QaT
	 vylGhA8ujd6VXLat5qtupv6ASjz6DoangTeNrmhM=
Received: from github.com (hubbernetes-node-4183ed3.va3-iad.github.net [10.48.221.73])
	by smtp.github.com (Postfix) with ESMTPA id E489D501035
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 03:35:11 -0700 (PDT)
Date: Sun, 31 May 2026 03:35:11 -0700
From: mdzik-sue <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1103543/000000-c8e847@github.com>
Subject: [bluez/bluez] 365197: advertising: add property with advertisement
 Instance
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

  Branch: refs/heads/1103543
  Home:   https://github.com/bluez/bluez
  Commit: 3651970e944775553e3cf9d08094c93ea7fe24a7
      https://github.com/bluez/bluez/commit/3651970e944775553e3cf9d08094c93ea7fe24a7
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2026-05-31 (Sun, 31 May 2026)

  Changed paths:
    M doc/org.bluez.LEAdvertisement.rst
    M src/advertising.c

  Log Message:
  -----------
  advertising: add property with advertisement Instance

Instance is an internal value, but it must be exposed to client app if
client app wants to use a advertisement in BAP broadcast.


  Commit: c8e847f563925610f7642c63662f201ca0dc239f
      https://github.com/bluez/bluez/commit/c8e847f563925610f7642c63662f201ca0dc239f
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2026-05-31 (Sun, 31 May 2026)

  Changed paths:
    M client/advertising.c
    M client/advertising.h
    M client/main.c

  Log Message:
  -----------
  client: add advertisement instance support


Compare: https://github.com/bluez/bluez/compare/3651970e9447%5E...c8e847f56392

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
