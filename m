Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0DD3BAD9F
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625378; cv=none; b=k1UG/UoMrduTJBih3RkEiAFBhqTq46adgCk7K6HNLJoBYg3mnWM8JPOXt7IPXQQT9SfaGhxNe5WkBxxDqhsVQTxLRZ4UfXqP/DF2OTZSyOnwZzF9IEmEGF22RpE0a/44vsPHt9sbj5P7PJWJthW12U9JUu8xqlopCZzwHbFO6BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625378; c=relaxed/simple;
	bh=GNz2W7baZacGiH3R2VoyjxhUJMcxqWAr/kKzgYVJDcg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Ysw/eQyempQajU1PA5PljvFNld3gYsqs+LWaoo0amDNX00OzCRKEYfHM1cXNTVh9jnv5TDoHhOFx4EkP5t9Gc14QEm2pn4ej4SkVBOt9paBvFV43R6RiGd8I/JLbKOYrDpsb8lOVoOUQP7stQvwSQ+hqslW0he2ZvF2JRbUAps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iRO1P4HE; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iRO1P4HE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784625376;
	bh=KMgTs3xj0OhlIwcObMssZMHCQFflZEPbeHsIqWl88UQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iRO1P4HE+0hfVEMHYntn5k/AJgVeZce0dtqr2d4/LL3CLazMuE8o9S9KOUil7cVWI
	 gHvoawh4N8bEn1UewpxFxtBHi+PysEx8fTPubGR89Ya2sv+4nsHPFY2ttkoD6iAO5T
	 0qKtBIDsdYwM0eTadV3aFWSN6JKYFWNhWf+aOEKE=
Received: from github.com (hubbernetes-node-9f92d1e.ac4-iad.github.net [10.52.184.34])
	by smtp.github.com (Postfix) with ESMTPA id 7CC537810C4
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 02:16:16 -0700 (PDT)
Date: Tue, 21 Jul 2026 02:16:16 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1131452/000000-a12498@github.com>
Subject: [bluez/bluez] ede1b1: rap: use session lookup for RAS operations
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

  Branch: refs/heads/1131452
  Home:   https://github.com/bluez/bluez
  Commit: ede1b10d67642eba459a9b9b8860d844ded0997c
      https://github.com/bluez/bluez/commit/ede1b10d67642eba459a9b9b8860d844ded0997c
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-21 (Tue, 21 Jul 2026)

  Changed paths:
    M src/shared/rap.c
    M src/shared/rap.h

  Log Message:
  -----------
  rap: use session lookup for RAS operations

Store disconnect information in RAP state and
centralize attachment handling through dedicated helpers.
Add bt_rap_get_session() and use it from all RAS
GATT server callbacks instead of the previous accessed
notification bridge. As part of the cleanup,
remove the accessed callback registration APIs,
related notification code, and the unused timeout.h include


  Commit: a12498ad4b814638833fd7a2f2b35e24ad4799b0
      https://github.com/bluez/bluez/commit/a12498ad4b814638833fd7a2f2b35e24ad4799b0
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-21 (Tue, 21 Jul 2026)

  Changed paths:
    M profiles/ranging/rap.c

  Log Message:
  -----------
  profiles: centralize reflector setup

Add a helper for reflector initialization and track D-Bus registration
state in rap_data. Simplify connection handling, move interface cleanup
to object destruction, and streamline removal logic.
Remove the legacy RAS accessed callback path and its registration
handling from initialization and shutdown.


Compare: https://github.com/bluez/bluez/compare/ede1b10d6764%5E...a12498ad4b81

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
