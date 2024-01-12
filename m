Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A80117727
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jan 2024 22:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Rgbcm0To"
Received: from github.com (hubbernetes-node-86730cb.va3-iad.github.net [10.48.155.33])
	by smtp.github.com (Postfix) with ESMTPA id 4302DE1063
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jan 2024 14:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1705097606;
	bh=cSVWQVlYvXBVi59N456uEgU2hsLWAr334UstDmSJcYw=;
	h=Date:From:To:Subject:From;
	b=Rgbcm0Too34muT/NtWigtve9n+r10zvnQS4avA02smj/6Dt+2BWrP617LPjKQ/I6g
	 1XZxNKNJD6iYcuAy2rJBbW4HBFyg+M2/szKFIIJ6uFE0PYYiKR3Cf7JdT5hmvBYpSZ
	 461BDOBICmrCrQFDU/Acpy1s+1aZAJPJ3LLwDK8k=
Date: Fri, 12 Jan 2024 14:13:26 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/tags/5.72/000000-0244e1@github.com>
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

  Branch: refs/tags/5.72
  Home:   https://github.com/bluez/bluez
