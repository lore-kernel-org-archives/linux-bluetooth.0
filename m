Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2279EC2
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731951503; cv=none; b=asY4u7LZSCea5ovaQx1cyL0yWOqjUyEGHowdbPuYy/mWnkZavrUElduH6k/HC/4V6XnA+7HdGwClC/czNyKWF9LcLJ5MMYJhF5Ek8hEPJoiQayYYYn1qV7gU3gv6i4lJUn4TPtspv/DM91zUtljf2rIUzMS5PkAESiF6+qb6sc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731951503; c=relaxed/simple;
	bh=OIQVRhGvXJTkbkTR8vaDPAgcKFAGvRXyBLj4PqrhbQs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=J7Zq67ocGThF0dHNGJ2n8aglNuziPOzCcbeQyzXnHl/sc4rhKAjqvJ2yrlXUK53sRB8F9QwbQ2a4d0jD1NEofbHaBT078we1PAm+7dBNmM/q+MDKaLQT3l03LGGYaiGPZlKTTeMgHTJN7911PJ9Ppk4fNNW4wNPWqBFRmBfplOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BLWuoky3; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BLWuoky3"
Received: from github.com (hubbernetes-node-5067fd6.va3-iad.github.net [10.48.220.41])
	by smtp.github.com (Postfix) with ESMTPA id E7DF6E0445
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 09:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1731951500;
	bh=zyWj0vzX3oH+v8h2x2ks5NQICswAy0EZizQ3AVLvBEw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BLWuoky386m4O4qI90DP/6eS1mTtco33yGZJvQK/IbhqYDAmX0Y8Zcya5NMylF1dj
	 9d1wt6Buhpy3JdCofUrwhzMTXWIUYzTh8h45EOKaZN8L2b63FXpUq7k4JBAdDSPgvK
	 Yyql8LYr2SFNx1RsFZONgdh4jIL6vcM6WMeg95PA=
Date: Mon, 18 Nov 2024 09:38:20 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/95e89c-da0253@github.com>
Subject: [bluez/bluez] f863d0: gatt-client: allow AcquireNotify when
 characterist...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: f863d0116d6271585c2521ff18447c95d95f82fd
      https://github.com/bluez/bluez/commit/f863d0116d6271585c2521ff18447c95d95f82fd
  Author: Benedek Kupper <benedek.kupper@epitome.inc>
  Date:   2024-11-18 (Mon, 18 Nov 2024)

  Changed paths:
    M src/gatt-client.c

  Log Message:
  -----------
  gatt-client: allow AcquireNotify when characteristic has indicate flag

StartNotify / StopNotify already correctly allows usage when the
characteristic indicate is present (simplify this check though),
apply the same to AcquireNotify.

Fixes: https://github.com/bluez/bluez/issues/1022


  Commit: da0253959ec384d8c4ff7c970ce12fb8a95bd052
      https://github.com/bluez/bluez/commit/da0253959ec384d8c4ff7c970ce12fb8a95bd052
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-11-18 (Mon, 18 Nov 2024)

  Changed paths:
    M doc/org.bluez.GattCharacteristic.rst

  Log Message:
  -----------
  org.bluez.GattCharacteristic: Update documentation of AcquireNotify

This updates the documentation of AcquireNotify adding that indicate
flag also allows the usage of AcquireNotify.


Compare: https://github.com/bluez/bluez/compare/95e89cd2e4f8...da0253959ec3

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
