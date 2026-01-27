Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1AE309DAF
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769534803; cv=none; b=T6PIMDTTClPOmMSn1yKb/Hc0bNsQ82rBAzUSHU57f/3wu45vxo+BJz5Hl4sN6/+c74uUREgmPHLvOOyGoPT9cUCZfi0WdRlQpiyawosEEYTEvP5zN/ENDZk0DkFXgQBfSFivQkMrgvCvAAK/z//7d7YkQfVQUAj0LXXe1+szN3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769534803; c=relaxed/simple;
	bh=zaYkYaFm8Ru/lpLBNbyobLpPPIp0lxuv7rJCMHbXPSs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=syrD5Rar5uYYFgVUb8EPPsG75xTcFaYnBoL71K42Cow5aKnYVCPmEo4wM09o+YKwxy/JKoeD8G5k8xGuD8OXYm5rdeyZ9wR25KdL422MpZj4t9W8NLtTfuY4dEigsonspvrW3Ww0ffJBVMhXS3ayND0+HI8LM9q9aAHwmXdI9JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=nFh8drkV; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="nFh8drkV"
Received: from github.com (hubbernetes-node-a9cd48c.va3-iad.github.net [10.48.142.31])
	by smtp.github.com (Postfix) with ESMTPA id 91DFF3C115F
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 09:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769534793;
	bh=cJzV+pmNG7XSj2/LQuCXXYja8yxA4MdGH0F1GojyW3k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=nFh8drkVjW/kIs1lBQyEaNFmptKPcNMnDrf6RIpi96MRtiq7OHnRGs4exSqkNT6eC
	 ITW4ZIBRr476gNByhOVHht19jWDyRLNE/dQh6eWLa/GXBqly1IvZpGfv5UwI1kUq+O
	 6jHD+4Bx4DnH84awtOW3By9KNujBbD4KIvAGuz+c=
Date: Tue, 27 Jan 2026 09:26:33 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047700/000000-4b543c@github.com>
Subject: [bluez/bluez] 4b543c: doc/qualification: Add PICS and howto for the
 HoGP...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1047700
  Home:   https://github.com/bluez/bluez
  Commit: 4b543c9b99d1e1dc97f3ee57df89c4577f659893
      https://github.com/bluez/bluez/commit/4b543c9b99d1e1dc97f3ee57df89c=
4577f659893
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/hogp-pics.rst
    A doc/qualification/hogp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the HoGP qualification



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
