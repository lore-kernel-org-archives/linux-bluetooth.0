Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898071E9B12
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 21:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765403351; cv=none; b=YMrAn+qdNbSmYLuQdkhZprtEv+zCDJXXathondnKvFRBO/WkEFLNEhnnMi1kdRW56lo8xbC6fKB9KOro0wCkP135z3UdawDa7zDD/mGcZCVmn5KiIgtTh5b/rm8tEcpS9O6K/RAWcSZeKk5DRrzEpBjtu3Gg6DE+mMqblNdjetA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765403351; c=relaxed/simple;
	bh=NQtwKpC2/I6NXiq0dmE8lQ75to/Xx4edPUGGK4fKbVk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eSz2ii/o+x7X4UTg22T1HVjmcTIq3RCp0Fhk9G8WsYJrEVx8qXKcZCCohXSJ3iOb8kAR/JZbplGqaG1fFNsWPeSfQxR7H6qHZCE5w6h7IriDCEn5o1ndpmHgKERZa431ZjjIjJtKxqqKzdehlJusUpwh7bFIAetKPvxSBiMvIxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JPBw2qST; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JPBw2qST"
Received: from github.com (hubbernetes-node-c0e703f.ac4-iad.github.net [10.52.208.47])
	by smtp.github.com (Postfix) with ESMTPA id 83C37400CB8
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 13:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765403349;
	bh=+vS2AAD5dcrHwFsZA9bG/Q75A6eiN9VMHotvYt23o2U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JPBw2qSTfi7JvxQ7f5yW4WK1xdo/ss3lI8wkiw/WNxD9FxGKtkco+Hp21ZkI3RAVF
	 0w46fkWfGXLFmA1jhzQ1HZMJJuIpCL6m8OGUyspIaM3GwTDG3Af4OiOsnXl5wSyK+f
	 GDQXihWlN/cVEQbi2MfPFhLtEpABdncy+4fmFgKM=
Date: Wed, 10 Dec 2025 13:49:09 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1031813/bc2488-000000@github.com>
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

  Branch: refs/heads/1031813
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
