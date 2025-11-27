Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E15334C06
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255669; cv=none; b=Fxmm5sXP6UY/xrskL0vk8RaH/A0bjivhCFd8zmv7cx+Yi9jPuS+p1XMPSA4e1LhbsMW4YUYpPbYCUC3+VMgYobpqdOGqODu15UQ0wzHmdgux8EcAyi/KbqjV2TuWEQ8r7MD7IjH69QJgpemMAPEsvaWX3DJl4cRi5XZI+TpV8T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255669; c=relaxed/simple;
	bh=0kxDB4JsJHknUFrcRM4Ah6EftFHQXFj8NJX4wWkZ6R8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aDudMnVlt1VznllTnlTuBJihXWtDtxZUJHLNWA9iniz6kYxydLQ6H2bv7VH3V5pscSzxQKJjYKEoOEGEFvhA/gOccwutSon1TdeVlBRD6jLbYa7lWFc/gnkIKMhPnQSfTtmWH3Gb4NupkBTDCCiNGbN1kaYqakSfrp/sX01Vt64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VeGF2B3Q; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VeGF2B3Q"
Received: from github.com (hubbernetes-node-bc8a0d6.ac4-iad.github.net [10.52.125.39])
	by smtp.github.com (Postfix) with ESMTPA id 5F3FA21381
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 07:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764255665;
	bh=yY5t9syTzDVPweV/IX81kI1li9hTapVAM+dNFBaKsu8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VeGF2B3QfHwxQ3odHgBUUl6g9BDfo86QerIAU3XyLrJuCXI6zvldIj8Szxmmrt9X/
	 /FR9UR70zAd8UzTPO7gj5DzMq+lfcSO+6bLQS3LAfC1ZZG8rgnSEtR8F+3LEhVB6EF
	 7JYx2ht5QpsgyrGiG/vK/eDaac6nLddz8mzlRQ2Y=
Date: Thu, 27 Nov 2025 07:01:05 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1016771/c4c1a7-000000@github.com>
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

  Branch: refs/heads/1016771
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
