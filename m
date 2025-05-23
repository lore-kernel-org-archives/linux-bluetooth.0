Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E33E296FDF
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748019135; cv=none; b=OBW0K95j80fPxniYuJAa9f5BwOUQAq4bN/u+MUNU9GPbaiMy70bnKNvDytXkILDx/cu7bhClpP25AuMYpgUtt/BIGbUgQkXuRC8ny4wVewnR/kBj/pqiITsLwyqGteFkd+ObsUHNJgeAypE8qXqWFMgQmFiYKFuaSnDu9ksrGtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748019135; c=relaxed/simple;
	bh=LGn2YKIrkGjMvFzw9M02LLtvvQuZ0Qh/r6OLtG/CZhM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eD/p7/zbNQtuvF0MhFsMH1SqXnGsoQisj73YNOuwa2Upb1YJY38bxmgX2eTy/MLfUtpP3ljL++lJBEgWGzoDJMOqN93jcMijs7vBYgLJ7k6UbNj+wDP72n1o2u/R2w4KFbI96VNKEmEtvf1zU3ZNwxm4rOxIPxbeeX+QH+f9uMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JRQXCccu; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JRQXCccu"
Received: from github.com (hubbernetes-node-4971d96.ac4-iad.github.net [10.52.155.35])
	by smtp.github.com (Postfix) with ESMTPA id 309376404C6
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 09:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748019133;
	bh=QywijGhkJl0rChrYzr95Z6iVfDvRGsXZFDC0QmBsQhY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JRQXCccu7DiZ7zFJtcQxvl20fZWeVdPnxQLjU9U8Gv/Hod+Jg0w/6jnfGFrPUA/yc
	 KEHzeMTdFTs1zCWpbbh+fxmbRW8SIhPB/fgjAiua5Nq9GPxa9bYbtqLvUVa/MjWPOZ
	 0hnYU7TSgGy5AxwlZkHmI+05mDtB+2Aa1K6VYKy8=
Date: Fri, 23 May 2025 09:52:13 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/965873/2b0e76-000000@github.com>
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

  Branch: refs/heads/965873
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
