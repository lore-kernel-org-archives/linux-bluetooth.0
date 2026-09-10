Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB6148EC77
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055296; cv=none; b=NGoaKfRqAXXlmQl24hJQkbOZJzM6GNx0U+wAhYWmbmLDzKs0VvMt0vdP5wK0bokY+5fL/ErVYi4J52vxXUc7U9vNMbY6qZwzNNCMi254Du5uPvDe77pCnEnJgNr/50ysOvkbaJod4Bg3GmDF5g6h30Ygk5c/dWteG2mzMi9MBRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055296; c=relaxed/simple;
	bh=ZuHyfep1xdwd94MxyrmaGFTzUFNHl7pLtZmkCo3fbIM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SORuIp7pJsY3+iWVBgzSazDYc12lBdTmVOH+R4vbQ59oWnz7c3g2QSnxFZS5G+qA7Lm8cBX2u49lzO9fWi6OK7EpdHqKJjpRwp+5Asp8mJDC1g3KwqrsKfdqegZSe3P2ZCcksMOLJFjboMifa3pbBBNMp0asuSLUfQ2kdKwhV54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aEOQactg; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aEOQactg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789055293;
	bh=szWSoLPKJNyI4IwGzEqvvPKfWaJN6L8EdPBCjFRkVIk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aEOQactgUC/cmv8QKHpqfWXjpQkdLk01Yitq4fX+98HiP508XAGu1N5mIt76nb+hS
	 SkIjAUmVISB7qmgXOdGAW4T2fCBk21rV1v8kPeiYiYM33lzOHEljUhL3dck2i5WHsr
	 nW8mjfFC6HFon3vCh65P+C2AI5FXI0GCoQLKaq4A=
Received: from github.com (hubbernetes-node-09d1dcd.va3-iad.github.net [10.48.68.58])
	by smtp.github.com (Postfix) with ESMTPA id C914D5011EF
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 08:48:13 -0700 (PDT)
Date: Thu, 10 Sep 2026 08:48:13 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/action-ci/push/refs/heads/main/171e7d-720a43@github.com>
Subject: [bluez/action-ci] 720a43: cleanup_pr: reply to the original series
 when arch...
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
  Commit: 720a435437fd9849f474f77ed49f3a760c82a35d
      https://github.com/bluez/action-ci/commit/720a435437fd9849f474f77ed49f3a760c82a35d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M cleanup_pr.py

  Log Message:
  -----------
  cleanup_pr: reply to the original series when archiving a PR

The pull requests created by the CI carry the patchwork series id in the
title ([PW_SID:<id>]), so the series can be fetched from patchwork and the
first patch msgid used to send the notification as a reply, the same way
the test results are sent, instead of starting a new thread.

Those pull requests are no longer skipped: if one stays open for more than
2 weeks, it means the series was never applied, so the pull request is
closed and a reply is sent to the original submission. No bot comment is
posted on them since they are created by the CI and not by a submitter.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/action-ci/settings/notifications
