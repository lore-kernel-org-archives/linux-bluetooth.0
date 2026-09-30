Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11423D25B2
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795887; cv=none; b=jG97yWVNyzBE8Z/TrqhQqvCxjieUwzLE6UQw3iEGYOKlehNBAOH0kdVmZmrSm6gQvhuWNT/VplqlcCZBunfKG82cRsWl2ZkVWWyQnMFdQhsDmcSXEKYkV66Qx2W9yM86Fsdx/5YAL5gNZUJMpv+GKdIAHeK5Ur6HVtb7Qqz3HwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795887; c=relaxed/simple;
	bh=xeVe5ouYDRzNgBuH4DQoWbM25c2uI+y3zy+bp+DL1Ho=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FFp6ESk9WX7eP8T3ti6xwuky+ZOmtS5moRZlmpGoYOc1KIU2/BuUoUqpnFrXvPKmWsxP/n0sRS/8HD9vMcObOBiIZbRB4ZkU/R3cpfBGuFo7bPL1et+0W9pTJnygepxSSZB4kG9RGa5z5vb/4YhtU0Q7zec57yXtx1gjax9+NHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=FrQWcoGL; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="FrQWcoGL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790795886;
	bh=3rRRgihRPsO/HAo3Y14wytPIhrsE5Fa+Z0D2lj/n38w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FrQWcoGL9A3SoMuhWtAXXtK2/kSurNeLdpNDnw02UDM6iZyljbJcJtA3vGCpU0ln0
	 htc4Pxf92Y3Juh73u5SGyCJvrvLWYzRpu1bWZi2MiE4Ib3nKvnXrZQ0kmNjyo+8EGw
	 mE+zLAmio6ku9pB5bkDuZSrIrEXyrycJslUZVpiiGA5QHRboNQ2Gp+Xk6ciLw0H8WV
	 o0G33zWwGS6mIY/InfZXjoPfCslN8g8If5/yXF/oDLl2JC0n84/dN4hH+uY7A+WUB3
	 wjUT+L5C/HWAZ8MIjlQ0lrkl163fllqN6bTIL+G4DfCfIW52T8tDwE8wo96+jYl8KL
	 cH3pFZ1avuiFw==
Received: from github.com (hubbernetes-node-d7ec40b.va3-iad.github.net [10.48.73.94])
	by smtp.github.com (Postfix) with ESMTPA id 0C5728010E4
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 12:18:06 -0700 (PDT)
Date: Wed, 30 Sep 2026 12:18:06 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1175715/b0e1cb-000000@github.com>
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

  Branch: refs/heads/1175715
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
