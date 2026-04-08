Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC07C348865
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775682345; cv=none; b=LkkoID1d0GnWec0sdS5BArBRiys2QBSzsaku8aO0euabcD+9LexzRjjdivAXz57Er8BUKB8Y/1V3eiexIp+yz9J/wE336rNPT23K26BATPFamoGXy35vabgruNAd0cSW2r2bF4whaeDFeHOq/Nx2uj0a4OjYva7TjBNTawTe2pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775682345; c=relaxed/simple;
	bh=YHU3cJN30rnI23VcPf7g0O5ALHuey/GSsHlBk2jPcgI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=APCFOwBMfvF0iULtpjwoF6U1bX0s3ASLidRFPjnCAIbEat7B92SmeNnHlQ+Gnqx3VdCmKgggjUstY9wXuQ0CAMjuU5bubtjtmj4XP1kVbpGmpOhPY4uyeNhlv5ldNrrYa38oSdY2J97tH+ejEK+xOidwbrccU2iDfsGuMTyRsGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FiGNwMmu; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FiGNwMmu"
Received: from github.com (hubbernetes-node-70bc4ee.va3-iad.github.net [10.48.82.30])
	by smtp.github.com (Postfix) with ESMTPA id 18A36E0C4C
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775682344;
	bh=R7DrRnxEq9t/AlMPRSduFni1YtmOziiJoezDsvGxAm0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FiGNwMmu+SJg2rqXxZwZgNrs9O4zMcDppsRcOGTRA6f8hSJMdvS4K1j4esObMFInp
	 aQPbls3HnBEaigu+MdCgHBpmoqXPvYx1G6ajJcUyRvEHONLd8vS7qMzXOaO7az6KSs
	 cVfWRydClUoF6x9HHB08Js+gOy/ZsLwMA04c5OR0=
Date: Wed, 08 Apr 2026 14:05:44 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1075892/c0812c-000000@github.com>
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

  Branch: refs/heads/1075892
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
