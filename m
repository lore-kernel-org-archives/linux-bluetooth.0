Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B9B31AA83
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 20:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765486776; cv=none; b=M8fGQymMmD6IjE3QB1l+oHSIrXPIwnXZg04d/6+5eZtNHahf8urBVrHuL2XR/vfWfZH1bd8wdJYnsYt+dyuImIazSVB7NED8GEPbZGnP3YKGNcs5QjRMLD29W3NTWszzoDUqA6EaS5yqd3H66xMd6AlVITfTKcZ44YAO6gkdNbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765486776; c=relaxed/simple;
	bh=PbO0e4e8tzWdPXzX1b+E9KtzmVFmd8BNKt08OjHwk68=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ctL6Cawo8SpuyVDwMwJXvEmwElS/6YT3B2N2PYQ3LufekA0hJQ+Cn+qKGQXtQdtZSUC5K8rEI85d5zjDfxoF5yeIOUT+8piKJrdr0SfMjTlcmpy9xrMC4vsgh24kE8538imEMqtZsY8qtH/e5fF1SRCK0vAxpvQ8SPTN7se3ueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Zrs3ZoC7; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Zrs3ZoC7"
Received: from github.com (hubbernetes-node-256c3b2.ac4-iad.github.net [10.52.147.31])
	by smtp.github.com (Postfix) with ESMTPA id 9759A40124F
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 12:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765486774;
	bh=3CW1KJypOV1dwv6648SjdSN4ph090qTmf/WmouIU4eA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Zrs3ZoC74IlDLyx80U+gNAc4ozrpgjlivZGuMM5FU/+aAJuSNbYP9akga8+X5lLAF
	 H7smbb53XQFRvvDe7xmUKozkmtTGRX9gP71UK4WLxRHiI9JvMUNiDxcLE99HptFbAp
	 3wJHR/cvThVlcNRT8QaE4gJTf+4ayr4AEaFG7HDs=
Date: Thu, 11 Dec 2025 12:59:34 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032419/09d4c8-000000@github.com>
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

  Branch: refs/heads/1032419
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
