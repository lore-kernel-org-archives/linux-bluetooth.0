Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FEF4657F3
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 22:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774994403; cv=none; b=RYUCF3OFaNjStJI1b+354jQ4TA2Q4xFEzeDYmYJYErAaEkyhJzNWbNfEa5YEDGq0VtTSRx8COHKrDznDTGxJBTOpaVy3nyQoIi8kW6Ir8J92/lYB+TyggLe67nAK5pzFcBGyTFtQSMlcM8YAs6gNcemadvbXozZOI3ZtiJ4RWP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774994403; c=relaxed/simple;
	bh=1DNILWbgIQcXRnrZZ4Q8scWWi8pegVUE+8m+pvMC95Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jvPdZaB1JOK2wGlK8kIfZ39sUJfCTQE3SsjOOO3scmAM447cL3lbzbnSJ0PZMYkjSsjv6Arj4foyXN2mDdA1LAmQECPRsx8CsDcIoRjimvU3eMn8wqI03RWU7avgDYaNZpfM5rBJZXBFPlGoaFS4untwf7EfSzuG/dPOf6gCppM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Rnr8s7xJ; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Rnr8s7xJ"
Received: from github.com (hubbernetes-node-03dfe2c.ash1-iad.github.net [10.56.160.39])
	by smtp.github.com (Postfix) with ESMTPA id 997C19203FB
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 14:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774994399;
	bh=87onXsvQZSjlOu6auVtzKCPf5NNYfzRuvkcA2SgcKy8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Rnr8s7xJsNAMI2+x6VPEaJ3nG4ZBMzEO5ZjP2rhcwiseqHRK5xadfeGdDV0TQGDYw
	 2Ew7pqwttt5Bi5JGkIPEbdLrET6QjFzaJaeaHhvDhvDfgtf2ExU2Jjw7GCHdMt2GbP
	 obHSXFo/S29RiZXkzAnzADJ2r9+YnD/ggycKfVVc=
Date: Tue, 31 Mar 2026 14:59:59 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1075447/000000-c446bf@github.com>
Subject: [bluez/bluez] 0e74c4: shared/util: Add MIN/MAX implementations
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

  Branch: refs/heads/1075447
  Home:   https://github.com/bluez/bluez
  Commit: 0e74c4e43ddb701b8db16504b8b5c0273baac1c4
      https://github.com/bluez/bluez/commit/0e74c4e43ddb701b8db16504b8b5c0273baac1c4
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-03-31 (Tue, 31 Mar 2026)

  Changed paths:
    M src/sdpd-request.c
    M src/shared/util.h

  Log Message:
  -----------
  shared/util: Add MIN/MAX implementations

And remove it from src/sdpd-request.c to avoid a redefinition warning
at compile-time.


  Commit: c446bfe3cb10b8d2ce52661a715a3dfdaf576ebf
      https://github.com/bluez/bluez/commit/c446bfe3cb10b8d2ce52661a715a3dfdaf576ebf
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-03-31 (Tue, 31 Mar 2026)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Remove compile-time header only glib dep

btvirt relied on a glib header macro to use MIN/MAX, but didn't link
against it, meaning that it was dependent on other programs in the
project using glib to compile correctly.

Remove the include and use our own implementation instead.


Compare: https://github.com/bluez/bluez/compare/0e74c4e43ddb%5E...c446bfe3cb10

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
