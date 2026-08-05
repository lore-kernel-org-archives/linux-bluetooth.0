Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E4747043F
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785943527; cv=none; b=TMJ/dhX90LlogxqzUqji8s1Y3zl6HSpyXZbbZY1Mnz53FD4dvbN6VhENv3FN+zKnK1+42Yp7eVUTiYkjKYXNq55TjPoeunT9HPzuhsYwvfFRaVrRzbYIAwXuwTaAACCUiOe3r9EHuAkqTy8EZvtxXGW9yi1z4AuQP1B0gHnnfYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785943527; c=relaxed/simple;
	bh=tiQ/ZT8qfMah4MP4reUVPHrIq9sDiIBD/FaJq5Xd4/Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=q5Yfvm0Yg5eKgXePH+/NeOzdCO9FUiTE9QSIpw9pw0XOv6cwNs4xx275ydSJjb7dBs/cs1dJs0b/pEaA5hKoJ4f/Iguogy6StVwTNEjayEP74g8wZAaFql+oZnUh3ZwGI4t+qutBK8Nq8mAq89RKjoUJRRLGtN7glwspQXURpZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Y3cu+faC; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Y3cu+faC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785943515;
	bh=MDLCtoYSjKdiHLLM53j5JWQJXzYhshqiBiitbvbBxFs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Y3cu+faC21lsyJVruIqjoaiHMqcH267esjhQUsihXyTmOzGBgMvrxgWPulTU/ea7X
	 zyd3rU8/eoNAamdRrkmWPwSYSN6GEO3rBSQ8ijbuqR+HqaGjqQwVdkhv6jrF7s0Y3F
	 b9DCowsoeUUExu6Fm3E7OV+MnbC0F0ggDV9ECJuE=
Received: from github.com (hubbernetes-node-bfc0f8c.ash1-iad.github.net [10.56.175.18])
	by smtp.github.com (Postfix) with ESMTPA id 34D49600401
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 08:25:15 -0700 (PDT)
Date: Wed, 05 Aug 2026 08:25:15 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1140873/000000-b30228@github.com>
Subject: [bluez/bluez] b30228: unit: Add test for sdp_xml_parse_record()
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

  Branch: refs/heads/1140873
  Home:   https://github.com/bluez/bluez
  Commit: b30228d4a4d01ef51f0979e2a6d9ed9db3141ed3
      https://github.com/bluez/bluez/commit/b30228d4a4d01ef51f0979e2a6d9ed9db3141ed3
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-05 (Wed, 05 Aug 2026)

  Changed paths:
    M Makefile.am
    A unit/sdp-xml/Bluetooth_HID-sdp_record.xml
    A unit/sdp-xml/qt-SerialPortSDPRecord.xml
    A unit/test-sdp-xml.c

  Log Message:
  -----------
  unit: Add test for sdp_xml_parse_record()

This adds 2 example XML files from other repositories, under a fair use
license exception.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
