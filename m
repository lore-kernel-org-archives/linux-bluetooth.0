Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7865043E09C
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785422061; cv=none; b=tkDsQL/k8wrLGcxeArkm6mwClx5pbmAt2Zhy70Zg++RhozHXwifpb7iJ6dfRX0EScFQDr0TfBpaWTen+pMHMYi0Gk3sVY0lvQxSEh/xG393/7Wbg2O4UbUQdnR/uTDKaZ8uNdrtqfethb2SSFAbH7E4ZSnWs196tpBp1pjB88lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785422061; c=relaxed/simple;
	bh=wjThMoqy/+1YjhzSqlnDWVeq+i9QIiMGU5/i9muuyL4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Ugm7AtsGKI1AdD45dpaxInmLPsT6a0iiiNmDtjqgDjCaKoTr6mjjFeBczeUPFPZAMSowxJoZY82t+panVsSogn2tMBxWYVR3co2IjYr/cdJsZElCC1NcGzmirNgtpBI8kmN9T63S0rOCg65+LUCDGgGvmG0LvDCLABdy9UjwRrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=O0OOEorm; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="O0OOEorm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785422059;
	bh=X8H853ZNR9waiVbL3rfLEqkvZ9oZR/2uUxQfGwhnURw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=O0OOEormOMd2zlWAznSUy8xvT3wN2kiwzj6tVIUhMrFgqPFQhe/ax28I9X4q7kJPE
	 w1QiPP56IghnN8OJjrf3jox4L+sppf8w5VWcQjicL8/WecdVMRVbm1cJY6eiF4IAxy
	 BPMDUaSqnN+EmsJiNKBwpZoCQkrBjSmnxOcSynhI=
Received: from github.com (hubbernetes-node-935ba89.ac4-iad.github.net [10.52.177.35])
	by smtp.github.com (Postfix) with ESMTPA id 750B27810DB
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 07:34:19 -0700 (PDT)
Date: Thu, 30 Jul 2026 07:34:19 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1119059/74a305-000000@github.com>
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

  Branch: refs/heads/1119059
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
