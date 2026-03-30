Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1D43815C0;
	Mon, 30 Mar 2026 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863714; cv=none; b=IwYK8SElZOi1QC9jfDA2wPJ5W4oq3KJQ61l582ENVq9S41nBXXi4Cp9KPsOs1prtTZHvEEjx2Rt3imadw/RZ7gvqaSqIfchHlG1l3CiGKSy5JTAxBsZ7llO5xmZGVk8/M1JP44wT+6MWU/D6mGeKU4LXwjXzygQ2nNnZ8v6E06U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863714; c=relaxed/simple;
	bh=kdui6uvqkQiGwxIHDcsDUXImt6ZKcy5zk4zs+j2Sbvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FbCJUkEnUYz5/AWyDRYgZxcL9qGoPfg0ZJ5XtNN4K9WTtrhtjGw4NDCmLm2OeK3UG4yZE9CpgkdUllUfGz6eBsECSdXMRp5ERhNCUJ9ozhJ2dXLy12jgsXCJA8OPTlnwphmIaxJ1tvdywwdmv1w6YSDPjLTc4FBqa3B1Pm4nmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgGPh6bz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgGPh6bz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1725C2BC9E;
	Mon, 30 Mar 2026 09:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774863713;
	bh=kdui6uvqkQiGwxIHDcsDUXImt6ZKcy5zk4zs+j2Sbvs=;
	h=From:To:Cc:Subject:Date:From;
	b=jgGPh6bzSFCbVsWrLfWVOJB2dX1ZGHDNPMm6IJr+2Q1Mf/jW6gVZrKJdd0uHmlSnI
	 q2Wn4xpEr8AVaJaeLASN0/KWTca3HlIwJ15U6I0MGAPd+6Erq3vQ/mt9CzxDydyDsz
	 wVNvGk9PmGEwo6IHJ/y8x28hHqCbyAVkNbFkoGaTV6cnAANyxQw+HV2R2MShiTT69u
	 hK/VfjfQcJfuG1JeHYfDrL41MoKaUBlURmxq3J9v+SrybXlKyE1GHZp8BZVQNv4ZnA
	 drFUderBx0HAa2veFIDlioZTniBMvGkSA+q0sEEj7TyI5jJ9sckpdjAtTj5TjREJW4
	 oN6anjkAdKsLA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w7983-00000006oAL-32bV;
	Mon, 30 Mar 2026 11:41:51 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] Bluetooth: refactor endpoint lookup
Date: Mon, 30 Mar 2026 11:41:32 +0200
Message-ID: <20260330094134.1622788-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the common USB helper for looking up bulk and interrupt endpoints
instead of open coding.

Johan


Johan Hovold (2):
  Bluetooth: btusb: refactor endpoint lookup
  Bluetooth: btmtk: refactor endpoint lookup

 drivers/bluetooth/btmtk.c | 29 ++++------------------
 drivers/bluetooth/btusb.c | 51 ++++++---------------------------------
 2 files changed, 13 insertions(+), 67 deletions(-)

-- 
2.52.0

