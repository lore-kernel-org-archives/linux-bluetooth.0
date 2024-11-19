Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA991D0F63
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Nov 2024 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732041846; cv=none; b=NKw3it5jsSizphIZxe/+st9L79MsrJkzi37Z3088n7WSBKd+uPE6JMmRN/BDMvLSBmyJCcmUhRN5dqjL7hHTLwUdHlKBXoBPx6M8dM6Mc1ZZDkMSH6srIEv3Od+/7psS6ZehOl/Rh8npe+5WcWHWFi+CgQ6y+JmdKTNnTBH5+8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732041846; c=relaxed/simple;
	bh=Wf3eLPxjlqT7+KDpMHSuvITls20U1VO2wyHyb+xhPyo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=m9PAle7hrWnYoBGIUPwGYJ1QhwtlLuAT+l+bdSGFmwxKm/rNhr86TkSgKwD3x6cZjl6jy+Gwy1Ifo7oLDPnzouSiASGFRGbeEijcmX5+HeDHhQj7qdd9LjKtXohsLLzlKAw6Q5EJOg02Gxob7ermn0b8g+vxhiQdm6luX0Omlqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gtm6ZqVq; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gtm6ZqVq"
Received: from github.com (hubbernetes-node-dbac0ba.va3-iad.github.net [10.48.133.41])
	by smtp.github.com (Postfix) with ESMTPA id AD611E0C36
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Nov 2024 10:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1732041844;
	bh=xV/7Ucw28sZmrtD+V4M4ffTehNvc45Mp2XOOlOIWshY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gtm6ZqVqTGvUqyyuRprtn9dw3uJCKJntJRNMFkcx8WPWEqKoOHsg8aSo0frOEvUyo
	 MYJX8ob/B9wFa7mfEjH02r+5CX5umzpOaRDyWnYLy9PXExZcB88HyW7u4F8DvgqsNm
	 IMBvxirBNBbxGLwMCQdCLzRll0lM8U5CwAI+cr18=
Date: Tue, 19 Nov 2024 10:44:04 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/da0253-5c6535@github.com>
Subject: [bluez/bluez] 5c6535: shared/att: Fix failing to set security level
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 5c65356cae64ddbc95210deb36ee66430645edf8
      https://github.com/bluez/bluez/commit/5c65356cae64ddbc95210deb36ee66430645edf8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-11-19 (Tue, 19 Nov 2024)

  Changed paths:
    M src/shared/att.c

  Log Message:
  -----------
  shared/att: Fix failing to set security level

bt_att_chan_set_security attempts to set BT_SECURITY without first
checking what is the current security level which may cause errors
since the kernel does actually return -EINVAL when the security doesn't
change.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
