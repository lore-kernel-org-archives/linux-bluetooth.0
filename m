Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34CE2DC799
	for <linux-bluetooth@vger.kernel.org>; Sat,  3 May 2025 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746259049; cv=none; b=cMAAcPUffQ0+vPmVDvf5SD7pHQnAtp1uwoSkLMm5Txp/Tadu+nl47ALWsrowCt4P1qFWuzqUsyvMHpnDtcr8Cu7cBMCGDkx+VPWH3B2MTmQPJZqCJ+Z31dhp9UO9ZHk6g1kTFFZWfZxFk5nbfoP723cySCTPdsTAd1n8yLD+cV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746259049; c=relaxed/simple;
	bh=lHr/Gj2PChf0KGqVXOdG2rbaFBB1k+7SszG0zDRDRUE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BgQkeRvq5DVI3X1P7BP3ODF1SeoAxlIO8YM0zPBFzqk7mQ9IOD1QGHxDVYp1SjtR4c5zYXOED4gOnqAuP+hECGH7K6X+YllwwycDIEZI03YANIzYnv9xEQ6KkeWhQ0DZwZpcaeWCTNAqbD9BAupx/2gw/OVcYuFOAyHaE9c2N/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XplZyI1N; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XplZyI1N"
Received: from github.com (hubbernetes-node-ce60ff2.ash1-iad.github.net [10.56.169.33])
	by smtp.github.com (Postfix) with ESMTPA id 949F6140413
	for <linux-bluetooth@vger.kernel.org>; Sat,  3 May 2025 00:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746259047;
	bh=ORXR4mMQgXDQ0pnP7ZWvdO+FyZJ+H+U7ZhRVR4MnEgc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XplZyI1NJGpHA/Q2dXV0W6hxQOoD+MwspjdrS13EYsqKM7zPCQuVtH2DddbqwFy+W
	 9r440vRhiTsi4pbvsZntDLc87XaWKtzcCI4IVetQmnKPa1GempGt7DZspjGkkQUH/Q
	 axaK/xmrxJ5BeZF+jzxby4oaUCUJjp8gESqtIN9U=
Date: Sat, 03 May 2025 00:57:27 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957508/7dd5f5-000000@github.com>
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

  Branch: refs/heads/957508
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
