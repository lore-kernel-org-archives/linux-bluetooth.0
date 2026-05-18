Received: from out-31.smtp.github.com (out-31.smtp.github.com [192.30.252.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91624388379
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094909; cv=none; b=uH7Z75CN0xnv8Hr2NberzCOyvYUEjPVkYREKE8RQQUt5E5HVRaQvM1wUd9zuVs7fHRE/5O+ln4pu5nHPiS/MiU6yApaD/gtge5ui6NiLPE3gDzUDCJmBLsy/5/B0EB2E5jQBzefx6m+jx8yjLEIAMVpLxtBIdf03H9jfoxGXIFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094909; c=relaxed/simple;
	bh=wtlXR27UYL1Y8rUh6P6Z1KwHmzsKYZaisC3N8a7Y9LM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MxQD7UHItA4g8mUNR/BXDIaDlY215O2bZs2DsPl+kDzo39DjZ/blkaGHiQx6VvBppXHjvZnk/dpICP9NR4EyRl7NkF5iUhaJyI/SEKROEtOu5W0NQNYaF1ZJ6EDK/mKnqwGbXCwFeqjRBfV2DcapK2zonywRHK8h/3MsaXFUTc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PpSLgqZZ; arc=none smtp.client-ip=192.30.252.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PpSLgqZZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779094907;
	bh=krZhbFAohCzO5dRx49jn7HVqdc1E5dwC8INNwwGQyTc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PpSLgqZZPqLxdI3qkM5t0XlHhR+N7uOQqDn2DXn/Iwv1VDHql4lKuVzJdqLS5dIYk
	 Mu/C5I5clR6rHFPE3o/08HrhaRyQ8kpubkJD8+g0wrujU2wbFhi6Gjy7MPeeeEC199
	 8LmtZdR+V2CSJiaAf1kJGDwfForkd8TpgYK5WHdQ=
Received: from github.com (hubbernetes-node-705a84f.ac4-iad.github.net [10.52.137.16])
	by smtp.github.com (Postfix) with ESMTPA id DF73A321D12
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 02:01:47 -0700 (PDT)
Date: Mon, 18 May 2026 02:01:47 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1096354/000000-51f3a3@github.com>
Subject: [bluez/bluez] 51f3a3: device: fix inverted NULL check in gatt_db
 clone
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

  Branch: refs/heads/1096354
  Home:   https://github.com/bluez/bluez
  Commit: 51f3a3b221be978d726a4cfc74a30272a24e9e3c
      https://github.com/bluez/bluez/commit/51f3a3b221be978d726a4cfc74a30272a24e9e3c
  Author: Zhao Dongdong <zhaodongdong@kylinos.cn>
  Date:   2026-05-18 (Mon, 18 May 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: fix inverted NULL check in gatt_db clone

gatt_db_clone() returns NULL on failure so the condition was inverted.
With the old check a successful clone (non-NULL) would return false and
skip swapping the device's GATT database, while a failure (NULL) would
fall through and dereference a NULL pointer a few lines below.

Fix by negating the condition: only bail out early if the clone failed;
proceed with the swap when the clone actually succeeds.

Fixes: cbe4144dea6f ("set: Attempt to use existing set gatt-db")
Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
