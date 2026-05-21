Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E0833ADBA
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779364543; cv=none; b=lczvTpiRwP7N2ULOAdBm/ahLJEuG0HDdSpuEB+FdUcT4CtJiG82qbQ5JNeCElciEju1GGwpAYjlC5bqjmcsZzjAknH97Y9Uo8EFpJv3FD6rPWOWYLI3U0ebkGL5uMO7+MzX6809o/zI3MXJIk/txT8g8T79I/DCk5AVBxGfFDv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779364543; c=relaxed/simple;
	bh=RznKf29oBxYWLz3cKg6pv6evGOH/f1Q28T9Nmv1Cj6E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=p63DmxIItpQh1vwg/CHNWvL/u42ADJRR7FNLxSE3MbAlFD8fsimgQfJo9JdAshKYuxQH+tFbQAZNVJBKZyzdiYt07ixYFu6Go0Tu6zCrOESj+KsqDjXFjrt8Y458dgbL3ehdfwnT8RPmGC1n4DHy1yU6NsuJxmBE7c0cwsdaVLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Eb/1weX0; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Eb/1weX0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779364541;
	bh=WyTYnSYgK/vq2AhF0k1caqaNW5940IpdTRN/1VPbFWk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Eb/1weX0Jf/BJQmMebfJxUrnwThWYqT+XLBz276cnTiGoX7n92UtM40u8AqDvsj4x
	 TDw8Jx+NVaAM9ZnL1IMDPBRzFyZpZPQc+MzqEXT9gv+ouxJ34H7rLsvMzA6ZbaUvuW
	 yHKOtaoR33FVwZ/qHqzFAvR9GQJNj5F72ihpKY84=
Received: from github.com (hubbernetes-node-933a61a.va3-iad.github.net [10.51.89.42])
	by smtp.github.com (Postfix) with ESMTPA id CA9142810E5
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 04:55:41 -0700 (PDT)
Date: Thu, 21 May 2026 04:55:41 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1098658/000000-090000@github.com>
Subject: [bluez/bluez] 090000: shared/rap: Add client ranging registration and
 no...
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

  Branch: refs/heads/1098658
  Home:   https://github.com/bluez/bluez
  Commit: 090000d083d1fd56fd3379640ba8dca983b05e23
      https://github.com/bluez/bluez/commit/090000d083d1fd56fd3379640ba8dca983b05e23
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-05-21 (Thu, 21 May 2026)

  Changed paths:
    M src/shared/rap.c

  Log Message:
  -----------
  shared/rap: Add client ranging registration and notification parsing

Read the RAS Features characteristic to determine whether the remote
device supports real-time ranging. If supported, register for real-time
characteristic notifications using the reqtracker for the CS initiator
role.

Parse incoming segmented RAS ranging data notifications by accumulating
segments via iovec and parsing complete subevent headers and CS mode 0-3
step data, including IQ/tone PCT samples, once the last segment arrives.

Changes in v2:
Removed unneccsary DBG logs and unused variables.
Use helper functions for readablitiy and code indentation.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
