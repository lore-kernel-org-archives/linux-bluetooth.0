Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB8B16A956
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 02:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764989485; cv=none; b=ZCU3k6TbilsnO1IV6aPOIA5H/0ZejEbW+SRL0z78wh4sSTSUXEq+ihVvCPrl5wZK6sJjSpYJT+ChqVKGaY8lb746BapNQwI7t1APFF15lVhF1wEeCDV1oMHJ+Un43c/eCMW4hFlQP2RAnjA2e+9u1mC3GmwT4LJc1bpn1hgxu5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764989485; c=relaxed/simple;
	bh=8ddwVq8QZcfjIv16mOLrfhuqUhhLieTQng+XX8yWihI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AxzqiRo8jSDZVMttUZtHvA3KzdI/rKv7NJZbAzySQkTgvv5DrUmb5idgFvmDhrZb2P3IenB4H08+81zMvpQPFMFMltmWyHJo5+2aK+DLmAEIMmAl7OBPoZN0T9DMAow1OgYRBwl5goabhNugG2z1Rw17bHvCr8fa99c42U2l8YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=nIeE2GNh; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="nIeE2GNh"
Received: from github.com (hubbernetes-node-3853e60.va3-iad.github.net [10.48.209.43])
	by smtp.github.com (Postfix) with ESMTPA id C1307E089D
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 18:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764989482;
	bh=1PwBoEQhVG+YevJRPQv5jVNMGBziD+N5ISd00pYS4gs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=nIeE2GNhzmc/Eug9NfRDty+is2eASdzJLoqX90Lr+AeRyGmPKBlZ/1O6uOJDcAGtQ
	 M536PC/9tscCrUMrK1cZmY+iFs2QwFgpLElTogyPxIoGC8PjAWyFGJ9Wu5rqDKx5cM
	 WB91XzOwoh5S8bwag3lURRZvc2rnjU5swvKjScko=
Date: Fri, 05 Dec 2025 18:51:22 -0800
From: Andrey Smirnov <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1031026/000000-e2324f@github.com>
Subject: [bluez/bluez] e2324f: input/device: Fix off by one report descriptor
 siz...
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

  Branch: refs/heads/1031026
  Home:   https://github.com/bluez/bluez
  Commit: e2324f7a87cdbc4c4f95882f841e560bd331327a
      https://github.com/bluez/bluez/commit/e2324f7a87cdbc4c4f95882f841e560bd331327a
  Author: Andrey Smirnov <andrew.smirnov@gmail.com>
  Date:   2025-12-06 (Sat, 06 Dec 2025)

  Changed paths:
    M profiles/input/device.c

  Log Message:
  -----------
  input/device: Fix off by one report descriptor size error

Due to the way we handle SDP strings internally BlueZ ends up
including and artifically added 0x00 into the report descriptor it
passes on to UHID. This results in kernel error messages like

[371225.240843] microsoft 0005:045E:02FD.0019: unknown main item tag 0x0

or

[367200.458679] playstation 0005:054C:0CE6.0014: unknown main item tag 0x0

The error is ignored by the kernel's report parser, so this is benign,
but for the sake of correctness, let's not supply bogus data in the
first place.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
