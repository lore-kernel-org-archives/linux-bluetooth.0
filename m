Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch [109.224.244.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CBC41A925
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970204; cv=none; b=ATX8YIGZ9IDgcVRv+hzf97bQXok914DZ43puCR1R+rN/kyioYj1kznUzzo3RiCVTvEqlu8yWZDxK5g8nXc9SgbvkVL0XqfLMv7rxGXvlvYpIXkB57lGUw/haspy6mVKK4qpTglIZ9NQaePQNRvApK4JGmrFKp7oUSqIFrGrq4Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970204; c=relaxed/simple;
	bh=quadcf+F3w95Vv4EffkoWEgj0LG46W18oiyVW2rhqjk=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=Dgraehbg/Wp/KP3UkLrP+FQAdQGAB/5FGA3rw/zXxU88pRt77+FnX/2v3Lmadho9J2m3yxhB7FrmGM3xgqAi53ERgkGMFBKkIWGoXms47cAEzwMUwOSM6iL/VQKBOe5wAT8TxM5o/LT4sqZoG5WpRlZDsELvlALUbKFc6+9Ee0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=VrmAXDHe; arc=none smtp.client-ip=109.224.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="VrmAXDHe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1786970193; x=1787229393;
	bh=quadcf+F3w95Vv4EffkoWEgj0LG46W18oiyVW2rhqjk=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=VrmAXDHeH77aOOp8Y1H1U1l8MmN6pANkVy7OvBtX8VJIW9NLeiKe+Ol2p5YygmCCO
	 j2PNV9H5UKSlKRcooZEB/B5mIeSB/8ENs7iIKFLAMg+4UhbOw5gzQSTnNxU7aj9HNp
	 HmClxPr3FLfL7c1x2LNR5NZQsb9+ytthmpfL2iGOWBVqtPrkg7ELKjAlii4sKHKk+/
	 ODEhpntJKPew4c71FzHKPLx6LSdhuyUaE8+jyobiLE1IUj62C6yP6KrXgFCxF9xJ/s
	 K83A7PWJbi1WINZEMT3LZchY0WFLQnjryDYXFf/OSm+HksGvshF+wf1oDzlRzltUw+
	 poq5BcNHeosgA==
Date: Mon, 17 Aug 2026 12:36:29 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: kokimuk <kokimuk@protonmail.com>
Subject: [PATCH BlueZ] shared/bap: settle server-side Release when a transport IO is attached
Message-ID: <vGMp0n8dAgmXqtRorR7FRnCKhxr2zL-IDD0-WADMSPUucAPLl-vsydo2srdC0Vmm0F9rY97yHxlOx2lS-SO15VPm_jFuHZ6pRmcMtdl1cX0=@protonmail.com>
Feedback-ID: 38788646:user:proton
X-Pm-Message-ID: cd1b8a482552a38818fcdddcd4f437a505cac7dc
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Empty Message
