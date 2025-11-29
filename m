Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B731C1A9F93
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Nov 2025 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764435700; cv=none; b=gM+LHrWFzgH7NGZcIEfLvxQ6LAQwUa4nO0jc7dvCQgIYl3AnjV1P+bGPCFMUAEvPLuuTC8QSxgtL1TEIMHQ0Kpx6mZY/rHursTiK0anov0PAoEMGe+eC2gfpqjcInnlr21cAbvtgTXiWRqwHLYHeWWWomkduQTeL3dguOreX0mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764435700; c=relaxed/simple;
	bh=+Y6YmoWaeC/DApHYLfPVZYnkU+nAaRk/U2eXU0xwYkQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=rcqcCM5tNEaTGNvVeOrMGX+1yUjLH8RrtrSlW7iLfKImyVdPwOgdBDeypcQb9JQ1pM1AhXGlPX4mIPwR/zrW/KJrEm3mKm4LzIYDSyyeL6h1APHO6KP6Qv85uvuFvJfW6K61BTTVnGWJHAAdb1zwPaxtBoUVHC+WWsxX0+75+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SRwSg0uJ; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SRwSg0uJ"
Received: from github.com (hubbernetes-node-42d3c43.ash1-iad.github.net [10.56.153.30])
	by smtp.github.com (Postfix) with ESMTPA id 0FFAC1406AF
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Nov 2025 09:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764435696;
	bh=/QbWAdAEh2ig+Bzd51/gzfiedVhJ2uvKTcf58ba/cy0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SRwSg0uJue5fZnxns0pjKABNlU/wcP/BBX9Us31jEATTKo0WhXXbvkT4EUsx8uePZ
	 Z20NRSaDBBZeGeutydhpSizAssd2lVzRBcua/Yg2GRxFJkNNBBm574Sn17Br4Ud/uE
	 yUIJuim6fYZ6eylnL/Gp06fzZ/iXQZ6vGtqTHcqo=
Date: Sat, 29 Nov 2025 09:01:36 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1026741/3c3893-000000@github.com>
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

  Branch: refs/heads/1026741
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
