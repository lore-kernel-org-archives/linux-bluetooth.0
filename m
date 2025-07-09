Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7272DE217
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068470; cv=none; b=qyEbOICVaH+6XB/gBNAuhrN8aFDY8iKXPhji5kzbxBk4GbLXlBr8j6Mp9TPjuFU3lBbAjSjTTaaJX08nRaC5jhmW9tS7JfZRySLKNCkgSsiU4Gkf/QdZH3C2EnmGf4MtOF+kDHDPpZ6McTmZbEGCb+u/mjPyvffOpgCISPIMLSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068470; c=relaxed/simple;
	bh=NPLLJDkZxgDLSSGvrSQK7eYLdkOPX7Acxe/2WPWy5bU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Bk+/WbbxQxliwttyUIzaxvlyBjZlBfZM93d+K2lMqOppbLbBdxXPxv+bMuhFfYHt57dgOYbn2BMiIbl0KA027ZiZYq/HOxi9Y84XXGF4fCDSD5rHP3OyJs5MZDDC4UElYF87xgqsY+vrFTIWOtvse8HQA2GIe5Y98gHVxm5rGBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PMC3GolF; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PMC3GolF"
Received: from github.com (hubbernetes-node-b2eb4aa.va3-iad.github.net [10.48.210.101])
	by smtp.github.com (Postfix) with ESMTPA id DB8504E14EC
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 06:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752068467;
	bh=b2nRgcCPS3DXB4WzfNMQDuyT/kuLN/bfCuVR2I3UL9s=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PMC3GolFmgzdDejFsUTXRqZzPiK7L9x/Zy17bp+9m0e/RRyuLSyQKoApfH+/l+05Z
	 OV3fXM3LGGgRPwCGe38LrWOM4yL3NMEO3Fu5+/LvIOK4J/b6w1KMbblNGuI0y9+8eN
	 5q33dXhfNUz16NcYSB5+F3yNu9VUgFeIQc6ovlYE=
Date: Wed, 09 Jul 2025 06:41:07 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/980525/000000-086150@github.com>
Subject: [bluez/bluez] 086150: shared/util: Introduce strnlenutf8
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

  Branch: refs/heads/980525
  Home:   https://github.com/bluez/bluez
  Commit: 0861503351ffcefcb2ed690f71f9a332de204f45
      https://github.com/bluez/bluez/commit/0861503351ffcefcb2ed690f71f9a332de204f45
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-09 (Wed, 09 Jul 2025)

  Changed paths:
    M src/shared/util.c
    M src/shared/util.h

  Log Message:
  -----------
  shared/util: Introduce strnlenutf8

This introduces strnlenutf8 which works similarly to strnlen but return
only the number of valid bytes of UTF-8 encoded string then replace the
other copies of similar code.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
