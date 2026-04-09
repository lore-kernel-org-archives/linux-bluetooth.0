Received: from out-35.smtp.github.com (out-35.smtp.github.com [192.30.252.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BA031CA4E
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766032; cv=none; b=ahqIr4hYyuVtMpI2/lTGBLMCRULDUYr5b26Swx7o5XL1Ul678JwascCQzug72I5P6DTDS947Y6x627nqwC6OB/zxENNdr4iJL8DSV5qhQ/w2OyAg300RrSzoP4FIWKJWtzqRE52ELvlJ+BfasYEBvCMba08d73PrIoS1sF/K3vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766032; c=relaxed/simple;
	bh=9TdmMxBBnheg+TMHenanN4Z1nilHSF6A/vnmM62ZTj4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=T6eF0Qe2rLljzAwVoOOYRZp/IgLTpstEn7Cu+HdgaTzG4fZbkr1z3wb0bYNyxxm8EARIsgU9TgUkEpQgdjAqrK0bAZ6NcYZHn4R3CqDS27mfWZWem3pLfOkhEcJzhfBdpleaxg7QXYydFzxSal+yTQlL6x/DWOCpiA9fjCBDIeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bBebl2HW; arc=none smtp.client-ip=192.30.252.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bBebl2HW"
Received: from github.com (hubbernetes-node-f4bc677.ac4-iad.github.net [10.52.220.70])
	by smtp.github.com (Postfix) with ESMTPA id AB0667010A2
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775766030;
	bh=oLJCLGeeVB9cKzzg3OlXTfzZGFbJmXranFfmAKmA5Yw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bBebl2HW0G2uDU7PlI6nLNkk6hcecZM6/tvKYUt4Hg+5yID3ytKU+muRb5nuKI6S1
	 EQCPGH2XotD+lqNhB2VaYEb6MTnUWRJS9p52dP0NWKpv+d9szulm0je0RRF2VJpSnT
	 MVkRc9cxdZRthNwjU7/6HrFwKk4UO6EeHvXhfmiM=
Date: Thu, 09 Apr 2026 13:20:30 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1078904/24385d-000000@github.com>
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

  Branch: refs/heads/1078904
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
