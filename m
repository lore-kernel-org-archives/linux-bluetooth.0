Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E0D2701C1
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477869; cv=none; b=FKFqqnuvkzucZ/oPx/e22rjnkexvC3kTkB0koYrO3kL1hfCL0x+Ws6uK8FFWU1DXIT38U0ILZVpet/Y6ZImp3vdBMExYN0ZbG6q+b4d1v0AHu3Jpi7ivLLOYcf2PsRAMSIkYi2Cv1qUFHnb8l+eCE1JX48zcANETjr1fPK1y5vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477869; c=relaxed/simple;
	bh=/4ao8UVZO58orWCoAt9+MzpyizdiAN0P6MKkAcmFSAQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TKQfomDAk0/YYy0B15sCLesSrDLMYQ4UAVrvIFHrhbA9THF9ZD1PC1rKy26dmRkD7bFi8xQgmai78/O16epMzYChy5/AKgb3ROIVbzFbrz7zxeGwPRTGSF9zB92oRb7Tvt8pnyBM+KvZrSqiyxoomnqmB4FCNmWjj41ok43RgRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fjbRIJA7; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fjbRIJA7"
Received: from github.com (hubbernetes-node-0f776bc.ash1-iad.github.net [10.56.196.49])
	by smtp.github.com (Postfix) with ESMTPA id AF335140845
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 13:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746477867;
	bh=zt5qwnrnSUtKO4U4gYuBPLkvKPBgN5W2JdaxOqcczkA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fjbRIJA7dmSYMesonRsYU33JLqjNW4ZqieiIi5Wn6GuYrXQfeCSt+iyPauPow1GjA
	 DVmu3tDIY/wjfDAyDyoyG4UzlKFOJ+DAxGHMYALf72FviLNwgvIzftR4Z/qwVRD72y
	 iVjYbxe7rGY2YhX29SOjw3rQZUeMrLzyYE3xCrZM=
Date: Mon, 05 May 2025 13:44:27 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/959620/2ccdf4-000000@github.com>
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

  Branch: refs/heads/959620
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
