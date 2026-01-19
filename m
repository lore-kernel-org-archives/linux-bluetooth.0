Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B294C3A4AAB
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840145; cv=none; b=CmbvXlLK/7n65TgC/f3sm2pEVviDvvuyETfANvI6A364qAmUOwzwE+tpU8jUcu5fTDNnXWNNDqKc8iOBKwmOiLLEWjKqCHE0qRnK9i6Nq1DHlJBtiycl6PDiBQg2220Fvd+2CaGJLemZGKT4kedJrf3FAwQz9mqDwV5KaJGPIIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840145; c=relaxed/simple;
	bh=+L2DYFTCnjTLeTbPFU49io8KwIDgFO0LlEVrr4ghB9k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gcPvqVS8KQuos9SkTRDuJIuRaTCIsUH7SL/+2qEiIdbx4SxfQ9bUQsPeMO2WWMdIeCxaBTnp8X2eDRcUy4OpEzK15D3RvaojqW4MWHsGNmTn5HQsp7kEFPu3unMDcGc064Ax6WA7MCDcou+WQTswSWUEKeHAizhyOLpfKdcegvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lsN9pr/8; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lsN9pr/8"
Received: from github.com (hubbernetes-node-2784c81.va3-iad.github.net [10.48.173.31])
	by smtp.github.com (Postfix) with ESMTPA id 827624E04F6
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 08:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768840143;
	bh=+agaFCbIQC/alfBZ3CyUxChPtNsczN6avnrO8FdFU04=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lsN9pr/80l9AQbE1AlkKioMjPpeMBoBfvUupfA/nt/pCe9D5vXAFFg0dlyDslS3C5
	 hhiGbIwEYlChTSR9X/2YRHy1DlUFnLX1e9GmBWsxWPXp9zgPNVMaoROT7vOE88de4f
	 6+CJbuR6qmGn1r0Iad0X0PBfJ3Dlpd3qU3fvUz/0=
Date: Mon, 19 Jan 2026 08:29:03 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1043486/fb4afd-000000@github.com>
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

  Branch: refs/heads/1043486
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
