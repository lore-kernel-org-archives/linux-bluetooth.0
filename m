Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF4F1E1C1A
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698128; cv=none; b=oqXKrFGegeczrb54hyM2PGBmWHWudJVPSGd+42aYAdK28RU6Qbf4ZU5kBo6m3+FTjqrF3VHmaBOdSeW4K/nQ94OPb2d21iNYNFCk35GD/RLa1qGFWfyUx/3J0ooCdruUcpN/btf8ze4+5SQ5IGOZamclbUMVD8NfBtHKX1rNtfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698128; c=relaxed/simple;
	bh=z5Z9m/IY5tFNRQZi3XOewG0m8mlizkmkKCDjq54s8+o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZfvxmiGbssPi792NpSG47NakXEuA8SoWeYpVcBUjp+bqyue4Wzsm8g6jdtvgZvCmxGPBL2ZtshKAV987QlDPWhWTf/RUkv6Y4SvYHSe2zRPjLw0vsWktnrMZtvHDbHMMXXoBfyuR9l7QWlQ/5LaMAy1UeuKFBFpejawOByImGO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SvyoBYXY; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SvyoBYXY"
Received: from github.com (hubbernetes-node-006cf2c.ac4-iad.github.net [10.52.179.58])
	by smtp.github.com (Postfix) with ESMTPA id 5C4DD7006DA
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 06:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755698126;
	bh=/L0mKTuqDhjokuW1SPJm7Vem6aanZTmIc45KwF9LiFY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SvyoBYXYqvrjXvTe9EL1xdiDnODTTmoAgPmp1+3zO2KKXw6xrJ+cc33z+yg6q1gsb
	 +niSqNnQNN6yOW16kQ8JX7GrRr2bjst3D98R6pIyNCuH4H6lMbfBexP6bJPNhJgXdC
	 rqerANV+4va3pWtll8fjPHN+Sx3Z1iWcCwVqGv6A=
Date: Wed, 20 Aug 2025 06:55:26 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/993065/b779cf-000000@github.com>
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

  Branch: refs/heads/993065
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
