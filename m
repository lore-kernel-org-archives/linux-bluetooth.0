Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA4B3A63EF
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789412639; cv=none; b=SxNAhy8jT+WAB2DKsI1n49ao8Xx5q1pDg0K1t3tuI7B4jUYOU32bBgkrhmnMlR/YKoEk9x7I+1YMcMMfyR05SmL0WKEfrQJKOAWMJ/7jSgKgx/reHASQbQ9+nH8cAbmFSrRrktphUot+j/k7HUX8CFPAlCVEfcpmb47W0Kdz2y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789412639; c=relaxed/simple;
	bh=RlpvNPygxlgAb1vcA5gZcdp81g6DFVtNQHFjaMTb4wk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LaM8wo6zqbZjS4xP+Lj/2Zf6qJ924ihrERI714l5UkijWKEfQtRmXbQ+Qsu/nW4L3f1yte5sKiTmGusywRy/5Rme0gh2QhEkx4ypsZepV/4Z5hzMF8U86ArSiOfj0sw8zuOeObwlMMYn3NxayeXmiV98Plqqrb7w4/pO/aRdP30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XlVlciBK; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XlVlciBK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789412634;
	bh=NJYLD8de1O3cvo/BUNHa+OkM9cMLdbtqeWjTXVzpwWs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XlVlciBKjPxBew47Bfg2FDE+QpY7+IXdY23iZYDi+z7RVqoagOTZDNsA/uyfxrSeo
	 g/+Yv0m06vuP++Q+qL+S9gHDOESZOzo9RHuYhtDanYYHfWENwmB2eNHCP+vZuZPQQy
	 aap43fYJ5MYTrmihwI5quvEENv6rn1qbzANn2d9s=
Received: from github.com (hubbernetes-node-d3cf174.va3-iad.github.net [10.48.167.47])
	by smtp.github.com (Postfix) with ESMTPA id D9AC6280A4A
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 12:03:54 -0700 (PDT)
Date: Mon, 14 Sep 2026 12:03:54 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1163573/3e9e53-000000@github.com>
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

  Branch: refs/heads/1163573
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
