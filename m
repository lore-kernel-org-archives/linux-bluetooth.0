Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C85352C34
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577431; cv=none; b=FKmlEL0kIPO7YZQXFPHmqu9icJn+8a7RnK1210M6O/t3kSNa0wvC82MbpQn/Yq6wROMDL10TUMqTyJxM4wjbNS1scbb26QdQTsk59dGBWa4GiaW4I0nxbXMDTOUwRu8LCG6FDVBapqSdAoPTjkiHNQqjKeN1g2S2RC/yzZG4tsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577431; c=relaxed/simple;
	bh=hjAGcAUyOIM6NCjbQJKmfzuGuf4PUOC59VQajOUsQRc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jqkpMjby8Joy79y/P0FvyLMZPkfeqOC0pjtaNl+7XndxklDcwmnsZsUlMFIBnlGOVCrqP3rGnXAkB/5RIm6HMfu0fw0Rvw6YLoXK5CaO6KyuBhBAyqcvaEeviQmQGrOwb5whetVFiVttWcP6y7d0z/8XwL+Hx1pI9DQMV2+kefc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=m5OPCSeC; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="m5OPCSeC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784577429;
	bh=mrsrmpD+XW0Ou3sIVd6I4eqRLgtocXs14KMGaRHsZjk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=m5OPCSeCflL7sOj0Jdsxn+00WqgJ74gQeJh+7v3w16nqRql6EHNwJQ4bU+TOLibP2
	 +BnSOmi05M5b7IUc1oDOYFZyLmI8u4cKZSPJmz6PcKCXuIkfRvaAq8CLLBt6qY0mr6
	 G8RsibNY351pQAsAkE+wbzsZ6BNS2Xp/BPH0o1AU=
Received: from github.com (hubbernetes-node-c21264e.ac4-iad.github.net [10.52.139.30])
	by smtp.github.com (Postfix) with ESMTPA id 491377808DC
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 12:57:09 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:57:09 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1130938/294a72-000000@github.com>
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

  Branch: refs/heads/1130938
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
