Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8543129D26E
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2026 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781893371; cv=none; b=tLz3fHXlZd+YM0ft+0UT01BKadYejw3UcvwULAITEewELFasZvM2Pd56rdVRZcdCbfzFvPl8SxBsX1MkWS8Srcs0ysuYE7zYGVykrQA/3CePmwzo+dThUrr5b+n1r2npG5D3z3UjXtF848zYDq/AQxq/pMZ0xwcBuRT332WA0Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781893371; c=relaxed/simple;
	bh=rE/v86iBxBvOmBzFFwGJs9PjbpNzddkxOt24RJ0FM8o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CMkvik6PHWkz700qPbCjz7Y2Bg9sRTcJPYEneBllRXKnRGl0XJQ3OdL9A1Gh+jIiR3W2RldWDS39STELr/jdlio5PrSNVL3Ca1DiStmVYHStiA5JO0mm7aIc6Sf+lJk/Y1w0rwSg9zgQpH263cDU3uAII9NzjrWteSq7nEvMRWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kdZFB6GX; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kdZFB6GX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781893369;
	bh=1Q3i/WaqoqJS85FwCyaITwJjmOvXmA34/NiEodQf+/I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kdZFB6GX31ljforljW/uLE4xquGb+KZjHd+2YKNzYHh1kFTfVON4A5wpQvDSxUBxo
	 x0Z+d0eJw1gx9JDJ8xObO4/mcXyAah1nbaeMovn0v58B2N3ArfpHlMKiCZZPQDWIxe
	 xFH5s6Gg2wJTOV43cKCbg7ottn2/09s6PEQva7qk=
Received: from github.com (hubbernetes-node-b94c874.va3-iad.github.net [10.48.12.89])
	by smtp.github.com (Postfix) with ESMTPA id B29C28003C0
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2026 11:22:49 -0700 (PDT)
Date: Fri, 19 Jun 2026 11:22:49 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1098168/ea64b0-000000@github.com>
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

  Branch: refs/heads/1098168
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
