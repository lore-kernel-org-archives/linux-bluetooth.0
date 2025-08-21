Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA572E3718
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797778; cv=none; b=OblyHJyu8nAtVzDTD8hOE55REcgpnHlk2TINNcvf9Dt3qgmspYOMECL4teyPP4yTtezpYuDVossFnV1ecu2Md0R6hGlTOv+fJpNIeagegjg4nk+X8cptOcBjnc6vJUsAfN8KXRD5Izl8EQjYKHkuCDROKCCBi+eInXZtWv6x6Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797778; c=relaxed/simple;
	bh=1haLGdJ3XDpzve+q2AxGd601lv0vmporu6YixwDBgtM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KXOSVddgPm26briR0lstmppCD6K9bY1brKp/bXOT9Zwsfr+1iTx0kElFu9yOEL+OqQpNdDBc1INk7+KvadPcoBiftoUoX/pDnz4fLLxj/kPY9g/J2B3uu0WN1EvpG3uU89MhhkCCyZhWyU8jxdEoBYi7q7Da7OUtQoVKYzQFh+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NEDphFQJ; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NEDphFQJ"
Received: from github.com (hubbernetes-node-34c8121.va3-iad.github.net [10.48.143.35])
	by smtp.github.com (Postfix) with ESMTPA id CEE368C0398
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 10:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755797775;
	bh=op/BS8TvfjjfUEkUDW10JIshm9LJrzCVG51m0ZF7djM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NEDphFQJtw+CN/21QTtaZc3ijWtzBGWkFrCCMGF1T3tBzjea2XsLBSAOuX7jyzb0j
	 v4Qe6chVumwSsQt04dzzRWqazEv8bPw1ugAURhxiDk7fN8EZ6xzIlQZbCRr2auDnUi
	 aoryNZTpPHYFnU+ARfoxIvTuiEfoAVV6eA5sAW20=
Date: Thu, 21 Aug 2025 10:36:15 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/993547/f47078-000000@github.com>
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

  Branch: refs/heads/993547
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
