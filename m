Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820AB37F01F
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783714166; cv=none; b=eds/3CbSCSa1Pm5l1b2iBrF65UfYwoNOF6IF9VJgWz5hJT9MoHPdktk1gWvCkRniRLAQnYmMTazFl2P3FVZyITYTM1Xk1e5D6vXxshksCWrsDFwIIOoSp7QXrclA8ramJ7Q6VEXYaUn3On29TJ8Lp6OsEoPWU0szyPj4ZjnfYsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783714166; c=relaxed/simple;
	bh=6HeMKTy3u2cdm0CQfGen51uESELQcI9YupMCH60LwZ8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aHqGTIsJYnzGj1daKd0StRDW65FnHTI5ecV79kzOHJ1HgTBIyZYGnMY/MBETSg/cZaCQlTS6LCbEwkmV3mywao320HlcJDzgK8PY9LZc0mo6M14nqbrqompxzPJvmeT9hqlK0LHu9k4DgABs4/8SbESSYfvuyaILvcPA0qvWWdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ce8+U+Qj; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ce8+U+Qj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783714164;
	bh=h5PNOHw/UNzq6Mdz95b7eR1FMzfFN1dhYC30ANvoGto=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ce8+U+Qjwp5JGVweJ6pDeA+/mTG+1Qo39bZfN8cEK4mBiFNYtq7SpkixE1dXBGnb/
	 J7uJGy93IvhgPZ5aeCUNowZdn4PHlfICqDbB9gI69DY5/nvA2IrRFJG80sZog6E5e6
	 MuhBgvj+qRL1UOA9OH2nL3qpPiF/UohfKXO3DZhs=
Received: from github.com (hubbernetes-node-8dfc457.va3-iad.github.net [10.48.81.57])
	by smtp.github.com (Postfix) with ESMTPA id A51C950107E
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 13:09:24 -0700 (PDT)
Date: Fri, 10 Jul 2026 13:09:24 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1125495/9e3c1d-000000@github.com>
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

  Branch: refs/heads/1125495
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
