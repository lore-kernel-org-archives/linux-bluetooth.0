Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF609269AF9
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745440665; cv=none; b=HG7QZ3qLXcSw/6IHjvEgJK5szoC6q1kWaadTUGt3vU7i6Ovt4Bj296rj8ExPPPqnVeq2buVjsov11HQIqGlRKGriSW73gwNsx3HgrhO1qcaf0P0JA7Aa2rBCnF0Vq7GoOXOa1u9g90cK0E6937EjURHMWEVP4jJJoU+mTKbxZgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745440665; c=relaxed/simple;
	bh=cE5vgTjK1ZzS6NwO1Atn47I2tmmrzkAf7jaSD+j2ucA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=k8+fp5zF8RFfka/RnVEt7khEonDsAE1YUg/s+BmulJSbL0mMMXDB34vSEsXIUl9k51Eo5aAfssHdtDBNHgFK+ru8uwZYtZAL5mgG67n1Ke8+eY4xSks9fe1o1h8IzdyhYuR+QTmxQZuKgBhAT++L1QBug3hTGwKx3jQtP2WJFiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kV3341Z6; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kV3341Z6"
Received: from github.com (hubbernetes-node-34c8121.va3-iad.github.net [10.48.143.35])
	by smtp.github.com (Postfix) with ESMTPA id DED604E0519
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 13:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745440659;
	bh=99RJvbC2R/86zUMOToKrvslNf+ycU+8noLhT+135p/I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kV3341Z6Jw56yXR8lf5Vj6TRN/ZzYLjIISgrIXej7V8rR7YX78OQamH2azxJHr3xu
	 adVXH4Ra6WZ7ttz26xpjldWumTA+Te1puLe4XVOZ2bkce3bN+mgqU7qkoxoUMFMucq
	 KJjbbNi0Fj+mDew/fvxOzv83K7L2z7I9QCVBff8I=
Date: Wed, 23 Apr 2025 13:37:39 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/workflow/000000-2d98e0@github.com>
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

  Branch: refs/heads/workflow
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
