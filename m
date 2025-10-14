Received: from o5.sgmail.github.com (o5.sgmail.github.com [192.254.113.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB7E307482
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 20:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.113.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760473992; cv=none; b=tEriDFU7JX3RFgLTEzs0q/qDd0IT89JYbvnWLZ144HGIcdV/LIijiBk5dUGl2Hd0Qv04rzLOrapddK4WumxpFckEnxZydYWhkYB5j8XMn0/ugw/ChPJMnGID4tVOOwYYdyxt/ac/eJ1Q4/cygDAQ1nVha1Az6JGFEab13gavwCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760473992; c=relaxed/simple;
	bh=TMK5x93rX/lsi4tBgCe6zl3oUtoGCXJpJbRUr4klhjU=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=VooHVQ5cUXm0kBy4LlLY83Bg9GFg5Lgyth/1EjKQGOAwEaoxvLY2WWfvzCm+Xzou0NMg92zksoVpbFRf2azZAgDjKnXdu4ZW5MfXc74VbHt+H1sy2UHSPfJc4L8cuVDzl/V2C0SYYvSdd/jSeIBK1GVHFkzKnRMLOyuLjVZ4dms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KvSsY0eL; arc=none smtp.client-ip=192.254.113.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KvSsY0eL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=dWcx5Bqztx0bdBzbkb9Pw5jGJpvHtXbNdjU/huV9uVk=;
	b=KvSsY0eLZSqVr5kB9GswG2sABlcGRW3xgfrezIJy95M+ybM3gZZmeMzxyfYhpe2nXo85
	mHpsD9UFrXkLgRgX7bm+uXS+3FKMIf/TJtsK4t7CcFLghxrNLe3Xk4aUSpH8f8Grjh2E0S
	R7bl0gIGIRK2AMI+sWgtA9o3ccT8n69CM=
Received: by recvd-586fc64576-b7sqq with SMTP id recvd-586fc64576-b7sqq-1-68EEB385-20
	2025-10-14 20:33:09.71624661 +0000 UTC m=+11418531.952711341
Received: from out-20.smtp.github.com (unknown)
	by geopod-ismtpd-11 (SG)
	with ESMTP id PpW8C8VySpyZ4XTO9YRm0w
	for <linux-bluetooth@vger.kernel.org>;
	Tue, 14 Oct 2025 20:33:09.680 +0000 (UTC)
Received: from github.com (hubbernetes-node-db334a0.va3-iad.github.net [10.48.209.94])
	by smtp.github.com (Postfix) with ESMTPA id 34E218C091F
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 13:33:03 -0700 (PDT)
Date: Tue, 14 Oct 2025 20:33:09 +0000 (UTC)
From: Luiz Augusto von Dentz <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/1011517/000000-951647@github.com>
Subject: [bluez/bluez] 951647: transport: Attempt to reuse object paths
 whenever ...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: 
 =?us-ascii?Q?u001=2E8ki=2FFbqwlQO04QBiriT34f6qhM6wd38+BQvADylPPTIQmeZqt0Mdj+E9P?=
 =?us-ascii?Q?ngWQlMPxccS8u9EBUyRL9UmZaAIAuRr+mgNgA4u?=
 =?us-ascii?Q?+4BFmaFkTzqydKOFHZJCRaORaRtl+XBfHduSI9p?=
 =?us-ascii?Q?m+zD5BtZfFS9a491d0BMgE=2FFD05Qn03HI9Oss1q?=
 =?us-ascii?Q?Cjhb30yrNZT=2FfJ0f=2FrTPwx9rrwhRLAQ=2FfE+37jg?=
 =?us-ascii?Q?fgu6Gvkg8LrDoPMdzPe2oMhuq4N21GVlIPwimbZ?=
 =?us-ascii?Q?=2FFnDfcPbBRQ3FQWYk=2F+JqdrJlg=3D=3D?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/1011517
  Home:   https://github.com/bluez/bluez
  Commit: 951647a67e420966e930ad3320b405784d76bac7
      https://github.com/bluez/bluez/commit/951647a67e420966e930ad3320b405784d76bac7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-14 (Tue, 14 Oct 2025)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Attempt to reuse object paths whenever possible

This attempts to reuse object paths whenever possible to make
scripting a little more predictable by not having the fd number
being increased regardless of the actual number of transports.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
