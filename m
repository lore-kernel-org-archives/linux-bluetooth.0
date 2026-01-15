Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8B1312819
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768488664; cv=none; b=ItzVgq13u6R3bI6UGGgXt+Inv2/RM1MmfB13I9bzoopU4u5NCo6FpanuBm0vvbGz+/bK6bJj3t7qXQbgov8uPUXxEq0ajIp2TyN4mG3M3j4iZf8jXR6DyrfEK15OY5KzkSo/iYcli6UkZLBhKhqZzSpGFccfykZvzvPKuEvFg2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768488664; c=relaxed/simple;
	bh=dSDrf8jeg5RbB/cuerQFYrEKYuio8dfUjOAH5JBiM5I=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=mFipMftJDgbkbUtwWYUUYSfu3L5E78DcMEvBdFw/IhYaYeG7pbzgeHLVTtWTtOOm5QaYq4XiOhHbypPxjtDTsK8BTGWhzG/yN3fF5FXx7l9//CsztrQMdTmNdrfci37dGOabb2ETT/pcFpUbRChzNo40K4zaokoes7y04nWIJK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=T+AP9skR; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="T+AP9skR"
Received: from github.com (hubbernetes-node-baae155.ash1-iad.github.net [10.56.179.19])
	by smtp.github.com (Postfix) with ESMTPA id 7E2F5920968
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 06:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768488662;
	bh=AEepl9BezVNAvgNEEyyURhRPCpNUjdIwmVvvP1Lbnjs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=T+AP9skR2+6/BDz9Wo+f8wFYXOJmEMxl4/2WcLA7yosKXPX9RCjlHNPyM3wO5qIl9
	 zoIHDYlHebtNxiw/zl4Bz4O9WGIOwEi6K42Zn5pWg1xi3mxSPQV0l/9eWfD5jv7sZF
	 ALlH0FN+yCPUgtewZ2BtvRDfV4kb2kSPB8pq1WIc=
Date: Thu, 15 Jan 2026 06:51:02 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1042857/000000-0dd500@github.com>
Subject: [bluez/bluez] 0dd500: shared/btp: Fix typo
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1042857
  Home:   https://github.com/bluez/bluez
  Commit: 0dd500031eecedbeafb6e73b62c3e8d00e792b07
      https://github.com/bluez/bluez/commit/0dd500031eecedbeafb6e73b62c3e=
8d00e792b07
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-15 (Thu, 15 Jan 2026)

  Changed paths:
    M src/shared/btp.h
    M tools/btpclient.c
    M tools/btpclientctl.c

  Log Message:
  -----------
  shared/btp: Fix typo



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
