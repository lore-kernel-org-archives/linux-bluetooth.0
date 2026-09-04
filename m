Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F5E422556
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 21:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788557837; cv=none; b=HPmDOld8CypG1uIpMX8cEHiP2mzS0JE4CsXrGAFcPP/eXb+vcWmF3qYBhPWmHxAH5hD93YHx4ubQnOZlh8Rgp5/P6kR+CvfJmQokR4NNDwt6pn5xE/scowqwnrJeiWFa4cDDfcYVlmaMHe4e2Bjjje/kcs2JBrYwd+BgWhipMMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788557837; c=relaxed/simple;
	bh=2uYiqeFsWKxZpHTjzwzcrX7arK24fnJvpUUeGRXrpeY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=sgNNVVCzH4+wWmkbsDo1xveAfnAR9b+nQqKrAW6O5uLEG49/us81bHgH9vgZn2MmfCuVontjdCJzYI9/77HK65LS9T+1AVp8xKLvWGHleXiaHISFOtdjS7mju4Pk2hSvfcwpDC6FWFA78hr3GtkQIpRn8RqZIBC/TGruS28MILY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hjqcXyMd; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hjqcXyMd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788557835;
	bh=ySqcpMgNjM1ufjrZvmeyGhEnSkt1KwWB30DdrTz/XVk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hjqcXyMd9Ke3Nro7rAS/NcSeHf9aB7rxQF5QdFheiZZuiv2zP08bXB0G7IrAt8Kz6
	 wiweTTzbnE5rSKj8usLdqJ5+jjyi9xGMjR0ZeFzTU3c0rXcZDLzlVz3Krjx3NOh+l6
	 +41awpqSRqu+yT8NgITBeOmSbx9v/w5UWtvLsGl8=
Received: from github.com (hubbernetes-node-68422ab.ash1-iad.github.net [10.56.85.29])
	by smtp.github.com (Postfix) with ESMTPA id 4492C601001
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 14:37:15 -0700 (PDT)
Date: Fri, 04 Sep 2026 14:37:15 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1152755/8160c9-000000@github.com>
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

  Branch: refs/heads/1152755
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
