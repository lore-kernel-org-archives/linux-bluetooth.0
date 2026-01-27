Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608B32DB7B8
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536942; cv=none; b=PiFmWl1YgtBY+JsSIbhcfqu8OMbTxAjmKdHhiWFE1B0GlHx3TIXuKVo7Gu9OVk1dyE/1MJlx5T/vHrAgX0AWsDVyXTYSe7ARZKsuI5ad6RQpzd8JZuhlaGXmLGwjMFrV7TpzmWm89RdSeZ1mp7CI3+V4luUvC2MqZg7LWLtzcuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536942; c=relaxed/simple;
	bh=aW1v+TaESKowU6wLAg6buiRLorKPat9fTa2F3bl9UTM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=D3teAhjdRTFNLQKFMf81JSCuoZh90Tib6RD6zU7fIc2fvYmbBKvfQeKTGOQ1v7lemJQYgw3rQQ7TR4yokAWCjKdGrN6qaH4ser6KrDt8BkKRzIzjZwNwYGXwKkGgEqf3KqhAm+FlKZ2CjirJR+NEc2XVzwMqJZEwoF8Q1zGBYuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=k0VX1P9W; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="k0VX1P9W"
Received: from github.com (hubbernetes-node-9675af7.ash1-iad.github.net [10.56.201.47])
	by smtp.github.com (Postfix) with ESMTPA id 6F20E1412DC
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769536940;
	bh=NbsAA7qhHxfLeZF1os5Xr35aun2gZ0eC2yu3qhAnhKc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=k0VX1P9W/cZOtomAPfe5rPmQb75nxzVq669uBQw/gRMPHZ6ZEjZa2DsjTjfP+Uf6/
	 2inbw2CM+08Ro2zuZWqGOJaK4jGa4yUEk0iOhksbLvVPFSxwjjaaUlH7g0UyF8wq9C
	 e5JEaKXjTyD7o1pb379Yz/wmAoH+9S5fIbMWmQJs=
Date: Tue, 27 Jan 2026 10:02:20 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1046231/fafdc1-000000@github.com>
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

  Branch: refs/heads/1046231
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
