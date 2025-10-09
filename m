Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4543F283153
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 21:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760046958; cv=none; b=REJE1Jh6Gi88mAdbhceTHRrqwsoNuQL3nPZe3fbaolQUNt4ybpOmvdlHka8IqVyFghs7X/pM6O2ruMTYkZUOKjVW5+Ciii6J0/C7JoZi/LgAZDY40hTb6fvL3va4hN+U2XGAM/VCYqKO2iB5DNojLm1peIkZ93j6RoIVUq9P8gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760046958; c=relaxed/simple;
	bh=t0myUAa5wBsEjh8Cjbp+3Y855QNCOOo+R6oynIJ5qsg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=u7EhrnFtALHGYrej9o+RXi2f9/hcf4aBnMUIwWcSUneqE7dsNihF3EpZoveAmpzJEumjoce+e5kQO4CnkmABpqI6DfWTFc6FJg0dWzYrEuVOLlyNsNIYbHiAOr8YTJs8Vq0UsZokQiXmj0ScvN/bpAE2a4PljoRtB+Lq1+awjcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MeL12xt8; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MeL12xt8"
Received: from github.com (hubbernetes-node-81ccf5e.va3-iad.github.net [10.48.205.100])
	by smtp.github.com (Postfix) with ESMTPA id 3EF0C8C101B
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 14:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760046956;
	bh=U6iX2G3rUCdeeSQxNhhU44kX+S2By5EpSl3E3MhvCrU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MeL12xt8V3pGQreOWqIjQb6L0qHC0i+JuslN2Ib9ll0GaRaebYxyDryddr9Wn2bGu
	 XqP4dtaDE0SHnHPW+bzPV0Jck1W98IM03rDt2DOX/UC1484C73IZKyL4Db2aH93Tp5
	 HSRJf/+qbkAP2S/jfS9RspoqNnNs2QCiccd00MPk=
Date: Thu, 09 Oct 2025 14:55:56 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1008324/c3e880-000000@github.com>
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

  Branch: refs/heads/1008324
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
