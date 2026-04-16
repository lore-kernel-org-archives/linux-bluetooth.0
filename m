Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65D1B640
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776368215; cv=none; b=Ewh3bd0SwEhjUpZa6jc8AqJm5Fx5XLvI9k04HnMkf8av9kS7anvixa6cqIJFT030EEgOJ0TDkcTeew/TsalUOfeC+ijP351GErUedhrl4EPHHWEGklMjX3T5mF4EkGngPeqpD1JmnLBFvkqidOnALXrUxqierAwPL+NwZ06PfY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776368215; c=relaxed/simple;
	bh=a3+cta8WcRxqWypHAX/OzB/w9vUBasEb1NGvZybcLP8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cq4vzwjjRbNSWtMcqgF8v1VsYsvpSKciC8fLPQOxmQ21UnpV1i+gviIDXGP21jPfyCH4boa3Ap+g2vywzsjxAesLqYK1zvvg5D/elz7Hk3RgL7jYFp30LeUT5tNZb8ibAeM0bfULCKNVnxhK8w6uwS1rejeCfAtnF3ILJ/nL1Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ProLfkR8; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ProLfkR8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776368213;
	bh=dyYGVVxm6P2LOGd5jDybhKf1DGY8jAyEG1g860j/AVM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ProLfkR8PigR3UfT3kZnncsJObOqXSNiWWkYsZiUH3PhsyhtyUQS6wiOdimepIF19
	 ywYyWgtZ1KMFAziKsA+qNv02PsrggWFvot/uTXRPc0zVkI1zZ2IkOf4Tf769tOuhaQ
	 U7jpWYUWnuWCDyHYGH8zgIGH8BJjMdOljgmGU1rM=
Received: from github.com (hubbernetes-node-c322354.va3-iad.github.net [10.48.200.23])
	by smtp.github.com (Postfix) with ESMTPA id E4C921810E3
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 12:36:53 -0700 (PDT)
Date: Thu, 16 Apr 2026 12:36:53 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1082169/000000-3a005a@github.com>
Subject: [bluez/bluez] 3a005a: client/btpclient: Add BTP_OP_BAP_DISCOVER
 support
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1082169
  Home:   https://github.com/bluez/bluez
  Commit: 3a005ae57cc3399ecbeb39ab2b74db849cc44e97
      https://github.com/bluez/bluez/commit/3a005ae57cc3399ecbeb39ab2b74d=
b849cc44e97
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-16 (Thu, 16 Apr 2026)

  Changed paths:
    M Makefile.tools
    A client/btpclient/bap.c
    A client/btpclient/bap.h
    M client/btpclient/core.c
    M src/shared/btp.h

  Log Message:
  -----------
  client/btpclient: Add BTP_OP_BAP_DISCOVER support

BAP/CL/CGGIT/SER/BV-01-C expects IUT to discover the services before
continuation.

This reduces connection time for the BAP tests.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
