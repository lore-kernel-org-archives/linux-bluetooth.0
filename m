Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4227B4A01
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748972077; cv=none; b=iQLwjXclqmB8R02zX90kcnV0NbRpZ+yOm05nH1C4pkUqG8UbV/BvP0n0aZfYx3WAWPvAduZjXUiYf4a1RCdfSYeS77z5iHXKBXc0Enh7vado1yEZu71CK4is9Lxi4bppqMLlE1kd7/tp5xegWnkBgNseqquWYa80iTEvVuIcZ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748972077; c=relaxed/simple;
	bh=tOxK/p4A0cSZejGlUNcd8kndSQBzLGdmRN+VwssDTOc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cO6VNgXoRxjZWqAsOtv/6PEHVUbMDn07Kp1nxaxLdj+OoV8NxfX8PCJwQWD70IN8GtiINfQ4C5pSdO6evLUTvlFR1MJ9xrIrv23Rw9RoWc4fQb+YmJm9PO0eDvscG2vmHv6Lq6RdPB0l+YBLIFvRbtG3rn042D3a8KgFokYAzLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QN7WCUhJ; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QN7WCUhJ"
Received: from github.com (hubbernetes-node-e176a6c.va3-iad.github.net [10.48.201.82])
	by smtp.github.com (Postfix) with ESMTPA id 635BF8C06DA
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 10:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748972075;
	bh=QoT/GJKMh3f2AdDSPxPB+LCVfIinOkOY5UF/7GkHxWs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QN7WCUhJq7JADBUIS0bCwS62sdI0r47Mu1byOhDw0Lb2dSW7kkc+qfDpW4PrGaiwU
	 /fyQInIsegQ1NL5T00tD2uM60dN+MKEjuF1Iz4T4S4UDuQiJvKZIIwhy9EweapiDGT
	 LC5tYM5avNIgYWGeFOFTPdnzFdXdSukbee1qmGAU=
Date: Tue, 03 Jun 2025 10:34:35 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/968153/b60af4-000000@github.com>
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

  Branch: refs/heads/968153
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
