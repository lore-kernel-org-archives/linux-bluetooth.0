Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776E144E052
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564799; cv=none; b=k+Z3NtcqhO2sK1qcnuxt4G7EuKQJijmJNhw8f5/4/L5k2kM2LRcp/yGk3weYmGo4QZrOpD3hJ/Waff9Nmr1kSEOtym/enue89dIfni17ZN/2e9dfv/mt82cdiR5rLQ+XvhN4P5n8OjvQIrIyXWTxZfDU0tpWiemmGJu0SotraV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564799; c=relaxed/simple;
	bh=PIJ9wUWHbHrFCa7tKdhjuWOb5zQOCNE4pIAsESY/IIU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CJ5jKmbqA7G/5upUkdyqftg5B6TOWE94nE+5mQL6xiqAlL1yE3aSgouu+4K+Wus4Kho7Optf4UvQB/KfI9o2Fi22uc6aC8szuuE+VeMiemKmztK3f4vOQ0Ko4018gBBOgsEch/hz5bQLbR/GSQNUN8ZxFvQKOmGUE6hwbO9086Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Uh71FPrn; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Uh71FPrn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777564797;
	bh=zq2LgmrSU2ab6k/0p/+3fcq44MT+amYHzTt2/8XJHAU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Uh71FPrn8hOc/hbwaFjQldE6Zf/mh4HnTBW1M3Z8ZpoRk1KjdxJcrGqK/UStkl18p
	 B9Lha/jJiqcxGgWFeZKr12kA+x8XTq6GchqJ8thZGXjHNIeyBV9JJorfUrF8VaAwn8
	 5eNnzu2dblgjAcb2xCFfuVA/paUduoDGcI/z0W8k=
Received: from github.com (hubbernetes-node-1308e3a.ac4-iad.github.net [10.52.13.58])
	by smtp.github.com (Postfix) with ESMTPA id 99D0378105A
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 08:59:57 -0700 (PDT)
Date: Thu, 30 Apr 2026 08:59:57 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1087948/293b36-000000@github.com>
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

  Branch: refs/heads/1087948
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
