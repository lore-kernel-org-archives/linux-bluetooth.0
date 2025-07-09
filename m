Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92583283FF0
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066346; cv=none; b=H8atc8hHEb4yRy+mukdke+u0QFDMmSlCsbvfQUKYo40miDL0h7YIMEsPNWMo5hDTOffS6/Zq7yNUixfTsNNIvmlQo5JKhIBMN6+lZe186l2WC4ehp/yXegxm059T6yh+OOFgzB2xqxcm++x2P716f2N56yOHhGNeVPU2OiPnJmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066346; c=relaxed/simple;
	bh=5DmyL4gfbiAwE3BXupOK140SxHDF7VZ59HXQjlBXpxo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UV7jAOW4Th8r698n/WxtKhW3oL+l3aeaQPUfs0kxJ0YZMkCsMddXq9UfR6hmVU5QXb9CpTZq0ZDZSS4N0G/JRKvPiaCQ9b7BCv6csMPcRMF+ypbLQYyO+ImKXom7IDKSnzD4GFSwroBH04bBHCNEAM70PFwNH3Eo0MiIB6yFdGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UixCjtxu; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UixCjtxu"
Received: from github.com (hubbernetes-node-b2eb4aa.va3-iad.github.net [10.48.210.101])
	by smtp.github.com (Postfix) with ESMTPA id A42354E1126
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 06:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752066343;
	bh=9G6cNXbHpAMQ1PruU+nmysS76WjQMQ4BZXme0MNn3VU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UixCjtxuT003L+9zS5t8ymMQbYgDUwvL6aXCScqggwWgel6yN7eTkUmpdMZ6E3LcV
	 NlaT9Ne4biR/b2b2tfIB3tTiAHN8DOuD2Y3ZY3Dy8s3nmW5HIbujddoIyGUchoC0AP
	 Lzv4DOITnFh1afVv1BF0Yv28t+TxmQBkwVCb0PQo=
Date: Wed, 09 Jul 2025 06:05:43 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/980014/039865-000000@github.com>
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

  Branch: refs/heads/980014
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
