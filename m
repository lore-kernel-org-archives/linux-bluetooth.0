Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205B2330B02
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764247489; cv=none; b=iQ3fevrK4pnAP6n2G/nztAJOZf3EXx36rKQ9YNoLPWGo42vAYbzJ4G1J5wPH7LkWXOx9RaVXm5EhFyDfTC7iwroRTuJnFKjKGIXasm9lHzgkqkH+Uw9XsYGFR+AgVNlrC44Ao8bYBBIpyrb5heyHT9ul7t34XuHK7SAqytgsm0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764247489; c=relaxed/simple;
	bh=L7LBhedSi5pR3V1wRi9xoWjbjNXp8ZWPBg0Cgc3/pf8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qvZMu2MO/TpDJkDgC9AqX5SFyh5YHHRpjxSdJ1lIJrb92+zcOgUipKe7pDfHxQgtfScUz8garGmlQZMzFLkPIwqi8FRHAqIYmV5/36rwovqB41LoHMPAnyifBatu9BUMRZ2/wlrZIfExrDlJAv2b/6Y1l4XDcyStPra274u4VvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eMKW6pml; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eMKW6pml"
Received: from github.com (hubbernetes-node-74c9c5a.ash1-iad.github.net [10.56.203.44])
	by smtp.github.com (Postfix) with ESMTPA id 489EF600319
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 04:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764247487;
	bh=8idveLmAApkMwyjruHliX9sIHEvxhK403GMh4l6tHf8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eMKW6pmlG4KyjsZeL28rYpGB1oNF/fdZNpSjGLlxfSIZqwjLclmyfNP61DIU6BmoN
	 wCJeJDC1LnKa0oY2akcmas0SDIP3GxccixsFjPE5C54ZeqQ76cL9IBu5t9hV5MPOmQ
	 pO9DMkC7Wmlb/jSz7bAKGNzOlvHuOFWtfJ4H4pek=
Date: Thu, 27 Nov 2025 04:44:47 -0800
From: SebastianForslund <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1028268/000000-8e4816@github.com>
Subject: [bluez/bluez] 8e4816: main: Validate the AdvMon scan parameters
 correctly
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

  Branch: refs/heads/1028268
  Home:   https://github.com/bluez/bluez
  Commit: 8e48160c37c7b7f047108f3af9b6b748284c8fb0
      https://github.com/bluez/bluez/commit/8e48160c37c7b7f047108f3af9b6b748284c8fb0
  Author: Sebastian Forslund <sebastian.david.forslund@gmail.com>
  Date:   2025-11-27 (Thu, 27 Nov 2025)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main: Validate the AdvMon scan parameters correctly

The strings used for validating the main.conf parameters are different
from the ones used to fetch the values. Change the validation strings to
match the code and comment in main.conf.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
