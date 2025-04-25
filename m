Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F9E21B9FF
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 19:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745608253; cv=none; b=gICHa/kIoDDJud9FcmmkkOcTM1zOISQR6aaSps3QsD2S+eef31at0fZK8UyyE/a9XlBprTV3NxQtRmKU+ijYjHtkMql2bujsonpuv34e2zVhYh2EM1+9oVMWExID/EbTqLxKBmxCbsNmq2GXTVVXrao4eD2arEMihQzzujJG0Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745608253; c=relaxed/simple;
	bh=60spufuT1n4q+I7jPjJ1PBbC3BmtddJ6XvD2SLlsux4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GDfhNk5mXcYRKeaBolMOpmpnhsGr2yT9mTireSo9fVeIMDF2SGBOVW2FSfwd+WmVecq5Hyi3VKlFwFbKGDzGsqn+C5LiCqbTt0jFr1gCzqsRVMgDS4J++8Ja18ii2Usr1juoXumcXvUQLkwodOrAbG13ohR1MMtkii6SQJmfqFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LThty17h; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LThty17h"
Received: from github.com (hubbernetes-node-c17954a.va3-iad.github.net [10.48.155.32])
	by smtp.github.com (Postfix) with ESMTPA id A4EEF4E015E
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 12:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745608250;
	bh=1tIxv2DG4S1BI8FOBZX3TXUHLcDnfz1IpiHpppKfTfg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LThty17h7y03z9eM9xsnmCUSSI8ubvxb+upy39XUYU4rHFRs0AQ4FGA+7Tk6m232H
	 d3BkH1Eqr2rGT2II5e5XagqJ8wEb0kY0lZZuVePEI7l2XBgNY3x3HeqZ9mxlgND9qK
	 B3SFbGv2Wwg7aQE3fcXthWLgTDvnVQdhvp5BPB3o=
Date: Fri, 25 Apr 2025 12:10:50 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957071/409078-000000@github.com>
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

  Branch: refs/heads/957071
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
