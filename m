Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E674718E0
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 21:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789076611; cv=none; b=IYILM5CIvewi1YuLv6qGsgfxeYYf0Zh1qpg2JTRvU+xJ0kRe3W/sC6j+Tx3sExTTP3c+Mohg8z+yxcWF/acQMge3uWuCKtxvgfhZJ14aN/kaaHQW7E2hRWsRyMCo9GYdjOwuM7neBuuA7n3q1qm5LzcaWZtRBmZuHj7N3HFNNDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789076611; c=relaxed/simple;
	bh=E7ji+mtLS7CnxEmpRtcvRCZ2seAwxK/kcdrziNrO3BI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=U8BjT4aDZN5Lc5JSi4gJpDUwzyXdviNM11EeOzfB7GcyKiY0M7MwfAOgxs+KpVQSGBV0Gtx4BO8SHqQDeax8UFC+yN3lRYCoGkm2sLF/H8AJ9VFv8++WtZKFMedTMRbX+/NX9Eed3IRJOYQIAz2yE5Pcj4j+9XddoHuIZa7PDWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SutUtZLg; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SutUtZLg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789076609;
	bh=8I3DdOmBhJodyxF6TWX5n1drXvrQaaIXq4/vCENCrIU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SutUtZLgl6Jfh0++7hBXDdYDIqskInw+bur8CySkmxzOKhiMeo39vOp1RJ0gbU8Zh
	 RO0ydaL4PNv8mTrTxeydIMow4lXVINRqpKr/PCUJ1Tvqo7ZhM/NALCP+ItX1pALFWa
	 xJsYrndmhSDP2u1qW1rxMs/KnVYWGwU4RByscvxM=
Received: from github.com (hubbernetes-node-80c3da7.ac4-iad.github.net [10.52.84.28])
	by smtp.github.com (Postfix) with ESMTPA id C34114031C
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 14:43:29 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:43:29 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1161557/aca79b-000000@github.com>
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

  Branch: refs/heads/1161557
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
