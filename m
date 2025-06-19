Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00395235042
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750345103; cv=none; b=I7xjhzyxM1YOzeaYAMHqeHMsw2GPc7dqP3nKUQ23ssJ4BW4wFoGhzgwyx/rpKCPU0B+HqoxvDlwKMqBnpiTh8/FvaKh8NlGS88tbZa5IeLH8E6ma/ttk7YjjywtQPtHY6nsvK3kIk7mEAVQcbpcAro4aJUovp/VisAg1t9sb7x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750345103; c=relaxed/simple;
	bh=BVzJKz5S+KPUTjBVUjdNfYOpMrvPpWmyQ7xe4MU6mJI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XBn9sRPOEYifoH5Z7Kx2FJyxxFMyrmzA5RlmxpAi9t2cpu47vJogPzGVhzqPmMDiSyXIuOmVom71wDV6DWcA6ZCmsTTKuu+mPXinr91HgJuPKZRZXvfaxWjVQSqURhfzKuvSkeoHrHIf9geBCshPs8/bzeWh6ZAC/qoTdDggl2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bCPH6Y4J; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bCPH6Y4J"
Received: from github.com (hubbernetes-node-9f6b69b.va3-iad.github.net [10.48.209.97])
	by smtp.github.com (Postfix) with ESMTPA id 260828C01E1
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 07:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750345101;
	bh=qX0USH9AzduaIZTY20citLF07tMsh1BAwUjbPWdoHgw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bCPH6Y4JiL3JianmwuEPNF3pOgv9lg/Qw2rzGH171f1OMZB2tZ8lz7QamkPReohRl
	 rBB7be/X/FujQT7H4qKHwj01TcBuABG/J4kv2lSLQg6rj2IxG3tRlbCo5gIicDAmqz
	 l6QPbsxW6+tpgjO8DGX62vP8SIyLC/vsZCTTeAQY=
Date: Thu, 19 Jun 2025 07:58:21 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/973861/ed138e-000000@github.com>
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

  Branch: refs/heads/973861
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
