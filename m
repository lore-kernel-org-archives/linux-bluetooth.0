Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E56288A2
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 21:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755553524; cv=none; b=AjVyaZaBdnSVD3RkLuyU8Tr8wBe8GYotBMHD+dTVKBLg9RGbrWg+3abtfGfTCN/V3W7SZtFIoYvEFk6fZziT31SOTizq6VXZXMaxd3tTwiX83qq0+WzzLxaKnUJz0uJ/N69TXEh1rqcFLblpc0/NV2D8ZcAYZI/wjzZUUCSS2V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755553524; c=relaxed/simple;
	bh=vf+7tUwvmjJWwjzG2pvDvwg6zJ8V1uUrW5v4xVRXfZQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jYVgLmK7fsNQGjObEuVCELdUIVHF59ihYn09oZqHD6vlnTjZvYwkoIBxzeaSD/DdzO5Vc2Tn11FoKVXspp1YzTRlb0zQy7uUUUGL2+9TySf2mlcliKVMmtZblP409xRTynFTVN/wTAxnRaWkGOH59bIutv6Zw1wKeQAe9bZ9Cfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mdVk7LnR; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mdVk7LnR"
Received: from github.com (hubbernetes-node-c984409.ash1-iad.github.net [10.56.175.32])
	by smtp.github.com (Postfix) with ESMTPA id D1FD76008D2
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 14:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755553521;
	bh=C9+mBMkxGwE7vjrhgFIsigaWag+IFS6f4dboIDL6/QI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mdVk7LnRt16yTNHfHDWOQMExPt3Hu7ejJNjfZMyZypZI9NSBHSdXo4ckajrpqMoRP
	 SP0JNMTAvRna1NSZ+635XfWRBh6+0UL1NJlQXWk1PwvTpt7PZzoKSzMzsQXRJeMhiB
	 5l+sV3kB6mdcOwMTjG75QZ9PZJw1+vMU38hXWxpk=
Date: Mon, 18 Aug 2025 14:45:21 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/992140/40cdfd-000000@github.com>
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

  Branch: refs/heads/992140
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
