Received: from out-2.smtp.github.com (out-2.smtp.github.com [192.30.252.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2BD54774
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 17:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778087922; cv=none; b=n0wltl2YGivHaYufSNjkVgqX/uCF+BzWaJlen7SsG2Is0RIWv3T3KChlytQ7vHDfYdmT8PbGeFBoV0kpz9B93iLLFqBp6sD9Hy5Y64gwbdq3PCQ6V2HI4IPLXrnmBRM+EiBboDibJ+fjnJYGubsYoY4M8JhK90MGPOv5FRgsy6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778087922; c=relaxed/simple;
	bh=QEedeiGy69S111/vZsSrMdzn+03efypbjOZnitWrpFo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bxKxHZU6Ahd9y7UbdKL3K46chxhsJFHeETT2hZA+IXj5mdH2Y8nAPxA3OS5bY++oHkNn+iXzI3rO/WtJkg+uCeyBm05EcxQ84TqqmFx3EG/FqZHUzIOzwx4dhIEFNNMSSUPf2CtQ/Arcqktlw2RIsiAAOdhSKtrpLM5a77fXCU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=g4a5nBjP; arc=none smtp.client-ip=192.30.252.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="g4a5nBjP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778087918;
	bh=aVVxmOoBGyIW52udgyBdMeRMD58D3qT0Uf0DR0jesi8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=g4a5nBjPwe5XHyvmfTcrVayskul+j3zo6x2qSMz//6lMZ0UDDNG0k8z22RV0RK5mI
	 HUdgOZzXAlUoCxtpJRQei+HIbQIryM2SJwxv3yRXvcua9TT5Ze/Jc5sfaMPvCE/r4l
	 pRvoxlXuBwQYcshahOZlaIb9VI27EnUVjd64buTo=
Received: from github.com (hubbernetes-node-e140467.va3-iad.github.net [10.48.176.40])
	by smtp.github.com (Postfix) with ESMTPA id B3F3C341162
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 10:18:38 -0700 (PDT)
Date: Wed, 06 May 2026 10:18:38 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1090349/036ef7-000000@github.com>
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

  Branch: refs/heads/1090349
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
