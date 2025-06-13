Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7A22580F9
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jun 2025 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749823882; cv=none; b=ICwvrHzu6P7tGfoCZjdB0rXL0MzFPHHcxOFegi5wYteh9VL3ZuNM+m52arMen2TyTNHZR09vZwBuUh/8wCZNbJYOoDEiBX5t9UMPoyVt5+QEwAmI9HC+AaFISxIOvRjxvjtYS3v2HA+SMimcGfdikguxQHeaQshmsHjQK4Ur6Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749823882; c=relaxed/simple;
	bh=7OINk8CANDme1Apbc7pyAnqIV+wtRv1rjuTQ+FK6bf8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Rupw60iZIuXsV9J388aZvU4nfjbURx+EMwkkvEGXLIYJDF6jyF/t0mJiBvkCzcdPZ1Ujn23wI/w2gRJ8Bgf0aznkgGXjhVw/8Vxh6HzFudyRn9TKgVjenf8XzT5Zu1c9VpwrO1dwWGM3PSGQKX0IhpXuI4DjrGY5kCtxid7DRGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MhNigMZr; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MhNigMZr"
Received: from github.com (hubbernetes-node-2ae26d1.va3-iad.github.net [10.48.13.46])
	by smtp.github.com (Postfix) with ESMTPA id 803CAE11EE
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jun 2025 07:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749823880;
	bh=1Lm9hdKF6RFELtVloOgIQ8C7t3mpYxXpijhJ9qxrV4Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MhNigMZrwQacQenOmNRykQxgn5rmpKLt69yCGk2TOEY8/lbPqCkTKjCAXjrg1sdGC
	 M4PmeggJpqrfxxAikM8OEIdDtOLAUqEBJjj70vL+l/ZQap4eY/fNgV+EkpAm8vz5Kz
	 S5oZqiAei8OysOAvYrOPVqTWlVawujJqC6oVVp9U=
Date: Fri, 13 Jun 2025 07:11:20 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/971855/000000-86eecb@github.com>
Subject: [bluez/bluez] 86eecb: shared/gatt-client: Make bt_gatt_client_read
 use b...
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

  Branch: refs/heads/971855
  Home:   https://github.com/bluez/bluez
  Commit: 86eecbcd3be752f69e9fcb7d978c555f2166e7c9
      https://github.com/bluez/bluez/commit/86eecbcd3be752f69e9fcb7d978c555f2166e7c9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-13 (Fri, 13 Jun 2025)

  Changed paths:
    M src/shared/gatt-client.c

  Log Message:
  -----------
  shared/gatt-client: Make bt_gatt_client_read use bt_gatt_client_read_long

This makes bt_gatt_client_read use bt_gatt_client_read_long since the
later does use BT_ATT_OP_READ_REQ for reading the first chunk, so they
are actually equivalent in this respect, but bt_gatt_client_read_long
detects when the data returned maybe truncated due to MTU and then
proceed to use BT_ATT_OP_READ_BLOB_REQ to read the remaining chunks
which is a disarable behavior since there is no property indicating
when an attribute would require long read procedure.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
