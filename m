Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685AE402B8D
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817213; cv=none; b=sj3WzZRPXaWD54Oqk54Ryh0PwoOWUQXioM3n2dPedybIrR3uCmTSArSP9M0FP58W8sdh7zAnQ+oUHXzk8LloEyoJOEPaASuAXL9Z7vDqefX4cAupkjPqwfZhAoADsa2VNDAcMt8eRqTUDhKA3qvgWDXpqch4HIJrugZBEL8empA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817213; c=relaxed/simple;
	bh=R3I3nmYwd/J1q/R1EfkHtbwABRsq9SxyJBoDN6ANIqM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RE1ZeBRWc0qmxWA0hod7sxivwSHXI8JgbMf80tadTkYmKJcqWK8fUp0sj0OEi+AdwcsBOv0vK58j079GV2d+tggMWC/OjZBHss/1MWw+jnZ07os7eMHsIjvIFP1AKR4KjsyGMrFEdAW4FD6DWLhdJkN+Ynfsh2Kony8PEcbR/TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SNGb1OSQ; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SNGb1OSQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779817211;
	bh=NuhCx+dbU0uVswuaEHVra2oA2yFc9nK27mEbmeoJKQc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SNGb1OSQfxu8fqzbDzxvOb7pONlSpL8AwLiXWHRUcvwAPf3cr5D74ZTL/5Q8cTfIT
	 G4pvOZA83Y64PcMhS8WEFAr+0PQOwj/5widePu3Tq8q6vnGf979TJjf69GcQRQOMmQ
	 oWEKHjIJoq5C/cGcYJpJHrgycUrwI8sm/N1GLT40=
Received: from github.com (hubbernetes-node-3ebbe39.ac4-iad.github.net [10.52.146.10])
	by smtp.github.com (Postfix) with ESMTPA id 955209411E4
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 10:40:11 -0700 (PDT)
Date: Tue, 26 May 2026 10:40:11 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1099306/6e45cd-000000@github.com>
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

  Branch: refs/heads/1099306
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
