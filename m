Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716772BDC0B
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Dec 2025 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764794207; cv=none; b=Iizs76HC4oTA+mK7s8cgKTK7RPH2IfNWtpFSXd2N2xniwnZ+M0AQ/7kxD8BknyU3HQYIDjFxGzKGRWYQh0IEV95I0kLa7yTLkNA02SjLsqAsWJeUK+9LGv2kVqqxH3PY4jvTeiGOetaxgSbLLMfwq699jv3X6yhUtPPdpLBbSRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764794207; c=relaxed/simple;
	bh=Fv0cFxriwiakgMY7+0z0YbakE6eEKPt1MUQzAKo6T98=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tZp3MjHblq8QA6XsH3szX/knBzoGYS16g3pGXqTqhzZbpkfYHArhudJoujvqaf+eVOurIeHsTAW1SbFs4clmLdGPcSiPsH+2A7M/JHc5OrU0He2JqX5hZl6X7an7OcR8xQuEOPAuNtj+FfT0Gq1UvKowCvIUu6OyKLKB3FTEHrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Rfjkl7EG; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Rfjkl7EG"
Received: from github.com (hubbernetes-node-858e9c1.ac4-iad.github.net [10.52.169.41])
	by smtp.github.com (Postfix) with ESMTPA id 6AEEE401222
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Dec 2025 12:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764794205;
	bh=L8HmOSEpzO6Ld1WA4MSSl9LJqrmbeh1Lz2PcUFzhrEA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Rfjkl7EGiyTyhl+o/sqj9X18DSA+ev7IOaOVIwjgihd+Q2cRCoPy04y+yUNaO5/u6
	 FiXfxm/1JIYfYW08Qro+RBWfZqGJyirRZH7Psd/4Nf1UpqOAqaQF6A2c1CL//WSXFh
	 JG7r5f+YBcERZ5GlpXtHY5i78e5+uE2aQvGQSukY=
Date: Wed, 03 Dec 2025 12:36:45 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1026777/402371-000000@github.com>
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

  Branch: refs/heads/1026777
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
