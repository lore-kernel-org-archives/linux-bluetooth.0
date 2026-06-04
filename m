Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15522413D99
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 11:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572310; cv=none; b=nmxzeItkqv6nMwk3NcOE67tYAW1LbTTu6FCbLpo7HgeoxCGt36uPwwrlQ10FjkJuPb7ygdvQ+2x3dUs62mp+0gHUZt6nBphc42ZWDrEn3DH07pBn/th16lZsjq3pO3fTJK8nSHfPtHZtWo1G27k4estFiMX4Ic2akHM64zMQMfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572310; c=relaxed/simple;
	bh=OnrjrCwHy9/JxeE1Sl2wpZX6dlAM2x2SAybcVLPMqQs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hHVixFjosTnqUiF5XDu+E9Vq+elIli5RmR3jnuhzPGAO7+8qwwvEcKiYxeX76570oTZXKq7n+MJypdQRrm1plrH3+c0qICDQ4s8qWiDnHSBA8pK3v7WwPTNgQNiCC8GR7LmLQgTJhrYFM0cboeMTru6v4Ak4sGSskRFoBvnFohM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=R9psPllA; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="R9psPllA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780572308;
	bh=sibx2AOfFNCOAgSYsyjllMHsPt0XLY7q/eYri1CcbHo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=R9psPllAtvPJs9oBag7kadFH7AnDxGwpMm7T9wBAwy2rigiaT8Gq0ixauzuYDDw3h
	 xUysxOImLKQEes3dHFUtiaCeOYfuydsnoQJElEFLxWfKc55b/+0eIEeYR+y5MQ4fxH
	 F5hY5vhzu2Hu/a4RQJ+o+YnPMHlQCIglWjfyt+jM=
Received: from github.com (hubbernetes-node-2b5067e.va3-iad.github.net [10.48.219.68])
	by smtp.github.com (Postfix) with ESMTPA id 3B3605010FE
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 04:25:08 -0700 (PDT)
Date: Thu, 04 Jun 2026 04:25:08 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1098678/53ac4e-000000@github.com>
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

  Branch: refs/heads/1098678
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
