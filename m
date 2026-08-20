Received: from out-7.smtp.github.com (out-7.smtp.github.com [192.30.252.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28023368A4
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234313; cv=none; b=e1454cQakC9LNm0+hQ5F7VOa7M3H0SMIS1TVteHLI3KTVIPo+nhtfBhoe6YWXqXBGpCmS3AcIftfr7Pf2OiihWfKy2DHz+p+brt8mK4ae+m7dQNbaCzSTe72ZLY7d3FDHjFWUEuq+iJ3IjQ7qtLLLEAdwDVas5WAWWZFJi533W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234313; c=relaxed/simple;
	bh=MiShtmZ099jd/qt3mJ2madDqG7j45i9j5KeB40mzoeE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YSADigZYz6eKDoOf9L/lBa4qEow3fb0bcPy3mIC7/6zw4S0HI9M8tbM1ts4hxq0dWJCVVOfe3p1cPTOQ0pScqL3fOGEQMZ1vNpz6O+bm1L+fIOFTamYn59zB3rCK6tPwqlvJ2m+wizfVtqFJ9L/+nCRIywH8cmQl4MSyNRI3AFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=it7fMTYr; arc=none smtp.client-ip=192.30.252.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="it7fMTYr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787234310;
	bh=+YsRXKlDT5klMuoaLVphveMBzR7Ywniw/glw0Eigq8U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=it7fMTYrOljUabji1QEht3mVnxW/BT/AxczRVAwBSoj5CoKz+D8Pubs1Li71pRbga
	 XjlZWroto0Bp0866s/aqgIO3YVLt8gPA4ULNs+uGQP5Ro/GkTp2QtKnc9vVL1ikW02
	 4ZPVW15s7+bKLn4xkBniYzfIsPDYjcJbINvrbKSE=
Received: from github.com (hubbernetes-node-b06bdc3.va3-iad.github.net [10.48.173.20])
	by smtp.github.com (Postfix) with ESMTPA id C12EE7806B2
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 06:58:30 -0700 (PDT)
Date: Thu, 20 Aug 2026 06:58:30 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1149033/0e5f56-000000@github.com>
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

  Branch: refs/heads/1149033
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
