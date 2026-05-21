Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D832D361DB8
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779388555; cv=none; b=mpWfD+towDT4oztTwuva961QP5x0CwAAN2UB4BXn3GIUjz/zdbBK8zoQhSSmIBCGzZPWdDJV7B+veBxtDmK+eEPo+cq+T2lg4cvnlvoMGVGrN26lCIXhXF7cIHPqAOBK/M1VgXDNuJmdei5HDh3m/2ElgFA3TIYezN/fm+N5WJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779388555; c=relaxed/simple;
	bh=OjdXzZCaE4yavsRFQpW7yiX3h5wOR4x73lRn+uehT/c=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qBB0/FDD1UP1NVAKulIqtMiTb6msr3VD9iwheq5BleKfLGWgQqyEdBPMf4BLNveYZH0snSD9tDQo1XUS8syap2o+Sza7DvLPgNRvsFatizYeVxb4Ku50jjLU1smgtqIzxy1YD+9mDOJqhZ1ch38jbRbqc2jzcV+VgBeynopNKKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gJNoPSfz; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gJNoPSfz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779388553;
	bh=v6bfTah8tdCUV7BHhNS19AEp767b4SMvWiMNKu4rxwk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gJNoPSfzi1+R3PJP2BYKWX4et/MsL/85+2cn9M6ngxJwFHtaFJKH1PVsgYXLZE0Xq
	 gmSUGUtxtIkHwzykr8SqlTyiOHXhwp/whtdU7tMhrxjGTXxJcThP3wEa3FWnvt/kjr
	 8MJ0iSl64P/nPLTJzwWqc4fPFy5fzUOFt7YFnu7o=
Received: from github.com (hubbernetes-node-fc8d897.ash1-iad.github.net [10.56.212.106])
	by smtp.github.com (Postfix) with ESMTPA id 145C61811AF
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 11:35:53 -0700 (PDT)
Date: Thu, 21 May 2026 11:35:53 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/action-ci/push/refs/heads/main/c1b86b-f2343f@github.com>
Subject: [bluez/action-ci] f2343f: ci: use HEAD^2 in verify scripts to skip
 GitHub me...
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

  Branch: refs/heads/main
  Home:   https://github.com/bluez/action-ci
  Commit: f2343f58b696e2ba1f3703957034fad22623744f
      https://github.com/bluez/action-ci/commit/f2343f58b696e2ba1f3703957034fad22623744f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-21 (Thu, 21 May 2026)

  Changed paths:
    M ci/verifyfixes.py
    M ci/verifysignedoff.py

  Log Message:
  -----------
  ci: use HEAD^2 in verify scripts to skip GitHub merge commit

GitHub Actions checks out refs/pull/N/merge which is a merge commit
authored by the bot. In shallow clones --no-merges may not filter it
correctly. Use origin/master..HEAD^2 to target only the actual PR
commits.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/action-ci/settings/notifications
