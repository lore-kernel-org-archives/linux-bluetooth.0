Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC5D46EC7F
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306722; cv=none; b=MdQr+0aWQkX2sg2JopJ/NFeiPrZ9oGLQ8eHY6l8sR6kePHYjb5GjT2/wtLwXNvH/jz0IP0unoovF2scznViuMSY5ggSZPn1MmTpg6rWom91FiRolu9yaDp1yTGKQt7mkPQ0lNH2VFrWBUrBADRJzaiWWD+7hP8rFv0o/2xK+TbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306722; c=relaxed/simple;
	bh=gFVYKgb07NWGSw78b9NFyuVo/LuJbyiVnvguuuxHrZk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cFufqQnxmMLDlFW7FZDHs69ZWFN0ceSZItVwzijTj/Yxw1yPkWXPhuv860Oy+dRzyaTII3Po6lHxw5JJb+MvBYv0mnfjUJMgoddMl78R/MubwGHyBSw8zvmVKGmhmyY/jsyhmUT+J7tU0BX7OSlJFPUUx/5aIlDpyikIAXKsG1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cwhbnDrz; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cwhbnDrz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787306709;
	bh=T+t2qsHGwBkEV78VewgSHVaWBVMwzUIinRTL2AkHGcc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cwhbnDrzgkXSc3Bh/HsjnudY83usYdgfa/rzT3v1qjny1Kq5HGCnvWcfxBcL2gBLJ
	 UxDbEqd8ymSoWoHmo1gn/aYeRFOnRfgv3qkUY3/7feiAP8N80CsvkhBrsio4RBiLf3
	 MndVPgOZnLG+dEwgaFL9t+YMDg0sqy6/2Ko7dXX0=
Received: from github.com (hubbernetes-node-e32b404.ac4-iad.github.net [10.52.140.46])
	by smtp.github.com (Postfix) with ESMTPA id CD0EA941898
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 03:05:09 -0700 (PDT)
Date: Fri, 21 Aug 2026 03:05:09 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1149110/ce7f2a-000000@github.com>
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

  Branch: refs/heads/1149110
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
