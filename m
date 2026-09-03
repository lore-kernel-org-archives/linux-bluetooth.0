Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99DE401A0A
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 11:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788434012; cv=none; b=qBlUclKAcR6wxZ/SV4m4K8ZFo1oDU+CL33WVNU3UNZDRUCdc2l5A8K9kRfgFUWjfEOFuN1mhftkOhU2V56fGV9skqpkla+W4o+xzMa+Gp8GE+f/3u4fZNRlP4iYGyM9vjNhAVWU0PHULSNz8XNiS+1w4G3Kqok56WzGNp0o75yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788434012; c=relaxed/simple;
	bh=axAgYBsluY9LH8JmCovvZdLryA9FvsGb+F93joZmDQc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BErAQBlKsebyMczm1NJa9IwFZtc+OVa36a6HgepFcb10kXDJA+K/MG8O/sUQaqy9scpwut2S8qHqALDfWCqNFOa2/QgQVZQF9Vc7rANjosotHH59W4kGcJ7IzC6KDVhy+wgh9uKql0ng8rWL4W5teBX0O79E0slDlcXbbL2R6AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DmTjTpau; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DmTjTpau"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788434009;
	bh=bYa+Q5bCOosKvzK0COVtPNV49Y+4+v9KfBjcje2jxxU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DmTjTpauVjZ8lKeyw8QQleIZWl7PnMdDwDdc2JE3GUgbtB2QDGlaCqy+mEftPBO4d
	 lfLuxc5okVaaJbjoTKp4ldCJYEskS+KsWXnOren+5z9hXwYaehAx88KtpaDJbhz+VT
	 +7WZXYuk0uHbHHJ44fK2Za43FXdghe/ezKzSZ4i4=
Received: from github.com (hubbernetes-node-5463c0a.va3-iad.github.net [10.48.67.58])
	by smtp.github.com (Postfix) with ESMTPA id E5B01500D27
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 04:13:29 -0700 (PDT)
Date: Thu, 03 Sep 2026 04:13:29 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1139970/c73543-000000@github.com>
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

  Branch: refs/heads/1139970
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
