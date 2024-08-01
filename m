Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840351A0B0C
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517958; cv=none; b=HEqRNyCjdRpf4wzW8Sp+7f/oSi5kXx6GLGNDA3kBrFTqxeBLAqoFb5MC5khoOugicFN9lBQDdLQGHw23A2tgP1LAd6t9CfBDNys30GThZ5qIz5KlqFc8h3MtkcOL+b5MALmfmwsfJ//XDXuagtbk6MCMXVW2WtrvhM7/C+5UmUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517958; c=relaxed/simple;
	bh=eCP7QpTaLNJo0bDsB4+HA6lgQNr04uy1wsOIANCz8Dc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ueKA3kn92gKIeAykqVkjGvN50hFBUh+uJKjo50KkGZ6luHIICfqvVwhVA8GqbgVtPmNc7LzRdJALQiqva0/QbxXacEVCczS9Mb+woC804RQqTxVs55aUMeirZmMsFc7k0PfKqeGRzxHELGL59KejhD4Y+LQX8HaYVeIJNJSoWPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JpCvlfJ+; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JpCvlfJ+"
Received: from github.com (hubbernetes-node-006e911.va3-iad.github.net [10.48.133.43])
	by smtp.github.com (Postfix) with ESMTPA id 8DA194E0D63
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 06:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1722517956;
	bh=QtTBWBhHYKNAUSysdIHUI7m4QA0ZJYz/+3DZUuwa2HA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JpCvlfJ+tHDUN+QWncJnzzJhPh45J700XrVwkjs4Q2q+KMb2EgOCgDil+/DeO4NuX
	 7TtV1sKo2VPQ3JEBzYxigniXllcRIpmvkY+zpDD++nSKjj9uCrCXzkSEtgn6VlhSOb
	 247+hxZm5bXLlv2x3YnmnYYYPOiZKNd9aHA67V4U=
Date: Thu, 01 Aug 2024 06:12:36 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/998104-100c84@github.com>
Subject: [bluez/bluez] 100c84: shared/bap: Fix overwriting sink attribute
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 100c845b2d20e7f4f96b371e044b8b59944230ab
      https://github.com/bluez/bluez/commit/100c845b2d20e7f4f96b371e044b8b59944230ab
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-08-01 (Thu, 01 Aug 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix overwriting sink attribute

When allocating the sink and sink_ccc attribute they were being
overwriten by source and source_ccc attributes.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
