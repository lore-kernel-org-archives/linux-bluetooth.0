Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC07322756A
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765483272; cv=none; b=Qhzm7o2RlIJPqnE3w8DUXhyHqtQ0QnGPrF5dAVDU6EfZKUQrl7KAo1OOCReU2BxtB8mkj9JjVs5HPOiD1vNI65OB8f6x8xqCJaIadDp7Jk6Mp8sm5jvd0tjwYvd5u/XMtqmMIrvGXxEi1Tu8xdUJKixMymVJL89hj+XdPf453w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765483272; c=relaxed/simple;
	bh=+HTRoG2nnm/21V75neFcY23LC1mx42e7DR1Nn/6P03Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LcRqmZGlCL/ejRST8kY4cwBOlZxzSR4/s4ByAWDT3VaHxdiA9PSWTnHPa19BAHmDaL8L5SegNHNbJDkUd3WqzZY7z1OGeCs/UnMAtMH2ZW7fEVLlAABrCj30NG1xNtdPavbxWk35r3KQ4jUC3gDd2WOxSsGFY0nZmDUEQ50ez6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fujHz7Qf; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fujHz7Qf"
Received: from github.com (hubbernetes-node-335fc97.ac4-iad.github.net [10.52.84.33])
	by smtp.github.com (Postfix) with ESMTPA id B065C640BBA
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 12:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765483269;
	bh=buDcknVwGled03TGalPMhYeFYgHyYGMeD8yrQUZitBY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fujHz7QfDQRU33CMZsi00SmzmL1VC2tNEHhy2msJmqM6iwoNxu1Zc45pmjzOyotZJ
	 b03YTIIpWTR/8Td0HUML9T7wCVHTsXO5l9NMzSt+3vNgMd3lv0EgXEhAW+qzPlyaI6
	 WjfnnubcWXDpdRXgox8egFRYe3zpLnThT0amXoCM=
Date: Thu, 11 Dec 2025 12:01:09 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032051/1cc4ca-000000@github.com>
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

  Branch: refs/heads/1032051
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
