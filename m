Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC9FDDC5
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 22:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761863594; cv=none; b=DsGRxBNbfigQdFQN5bs0Ju3RycGkddr4/sXCjnEoxpzEsln6S1d8TyVVumgkv9oL3OnH2/dcjWtSr+pEKQPIlCR4LcHadf2ziNnnV482aCC+KPSqybznwNbPbTMoP6kA5pdRsfZQwqVH4ZW8szeKDzb/YrilNbm2MsBzC4XRxi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761863594; c=relaxed/simple;
	bh=nDRCXzlb/zEfm2LpVS2mQK2CSlhOupx2+qVLiBLK7EU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=od9/UX1w7SyUBiitVJFmukVhlM7I5RRrxu9ddhJwNOPecTOs/1+NZQuo2fam6Pl+DEccoJpvbeyHUfF/lg5GjLo0qZfeANWuMKlyZLSscA3fectuf9zJ6s3gNLmI87XcuEaRX61hNdLlxj0xqw0qWf55YAxiw4k0TH9hcl7InxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cCXW/ZcQ; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cCXW/ZcQ"
Received: from github.com (hubbernetes-node-ad90194.va3-iad.github.net [10.48.221.39])
	by smtp.github.com (Postfix) with ESMTPA id 3BA014E0B49
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 15:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761863591;
	bh=pQwOPLkJkaFTAhD1kEiGcJl0QEMh13sSY/tLQa+MjNA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cCXW/ZcQ+LXLofZXU12/j139IkvE2viITO3D2X4aZc27JzAPyXzX49hcwnZQ2FRXP
	 sVn27X6fp9BMVxic4hUiyRqrcwGOiYYfpdTcT+PuOcqEa3VRl4DBOxKCtbZbT2HPAb
	 ZGZeY5etMIjKL97ZPzZqSRi03+d9z1/Hzyf2lLGs=
Date: Thu, 30 Oct 2025 15:33:11 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1017886/1a9f88-000000@github.com>
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

  Branch: refs/heads/1017886
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
