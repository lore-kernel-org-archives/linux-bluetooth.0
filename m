Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AA546A5F4
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786098572; cv=none; b=oePL0h82N3/L/iR8MFgNvSfIJMQ9KM9L6ZuuiI0zk/CLf1NEH8zY8idWbnMhfG8yOnqz6NcCZgx4NXonVAqKL+QTfURWP3AspTbBoKu7EYyIrTqnE8yLkGzdL5OrMe9Y+LH/ttLl1h6bW4GAmXSr5s7v11RNxGb9afxcyc9CmKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786098572; c=relaxed/simple;
	bh=NrhgKifI8wV44KLpBOR3fDvL76aqgvcRV9nugY/AHHg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=W/nWGKtXO3mOPtw7hNc4QtQLfo2BFr7J/J6GJo6N0PBvz+BuQ34YI/e0Lztxb7o4orq5razQ6a2tnHF0GYUdfDQ0c8auxrMUbHU+gTc+Oew6MwWpco5Q8Tfsnim0Zo8t7zULUgcO/Z/XZb5fXnKFErY+70IDg5GGKZuJk9vevC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QjsnO91p; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QjsnO91p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786098570;
	bh=3UQqnwPBf/WFKDyXmKEEgMyTRe7QPeNvVYSOQmJVsHg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QjsnO91pi+wbVpVzfHlmo4Z4lKYAH5ItdiWeHhRODiQtVvzTWOsB8i6zzPRdo0JA9
	 PPJibPHZgR9Njr2AgU18QZnwO5ED5P2vCxxa0Abp8T1QnIXOKeOtAlahjZhgWGRFxy
	 7Q5v3wkuTa5eb2rDNUy6EYqX5FbkS2ivgwryEAI8=
Received: from github.com (hubbernetes-node-41e8427.va3-iad.github.net [10.48.67.81])
	by smtp.github.com (Postfix) with ESMTPA id 0FFBB500981
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 03:29:30 -0700 (PDT)
Date: Fri, 07 Aug 2026 03:29:30 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1142087/000000-7a64bb@github.com>
Subject: [bluez/bluez] 7a64bb: avdtp: Fix use-after-free in connection_lost
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

  Branch: refs/heads/1142087
  Home:   https://github.com/bluez/bluez
  Commit: 7a64bbfbe39d139b4c890de6ba272183b7a29b61
      https://github.com/bluez/bluez/commit/7a64bbfbe39d139b4c890de6ba272183b7a29b61
  Author: Jinwang Li <jinwang.li@oss.qualcomm.com>
  Date:   2026-08-07 (Fri, 07 Aug 2026)

  Changed paths:
    M profiles/audio/avdtp.c

  Log Message:
  -----------
  avdtp: Fix use-after-free in connection_lost

release_stream() may free the session's a2dp_setup through
abort_cfm(). Subsequently, finalize_discovery() passes the same
freed a2dp_setup to discover_cb(), resulting in a use-after-free.

Call finalize_discovery() before release_stream() instead.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
