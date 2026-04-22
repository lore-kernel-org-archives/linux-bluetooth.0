Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C6235BDDC
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776872629; cv=none; b=d40G3WWl4SEStoFaMe4uOz3KimTWiGjwXwQ/pTMJAPh8wEs8ss6oIjc+wLxuoOphJs8zH6+EQ1NqWEVgk08MpuXKDrAnmpQXJoZIx7wcHB8QGw7VJzvAPTDWERBrt1XvziX9pn4jdiDc7CuIFrkBEXcI7xA4lOitTOTWVGBOd60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776872629; c=relaxed/simple;
	bh=+niKd2jyBg10V/Vi2wjxVGq5kVCAVF838GwBlCa84FY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WwP2E+57mVDmVGcTgG8yx4ebpHYR623+XKmru/9TMb/TrMeUbpxU24/xHMVH99TUdT2PjywlH3NjbBSbWJx3LAWHl+q2tkW433EG4T0ackNznXNsME9+K77VVER++IolN+mb1uJDxuKRDT85ljG1Z187NL8ZavGpRMbw1kd/t04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IBHDPGY5; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IBHDPGY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776872625;
	bh=yfeTRFvtaMQclYvpnWbt/Lx/UtFGBBxWJ/906DJypRc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IBHDPGY5gq2XfkbO5hwnY1JeQYz43NAsmuKwoKRxigvp+fROsVmA8EKIkIwRKirsr
	 vcYf6XTr4MzCBsHeAGGPcq1jfmq+WRvBUWiujgYRUkvDP+40MTG5B9GF1MVS6yn951
	 CuofQfo5CZguESH7uKr3V4Z1DotBSFXw+1LNYsNU=
Received: from github.com (hubbernetes-node-a407c3e.ac4-iad.github.net [10.52.201.42])
	by smtp.github.com (Postfix) with ESMTPA id 64A0C9410ED
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 08:43:45 -0700 (PDT)
Date: Wed, 22 Apr 2026 08:43:45 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1081856/d638df-000000@github.com>
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

  Branch: refs/heads/1081856
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
