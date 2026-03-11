Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2728C1E5B70
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773263021; cv=none; b=bcPN8t+es/kR0DHSbVATF4IVIrJ3r0y6SWCUn7gzNRMW1cU0qfyQiUiLcXQ5gxEMN0YzcY0iMeSQadXzOEU0EEMTnO6YXVIVcndeEGXsaBQduqdOm22HXzCXwp1j4+WS0Pour4BRFwRff0DKiOGaXf8Fan8co4hg012uT1L8G3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773263021; c=relaxed/simple;
	bh=LXihrTCPNiY/XvYMnqeAnGjHBBfi+qXWZlTv1PO8crk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Jh+3aKhGpc4Twgn+saymGMqh8fPT4RUxjy2ClMKS7I/YlvnqSen66WjVSeQ04zhrd0Hl91/2tkKHA1I7ycBlggELUalQztV1Cv2TUmpvoA1LbrLjxyl/W/SqBiJcfTc02ogOuOHmqMwOslVP3ucinmR9BVs3cjm8H4T6DPgi+rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BXsB3hLD; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BXsB3hLD"
Received: from github.com (hubbernetes-node-7123629.va3-iad.github.net [10.48.124.93])
	by smtp.github.com (Postfix) with ESMTPA id 2DB371C10E3
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 14:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773263019;
	bh=m/+muV7thREJuSRdl1LWjOtFKC9mvPAVa1izx9B8Sko=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BXsB3hLDi3yz0+7nmrVBPKDwyLdHDuzBVZsqzVmpdwaNi+iYjbvHP9DtezWxIfXyB
	 QJcCDDNEie5RUDu/h/ycVebPai1GSGvpUUG9b+8dULN3WMCQB/NFBEXqCQcRaBTN8x
	 XT9DiwRgUhvvRbBjzx7QTgoSMxJHiatPC97fBB8s=
Date: Wed, 11 Mar 2026 14:03:39 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1052425/4b83f8-000000@github.com>
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

  Branch: refs/heads/1052425
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
