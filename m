Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151A5136E
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751570665; cv=none; b=gZNZrqBZlXqzbKHVBgjIiJd9cv0O8K0t+NxwJTmnwrA+L6F3dfyr6GuD9kRSB50hOTnpLt1triYvTnb3YOesXIU0bDWKqZKnAnf0jZtQa9jlSLY1jFm0nSWzoM7lRm2Mi7ChdKzNtidX7TCttDVg/+EJY8n1OwHv/ErkIU8rGiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751570665; c=relaxed/simple;
	bh=u9Hxtf5iupLwA3q1Tf1piCIv89PHVtFz9SojiSPwguA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DNspHkiXHCQmm6W+PI6ElZcukAzM0JW4ojq5XNdpNdu7pIPuMrazhV3emjnxizoibK4Ct25XS42vWTaOdwJU9UDx21YM9VM6EKjdPD+K4KuFkfKddXWZMAoyYjxoT707OsyrPhdJ8Y7tWNnreX+SltrIVwmJ0xLoGRumM/Jr0MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jilVm6d5; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jilVm6d5"
Received: from github.com (hubbernetes-node-f23db79.va3-iad.github.net [10.48.171.29])
	by smtp.github.com (Postfix) with ESMTPA id 2495F8C0397
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 12:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751570663;
	bh=0R+ZHg9iUTw0DkLdwLjHdsDHuHwxufumdXRN7+Uz3eQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jilVm6d5QEB+mt7MTuNNGvvLwdmGZYsqPp/vd28skUFdzVXMHHSK2aEmcArZIPHn9
	 Yn/+twrc44bDCKzmwG+EXl+pzXeJou64SSRE0z8ywrJFWOD4EltId5qPhhye6i2TOC
	 dgtCfyOhOGgzyTDQkZwIs6QXul6ieWTevN+V/rrs=
Date: Thu, 03 Jul 2025 12:24:23 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/978742/1f2db9-000000@github.com>
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

  Branch: refs/heads/978742
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
