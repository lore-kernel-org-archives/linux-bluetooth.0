Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D37A36BCC0
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704347; cv=none; b=r8zholocKvOPnkDIpVa5F4QzfoEeMsNLlWRGRRBDFcDEc2W4uvPBsdo+sPpdlPsJbNyk1JoRfvjMwC+Ex5y5dKVdqbUDot9A/WbhTqiLfQmbb6B/h5wqltaCqpiSbYIrbfYPGLEGiGxOJXxbCtH8DdRzjCiEv73dMhys61SBg9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704347; c=relaxed/simple;
	bh=aDLKJn6Y6jbWF/DtbSgFRFgdu25dqO8dp8mHZbz3+AM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DkufbRc8Le+NLcggpbP3GceT85Xo4i+pYCB6HscxR0hc7YcwO3bohOpt4oLwf/wT6PrJragfpbZXyorklLGKKxnTI9eF3Ig47EryOTU/rz6re1ui569NX8NfwQnbkkb6Q1Ewx+hDApG+o8Zze7mpwB5zaHgGkLRbVAzgfMVkMUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ze5mYua7; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ze5mYua7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783704343;
	bh=o25D6aPizTm3VWqdaGsAXQYrKl2yrASafndrnGFsWAw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ze5mYua7fB563MS/bjx4O+Udcq0ExjQqiBaVRbaO0cNjOUnhP6rClBzkQbSO/2tn1
	 rDem33m7c0CCBLvW5myfQ+c5cR67VCE+O7IWv/CL4I3A/SeIpAKZCbUxeZ5Vn2U6Bv
	 /aC7c3Xd5Np2ps6FO6uDML4Nq/2J05pmwizBDEmY=
Received: from github.com (hubbernetes-node-82ef565.va3-iad.github.net [10.48.73.47])
	by smtp.github.com (Postfix) with ESMTPA id 5B1FC50098A
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 10:25:43 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:25:43 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1125195/3f0cff-000000@github.com>
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

  Branch: refs/heads/1125195
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
