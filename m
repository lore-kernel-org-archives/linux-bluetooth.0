Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14676277C9A
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 11:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759924685; cv=none; b=tM11JF/s6+Y0/DNU8xff3d/5DUGjR4YPMZ9smcSDRtZNRg3HzMI/+ROlalweEjJdcjfC3a90SvbtD3kJ29mGlA2UqLoHFVCGYnXHuIq3lrFbQFlQSaOWKfwuLiSTzJKcGKQSO7EP2b4TA4uoYBSlx/Fr4N8GnIjHU28H2WLnme4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759924685; c=relaxed/simple;
	bh=6q2iKzD7e+nfdpkXRqRQroGv/hiy0yGW/cl/xHET/Vo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=l0mvRHBRi/WOGhNGOln8MDQcAMCzMPPQmHKvo/Wi2CR3Ogo57DQimPegt5BMnWlZo4MlvekOOTXHscmD3q5+dXFJCwbQOAFZAkLOFQwpkEyDv5uXeVu46eo8UpthNEd/d+5yIXcY1+OIpPsIHif+ktYscIBrIXq3tzd2+/oGX0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hAromxLP; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hAromxLP"
Received: from github.com (hubbernetes-node-31aefb2.ash1-iad.github.net [10.56.200.97])
	by smtp.github.com (Postfix) with ESMTPA id 28AE69211AA
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 04:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759924683;
	bh=iyLT8mROqE27vfkALZCPQJce3n70p/BJDWoPNswnyGA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hAromxLPZTqJZXYrdUTJwmf8cHG6RBHlsFMlbgoBSfZ5mT9UQ2rsteW9EyIcjGnLP
	 RccPqB77iGVRqkRpNxc5UsA6OkjVAyOP/rHKPr++Oky/XV5oM7WJ/tk7hkFSRO+nB4
	 40GnIyuYOAnHzwBVVFlcTf6F2qGrUYosQUq9qlfQ=
Date: Wed, 08 Oct 2025 04:58:03 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1009311/45dd1c-000000@github.com>
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

  Branch: refs/heads/1009311
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
