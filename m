Received: from out-33.smtp.github.com (out-33.smtp.github.com [192.30.252.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2084352008
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781086617; cv=none; b=f+vYHvopgTCs4ZZFs4xy1SHHxYhLuUgX0wze7oWfNDLMaP8njYwIHeLrWz7CK9/shs+JFiBHDRBLqYQuLnGenDNtskysb2f+YgeOc1oQgbuhbwm2CqRYEGmc8rCZkGyXRas4LsoUxIjW63HsSVpitMtNmuDN4Oz1so39oCUQRz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781086617; c=relaxed/simple;
	bh=Ysuie9x8iICzC0fjDScT2tCeewZjwTzRLvz6e6YHGxo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DrXIOrXGt8fBKpbyW4anQ7YsYqF8SMk2CbjYIlml1zNJeUZ/nZKb5zCh8BZEVDr8njxpmafXDux4cgst8VcGMBHnkRgCJ9/A1n2k8/Njk4mSp/VXPktr1MoiT9CczckAYVomdusSeLKXqXNiHQtJohbmJFY1tWYTGFQ7aTuKuoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RG2AC9GE; arc=none smtp.client-ip=192.30.252.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RG2AC9GE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781086615;
	bh=9h0nA7ulMbr0IFIx3xeOfrvxqAlL72iw+CKUCL16R3Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RG2AC9GEBog31ipJeS7BFY0C7y1wFW8U8WurHDptNDLNkB442UxlAKBPNJPeVhhjl
	 8DBQcO1XEWboWA/JNoNL6RcFg4hDMT7rrLeVj7ZjDwAqWcb2hLXCZWoDi62Meuegm/
	 DTEasatul8RU2EF3XbuoiDyC5HavEMI7NeO+wV68=
Received: from github.com (hubbernetes-node-82cb846.ac4-iad.github.net [10.52.84.33])
	by smtp.github.com (Postfix) with ESMTPA id CEC6D741102
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 03:16:55 -0700 (PDT)
Date: Wed, 10 Jun 2026 03:16:55 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1107775/2a496e-000000@github.com>
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

  Branch: refs/heads/1107775
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
