Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843B228504F
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Dec 2025 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764579664; cv=none; b=UH+9MvfNuDRIj0hbhO/wvcfVOcznakV+DHAoRynN2Sp8zekvg8SLJ2lps9CBJoKgvvNX0awSCdeggEAWGRPeHSWrtnWUn8SgnC5E++jUQvHIhpuXPSKX5ofiAuE9khoMV0KQHxVcCsFBgtI5szCMB5G/lcE04a96JkRlo87NAOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764579664; c=relaxed/simple;
	bh=e1ue0dTUVp8BTW9wptS/wpJW8zyKtVe9LwXRxnIV/UY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RHnukL4feGzzkIWfDTIIE1LzF5uLKXKEa3iLVx9jSqhsNDWWsDDx+IW1cFY0Z5Z4svkWpMBN3GC8cvFLnPRGNlzBHXarqX1rZR8zKEmr94I8NmWKbKu1Iz37rjv/P2NlzxLtiP4XbzO7Jl4U84sbaMRQL9qGTuyvxiFNsALPjVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jln8/39t; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jln8/39t"
Received: from github.com (hubbernetes-node-8c4c9b4.ash1-iad.github.net [10.56.14.20])
	by smtp.github.com (Postfix) with ESMTPA id 98C48601167
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Dec 2025 01:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764579662;
	bh=hzxl5zwxOfU2wYr0O6Je2G8FLNsq4HtXhfpv+elauzY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jln8/39t+jq6ghGXrOhH5dmda6uCZlngi/yrBkkI3QLVmZ45oDKtTWeDWey5hGKD7
	 dxvctTJGXk0XtiyUyFp/4x29f+VJHn58jluWSdt/Wom1l1xoQEhIXCWSboizdsTfrx
	 EnnAbGjL4r5wgSCGpKK77gJgQyNv2ZvxDW/OfIE8=
Date: Mon, 01 Dec 2025 01:01:02 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1028205/953f53-000000@github.com>
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

  Branch: refs/heads/1028205
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
