Received: from out-4.smtp.github.com (out-4.smtp.github.com [192.30.252.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EBE387357
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775210940; cv=none; b=u9FmVqBS/lS6hEJlfqg28L317BzKWj00OhDq3Jebt1qD+TJlfgcSXHq/1u2bCpTy/MGunOHs40hXq1SAlFbhuUAaLynUF260cTsubTy0RMEfjiEdSP0E2dAsttGBUcp2VXlENx+bdW87TDF39rva49nFrfOdU3Dy6nwy/59K3eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775210940; c=relaxed/simple;
	bh=eD4IH6IHnXZEHkZtqfUyqtbHcthvYb57g0IHqZF+GaI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZWCexGgiKqaNCrkND++m7a+big8MQGzjNGv05hLlwKs+otSSRXJTNhqGf3QAipjnzbRXRb8hiPkYSDlG4PM9qZ8NoEKvib7n21QtK02dWQ2OjZHf1n0ETXMTuViViwftR+c7xDW3xtFID1keTOf2EEgap/FW5R2XGcpE0BQO91Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KkOUfnoa; arc=none smtp.client-ip=192.30.252.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KkOUfnoa"
Received: from github.com (hubbernetes-node-1d25aa0.va3-iad.github.net [10.48.201.83])
	by smtp.github.com (Postfix) with ESMTPA id 29F652C004C
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 03:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775210937;
	bh=KmeWMKgH5LcQAEaSIWklxqqVqB3vL7fhV8M7R7Z8rkc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KkOUfnoair98/qdeZ0fOVZP0dMw1zVdK1iDqGrrEyJtnEJRtEipwPmrZZyqG2saYj
	 Ts3cSMVHmFKTVQxNtI9PeKZAq/nRy8R8Ks/EARHVVgm9FY3tmHEFEaKomJDncxSevW
	 LEaa7gYLLumz7zZScdlk5x1lXf5IXH7r7k3Djkpg=
Date: Fri, 03 Apr 2026 03:08:57 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1068246/e4e22d-000000@github.com>
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

  Branch: refs/heads/1068246
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
