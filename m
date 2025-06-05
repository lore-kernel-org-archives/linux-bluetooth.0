Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D43E26AD0
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749141736; cv=none; b=Sbqhqi4SoOtGON5GlTpc28so0UDBXt3z/dW9vEehi1GV243fI3Fmf4iOFA8erws3QrT8uyigXwxijQ3EG/lSTmm2XvxFnWHrfNZnUt0Sx+FUBJqL7LUnryTtinm6G/4mVNUzgIc8iVc8g/Fl14fp02P3AQdGumhpokYfORtSRn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749141736; c=relaxed/simple;
	bh=olx9vIHygPcdz84LMmF/kmUWW9X83sWOCPsyYe9yHgA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=idashQNLfzEkVc9MH7uPPWjrNK0u82YxeqS3fKj5AWCCx+rDbrXcR8T2UxI6WZJgYbtxkBrpY+/KbVjAf3KtJ301neqpTpaEV0QAWIO0t67QkIhjWtoCx2knftf0LTl09R0alvp71+0POsjOiBBotPJmNvJ+glavYTMJ9zclmwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AymzBD0R; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AymzBD0R"
Received: from github.com (hubbernetes-node-c927bd0.va3-iad.github.net [10.48.173.39])
	by smtp.github.com (Postfix) with ESMTPA id 224A64E0C65
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 09:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749141734;
	bh=rRgWCTsCPnsTBoPZD7UGUodO6vm2dWYL4n/VIWjCUKA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AymzBD0R3pcnDMYAR9uZP9/FhU4O6dDvlx3WxzMyEIVWjYjKwjyQte5sothf96nOh
	 ylsijSRUpRfJ4qQ1kluwMLHO9xA5DDE8/NLWdW4aAeZg4nYcIqKE+UxfZ2q8HGU42i
	 xiXxnatd8bOPlONeVkCWUXK44dyt2N7q0x2g33es=
Date: Thu, 05 Jun 2025 09:42:14 -0700
From: mkasenberg <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/968983/000000-e16134@github.com>
Subject: [bluez/bluez] e16134: monitor: Add support for decoding Channel
 Sounding
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

  Branch: refs/heads/968983
  Home:   https://github.com/bluez/bluez
  Commit: e16134dc0d2e3d366bdc61da29879aaa745e531c
      https://github.com/bluez/bluez/commit/e16134dc0d2e3d366bdc61da29879aaa745e531c
  Author: Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>
  Date:   2025-06-05 (Thu, 05 Jun 2025)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add support for decoding Channel Sounding

Add initial support for decoding commands and events of Channel
Sounding, a new feature introduced in Bluetooth Core Specification
Version 6.0 | Vol 1, Part A, Section 9 "Channel Sounding Using
Bluetooth Low Energy".

Testing:

To test the feature you need a hardware that supports Channel Sounding.
Channel Sounding can be tested using Nordic Semiconductor's sample
applications for the Initiator and Reflector roles, which are available
as part of the nRF Connect SDK and require an nRF54L15 development kit.
See tutorials:
https://docs.nordicsemi.com/bundle/ncs-latest/page/nrf/samples/bluetooth/channel_sounding_ras_initiator/README.html
https://docs.nordicsemi.com/bundle/ncs-latest/page/nrf/samples/bluetooth/channel_sounding_ras_reflector/README.html



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
