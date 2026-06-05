Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9302039150B
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2026 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680686; cv=none; b=NAeceIednFTiy5eDTsfcHXrL++UtQDC45eLoT5gF1gd8caG02cKgJ1BtzgsXIVW1WbN8YMBt+ceultLNwu21QMjcfIDlZcHBxmzDuxV/82q9uL2TmHaKwjpVbZwbl2dZgMbC9A4Rhrk7ZOjzvmmUPveJyxhMlSqOGiGJb/aS8Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680686; c=relaxed/simple;
	bh=OAbpYbroLfqeHXWazmRZ/6OxgzmOph4EBBeuJt8VqC0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=c65l4G5HAKqloVfUXz9p1h3C8Keb9JY3xnMRfkeowhVqyD74oukVRQl3N9t2uIs3GZv7sMWoyBLavFOW642XdS5rjg22msTfCaumbA/4byQyxecRyBolF3FQN/fplaFZ6bqssej0rEWenCDDRWRPMxX5JF1Chbtpj35IQJ9ds90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lUbN8hNH; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lUbN8hNH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780680680;
	bh=sNqMgoJLxQN+CYoq0aXah7pqrHo9kQHmt66lUI5L/34=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lUbN8hNH5ryz5fZl1Z/pZ/N9GyRtkO7QwyVBwnHX0ID0xID1qYXVbAG9Li4d8NCy/
	 ey1+S0td4k78wQKoFhaKRFdqjFpqgFN6C2hJWxDGJBNeQdpzs4z0Og//Ehu3Uq/asY
	 OYYj6KBm9L0LwZcdP+xfupS8ZHo0OeQx+L0EiRlo=
Received: from github.com (hubbernetes-node-6b14089.ash1-iad.github.net [10.56.76.36])
	by smtp.github.com (Postfix) with ESMTPA id AEC0B6010D8
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2026 10:31:20 -0700 (PDT)
Date: Fri, 05 Jun 2026 10:31:20 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1099150/f00fac-000000@github.com>
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

  Branch: refs/heads/1099150
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
