Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACD124169D
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 11:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769169380; cv=none; b=WAKeW0NNa21DuWUXxJzQIa6UYt1Q0tFbM/gcciWI6YwbW7UQaHhfre55Sba5t3F2C5p1mFkS/GRVdv/kXfTd3xJkshPl2VVyXkq5jjNehvrHtk5gWh8L57yUzP3G9lZDSRCNLETMQzZwfT/UtisiiiEoDdWFF+nUTDiXjMdB6Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769169380; c=relaxed/simple;
	bh=a6b5vcJyuzRFpCD2s+UAKIeT5/4yK+nFRBz7deSx9i0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nLvJbT1B/STR59Wtbc0U6bDI3GPoHVkA+UQahtAy6wWrkRwF26U695q99/pxJo9q0iWjPWz0INUdaUNWYwrTpdKyHLfSp5w3xLfukk/5LaAO5MJxN7ynyb4lldEWeleQfLRy44X2v5EEUytn4V2CqantdZAVrL3Yq7zALsDRUD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=J8bhnTwE; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="J8bhnTwE"
Received: from github.com (hubbernetes-node-0d39820.ash1-iad.github.net [10.56.208.37])
	by smtp.github.com (Postfix) with ESMTPA id 4EF309205F5
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 03:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769169378;
	bh=XoVF98LTDDb5L0F7SjYagxDpK9xzdqNqWPgfOrJ4YdM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=J8bhnTwEQ4Hkddlk76lbx2hsK9Il3kYEv/nhtrSI59fp3Cv+otlsx1qfIFWrGO/UJ
	 yG8+8EFXOKVfV1/zlFO6JVrXoJML6FhxnpWzSP7A6/pUZy4kdIH7XC4JE4MpeRK4EL
	 jwXbfztXSRc11dRPhJWGC9f5luyJAl4afVvVCHwg=
Date: Fri, 23 Jan 2026 03:56:18 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1046227/89bda3-000000@github.com>
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

  Branch: refs/heads/1046227
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
