Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D7D285406
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398015; cv=none; b=ep0jJN+lj0qs/eZm4f++lVAGmoFWhxGbfBEuIBrp+iHDqYtwvp6RgMdZl8z3pkEOUQ6uL/19U6doesMYjMuJlc8y9D+DomTkArhPZJKoBSzEuEwsttGzSmijNTmnafpwSDA4uFSnR6jxqn9JG5clsxQlzux97lsVmNVOIpJDMtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398015; c=relaxed/simple;
	bh=xczVPB/uY7quPWB4tD5aRlzOxMS4/hxileTPnulNtPs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=I6MThdtwW3qY5ZtipBWoyldbTkpAdquRZQyPc4q7cmRWSCoC4z7/CQFW+/cE234RqGVgat3ew3RebkZGhFUYCIfr32UR18A1Do2x71C2pC9Hpjm268DMs2RBl0w7/CnGNyenkCZo/DxFhGy1MT/JyUElFNd1XQN20CLf5ctqmHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Fwa9qqDn; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Fwa9qqDn"
Received: from github.com (hubbernetes-node-ac3b3c7.ac4-iad.github.net [10.52.178.44])
	by smtp.github.com (Postfix) with ESMTPA id 99495640C23
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 08:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763398013;
	bh=cScy/qdOwO3kxNYISFz23RunapAoYKjxF0/0Hl7PXNw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Fwa9qqDnn3eBb9KLl0D/7HMwFNSHS9jTjVviE2SjuytngH19aBKxHNzK7mhBIcNzx
	 5jyyLuJ6W72faUiAMj6qZVL3Yd2IjUDjtECFB0iZlDRU9j3aBmoPv9/XeLfdPzefYd
	 40/ZDnEAQF2PJS/HnATFGRh1qibqGc5YGoruky/E=
Date: Mon, 17 Nov 2025 08:46:53 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1023990/ce8b8e-000000@github.com>
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

  Branch: refs/heads/1023990
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
