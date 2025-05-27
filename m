Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC3925C6E5
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748355253; cv=none; b=eLaaevnpjr4uMj/90ixWIYRUhD5I6C4XrFGinmswEtB2qWy4VKBRba1DZcpJRUBh6rRbVVZ7SaUK4TqZ+x57mK0p04F52SiAXdUnxcBh7BHikzZZ+MBzal06XE1BdZCRsgW3jkcjQClqrfCorbvJxDEDM+J7BcEzyD9YIH25UKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748355253; c=relaxed/simple;
	bh=MUsiH7xPAg54bW+snVfA//V7c6mKkA0Ob9DnjguR4bE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BJzAciwdJM2XpKGUAdzxHX17MSLNX/7OxDR1kHg72Khh39bsy3SLvzitLBiN4+SXbzgq4Uo0mgPD0y1zhafSMLj9PXB98v3OIy0wxnTYW7xNsMVqYGACtz9MavD5mhmqJmMqf0e6qWTgKQJmcH4b3RzsNhiT3mxg1knSUnZj+6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iBMMnOb5; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iBMMnOb5"
Received: from github.com (hubbernetes-node-1a0bdd0.va3-iad.github.net [10.48.150.32])
	by smtp.github.com (Postfix) with ESMTPA id B66EC8C0295
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 07:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748355250;
	bh=NKbOrKJ9TtwsCCiPlBFq6AfL6S3HXm638QXO9KQEkLU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iBMMnOb5T0WbBhev03IVwIntZzJXtfZ7KKgrMJhDYttc//g95EPniP2IIjCKaw5pQ
	 Cih3519/rT/8oWp7dOkb5c7hWHgi2vDFJtJCtL92JBEYM1zf24QdA0P8Ec3PnKCgJ7
	 aaA8ON2UuhrA861yh7x0JNn1RRt6RaBCCJKWphDg=
Date: Tue, 27 May 2025 07:14:10 -0700
From: Remi Pommarel <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/966680/000000-99cf7a@github.com>
Subject: [bluez/bluez] 99cf7a: policy: Fix service retry counters reset
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

  Branch: refs/heads/966680
  Home:   https://github.com/bluez/bluez
  Commit: 99cf7ad1a011150a8cd7201fd4ebccc552964ef3
      https://github.com/bluez/bluez/commit/99cf7ad1a011150a8cd7201fd4ebccc552964ef3
  Author: Remi Pommarel <repk@triplefau.lt>
  Date:   2025-05-27 (Tue, 27 May 2025)

  Changed paths:
    M plugins/policy.c

  Log Message:
  -----------
  policy: Fix service retry counters reset

Control and Target retries counter were reset when service state
goes from CONNECTED to DISCONNECTED, but usually an extra DISCONNECTING
state is reached before going to DISCONNECTED. This causes retry counter
to not being reset in this case, leading to service not being able to
initialize on next connection. Source, sink and HS retry counter were
only reset when limit was reached, moreover HS timer was not removed on
CONNECTED state.

Reset all service retry counter as soon as CONNECTED state is reached to
avoid that. Also remove hs timer to match other services.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
