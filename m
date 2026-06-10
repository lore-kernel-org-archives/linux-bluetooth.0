Received: from out-5.smtp.github.com (out-5.smtp.github.com [192.30.252.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08074369996
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 19:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119367; cv=none; b=oRpswn9/CIiS2DsNy6DVV72QBRwW91hdVo3TXm75QFscApZdxFyfW4qGbRBWdvI5oErPI2z8C8n5XFwg7qiKk5FT1uSUes07ybMYjg9U8IcVOBlpDgEwqcNH9n43/miUW7Ok5CQWbLmlH/uPUmgVGgz1v+JqkXUU+KHHYFr2it0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119367; c=relaxed/simple;
	bh=wzRQyhPZVAT/xM3T3cmetI6oW3zm/Bz6+Te0iejwU50=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hmdLtN86Fvfcsjo3CJIH8pZ96jR3Sl6Hj2IWQCgdw3N+umoD+oYq6b3/a3mrpPcTaEIe3S6/VP1UFZu8DcMIWO2u3gETe2GP/b/Uk+DRR4+rYvv9HjZ6Hb8gciW0dzNi+ItpHmIdU36h7byupNv4/JzzXXuci6BaBDpkTqDofOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IhcqHh/O; arc=none smtp.client-ip=192.30.252.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IhcqHh/O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781119365;
	bh=tGdrVX4gge/3eHgyWWjpq+iDo8QFDpCgP4cMWzgtu0g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IhcqHh/Om4V2XaWtSJSdVyO3w5h7iC58APH+Jh7glF61tgXWdHtGhq56J69//9HKh
	 K7IaaPDyTYPFFYc81TEQEPjXriZHDviByGhwRVTES3Twv3nFP/BLx8cVuAakDDaZVC
	 /IaBQplZ3hc5WZSRFBPFSPkylXX8Gsy1lfKySPzk=
Received: from github.com (hubbernetes-node-756dc97.va3-iad.github.net [10.48.141.28])
	by smtp.github.com (Postfix) with ESMTPA id 45ED7780A07
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 12:22:45 -0700 (PDT)
Date: Wed, 10 Jun 2026 12:22:45 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108823/cedc4d-000000@github.com>
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

  Branch: refs/heads/1108823
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
