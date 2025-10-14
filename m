Received: from o3.sgmail.github.com (o3.sgmail.github.com [192.254.112.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E291FB1
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.112.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481151; cv=none; b=Ebhr/CDZsYGP7VMyb3fzo5H5BOCuLbhCoxqymPkmY+XT5kQf1DCMbL9+vj0bMfhDdSAw+aptRPAYYzeObdF/lL84Qcun+GQN6/xn8ZAI3tnN10jrj7rG3oiuJU/2OqEXKTD2njwhLBbwKroVg5F2Se+37orS9mlNOU+BETDC1e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481151; c=relaxed/simple;
	bh=4D+nWo5/I5UsEq6/OBWJ0JWL70CgYWdsffqz8SAIJnw=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=gptdNaoh7OvWVBybbDig4xHPtMkXazQTXHgxw81MhfWTiijVVerfdvD7w45Q54tvh7TcxVla8yH8SkZp/aF8dRj6F4Xsuv5VnmxaBkK7WnRNe8ummbOXHAyaaiSniPq5EKyNF9XSCWZBHp7ovmSkBjcbGD+G6CjGvuCjqBc4sfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EfoczkMz; arc=none smtp.client-ip=192.254.112.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EfoczkMz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=GX/Ovbxoo089HE2TLBcOHF3PjhXezqyEy+xF6H2zGos=;
	b=EfoczkMzyXq57rIbaOOay2762IBOgObZrQjR7oKysumr1vkV8vG05Di315utg0kWtmlM
	HS/1646VXLFF1GGohagPvG9oweA9+UlKYVVk0Y2A/H4UImPwy+TD5NTyP++2IIdijlVJRV
	9Jru4kftjRe2s3Uj3+xUEioxZ5pwFN6vs=
Received: by recvd-canary-695b44f4cb-qf8qk with SMTP id recvd-canary-695b44f4cb-qf8qk-1-68EECF7C-7C
	2025-10-14 22:32:28.974701725 +0000 UTC m=+11489042.380397100
Received: from out-18.smtp.github.com (unknown)
	by geopod-ismtpd-8 (SG)
	with ESMTP id gQ2xOcHyRqaYvK-ptYuh0w
	for <linux-bluetooth@vger.kernel.org>;
	Tue, 14 Oct 2025 22:32:28.964 +0000 (UTC)
Received: from github.com (hubbernetes-node-262f0da.va3-iad.github.net [10.48.124.82])
	by smtp.github.com (Postfix) with ESMTPA id BB4EEE0BF2
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 15:32:21 -0700 (PDT)
Date: Tue, 14 Oct 2025 22:32:29 +0000 (UTC)
From: BluezTestBot <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/1011519/3f1f13-000000@github.com>
Subject: [bluez/bluez]
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
 =?us-ascii?Q?u001=2EyVDaIUJfOTIVaBYkJvNzXFDwUvSfXABmYIMG7o2yQ0XjHiQN8HeKlKfUQ?=
 =?us-ascii?Q?+TD5y9uUDiSc3WCQ=2FbFOxbFL1vD43+vIgqf5wtv?=
 =?us-ascii?Q?B6jtUvlqLIelZosiiPR69kotC+7amvRBcEXdFMG?=
 =?us-ascii?Q?13dqX7fmJZAZ9gq2hTRWFeDuukd4KbYKu7g2VmV?=
 =?us-ascii?Q?WiTVagt=2FzoQcJY=2Fqgb4GsC+pKDBjjPWoYYHx9o6?=
 =?us-ascii?Q?NXQPW=2FnKf1OHMNqynjzbZI62RQlw+g5hGDKj8YE?=
 =?us-ascii?Q?IM996Cgzszv6J+NIuCiiRiKSEg=3D=3D?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/1011519
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
