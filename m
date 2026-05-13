Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E312640DFCF
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685803; cv=none; b=txzy3Sv5Qh49BDkLp9VmxJAc6Z21s67pfWHVnKwUeZembnncsFTqjZI1rKPQp7KZc1br12QMcA9xszh0ABIE0YU28A+YUO1EJ9JTnIph+2xFLvkfwGvYROKFq4TI+yGi1XXYZiDI8BarXG/PlR206OhGUPh58UYg7FxsDTmZ0qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685803; c=relaxed/simple;
	bh=HE+ygd2FoYUtQiQ17tm/VdzFl+v0iHwSGbH1Kq2Zcmw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=o4q5RlxM6TE3qb36Mg/OogDyiaohJwgulXO++TG/xgyD3fqBKgrrg9WDGd/JpJlaZnPa3JHC85P0R1L4470w7OumBUkfMcvdEN8lHZzM5EGze6w5VXFnYmVVtgQiKd+lFTrVkYKNK9R7ziVckkoHn2Za9ivDTR9Dih4IsqQgAkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=j4C6DA7k; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="j4C6DA7k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778685801;
	bh=h3Vfl2COEbsgZkhwI8qAOH8OMaFScArj14YL1+N9d0E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=j4C6DA7k6zaXouF0vY5OicMLBEkrXHWXGhwmaXNk2YgzBiMmrfOR0JUYEkJUagBlN
	 ewKMVx/3VRfk41mVOawgt55GxlTNaSa+vaYcZtb1Hg6FBA7CRymuBVGmQIoTatzqu2
	 L+0Z32A8l0gPbvI2s0jnvzU4cTNoAwjQYTIIUEeM=
Received: from github.com (hubbernetes-node-f97290c.ash1-iad.github.net [10.56.200.67])
	by smtp.github.com (Postfix) with ESMTPA id 1BBD218098C
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 08:23:21 -0700 (PDT)
Date: Wed, 13 May 2026 08:23:21 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1081435/f10e74-000000@github.com>
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

  Branch: refs/heads/1081435
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
