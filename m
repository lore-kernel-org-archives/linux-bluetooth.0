Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251A06F53E
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Aug 2025 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754078279; cv=none; b=WozM0jxE4utYwEPqwZN+JvHvdznL2/XBtPFxULdrikpL/GxpxepYI5GNsXO0OPxcmCm0qAvk/cts0Gl/BQmgNyeiCccuGpHWN07e4bWi4b2eCoq8StA9KFuVfdPuzpkzQmyuyAZHOBe0lcSZbGrOOdFBPEQ8XFOyR7VeJjAU1Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754078279; c=relaxed/simple;
	bh=mE/gQBMKcDti64RbIMVLuGfidl93ZD+VjRwyxZfjTLw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YowuPesE3SBPllzeXFl2RcorWyvCIupfxKkjS7rbxr3eBlE1xM9G18AWVNssi4SMohHDVgRqa3QwqE5o7CQtemQDAlEqxAJrOpIZI/8aMLobFq0fOrlWJOaa/2D95NdoGnvcb/qkzCgF/nCQrXyn6pUOisoKHFghRFjNXikJ8ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZRVcQ+th; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZRVcQ+th"
Received: from github.com (hubbernetes-node-ed2b54f.ac4-iad.github.net [10.52.145.23])
	by smtp.github.com (Postfix) with ESMTPA id 48009640296
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Aug 2025 12:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754078277;
	bh=7UR622oYb3a4Cb+2/fFy47RASSrog59NiJgVslcLzpk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZRVcQ+thJEF9EAJZ2Pt2j4KAKA1coJjOET6vg5gQJrQyi9q7RqFhQIkMP6AUvyd8g
	 R3DVMQ/Xh0NeavJITWDD9CxycubCAYYpKWAHqV8rJBCLrjv1bOfQOZ9pg3ZLxbEyLL
	 Ja9bDAOax7cawxcj/GvQyM177XRF6LKnMONDQH0g=
Date: Fri, 01 Aug 2025 12:57:57 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/978340/ce4b33-000000@github.com>
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

  Branch: refs/heads/978340
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
