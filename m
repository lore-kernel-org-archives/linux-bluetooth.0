Received: from out-1.smtp.github.com (out-1.smtp.github.com [192.30.252.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ECA382363
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779716661; cv=none; b=h0rEyVqdOrjHMr7G5SNj3KRAIcvxIQSgjOza7MYULeWQUhm6Zl5iXT6H8wMutUCn6BHCigwyDVfmrNjUFc0lS8oM2GopNmpLtW0G1iAuFXdnAxPnnyyBxCbSigA+t9grZptX/vaafSFFn0KVL1oukmGX1SG5AfoPtT5E04NKkPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779716661; c=relaxed/simple;
	bh=igOgy0OV0+8vedVJg6wrDWHeOO20VMTohfpLzTqXglk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PBvBrY15NMliw6MnAjUxl7MoVPw8mSsixMV1IWj/dmqZMFdqaJ1omWoVd5d8b5jxewEohlb5B3p3xvdtFIdQewIVKxeJz4m8p7Is9fz7B29JxndKuEFCX41yqMl5Tf242yg+A3RfN0rkCcnIkUszZMIB85SaxiM2InuMwaV3Xg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WYgoDt8W; arc=none smtp.client-ip=192.30.252.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WYgoDt8W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779716659;
	bh=kVPeM8bgwGb6/b7/9G0TxgbaJwoz7PXpnST+uqWXpxE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WYgoDt8WfFV/nvm8AdUFpSPrIn3dHGYHVGDtNmRfB1jJhY9Km7hicNHdvjZjY1dgS
	 bttX5rLranZui43o4m6HNxl0nkB2HiSqbxZawq4P+o3rzqCyXdqLDYpk3Y995RM7kQ
	 9LAU6WL8R4AuycvVvyeOfO3BHPKX0of6+jrCMxH8=
Received: from github.com (hubbernetes-node-4cc2aaf.va3-iad.github.net [10.48.207.107])
	by smtp.github.com (Postfix) with ESMTPA id 72C603407B4
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 06:44:19 -0700 (PDT)
Date: Mon, 25 May 2026 06:44:19 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1100262/dc3162-000000@github.com>
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

  Branch: refs/heads/1100262
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
