Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFD0171D2
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 21:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747775631; cv=none; b=djG3drk5QBoReI3twGR2Xxqe/5OuQObEXtJiKkrS5KC+7ZaaOhhd0Q9wTvU9NpaH4unE9OD2P4LxtdBLoV5hAJgWJnDqqFpKTEJJ2BIr+FfpGZSiA8WWwFN0eogG/YU/LQvd/N/rwRva82+Zt1gb7HJHM5guNdECvs04D1ppWyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747775631; c=relaxed/simple;
	bh=Kk2+PeHnr2lNuCoOnaT+dPM79rZ+3fnaNsPSyJJ5awI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lSpyN6iRcW0Q35mID+er1hPAKf00wDAM+6xpoVDLfozsGEFT7C4upfA/QZBJWUFiB+eKszWXEAlCKhEw1tyBRK9qEWBd+0lxm4jiw5Way1Yg+bU2roQfwXpW6B4nTmp7xxoH829B6/ZMxhNfGsgaxynMsfZDfHlMAY9jWVi290A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LdIcaVjw; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LdIcaVjw"
Received: from github.com (hubbernetes-node-2b5064d.va3-iad.github.net [10.48.124.72])
	by smtp.github.com (Postfix) with ESMTPA id 4F7C7E0BEA
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 14:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747775629;
	bh=fcMoPzrvK8qhlvxgYzK86wC1pJ+5oBnjqehhfhVRq3M=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LdIcaVjw28p7DVYf+a1xoQluC4+23MmcHJhRT2JOyVidDzLwo7QUPz5UY212KWy2U
	 EUlm+5O3GVQpHBFkZHsg7vnQIv5LXAJKyPLCIFhQ6kNyWoTffpnDEiFtP5/xzDGQSm
	 pYbDPzTgbYawNqLKbRBlnd8pL3UpskB1PBprcr9Y=
Date: Tue, 20 May 2025 14:13:49 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f39b3e-0402c0@github.com>
Subject: [bluez/bluez] 0402c0: doc: Convert mgmt-api.txt to mgmt.rst
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
  Commit: 0402c06746449b44b67568df058f4d466b542653
      https://github.com/bluez/bluez/commit/0402c06746449b44b67568df058f4d466b542653
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-20 (Tue, 20 May 2025)

  Changed paths:
    M Makefile.am
    A doc/mgmt.rst

  Log Message:
  -----------
  doc: Convert mgmt-api.txt to mgmt.rst

This converts from pure text mgmt-api.txt to restructured markup
language and then use rst2man to generate a proper manpage (mgmt.7).



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
