Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878244AA585
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369437; cv=none; b=RQiGu7EoZx8Q42rkfLhCkcg0i2VhzWDHZT57QZ2SZNo7j3zw4jiJiZZfgvyF3X3TUpHH/epMl2cj6BARrabMfEcNR5X83z5CgBuZG6jEK7k2hgNBwh6sk/uwVRtmECDlQEjNsZYusqqR344IPmJyQyXDMRKvTnhqYTXg0MXyLPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369437; c=relaxed/simple;
	bh=gSlpJL2bw37RmbyMhxTWBP3fIqs0KSLuBZBc2rXUg7I=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Bkvg3jx6fntvC1BUCBq8q/A/1+NAWzg71L3cMsxXYWuLs02+db6TaX+DHPwMcZ03m7G15URZBVTT/8qAoWsTtppiiWL3RTowj687hP3t4QlaEvLIUca+dipVvNXqpA/ctwYvWx6xe8G/OUb/bVM/92Ui5A3hobdqBMoVTJuvzSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cvTlbQFv; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cvTlbQFv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788369435;
	bh=Y8Xe/+8TRJnp9AYQmZqzNO4fYpsJEA0KEB5t38PY4HU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cvTlbQFvOYzy8yoDYUOXTAmBDDtc45KStj6osvhd4/g4Ks2cm681cfZRX9B4JVSGJ
	 3dw2dKJPpmjMwZoAbTdymtOBPL0DPjG1Q4jBR8vuw1aVC58XnDDZtwGLTavIE9B+o5
	 XojKkkhQDmgrNjCYXPAg2MmY0svzVS+cJR8bV3m4=
Received: from github.com (hubbernetes-node-26cab26.va3-iad.github.net [10.48.86.27])
	by smtp.github.com (Postfix) with ESMTPA id 551A5181301
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 10:17:15 -0700 (PDT)
Date: Wed, 02 Sep 2026 10:17:15 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1154582/85f3cd-000000@github.com>
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

  Branch: refs/heads/1154582
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
