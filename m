Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CB433A6E4
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583098; cv=none; b=KSMrF9F6D+JAbb/YER5KnUvDT2Gii3MOwoVyBozyCKPFgEVBuFEbAKUODzUTTCQSJW33pdtaA3JrCKFP4cFEjaSm5/aDGNS5Oqoo98u9d6cMch6PAq5My/WT1BChirKicPfhS7WGjEZaiiEFuUDIihnBIBsxrLiA7XL6ar7OFWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583098; c=relaxed/simple;
	bh=zYcI1cjFRwlDJyGxxaLHmTga2z6gYED1iHmw90cn8Ws=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bbMCJY7LQf1NtWUYCI8T4l1+f4RnJUR/DRO6B40v3eeFpi90z8lTzNgWWX0NJk491Ra47A0abkeHgakUaEn0WxXPLIAnbfjX7ssL5vB7GvM9NFi4R9H4BHSgd4zJM4wzUxdkEVinwC7jIYYLssJGQgXTX0nUY91qKTjoLmF1MS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GzCFOkWB; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GzCFOkWB"
Received: from github.com (hubbernetes-node-5447ff6.ac4-iad.github.net [10.52.205.39])
	by smtp.github.com (Postfix) with ESMTPA id 2C3F820BCB
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 09:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768583096;
	bh=bDJjNT7kJITbqEJMMByx2aHVva3p0ajhjLTCEd0N2aM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GzCFOkWBn+I53vK0uyTTyzBom+owkYDGofGmUpohU9DShnDaKloblHxLtJYWXcMZf
	 PRKHBwoMYNX7Zp4G7L1HCJoPn/jRXuKc/T9bMgLXjdijPAOZXUjw8D+DhXAKSqofE+
	 GL4IG5DF3dqnZYjQPDG5mqgMycE8xfEncWu3pVAc=
Date: Fri, 16 Jan 2026 09:04:56 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1034329/4fd06b-000000@github.com>
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

  Branch: refs/heads/1034329
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
