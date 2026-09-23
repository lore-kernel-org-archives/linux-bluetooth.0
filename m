Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1488643CEF5
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157708; cv=none; b=hEq2NAsmdjYY9owhZoNRw6mWldKXat+qiHWJJFq195u5KlT87PYrA5WT5Pq//j+4cJMn3U/f/IpRGE8V2V1SaY6Ex75yQ0NTP3bz1nlAWHisGrMui60dKuklndhykrjgBoJGFVwAhmWcI3Tn5v35ERtbAGWQyG3wZCLfsUJHtEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157708; c=relaxed/simple;
	bh=SIa43j87UrvQQztUTF48lM53oTT+v1VsUDWqwjXKSzE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=N+/emGPz+lURrwGO7lxzfIkrxTSullLNsBd7cSmF3rfib6EOf7Xef2zZmZMOPubGBV/HVSHazMH41ZTr7G0InY0KYnyUf2ndglKFNLohFHVebB40nx8Vh7hfe9FoqcSqCuqRQbBmapiX324hY9WN4PUWh0k8txCdsponoJqb4l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Bb7wzynY; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Bb7wzynY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790157706;
	bh=HvVkeBlalt0QJf1ZL4zXh//GVhyrvNl9uZhHeCMGCtc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Bb7wzynYOgktHG1maqM94ZJYl/KINsL+buNHZ7KIezBrCb6Gvpw6+ncbyurh+MwgD
	 v38/v7kRsNb0iz3ENc31FfL9yqyZKi9QG6v6GIBEyEL8cBxqLrlucfnm2ciy9DH+D3
	 tGsCfIigVQwSM98Es1l7muOPchJzc0SGdRaqLXps=
Received: from github.com (hubbernetes-node-94d846a.ac4-iad.github.net [10.52.222.83])
	by smtp.github.com (Postfix) with ESMTPA id 14D8E94177E
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 03:01:46 -0700 (PDT)
Date: Wed, 23 Sep 2026 03:01:46 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1171436/8d2010-000000@github.com>
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

  Branch: refs/heads/1171436
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
