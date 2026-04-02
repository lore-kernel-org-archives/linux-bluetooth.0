Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FD4310784
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775157045; cv=none; b=MX4fQS+AbVCRhPu/eazBmybU3zMz1IBdSH++dYSWq/qbAuMSio7iW/1iXYiurXocRGdORUNnEXnp36xER6/HglLhw2shobnU3orsCRgx848//ji0ZzN65nwm9CpdQhntFY/myg6ZUyjhjJ/tA4QRnJe6US4e+NQR6Ps1PfJyPc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775157045; c=relaxed/simple;
	bh=VdLlK/gL8aVknmxDjIt8dP1HHbqW0uXKiy1v5mrHhCY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=r1Uykxyd7zDS9bOWH6AgjsM4uQkQ/4evcwFDOg6+ARkJ/et4/xKQrx3o0rBD76Kv/tyRLGqgUjOT67WaaoMCYsBvWGKd0u/RZD+6jKBqX3eDNzJ59mTVCmSytdQQRKjJT6SegsoTsO6FUhoqzSRmVLBihLnh9KeMadn5X5trEGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UBRupZgu; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UBRupZgu"
Received: from github.com (hubbernetes-node-4a6b029.va3-iad.github.net [10.48.124.56])
	by smtp.github.com (Postfix) with ESMTPA id 14803E02A9
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 12:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775157044;
	bh=OAm7tZLOjudp6Se1cyP8YBDW35fua+eVF73tFyDSS0U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UBRupZgurRPhuRCmLBcF2mklXzzbdIKSBnmzpXFbolVFsHrTthunG7qYBoGoE59CH
	 S7nk+rniU/V7CEFaEqrO4nrmojzOss2zaXOyJFUhp475dODZsl9/Gjc1zBNvonHarI
	 ISToRdFv6ZGSPXXiemHnCXSA3gl1HDJqk59ggB7Q=
Date: Thu, 02 Apr 2026 12:10:44 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1076017/17e787-000000@github.com>
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

  Branch: refs/heads/1076017
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
