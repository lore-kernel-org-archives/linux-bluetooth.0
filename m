Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2672B2BD11
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Feb 2026 11:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771761531; cv=none; b=Ctf1EnSTmkVOjrgnOwatf4wZtowGh3/9lZqem4JS43FeTtW1OSrH0tIaAkAg+WDA121L6pS1m30Yq7RqoV166o1CZasnOBo4+hjZhMEF14dh46/ub5CQKH4Aw4YGWWQ3UGq6HnSuFtisiHZFS30lMqXcEiODHLrbHdjyJGLsIHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771761531; c=relaxed/simple;
	bh=0rAEMLiHCFlGBJQA/li6at+vH0it5N/2opStN4OG1MM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jiJw+re12HeDIj5N1J3WMAlItM725tfKqE/f34HmRQ9aQCOEBfCNcfuTsG6DJAPFPVjdY3syIMVESASewH6Xu8FnHCg57nIAARGr5m6ob6X0LH9ZK/BEMl3fGJn2T2NYaJIM80GE2VkGGSyL7sbJMDpqUhNwYIeNa3KDt3sEiIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=U5oFXTgn; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="U5oFXTgn"
Received: from github.com (hubbernetes-node-e87e602.va3-iad.github.net [10.48.136.31])
	by smtp.github.com (Postfix) with ESMTPA id 430243C10B5
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Feb 2026 03:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771761529;
	bh=npU7HX/21Y6jcy68UqLwCRy/Xm1crMRgjtdKy21OuNA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=U5oFXTgnmFu6CN6r57NKLEg01qIXeuM5cbsBVey1OHeNWcfN7TQu7dQAp1N2nYwZs
	 RlTBCBb1wCY8FgBMHjStFJ07sQ+A+S5VzQrbtJnQI24EDx0/VFu9XPDPDGU1vSoKRx
	 zxJurjE3I4fsW4Rg4weVhihANPx7JLj2KmOf6Tsc=
Date: Sun, 22 Feb 2026 03:58:49 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1046230/1a4f0e-000000@github.com>
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

  Branch: refs/heads/1046230
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
