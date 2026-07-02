Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D84E2DEA98
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011885; cv=none; b=l4+9RDtE1niPIFScWXDkaLXF+0K/bcSxMzBaj6nfh7o+Lb2kYpUVZRUpwuALIJpGaOD0X7Ce00K/izV7OAjGzoZ78+rIOfgXaPOU2+cKZBGwAn8ZMQGTMIOSyM6zBLfQO88QRke2yW0egdeRgpyCqHPuMyz+llL6ihNJfKoXPYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011885; c=relaxed/simple;
	bh=fMu2AfAE9evF/i7fGsN48CmuGwVIF7tIFw6AqgsngjM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nU4wyZ2OaZXVWfgRZOBS8FreKi9HKc7fMaabtJPA/stq3jsSbu6gCE2JRYQCJgDw7dE0stZ9M6RpYEk+BrvjdCmvafM+H5+nKyIc0LHzg1Ss49++qPufFAL9WxevYMJ3yb8PmPgjWDj7EjjTbSGgiKJ7X35hsjnfBbEkOWc+e40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=in8+xuXD; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="in8+xuXD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783011883;
	bh=F3hlM4QkIJO/ITwUd0uhdw7Gy2ivjPcBNB7DUnZZAM8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=in8+xuXD7iZtgwlMK/em7qRCyNeclxbxJmATGwGYi3V7b6KOBo4kGLYOBzOkPLR1w
	 PvO1YB2dj+0dU0gARA3BQaqUYnXnNKZ2R/QuIKScCTGHZjsgr+TQ8eBvZK9hm2TPYF
	 C4Yj7lnMaWGwpM9MObPqumN4fO9wNVV5lHuHhRoc=
Received: from github.com (hubbernetes-node-451456b.va3-iad.github.net [10.48.210.34])
	by smtp.github.com (Postfix) with ESMTPA id 9AD22800A74
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 10:04:43 -0700 (PDT)
Date: Thu, 02 Jul 2026 10:04:43 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1120587/000000-a6ffa5@github.com>
Subject: [bluez/bluez] a6ffa5: adapter: Fix crash on dev_disconnected
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

  Branch: refs/heads/1120587
  Home:   https://github.com/bluez/bluez
  Commit: a6ffa5f2bf4e652905bef506c09eab01859a4dca
      https://github.com/bluez/bluez/commit/a6ffa5f2bf4e652905bef506c09eab01859a4dca
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-02 (Thu, 02 Jul 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix crash on dev_disconnected

Commit 5d836f1c697c ("adapter: Fix failed bonding attempt after LE
link disconnection") introduces a regression since it attempts to
call device_is_connected after adapter_remove_connection which may
free the device causing the following backtrace:

    #0 0x5cd6e384262f in btd_device_bearer_is_connected src/device.c:3754
    #1 0x5cd6e384266f in btd_device_is_connected src/device.c:3745
    #2 0x5cd6e37f8614 in dev_disconnected src/adapter.c:8626

Fixes: https://github.com/bluez/bluez/issues/2221



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
