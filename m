Received: from out-44.smtp.github.com (out-44.smtp.github.com [192.30.252.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534CF3890E8
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777579336; cv=none; b=LdQGhD1JLCRzWM3L2TmQYcavQ7UG9ACFODYEdCooioxAbGl8trNv9suvAH2LdTzUaQqXgA3b0JnqHId3PohWMgI5mIiZ2w540YgqsNY1qXbzDgEnFUxmmbUPEDMEGztR5RDnOYnqgT+8GlA+7LH5ho+rqiwoH99ufrSyb4EGHFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777579336; c=relaxed/simple;
	bh=vj3t9m6/i/rZyqjkJ5Vj6zNCOy3xK+y0O6t3bZ0ddgg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RedLR+YJto04GaXowIwsVoBhno+OmDulA8WfoiaHwIpS0VacIKLkJ58lt5BdNIW/BEkkxHVOJ3zvTa6SZAqnVWfpSPMNXH/EHCuhl67secBsK/+8u7VgjXTnTyxqraU8j3ONQx/+OakuFymIO2qNF1QiltKHUDU/BBAemLWHqLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gp8N3c6I; arc=none smtp.client-ip=192.30.252.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gp8N3c6I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777579334;
	bh=tFCHR2TTowTBhU7GCilHeYxTmDiFng5QmpDzMdbLvIU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gp8N3c6Ij2l6RxdKXzzcwvV6s73BmgOVEsiggxTi7Gdwe4cFahjDz/y2BDqb5la76
	 vXb1Mpz/bNmWlBDER5tVAHBoWxLfr139b+J8RHSvE2Yq+8ZddZUu1xaERLwFN2IyBV
	 HUbaWwt+yWYhiJ7qQRFax8T87t1R8XO958OmIAxk=
Received: from github.com (hubbernetes-node-41f2782.ash1-iad.github.net [10.56.15.41])
	by smtp.github.com (Postfix) with ESMTPA id 75F52841149
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 13:02:14 -0700 (PDT)
Date: Thu, 30 Apr 2026 13:02:14 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1087435/07c44f-000000@github.com>
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

  Branch: refs/heads/1087435
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
