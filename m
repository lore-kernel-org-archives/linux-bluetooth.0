Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAC620D51C
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 08:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748333866; cv=none; b=JjShiZNzRpT+APvpGuaMBXtb8eNidMaJwhR8tGR3LK9ZxgB2putxbDrFuSBQ8aoHmzQU2LHGYh1661eUSlfSILb0qsJG3aK3jrH16yD/ObWJGZlXBaz1g0biaIGXWq/RxSAISwnnGSvdodiBsZkSa86Y9CV+Cj1mjpifTiMSzuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748333866; c=relaxed/simple;
	bh=4QIao+N6zNxk2JqTjmGtA0ljkOEdHZPe4MEU9jf8OFo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=sZoKk12rc4g+76HZC3+rDV3fmj4x1/st6RRMLPmO5xZrEgrUhA0CFOfd68lflzRE3staTOmg9m1Q5mXCJS5Qo5BW1P8XFiLn1mtgIgPcjV6RHrB7imwudxMFQ/lCwhAf2uUC0BCWJB7CXYCFZm9uPJ6hMesKy9Nwdw4n8fDxU8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IRoRBSo+; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IRoRBSo+"
Received: from github.com (hubbernetes-node-f1d2489.ash1-iad.github.net [10.56.178.23])
	by smtp.github.com (Postfix) with ESMTPA id 9DC319200F5
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 01:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748333864;
	bh=C8y80gGdl8B69BIhviaZs3X/D1AJ0IE7FPz+UWdGUUs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IRoRBSo+ofrjya8ERRaATI8N3KL1aaZq80lWVKKwfj6LLOwNHILYKbA4YXnONx+0p
	 0nmGddnwcF+6gTOk7vPLno4fznnCg2S+Dqi/DSyiwJ47s/b1rr6nEEYTDPf4G80OpM
	 erDstxJJHBpRCRtTybVy41s4yQq1cvMKSlk9p3t8=
Date: Tue, 27 May 2025 01:17:44 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/966581/000000-914b1a@github.com>
Subject: [bluez/bluez] 914b1a: shared/gatt-db: Add read offset to record the
 prog...
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

  Branch: refs/heads/966581
  Home:   https://github.com/bluez/bluez
  Commit: 914b1a77d6a7e14caf043e9bfd4f906fad0f8312
      https://github.com/bluez/bluez/commit/914b1a77d6a7e14caf043e9bfd4f906fad0f8312
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-05-27 (Tue, 27 May 2025)

  Changed paths:
    M src/shared/gatt-db.c

  Log Message:
  -----------
  shared/gatt-db: Add read offset to record the progress of att read blob request

When processing the att read blob request packet sent
by the mobile phone, Bluez ignores the offset and the
payload of each att read blob response is the same.

This patch add read offset to record the progress of
att read blob request.

Fixes: https://github.com/bluez/bluez/issues/1294

Signed-off-by: Ye He <ye.he@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
