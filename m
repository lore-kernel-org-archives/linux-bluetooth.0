Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EB02DC78E
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746021534; cv=none; b=uKzhQZekI2DjWo1LUI0vFYxD+OIhP8XeZXJ6qw6Hv3BDX/wVT6exmlfP0VXnyqtQ/yvtPwNYVwbDNArEkfg3lGZda/4M1FztkMaio1GobYSBon7lN0dMzuVNR4fGHURRlFt9r+B9DfSHv7M+P0jKUbIzOr6qS8L29IwgSPOAQ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746021534; c=relaxed/simple;
	bh=HnJHIcR5T3y97CeG4FF0ui8ecmCB3CtgUlIOxFwn2y8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EO5OnwcMz7e52wAIfBsiyFJPUv7LJFMzeRcmWEn2R1inRqndFu6LPEfSUQQX+qQefUmVWV7uviJrONwOybjvrHo7NnbD4v83Obb8NeTghPo1+uh/Xmeoyr1paQ8jSLoG1OCOZ2+c2CDKxxUgduJm85A7i6S7gL0cBMPisrwyFZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=F2PLus4e; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="F2PLus4e"
Received: from github.com (hubbernetes-node-267b5e4.va3-iad.github.net [10.48.131.32])
	by smtp.github.com (Postfix) with ESMTPA id 40504E1107
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 06:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746021531;
	bh=fNPpBhat9/qS9Y4xlM/dqa3tFpB9wMYiwxfgRRF/GDw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=F2PLus4eNSWLgSEcgdc5ISqWdEXSs9RjVK5u1NM8Zl+LNOa96pDiTgkn8mLb/eDBW
	 4wUvmfj5isEiOsh2UIuz4FCRdZ1vbyN9VRE7f8JiBjaJX7O/GYNTMFaHFz0C3Gwbqd
	 5/k1f2KFbTx8BvgdRF8QnZjgPQ+Akwm4JJZVBWsM=
Date: Wed, 30 Apr 2025 06:58:51 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/958158/aad0cc-000000@github.com>
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

  Branch: refs/heads/958158
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
