Received: from out-35.smtp.github.com (out-35.smtp.github.com [192.30.252.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2681A322B6D
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 19:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453905; cv=none; b=k2zV3TXxnVA7UeAIAwsI8z0UBQxv75++Ma3rJDbY/CtYukBRkP+4wqVH3TGFkJY3jt5A66SdUMnoWtHvV6OSuwoD8vc+m+oWaZw5iSMHjGnGxmEQg8MA/Ihf4/F4vWtKqRuPTYBfbLnDzW9LXIJ4PsvzQ70Ttdt+v09VTbDi7BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453905; c=relaxed/simple;
	bh=Ph3hIfhiuGdAktCUojheq7CAsaxiaM713J7pKaIrv24=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pCEwmzxpp0kJUFLt7suUOV3CrcGMXlV4s7NL/JoPKmILqNup+//Lq+7wgL8OIvgzz/ZGjbNEGEg9fhaafo7BV5n05t7oU43vih6mH3aMJ/VOAUBC9omcYH97y8FrubaJ6xKwueTimdzG00BgN6YLJ3EUJ7ZC+66UIEJGiZoCt4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ing0VyCO; arc=none smtp.client-ip=192.30.252.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ing0VyCO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783453903;
	bh=LXqnra/51X/cr2ngI/uArZVjk4qVWWC2lkgSjwv2Dus=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ing0VyCON/fSIn9gujeXK+C9K8KgOvvOkjSNSkArhGKqI769hbQOammRfWchB0SsL
	 QtPI62Fwn6b5eDB5miPWpc9E794bbnLtsaaE5r589mKJFPkbHeplQ5Mc1hhzutiFsk
	 YbL96Te2XUiHae8oy6T3BFG3oddrK6/cssPNXVhA=
Received: from github.com (hubbernetes-node-54e58d9.ac4-iad.github.net [10.52.179.61])
	by smtp.github.com (Postfix) with ESMTPA id 4AA66748AF0
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 12:51:43 -0700 (PDT)
Date: Tue, 07 Jul 2026 12:51:43 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1123158/b98029-000000@github.com>
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

  Branch: refs/heads/1123158
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
