Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCBC4D0CC7
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362800; cv=none; b=W3+hv91YMHFpYNLUASoLvt/Nbk9uDWb9Orbq0UkR5A/01vO1jtl4SFn5ouiRjRIXHrFxwjmEGKqoYcprbgO8tyCOnD/rXUthRK1wX66JQsk3tQot44TX7jQQMVD33LJ7AZX4j5D36+J8kufJNHIqByXUjz7ZvhWXBUkdLCs2pw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362800; c=relaxed/simple;
	bh=26YbIZCeH+TgcdiHvdKJt+kO7yJfWJNgfTFLj+cteUo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hf8CGYeG282X5nBRIrkO+FPYTW1n2SrxR2J23kyd7gGyl1p2T1XGs5KhiPcmmoYsrF07kH1jFw/ATU19WUOXVz19+bPqxQLKaetk9i9PYYBVemyiP/h1QkPBGYBiH/5cSYc5vdwkSRZhSUzrwC9zI7c1RDvZqaTR/CEd13dn8vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gb3cNA8i; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gb3cNA8i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790362798;
	bh=p5SmPSnMg+ub2DIC/L3B9wFBjbgGA47e0hKl+ekekrA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gb3cNA8iQ0A4qFr7780kMV+XG/rhAPxr1rrw/0GL46fMRW+Bnq4AWM+Y03ReGFE1d
	 0XOblb0Wvb7WRBuvIz+LY4TYhV4NCP7MrcuO6Kk8mOsDAUtCIjxoKIQCIbyNmcgeA2
	 ayVTUPLbzz5yyZAp1XUUD4bhAqRQwyh399T+xC5E=
Received: from github.com (hubbernetes-node-fa4087a.va3-iad.github.net [10.48.158.24])
	by smtp.github.com (Postfix) with ESMTPA id 57F24281218
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 11:59:58 -0700 (PDT)
Date: Fri, 25 Sep 2026 11:59:58 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1172004/f38719-000000@github.com>
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

  Branch: refs/heads/1172004
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
