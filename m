Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAF7A937
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281867; cv=none; b=K1zYzQ6ApMpVd6NTZdRdrvJ9+KM4XwuCco7aF57n+Ea+7Z5N5kxRaWSQq7LEN40xwVQqwnNsnRdgwNClbCI+SUuHf70FXna5fyDHkdYDtftMOffTc38kfFyitVq3CpA2SF1mkB596BsZOeMhFi6NGWdd6flc4o1PAf/W1mYAneo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281867; c=relaxed/simple;
	bh=VjmLDjkuLDQs1gjljdLDe5/lvG4lJN7DwmNiuAbZTnU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZZxhvdr8lTisEJ/vZC0SxyCF2qkEZAFrVHDRgP82xnHX73jdxcescyiKzdPmiz3A8lV/U5s5kEIjr7gg8rTtO4fCmXR/lSvdv9CS3EkwNcwsalie1uy+59dnKRCoIkNMM/CTFiTxhxdLJf7piXtaYOZ8bNju8I3KjmKnQwegHLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mifXX8X3; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mifXX8X3"
Received: from github.com (hubbernetes-node-6c20b7a.ash1-iad.github.net [10.56.194.51])
	by smtp.github.com (Postfix) with ESMTPA id B40C89211F2
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 07:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753281865;
	bh=qba+9VP9O/YGg9buTkbmXUgFhX3On39CWCf1BryzC9U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mifXX8X3OftGR7JcOcFHM3rFDQ9C+77WG122dBN9oyIhxUb3+cVVhPDrqOnbTWldF
	 qDeeWElm9LDexrtgdp7ai61YFomLa7lvOEpVxYiNreE/YbSqR38dpiKly4TBzX5qQD
	 eOgZWrCy4EKpnkVDuUR8hjdVX/PmdPB2Oi/fYpwk=
Date: Wed, 23 Jul 2025 07:44:25 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/984445/a69ae4-000000@github.com>
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

  Branch: refs/heads/984445
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
