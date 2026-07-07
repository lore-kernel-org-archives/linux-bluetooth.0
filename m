Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABCF330668
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783413486; cv=none; b=PPCp/27OalDCE6OIZW2J5Bd4gbuWktSlFFlsSHJf0fVIlBcfs6jqRsScxJEiHsFxUawlWBbCTXnlzZuLq2/TS1fNp2fvLyPz2f35sIqOoCgwYuCAVsLBMkfupsdAVAx/xkRYNpvXEnvJSepJkoTaPPjfA0zSypfzioglYmi+ji4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783413486; c=relaxed/simple;
	bh=gVFIU3M6GnKX7/+zra0K/4pYv8/Oy3r1EJ8JG/HgUF8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UWlNrVFQzotrI9tBUwxWjNDN25rA9Sbut+poVDuytoS9tM3Mdk1s/9b0KpUtWnxVl60kvbWrS50uOeK9NB8ZkApEuyVfpiviRuK+zrD2CyEtH+YQZU8xykehKweVXM+yLG1QR0lof941k1RA1zhPPfUJ4AiP7Xhpk6MyKNGpZXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=f2SGf3qN; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="f2SGf3qN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783413484;
	bh=NV1l5r+QBkN9YjuNHTsbJxzmWn59TrzC/P7ahWikrXI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=f2SGf3qNAZ8MCh1Z0zxkTcA33jDnkoMEx3kgRvEc74czshtGtNcj1X4kcoGYwKoqA
	 1lNqDLKR20EJdWjOqG4JkRhu4kGanrMQ8bYUNC6GvIYFxar3OKfSWHQ5UYJLmX/UzU
	 ihqteunTdRsj18XL015x2FT5bENROYuLl5K4G0l0=
Received: from github.com (hubbernetes-node-3b8aa15.ash1-iad.github.net [10.56.14.93])
	by smtp.github.com (Postfix) with ESMTPA id F3A3C366DCC
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 01:38:03 -0700 (PDT)
Date: Tue, 07 Jul 2026 01:38:03 -0700
From: Rahul Samana <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1122826/000000-db4489@github.com>
Subject: [bluez/bluez] db4489: gobex: Fix use-after-free when cancelling SRM
 PUT ...
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

  Branch: refs/heads/1122826
  Home:   https://github.com/bluez/bluez
  Commit: db448996954c22418d44421f704812cb891a6ae6
      https://github.com/bluez/bluez/commit/db448996954c22418d44421f704812cb891a6ae6
  Author: Rahul Samana <rahul.samana@oss.qualcomm.com>
  Date:   2026-07-07 (Tue, 07 Jul 2026)

  Changed paths:
    M gobex/gobex.c

  Log Message:
  -----------
  gobex: Fix use-after-free when cancelling SRM PUT transfer

In SRM mode put_get_data() queues the next packet during encoding of
the current one, so transfer->req_id and pending_req->id can diverge.
When g_obex_cancel_transfer() cancels the queued packet from tx_queue,
cancel_complete() frees the transfer while pending_req still holds a
callback pointing to it. Its G_OBEX_DEFAULT_TIMEOUT (10s) then fires
on freed memory causing a SIGSEGV.

Fix by clearing pending_req->rsp_func if it belongs to the same
transfer being cancelled.

Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
