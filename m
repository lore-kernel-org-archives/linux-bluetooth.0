Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB143242930
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 20:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754945250; cv=none; b=OKLp2ctX+yOtkhFaAtmmPUiaLiMFkIf5C3d1tdfRAIHrCyzsgmA0XZsWrCGcBsUGTlHYmh0Z4ZCGoXX3Z/c8pkTzWgCExXIkVbICl3xXiLO5nnfUBHrQLNvHiA2slT2Kgp3nc1nWjZKvBl7Jhxsq/7kM1PldGvBV8NQVcG8sC8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754945250; c=relaxed/simple;
	bh=1CJ8YvyR7wUDzoLMAgi/46q8JWahK5tzL2mvHQvY2eY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=J+n8HX52aBk0TMOUdbho1FzIdBaS0vYy4f9jIF+KoLvvlf3Rxj8R04dNju5aE4H45HUX5d7MfgrwrlB+0bdTbrwCvEjMauCIDq1O3ySm3/LvFKDCnm5uk5QMIglT3AD4vTFy3ZzV0d9XqfbHiIu5ujIzu7SMDHidvvANvKsvX+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=D37oQT5O; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="D37oQT5O"
Received: from github.com (hubbernetes-node-95900f9.ac4-iad.github.net [10.52.175.52])
	by smtp.github.com (Postfix) with ESMTPA id 017FF20BC8
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 13:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754945248;
	bh=3u3T96wzvbYTN0O2jP/ANIz2uZDhegul+2uBSn7+vZc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=D37oQT5OyupEaVzeDF94zFW9RJKW7R0GcL/r8auyZJ9teEvvmlUgma4k0Vl6cg5IQ
	 1y49D8FijwTOF1awcbJB9NGhDRZ77X5Q6R7VOzl5AP+ofu5O8WvIM+dfXhc5dMVsEE
	 pe1y+4GHvymuqGymWPikx9Kl+68gJNH8da0tz7I4=
Date: Mon, 11 Aug 2025 13:47:27 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/989676/367a0b-000000@github.com>
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

  Branch: refs/heads/989676
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
