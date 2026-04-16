Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9003DE43D
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776348615; cv=none; b=Oavg9JRIzlOXT2bS3qrHI2HGSjDL0MdwF1Gi8WHsA5lqPHh3x/qJlLg+9AoRzZPthRPZ2eNHObFVvLh2oEnng6BAVlEj6FcgD0CbGKAVW5KxNBYcqqw/PMSfcSTcS8rDkpFdDr60fPuD21nGdDC6KT6G03IHRq/adR9F87X7Hj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776348615; c=relaxed/simple;
	bh=+rM0ZFSQNB/gri7Qwm1xYcLGcV0rw4NnfYj0HiO9F/Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=rQrVdkE3GhbmH8N0ytvjTkTC00G+NE5H/IxXaOIeGyHHUBVgdfpVJw2j73L1qaKZwKwvwU4rV3sBC5+HSACFLpo6NGV8kw/BWfFJl2Ql+3sbB9FRu+J4HBlxUqoJcZMa3eJwWzxxQjd+ZhN4VUIdamCbxyv6OhkVAlM3lM7WsuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=T5UUu0mq; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="T5UUu0mq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776348612;
	bh=KhsjBAoUCzqcGRTqja/cwi+w9cWp4cN2gzjc5N0aP/Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=T5UUu0mqx8A4kUeP5EfzGCCb4P8J/m08jT7oGP5aEs7ZpxW/Wu1o6Ytu8O4gCTOBZ
	 bkc8oHLAur41y+/qCHBSLMx1pX9L3fdmneyTdIsdFJ946Cg4pqtIwawJSBbiJ8FGAi
	 GWxiWtZ6J2p3GRxYVmweXPzRNqkVKB3+cBqUfPQ8=
Received: from github.com (hubbernetes-node-12e456c.ash1-iad.github.net [10.56.209.65])
	by smtp.github.com (Postfix) with ESMTPA id BA7141812B6
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 07:10:12 -0700 (PDT)
Date: Thu, 16 Apr 2026 07:10:12 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1081747/76d5b3-000000@github.com>
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

  Branch: refs/heads/1081747
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
