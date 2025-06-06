Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7122F2A
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Jun 2025 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749236495; cv=none; b=DOT9uD0jnIP+fF8cfXm7cO/1Ab4jX6NjT10EJjrrUVsLcQ1YULL1ATNy7QmNCx9IY9eCuywl6MUxuMtYjS8uasPvfrBC7V3nMD2p/Yl8fn6E77tXKCePT43zKlpi50RS1WPLV+FXQc3qIKLe8tOE/YsUt87CSm3qje8WH2iGD3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749236495; c=relaxed/simple;
	bh=kywz6y9rDluu3ZJ4HD0Fe0OZi41AZcnSX8t4ZnGNddg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pkt9i2KdIAgTVT8MY49w0jsaCOqzZWG6P5RtdS/akUbuN2cnfudTQ8wGb6i44tXWiCnO9Bv48rgGMURW5IiIjNH8Fb1KHVTyKghmdj5q+DySA7CKobbHo7YqsQx2DjET7602WjAiP3gGkigPJWzaRYIG4+4MrISzDf2KqVf5Fjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IV2HFtSx; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IV2HFtSx"
Received: from github.com (hubbernetes-node-07e44a4.ac4-iad.github.net [10.52.164.21])
	by smtp.github.com (Postfix) with ESMTPA id 190BC20824
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Jun 2025 12:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749236493;
	bh=pt2PMBmA1k94eJ5wrthKNcsCJ2sL27UyHB8UYcTfGBQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IV2HFtSxIbqBQog7PXjOiMnzEeAzpVx19jYUrhpJRq5gcYqdaFfCsB/r0E+Rcf0Ii
	 qY03HTzUBH3RYyYL9tEyE9/c6bwwFNXjOPdTO6UgIZsaiDyj5/hiVAmGV/OFOuDz1C
	 BtoO3LQcof8mEBm6bh7TLLl0SGwHAQq7jgCO+ZIk=
Date: Fri, 06 Jun 2025 12:01:33 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/969046/c5ff04-000000@github.com>
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

  Branch: refs/heads/969046
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
