Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40899280CC1
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771012713; cv=none; b=aV9cBGpTX7ZEMSGTS92ECVnlAe3cvRiz/b6T0UvTQAJoxtuRpEatjtQXd/YSfuslHHX4cATpP/sS8X1V3cEj4LY4Yl8m9tfpC5TZQcr2WfLTQv9CBVukMrS8O0XvA9cPd4Ld5lI3q3QMaoJ3rfmHJCeJ3rQVXWfnDQDkpktTSvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771012713; c=relaxed/simple;
	bh=KWtqwrd69riitB14zJ+UafOyPFCpuuRobq6FQdpmM50=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=agAlzeboOq1Zmjwf7wmfkkwOGsffdUsKMsX4MvDXxpIw0XleyHCb8O57I9eNGQkioimeDy9CpigXnsZSTv1K8U8y2TN4lVr4xM/KQjRczxGpM5TnbHqxTPrQWOLehqtUeAds+I8nsyxlPcpjBPcDc0nRntCQetbf5trVyNpAyKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RoL6doTc; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RoL6doTc"
Received: from github.com (hubbernetes-node-e7df5c6.ac4-iad.github.net [10.52.211.99])
	by smtp.github.com (Postfix) with ESMTPA id 63E03400AAA
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 11:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771012711;
	bh=Pp/JU5AD4AxOt7YvNZTYLlH/1wttTlfB6IbVX8roLxU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RoL6doTcH4V0rTsg82xshCETVmQ46TiMLHmHJpLte2vfrMQsUQlTSJ4y1KskXCSu4
	 8LA6F3qFWm4Cw26AhqxQrFKBgzoMAUyipzByVopmlBYLaiCXWXzMz4cc1e+Jlb+xCA
	 TtqA/qtfht6kww2/3YB71ZwOHgNqdYSmuk+V1s1U=
Date: Fri, 13 Feb 2026 11:58:31 -0800
From: Copilot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/copilot/fix-lenovo-keyboard-input/5d9a86-cc63d2@github.com>
Subject: [bluez/bluez] cc63d2: Add detailed btmon trace analysis for Lenovo
 IdeaP...
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

  Branch: refs/heads/copilot/fix-lenovo-keyboard-input
  Home:   https://github.com/bluez/bluez
  Commit: cc63d26d7bdfdb3538acd849cac7a08f0488618a
      https://github.com/bluez/bluez/commit/cc63d26d7bdfdb3538acd849cac7a08f0488618a
  Author: copilot-swe-agent[bot] <198982749+Copilot@users.noreply.github.com>
  Date:   2026-02-13 (Fri, 13 Feb 2026)

  Changed paths:
    A ANALYSIS.md

  Log Message:
  -----------
  Add detailed btmon trace analysis for Lenovo IdeaPad Duet keyboard issue

Co-authored-by: Vudentz <2156363+Vudentz@users.noreply.github.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
