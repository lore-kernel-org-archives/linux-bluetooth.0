Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BBD3A27B
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932756; cv=none; b=Vn8wo2NQA5Z1617GsKpzoyjoTOmaAghaSiEVsq+/QaTQanstTCtOvITTOAE99rH1Mx7Js1PS3x8L2Avrr/4GA/8mSmL+GK3/JWOXunBqyNyLt7B4Ay1GS8Khakf6Mxr0XoNdBv9/0QxAmwrx1ParOh0FcFKyQtKFSvkcx6IuNCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932756; c=relaxed/simple;
	bh=bp8UH3ErUvnUbElIOL74LoKU0Dnq0nIbhub57lnpQ1Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lFEQzAVqFl0eqB5jt+0e1YxUGqhXxqYe+cTq+RHbrzWhXFZ9hJitFNKsgAPbzd2wMzBy+yf13B2S39pEGPgyAnS93M8zUbBfj1m5Ge2+yHbX879nFeduV1L4iK0rQQwcGYuSYmDGoZDy2LC2+LaqhIbVz412CAkK9CyusNyY9P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LQQ22/Cn; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LQQ22/Cn"
Received: from github.com (hubbernetes-node-de53a38.ac4-iad.github.net [10.52.131.21])
	by smtp.github.com (Postfix) with ESMTPA id 6F92A5E0927
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 04:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1710932754;
	bh=MNekM830zbMeIrgTKUTjwrBbyE6XxWlbMQ8RBt/KCS4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LQQ22/CnLoH+cxXh2vOFxuDEJMZzEqEgPqPjzOaT4RBn2v1I7slZvGbBoACeOylwZ
	 WO2ktvXlPqpQkmiiEonZa6vz4gzKhDsnVFUIgDX6u5oHzTmjXrA1cdgs4hBsB4RDfX
	 nDcYJfZenSV+l8pV/2O54JmrlwV/2oyYbyCJ06s8=
Date: Wed, 20 Mar 2024 04:05:54 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/6c0393-b8ad34@github.com>
Subject: [bluez/bluez] b8ad34: input/device: Force UHID_DESTROY on error
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: b8ad3490a3507476844d6c6a87b2cb336f7d4eb9
      https://github.com/bluez/bluez/commit/b8ad3490a3507476844d6c6a87b2cb336f7d4eb9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-20 (Wed, 20 Mar 2024)

  Changed paths:
    M profiles/input/device.c

  Log Message:
  -----------
  input/device: Force UHID_DESTROY on error

If we cannot sent a message back to the device destroy the UHID device
since it is likely that the driver is trying to reach the remote device
which is no longer connected.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
