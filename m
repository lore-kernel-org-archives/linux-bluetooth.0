Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4913F44C5
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665120; cv=none; b=QF26r8UinxFQTgEQ2CsZQuT/JR/wJDOM5b+qMR8hv3e7XzXzycfb2MhUL/ocbI8kSFUbpaFm2Qjkan1zwJX/bLruVHyOy942HhwwImi8idOvQQFjUvi8JvR/ecSAeQ3hwV5NQz2mKLj8BKS//WLuW8k26CBNuz8mGPz4yxL8boc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665120; c=relaxed/simple;
	bh=m4VVW29IsBaMUIVlwz1QrehZLRPxmV27BWozU2v+ZqI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OyDX2VFROGVDg/xOKnso51jFP8WpsJkTI+DnW38VOPtDCvl4Fd89caILOh/LckG4eI0unNDSKsM39B2I/MeID5KG1c39722ppm41yUhYmXBYlKXKOlA3aXEqxxstBka/Fb+diQQO1c0iMK41HkHYyGsq2Zv5IPRFtgJNiSD4Ay8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=GZfRgTp5; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="GZfRgTp5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790665118;
	bh=sBPxwQNDsfLBSP+vhoqGT0BTOIWxnLh2zES3mG5Qq4g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GZfRgTp5MmdsJSYivLtTbcSm+ymcw6CYQ+3wLGZjzBJwA/AEwncuZBG589Jm1t6OQ
	 1oieV7fO1ortuug/pg98aenpc4yK8Ck/bmULZcDSw1LLNkILEutqf/KdMX7+l43sCb
	 vR+NwB+rn4kz1bohKJpV2uWDIppTpWPCS0l6TDDZaBiv/9lYoKLpSBFUuXdRStkjUL
	 MNREF7fAldlRMGS1x2bitYPvsokYngP9aMmZy1WdklBmC6gqQ5p3ODYEF4xIYkOT+r
	 cjcW/8+vuLYcikWHymy45O6Z5xpc7acH9ewHbeHl03vagC9MCO3eQo2Fz09ZYRgL95
	 K+6R8wubSr5DA==
Received: from github.com (hubbernetes-node-e32b404.ac4-iad.github.net [10.52.140.46])
	by smtp.github.com (Postfix) with ESMTPA id DC296401D9
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 23:58:38 -0700 (PDT)
Date: Mon, 28 Sep 2026 23:58:38 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1175670/361fbb-000000@github.com>
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

  Branch: refs/heads/1175670
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
