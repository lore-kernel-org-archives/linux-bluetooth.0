Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FC023BCE3
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764686491; cv=none; b=cawpQOPy4MnZg3KCHYq8YlejHwXYxG5lmsEiafcbbL9zIJ9Qui+p4j8fLZLihiHqfS3z2dNeM8m/LiBD0QnN19NZb7GqENkFg7MR8z34f/ajyvD+DDwUNbw2kjEvVl4AksFeFnvbuMUe4aNW0ifecbt4CdgRX6U30dt5MWDx+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764686491; c=relaxed/simple;
	bh=SM0rF7AMITNaUD/0ntCNObZoMXfbAzA/xkngroZen2w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RpVzgMZnpW2fRzoz8ueAGvm9ICmfve+QKZZ2KFNTXMOmiVTeyiclTpcNyR/zER8v7jcF6ikSzPg/DMC/PgdaRlbcC3NJRuRFMXt0R0lwcHwaZ8u0PaBa6S2zfvNTs23n8EW9UfZsL4zi0gLr3cLBeZWHw1jHfLbnjLx2M2eBHjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Xpupd7L9; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Xpupd7L9"
Received: from github.com (hubbernetes-node-10b7308.va3-iad.github.net [10.48.153.30])
	by smtp.github.com (Postfix) with ESMTPA id 719C4E0350
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 06:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764686489;
	bh=rZ8nXLCjoAn5AGf7bg+Jqt0lDygAMpT57DOgoG8ewsM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Xpupd7L9cR2Ptxwh7kLG3Vft8AYS+06iYfsqMOPqVdr9wdL5SYLf+ttEGmlQRTva2
	 2qnFt46C7J75eC2OPzgYyZNakUfNc9J4jUmmRnSyp0N5OensaC5dW+YqPwVBr44CIQ
	 ELHawv76JROfB+NmA2hj3OGwhxwsEvGYVHEX5b4g=
Date: Tue, 02 Dec 2025 06:41:29 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1028268/8e4816-000000@github.com>
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

  Branch: refs/heads/1028268
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
