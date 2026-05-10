Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D73633260B
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 May 2026 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778408465; cv=none; b=BSXC7GlUa+yALQpFjrYTXID+X0GVXTOcuf6wUVXBwnt5VPaq43itWy1Gu9nS5/IaVEh1obsXdrCX07CnW23elIuc2J+lSrki1LjUtKvSAgJv+ux/T9dJhtXy++DoCMlNGwvve6vDuYVgLBx7ZjxqyieRTkTdlUV3/qEbPj1ezrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778408465; c=relaxed/simple;
	bh=Vz0iOJi1RDbZkAcsAeKgq4xqY0vC1QWWvORK6sGQOzQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Ghj2uLhEuLbtoygsoA4+m8eHoru5qfRYUdg8t0zxLyvCVnYTtJajNplR0dH3zHueegx+1vsI7RRb6+WNvhVP8uQUA3jsgMW/IXDwd8mkxWDvuye8DuwNGBxaR7jqkpuUr9q17fJtmUWz5IZ6y5E20BFQRxUxf5MoP7SUpdaIZPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kpGP85bG; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kpGP85bG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778408463;
	bh=Fqmkur3es1cbilvtYEqITuucF6b7Q+LRZVdzHe+ZXog=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kpGP85bGeiIgnNq3YSbPEeXL42VrdCjVo8ptJiqO+ZW+Zit0xofH4l2ILW8LITYLn
	 cq+3NjvYHegS6fmov5n1rM2UEgilpisrEQqLb/3g1BZY6N4vlJlKBOoK6RENeDsfpa
	 yGcJzY6G0g68V0fp58cGAOVOsOKX0SCLLrTsPzy4=
Received: from github.com (hubbernetes-node-df451ee.ac4-iad.github.net [10.52.220.37])
	by smtp.github.com (Postfix) with ESMTPA id DA7492035C
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 May 2026 03:21:03 -0700 (PDT)
Date: Sun, 10 May 2026 03:21:03 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1079646/b32f3e-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1079646
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
