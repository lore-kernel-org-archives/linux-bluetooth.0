Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E843DBD53
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774994404; cv=none; b=Y/jJX2fllohjkKqplr+3V+fUF1BOHbuL7yqEHc0hDJQ1L0V5nvMMRHmOrmNilCuqC0iqnwqlD/X1f5dor+s7LGRNszaDx1OIcreOUAoaaqQr+VsaVuQOTvYRen8fAg0kByqOjT54q7cUPpht/ehzYDEN1CKKgweDNPlmRUAyg1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774994404; c=relaxed/simple;
	bh=xOGFhw47/E+s56Az48VmvvRkWSISnGOHkv360bzvmbc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jFM7UvR7F+gLCybYxxLWayHFU0ulXSOT4zMb8ghtkfYZnb8NhTmGtQVc7rVz3HmRZ6soLFHWiti8tO74m0vGPkxHQRCU6HSRlg29cEI8DZjySQhJD0L4ypLCLj0cRtfOXdCWjpn00CcJsbCq/ydYiDIUGZLWOCVUun1r1Bo1y1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Y1iGogqF; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Y1iGogqF"
Received: from github.com (hubbernetes-node-72d0bd2.ash1-iad.github.net [10.56.156.46])
	by smtp.github.com (Postfix) with ESMTPA id E558CC11A9
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 15:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774994401;
	bh=uzH431nBUFLCuBKHtQH+q/mrzQcFeEHmJO1JkR1dLwg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Y1iGogqF1LvZw1xuXSHCWmx9K+vSRnbTXAUrKQBCxI8dPlztnHJFh9Od0jvoKfLY5
	 KVjvjNUlfUn/LXemEZNX2GdBqiVFMre0YiRBrhUjI0dmSgoJpSL9zXUr4kArnTArL/
	 r3ToIRqXF3Z/yByU2wocXY8E3Jr/WujaBwdfrBKc=
Date: Tue, 31 Mar 2026 15:00:01 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1074645/bc752e-000000@github.com>
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

  Branch: refs/heads/1074645
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
