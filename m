Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3F2548579
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788897404; cv=none; b=U9fGrs+o0c3CmAskTgY0LlWjxE8jGRmt+UV1q9aNYEIYR+ZKdXb7wCIsOuopg8K5CpomVLN+swno3Rin05MEFpqTPn/fkjKP4D06RABfXLl3tMSvaEsN/YrMSUPt7OrD/dlTztUyq4UCDTpkjN+cVC1uX1e/pnhCu32yiVfAzCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788897404; c=relaxed/simple;
	bh=DIcRDUT1uLbAJiQdh7mhFiwV27QKNMWxyiUMvW4yZHc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DfvK9iunGt3DEbK5fwa9uqMYYu2L6HRbTUWZdUW8w1tDHaPLiItCVIOR+bjr7plyPEbhR76+vIQAdI3PBYdqJNIc6QzKPCbtApgvzGLDoC/+/tW/+CiXbz2iK+EfPZ+l4PAFr8pQPvoAskfl3SwN34S5VY/jCQsBeFMafooRoyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ThrRg4AK; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ThrRg4AK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788897402;
	bh=4E6YZij8lufy1/nMZMdLRoVpPU3eDOygB/XFiy7MYO4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ThrRg4AK/Vv7GnwJJWBMwD7YpgVfg7gX73rFxYbn72vTeNhs9a1er6ibWYt4Dsg2K
	 4Nv6C7S4hqlx/YMfCy1AzDvctAOVLT2a8bo2Z/VyjPuNBcyN7ibBsXoGS/+U+s2dIg
	 tXpM2KAN4poWpx+ObGJGkdTBlooxpNullg7GEDoQ=
Received: from github.com (hubbernetes-node-b9d7428.ash1-iad.github.net [10.56.203.99])
	by smtp.github.com (Postfix) with ESMTPA id 7AB9652024F
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 12:56:42 -0700 (PDT)
Date: Tue, 08 Sep 2026 12:56:42 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1156962/017011-000000@github.com>
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

  Branch: refs/heads/1156962
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
