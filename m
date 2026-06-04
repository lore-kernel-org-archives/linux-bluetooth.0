Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9E21A8F84
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 08:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560533; cv=none; b=GSR3rR4CqNTgfGvkjKXR4jf/wcF7cAwGcfFzXEovJjWr2aaMMnTPTxkN+CUM3Vzp5hVYeHsMAkq+t2D5+Z4H0uLcLkqSXbWEsQB5fPOwh8o+3BeTinckSUrYpN3+qnd35PCbu0FWxLa3KiUuNcsKjwjJHOIXj9CvIukwkUCAayo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560533; c=relaxed/simple;
	bh=RIIsZnzKE5S0OIxrQSKCsyw1xcZ6eV25Zy0valkjEyk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RsreoAToaTzttrBYwmNk+dexRRDcch0POiDf7WUnih4csHJbxvCIrjiRbrGwhxPZ5tc7CGNytxXIB73lwJhInEH2xaFS8aPtnUjXk1LTVFqMVAGVo55oXAaFiI/YvlsuT5BXNqZMfs/Rk4SW9t8oXGeE9nbT08yoZxKOMFX1dgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AHWEp/ts; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AHWEp/ts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780560531;
	bh=Bnsr/ov53+W/RlR6SeEFhbiCOAAEga79/lWTUfm5L3c=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AHWEp/tsw8SpGBsY/PErUN0DG8vJbqf7DGmuDBFIrLXKLbq9ASX2Cy4mJjL/b64Xw
	 EKBtA1InS3kffsxAl232sII7EHWxvM6T5z4NyJOulLgT4vSHvH/cJw7qL3uK8deyeK
	 bi7guPGDtBwOMS4442BMLTV3sAEd8N/adSIoEB64=
Received: from github.com (hubbernetes-node-2800e49.ac4-iad.github.net [10.52.220.28])
	by smtp.github.com (Postfix) with ESMTPA id 25B409403C0
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 01:08:51 -0700 (PDT)
Date: Thu, 04 Jun 2026 01:08:51 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1104482/6dc162-000000@github.com>
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

  Branch: refs/heads/1104482
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
