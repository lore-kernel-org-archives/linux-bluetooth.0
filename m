Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D57D28466C
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 04:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784348255; cv=none; b=tO1+j21fx1tujIXtYtjB9HmiGy3NVLDcEKYeHbhOBaGp2cTWnjYNxtNGIIczYIJB6wT6z8xXyOTP+coNw7X5n7cHABc2Cfywg/bKdfnftQX4anXltbxDSvt/yJEcxaPuhN8/u2ET0KrbFJqG8Rnz9NA5Z40ox28dYNsgAYGf7sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784348255; c=relaxed/simple;
	bh=xkqZ6Mov5D0IUbYGjbrA60Z8F2BekxYWj3V/Dsfomxw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LGUMeV4Dul0fV+z6HOJGypSc7pC5cFXh0ODVqX55oaealEjDSkERKrpV6zf3JFEW9pRrU1xkWjbhj5j9F7YRsipe8le7QK0GB84QfEILqrmwe9a+uYEE6Si16pjXOfFrxsXsfM09x8tJoixkUJW4us6HEzc+SPM9D9Lbniy9Clw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PEDt45KK; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PEDt45KK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784348253;
	bh=6SAH2fmu6pdrC8h7y8/hHpa7sZXjcB11L/WmRapC+0o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PEDt45KKngSylV2yd2KnRwmhk8lis/q2VpnIgpBuQ5Cjv6ARh6y8diBcQhw4Dc2pn
	 yriMVxx075hpwRQxjPaKlByfFIBGmXT98liDdQnW4RePMBpnPegMd0C6V0p3aV9K8x
	 Llyoz9OMCKgAXRyXXtz5oDQs8tXJRbWT/p/j0WKs=
Received: from github.com (hubbernetes-node-55dd8ca.va3-iad.github.net [10.48.66.67])
	by smtp.github.com (Postfix) with ESMTPA id 39B4A28123F
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 21:17:33 -0700 (PDT)
Date: Fri, 17 Jul 2026 21:17:33 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1113188/0b6c6d-000000@github.com>
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

  Branch: refs/heads/1113188
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
