Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8919A1DE3B5
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Jun 2025 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749236495; cv=none; b=A091ISVEl6QlODNH41GU6jm2NyaKD7OePtdNAESwc+OSThhxr2GCL25OZ3O3UOqhj0G6MoBluGYOlKYu0Qh8bgdQYSR1SzkbE/mTKQEi/4/6pHCocAXxWfDs+zmd8ENG3/rHdAb/UH8CPt7jWUstkRrsTAC/1UtKTDACi7JjU1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749236495; c=relaxed/simple;
	bh=zZialDVEb25cDk+PW33zxXHVOR35Y9/U9tTamlUVInk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uUx0ia2sAwEGTtoZSVT3qlXSIvurZn3X0PMBC+06BfNhfiQBnEZJmUUYKx1LsWal1LhmOInr00b4G5oyIP1t5jkzq5PE6AE6raY1H0gnqsIb5yd5GTXrKt3wEiG6Tnej6jm3NWEcVFRQkKF6PnsoIJMigDh/nkqoII9hI/8yo4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZEwQ31PS; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZEwQ31PS"
Received: from github.com (hubbernetes-node-d89bf7d.ac4-iad.github.net [10.52.173.33])
	by smtp.github.com (Postfix) with ESMTPA id 96720640862
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Jun 2025 12:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749236493;
	bh=r4GtA2xcKkUEg/9F0E218eZRaPxTO1xU4axJJvLec+4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZEwQ31PS1OCGCyB4aOh89OZ4tN5gpeDFoAMrpLLbclAWSzBNnzjGI96+pw2sNi4yS
	 vpG5WQB3va8fpEqOxM9Ike6MVysOr9FLquiRAIfaeXW6QSNuu1bt2oXcgAgmJhoSaM
	 74H0aDFtGM6OVi0CC7BJHVSqteLC1jqKGJwo7ByQ=
Date: Fri, 06 Jun 2025 12:01:33 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/969025/07a45e-000000@github.com>
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

  Branch: refs/heads/969025
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
