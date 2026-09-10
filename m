Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDB8563FCB
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062030; cv=none; b=tXaYg03m4ZF/ot4SVlQjbEAZb6m36MlltmGT/iA8MwAu5OTHu7IvxrYQ4V/Vr4Zgo4MbRGwb4ldFrbwBjhuTAqUzwsUO6s57EylWOFJ7ForZRvDbPusRE1wqELMsAx3K2OYIsv3/xYSuqZQyntQdq8q+jq6bBOsTi/a27P6wY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062030; c=relaxed/simple;
	bh=rfSDHsV2cAYPhdEwYqExPOmtDj5UA6Z7N7Q/M/UNLII=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BFhOzdmG3JLNMEYWMrloTSxka7W9j3H0A4vx0gpCCAYV6inXxvRW5RxI7+zJ99sY4HUTSyAPfN7+YewWMcq3xd9S9625WMkRIqKUZV13zyDUgh8O5oExjGnNC04de3C6VG3vtwxaAYEUvt/lDTXK1OA9um0Pjy4ueazNSuBm+bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=h3DPzXF0; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="h3DPzXF0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789062011;
	bh=dlyX7gHG/r//pXul+2Exll1OUoh0CbkNeM43JXhrJYE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=h3DPzXF0W+Wvf6TOJw0Om24/mFDp7OIu6/UPFCtI/JwcOpmlJN/lfRV1BXI5k1OPz
	 7KhZ5XUScHZqauIW2n5nZ4ph4AKdFurjY5rh77ZMmDegnrc8jTQAGFvzB5vfXZWGOz
	 JDJtfqJTXCaoBrkut/RbUtngSnEN79IWBXEoInBo=
Received: from github.com (hubbernetes-node-3c3fe03.ac4-iad.github.net [10.52.175.49])
	by smtp.github.com (Postfix) with ESMTPA id CE5A3A0366
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 10:40:11 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:40:11 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/51d1b7-cd10ad@github.com>
Subject: [bluez/bluez] cd10ad: workflows: pass the email token to the cleanup
 task
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
  Commit: cd10ada1b16eb89836aa5a05066410aff48c2b68
      https://github.com/bluez/bluez/commit/cd10ada1b16eb89836aa5a05066410aff48c2b68
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M .github/workflows/sync.yml

  Log Message:
  -----------
  workflows: pass the email token to the cleanup task

The cleanup task notifies the mailing list when a pull request is closed
for being open for too long, but without the token it cannot send the
email and the pull requests are closed silently.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
