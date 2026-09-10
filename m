Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67FF503BF7
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061576; cv=none; b=lPHHy3q9RlHxy1vLREl07CvpxiC3Gtai13h7uID6Vl2Vt8ob5owkd2mSgcjDdLVMMrYoBgB4g6gMlqf4IidVkHduC97FgbBCqOoll4i01FoInZ4zAXoNm04vuw9fopQoGqDLTnELNMXrTQcU82Gf/1EpjGXucD5LcRQAASuRpfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061576; c=relaxed/simple;
	bh=qHT5ypm27g0l8TPUvm9PMHjJqLPQVeu+uvcA9m4JibU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=c6PW5bJzqUPPlrasNBkv0+BXQ2i2Sz1zC/zyMDxnxqgcu7PZ6OplskX1AkxV9sJlZsgY4ord4RtfDpx2OLdFyWHk7IHVe26MUA4U91dBNJmIIsIGRNzBg2h15NrPLw8FeFAdZNIL79RsDZmoNvLc0TBQ2qoe49cFhlQ77WX+twM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZAIVe5Ws; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZAIVe5Ws"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789061568;
	bh=tf8aPBsXx2ol7GbTxFBEYUn27uS6gvi0sConxjFYXbQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZAIVe5WsbgtRNnRj88wa/97tSs//bLRYlHIfUve2vHLh0NM8myTfJvuEdLOaBQgiQ
	 asEw9vufnUvxi7t6GknrxCD80wFNoOiANGsfKNrwCXsRH4mjQlkWDmdMgPq09ZONh4
	 saFkPDNi+U0K5rJNRLhe/wYR2VTKIjrb8PpLOAbk=
Received: from github.com (hubbernetes-node-1e6175f.va3-iad.github.net [10.48.85.32])
	by smtp.github.com (Postfix) with ESMTPA id 83178800AF8
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 10:32:48 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:32:48 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/action-ci/push/refs/heads/main/720a43-c4559c@github.com>
Subject: [bluez/action-ci] c4559c: githubtool: fix create_pr with the current
 PyGithub
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
  Commit: c4559c5dfe40fa36feadc59a1fbeb158ed25233e
      https://github.com/bluez/action-ci/commit/c4559c5dfe40fa36feadc59a1fbeb158ed25233e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M libs/githubtool.py

  Log Message:
  -----------
  githubtool: fix create_pr with the current PyGithub

Repository.create_pull() only takes 'base' and 'head' positionally now and
everything else must be passed by keyword, so creating a pull request for a
new patchwork series fails with:

  TypeError: Repository.create_pull() takes 3 positional arguments but 6 were given



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/action-ci/settings/notifications
