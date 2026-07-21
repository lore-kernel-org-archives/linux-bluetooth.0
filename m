Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC3434E2C
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784664569; cv=none; b=Qhcuf7bfB3JNyZz4TqPxs8/pOhxFSYus0NPwM16YuQrlj8DPAm+8AjXBrvw63dtgd3Dftyq5cNCdr4eTKIVt+oTpEv/XTdWHabp/wOZgX1KkGu1QX7lHYyKLOKKnj6i8C7qklzoA6Wqv5apSoKPbOMtpdSPcx2WkmATw0hn85Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784664569; c=relaxed/simple;
	bh=WYVKNoO3DqU06AvaI66vN09XLvm00vpHyJ5OiArESP0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Ul7+EswGoX7ajKS17dNwlO5jweJWg0xecplrecbFDWvFjGw496Ji3q3MPz9WimprDuB9xJLtoXFxox1wlCr0Q553r0b+jN8x7OqOrrxbvUKE5A6NTv2CJWrmSYltYPMH2ENWKSINolN+xGpKsBvmm+3BR4Wt3lJtHFFRidQNxs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=P4TI06i6; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="P4TI06i6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784664567;
	bh=JCzMZsuyo3jK+CT+TKq5qi8fBrqM0RMxYbAVeIG2sXg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=P4TI06i6U7Wgi9bTyF1PNq9axe62yXC1EdQLJzHsdNKIzrHqcBFR5Y0iVYb7qtgGI
	 KN949I2MNpG9RdM+O9O0XeD4Yx2XFpPcbmwJy7Ay4WW6p1bLf5T9w1kmNnQtXym3Ru
	 nlwlz4YWiCmJ4EcZmiVwBlKvwS2fltFxL0jmdBMc=
Received: from github.com (hubbernetes-node-f685c92.ash1-iad.github.net [10.56.201.97])
	by smtp.github.com (Postfix) with ESMTPA id 4673A520FF5
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 13:09:27 -0700 (PDT)
Date: Tue, 21 Jul 2026 13:09:27 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1114380/64653d-000000@github.com>
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

  Branch: refs/heads/1114380
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
