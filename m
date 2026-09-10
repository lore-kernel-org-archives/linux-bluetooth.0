Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCFE48383C
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062595; cv=none; b=GtPn9OsuYFtDsP7mi46lEtcIZygu26m3Je4M9Qk5UPOuHFtPvGABybY7QvtwX0Z9GwbmWVda0bQIElQf7pPJE4n5ngXI8kZN9UCnkMdnjaLufMK8QboFkfoeogiZOUij1uHsltc4QzCXbzLVqATzkuyKwPuCAk9Q3IIFEp8NeSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062595; c=relaxed/simple;
	bh=WfI4xbMxSWXP/p9hjSshlxcu+u341bRoQx5i2fXMWrw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uIqC5hsOVKeH5nkVEpFEo/nE1W+hUxyz3eMBbW05TgDkAND2koT1C22RlGRWgXHU9o71vZK6v3aBf4/COHgRpYSj1usx3iLTKx5IyeRHc1zFUmHpCLYk114ojnsvDqMyHwCU/6ZZmVta9taFyVKdoAQW9iXvQByUEERbZ80P8ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YmeRdEz6; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YmeRdEz6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789062588;
	bh=cdslgU08vUp5tjqCTV+toxd31amQn+P6o3BLnt/qxmo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YmeRdEz6eR8Pzs5PIdWBhZ0McIVkQPSVMgRsuAZzP0MktH8ba4xC0OZr8kVNkTmNS
	 0SIqoVaPn1pN2E5ldWjVkW9HNFHJjxft6cBkcjVskpq5c/WYMo8Uzelho60Y03w9UG
	 oZFPShs5BWIzteFOQc6iLiyDUo/OgNhb7QsxfcvU=
Received: from github.com (hubbernetes-node-adc5e41.va3-iad.github.net [10.48.69.82])
	by smtp.github.com (Postfix) with ESMTPA id E5850800ABF
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 10:49:48 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:49:48 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/action-ci/push/refs/heads/main/2857bb-436a7d@github.com>
Subject: [bluez/action-ci] 436a7d: email: compose a new message for each email
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

  Branch: refs/heads/main
  Home:   https://github.com/bluez/action-ci
  Commit: 436a7d6111155e0fe21fde8b7b3c6644675ae2b7
      https://github.com/bluez/action-ci/commit/436a7d6111155e0fe21fde8b7b3c6644675ae2b7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M libs/email.py

  Log Message:
  -----------
  email: compose a new message for each email

The same EmailTool instance is used for every email of a run, but compose()
kept adding the headers to the same message object, so the second email
carried two From/To/Subject headers and Gmail rejected it:

  550 5.7.1 This message is not RFC 5322 compliant. There are multiple To
  headers.

Start from a new message in compose(). While at it, don't let quit() throw
on a connection the server has already dropped, which made the failure
escape send() and abort the whole run, and drop the leftover asyncio
import.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/action-ci/settings/notifications
