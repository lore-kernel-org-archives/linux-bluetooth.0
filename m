Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121872253E8
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653438; cv=none; b=aXxDhlB0YD5RtvnBgzdMJcYUIpudybh7oztn5kGoGZCmjMtJcpwenHg0enk5v88A4GL2XRkBUi6iksEwkCJoB+HKaCNH94010InV/fWO3XpB6u/2JIVeMaNhpMojoo/hhnF343OIWHdAx4ZDiIJxRC8+ANVnJfP43Glou+ngP6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653438; c=relaxed/simple;
	bh=XmAVJX7VJMpC06TtKuLqMQrm3+rWTCTAS1EgFhR3XJg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dynPXjuS7mCq4WXyY9T3OCQkCmNlX4/+AURnCmA1LhfHO73jdP3YAy5hfKvpY7XXIgJ/jHPEU3BGcQJdDT2EeZKZdS0K/99gydMQtdhUDq4QVePB/V4U0d0ixQxGb1NCOjcrUw8Mq+7UyoEbViayZr9ZQbe7wG5ohXq3R9zyjiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ozp1+7ie; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ozp1+7ie"
Received: from github.com (hubbernetes-node-613f483.ac4-iad.github.net [10.52.153.35])
	by smtp.github.com (Postfix) with ESMTPA id 019AC700BEC
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 07:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749653435;
	bh=X2KkV631VTvn7KyVV952p5w3b5c6DrEaAcKtUo4wei4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ozp1+7ieBhRZXPdooIq+mJlTpqLTvJONWs7kdu1YX/4oTms4cbHy9D1Cidw4yziHE
	 tEc2hNmhHD25urCFADgqou1YkxQGLF0ZOM0QmPcOMrVxF8dsMZ3LpBgBL/MRJKVCA3
	 UH9wrNm0i3x3O042pBVcxYFUvKniVyURiAhEtY/E=
Date: Wed, 11 Jun 2025 07:50:34 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/970848/223573-000000@github.com>
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

  Branch: refs/heads/970848
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
