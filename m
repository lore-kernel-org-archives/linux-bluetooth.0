Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E9C342501
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719052; cv=none; b=EekGjLk4J56G5skoEvSX8Y1CHAZFI04hcQGZCJxGKU3132ckOrI3WsQJdg/abWp4NEotVj8rWeUFq2k03ICb3jDhp5q3TitwACDnOegXm3AY5AZfHCDYKMkEjxqaJYdPVy33YVm9NoIu6dydJkIsV2BaRadcSSwj9aX72tYke9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719052; c=relaxed/simple;
	bh=SR/GLqbRWZIhkmXewPrweTA6V9bIRRMK4gnpsYKxPHU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jqV1etfQp6wKkWqyQU3/4SBCPQEHBG2hon350SPenuwgcg/E07rQ4rt6/ESEjstVu1KFLXXf9YGPuvRBXV1UUCAJGWtdPI5dfEiFuP9WNqxnhLFg+tAw+WtZKt3PL9kSyu1yh1fmo2zvvSOgm4lr2xXWYpFgFV0ZzlsasExQHxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WAKkAUXv; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WAKkAUXv"
Received: from github.com (hubbernetes-node-40033b1.ac4-iad.github.net [10.52.14.35])
	by smtp.github.com (Postfix) with ESMTPA id 01CBC640792
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 01:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763719050;
	bh=+OeYG52d7Nly2tGBgbWpj0O346I30X3snfGg1fp9P4E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WAKkAUXvuFLqkFilkQoC/tZdLAidPE2Gx7+PMn3Z68tOxdFinwGrTqf7NcFx9V7oI
	 Ra+5Z28qcig8M3hwP3TfGi5DOsqtD/qcFYZsWBM14TLKHQUfPFOBMgcorH7ocGZYVK
	 tsg34B+UhELjxF7h169I9bf3vF4My5E0zyXMp2dQ=
Date: Fri, 21 Nov 2025 01:57:29 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1024759/d052ff-000000@github.com>
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

  Branch: refs/heads/1024759
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
