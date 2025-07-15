Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BD41DF26B
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591164; cv=none; b=CqyRf35beGAH1TzFT8bPujgCo1OB4Mce0XmXCyeAl/3BwQJILN6FX8Hn+rxKujldzpnwaO17O8eZlgqv24cMLTdpFjl02zVdGGNI3Grt1IQLRVtVAMU5upvtFZ9k8LA4nAvsQUuKPF6J5J4RN0Jr+9TiP20dREVPYdu83euddFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591164; c=relaxed/simple;
	bh=A4YIFMH8yuC1laS/9c4D2HULdEDB0Y9f5sbdqmVmriI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LxOiYJcbYIbMr6YvVp669SOYjjscDrJCHYNb1MtXQECmFkgeFEChRAEZsalc+7XEEHjFuTcbhLDA7N1fPzF1AH+mDIcOossYsTA87290CS/u3Zrkk+lfZRV8TJ39FTygygifHQxZCVhIaP6ULo57tKAeQB+vGgi5kj+24kw+a0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=V3b6CWkU; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="V3b6CWkU"
Received: from github.com (hubbernetes-node-732cecc.ash1-iad.github.net [10.56.192.55])
	by smtp.github.com (Postfix) with ESMTPA id 63C15601430
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 07:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752591162;
	bh=ZqgIGzhRYVSDT9LvtnhCdxIAcMCsENtnX0llWmAELT4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=V3b6CWkUqrhSsStPF44P5jbOMwHJ8uDAatAI+gKM4dz0LTGG2RyDOPnyzzGoA1DwZ
	 dRrb7CM5GkHmqkgfcqg4BIGw0YzqArQHN8t1F5IhrakWrqkk1KQHgCP01tNLWVQGkR
	 ND10dA0iKsBZaldyotbi206lBOX3sKW2bFrfbBAE=
Date: Tue, 15 Jul 2025 07:52:42 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8c9977-6c3cc3@github.com>
Subject: [bluez/bluez] 6c3cc3: doc: explain SCO BT_SK_PKT_STATUS socket option
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
  Commit: 6c3cc38da9ddd16fee23744cc9181404c4417b4d
      https://github.com/bluez/bluez/commit/6c3cc38da9ddd16fee23744cc9181404c4417b4d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M doc/sco.rst

  Log Message:
  -----------
  doc: explain SCO BT_SK_PKT_STATUS socket option



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
