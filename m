Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E97F559CAC
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 19:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788897403; cv=none; b=KJXOoC5lVtpy5TYvJx3xz4cbV3a8tjQEwPZdfUSBeK9TDS5MDJH8vt5Xkt8KXTX8iaaHaCJwc+FMNCkz4mOmT1T+nPWFL7uRv03b0HFiOcR+h+w6HfJAv6Lqv3c/lfe4A06IhsssQXSp7a4pMb3v/nly4bgpE0KdaMPBCNFDB9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788897403; c=relaxed/simple;
	bh=sKHAJYuwaGd2UhEzPcYE1m0an9AzJ5NM94kRNJY+q4g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iB1OYgZwvF+bIglB8me4VwBfKffR9ReDSZKRFgNsbs8fDJ8ZgWQ0EFAtBlyzAqWqfgEpZrJbbgoWuP03tFpWiNlbqZlD3qNSjdchR3UubRJ053Js0YdM57DHhxunJSM3E1D/Bg400XRqXX0MfIG4faHy9ryEoNvTFUfR4Ts5jxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gmw8iPQf; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gmw8iPQf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788897401;
	bh=3sLcOAochlZLt5Ul/sHgeyl0TwPae+KWH3l27tizSOk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gmw8iPQf97qVc6A8w1Pt3FQV9aqfOXGVCbbn7LuT3fGubNkfgFT7WLLInBXJshNLj
	 uwaZOzKE+/usbvSgXsC7Cf/QOrMNHE+3Ijv2ppd+9pnkMyICVeEoB0d911LsBKdoNJ
	 QXmaLFb5wMyRGY9vwRoxGxnG3HnqGPeRNIvNVceI=
Received: from github.com (hubbernetes-node-0969373.ac4-iad.github.net [10.52.13.42])
	by smtp.github.com (Postfix) with ESMTPA id 4BE2FA0353
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 12:56:41 -0700 (PDT)
Date: Tue, 08 Sep 2026 12:56:41 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1158120/ac2d23-000000@github.com>
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

  Branch: refs/heads/1158120
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
