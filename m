Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72A8254AF3
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747046269; cv=none; b=m/pBjLoBzv0RJslTG4nOl1K4Ph/bz87J2MDzMGWDZJ/ovB4tt6Miyn4SCmW/UfUjl8WIUIDCPfNmGJfsPHFera1BxXyyqrwD9OpPnhXIHkh7GY0h6oSj1H6WW1gt5CYDg7k7w8p+QWfGhks9fmuiK1e4fBX6Ts1dI4+xRVnOl7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747046269; c=relaxed/simple;
	bh=sv1+Ly0Bz5JK1MSV85OOGXDE7/GpryRnwBYigaxP3CE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OviX7NLbP7CY5YX5UGBB1DGGcZozfMsyczjj0dFcX3QRGJ8ap2kXBGrUTr8RgcEBYUDoDtx3YI864hMZPhGxmYoyM7Ar5KEhlzqHnGoNnlHQEKV8JUm1Y0hWZv4qdwA0u6y0A/tucyjjRixCP/MqFTrueH1tQ3hwESAtl6jcSsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=moslMgkp; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="moslMgkp"
Received: from github.com (hubbernetes-node-0649097.ac4-iad.github.net [10.52.146.39])
	by smtp.github.com (Postfix) with ESMTPA id 741F86405F8
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 03:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747046266;
	bh=rTk2aCb+qbpjZwrfSDFVmiD8kNBgQzHqwhFXW9pzh9A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=moslMgkpaJ+KF0WC5ogelWtzGn8KnbBy3F6ynf8L1SSkmlh+/qa8uS/lUMKdupi2w
	 4vJGTMlaZut906tvzt6QsH9py0HqqGZiKD740bQxK4Bxkulm2i/nj+mzJB6tfJY64C
	 Q8qbIYq5Xh3d/zmiPuk5efPEIiS9AIN2m9yQHEc8=
Date: Mon, 12 May 2025 03:37:46 -0700
From: Sanchayan Maity <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/961953/000000-7808aa@github.com>
Subject: [bluez/bluez] 683f75: shared/asha: Don't wait for status notification
 on...
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

  Branch: refs/heads/961953
  Home:   https://github.com/bluez/bluez
  Commit: 683f755c18a24b19e27d45bd839864269529507b
      https://github.com/bluez/bluez/commit/683f755c18a24b19e27d45bd839864269529507b
  Author: Arun Raghavan <arun@asymptotic.io>
  Date:   2025-05-12 (Mon, 12 May 2025)

  Changed paths:
    M profiles/audio/asha.c
    M profiles/audio/asha.h
    M profiles/audio/transport.c
    M src/shared/asha.c
    M src/shared/asha.h

  Log Message:
  -----------
  shared/asha: Don't wait for status notification on stop

Not all devices respond with the status update, so let's just send it
out and assume it worked.


  Commit: 7808aa41822a50f853f48660be393a972f0e7027
      https://github.com/bluez/bluez/commit/7808aa41822a50f853f48660be393a972f0e7027
  Author: Sanchayan Maity <sanchayan@asymptotic.io>
  Date:   2025-05-12 (Mon, 12 May 2025)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Create media request before calling suspend

Creating the media request before suspend can result in
a situation where media_request_reply is not called as
the suspend action for a profile may not depend on the
callback of the stop operation.

This is the case for ASHA profile as devices are not
expected to acknowledge the receipt of a stop command.

Moving media_request_create before media_transport_suspend
should not change the behaviour of release.


Compare: https://github.com/bluez/bluez/compare/683f755c18a2%5E...7808aa41822a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
