Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2E5221546
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 04:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785127460; cv=none; b=qFKUEJks+EgutpaJCC+234MHmH9ATOpU3jQiWc2xcwu9GWq5nMt0xzsotAu9IjuV4qNefDKurRMbbS5klg+9BuBpZELAQ/pDDn4pLXWnkcReyJSqigQqs92pPKCN4Cyd7Wr7gES/t7AUDp8d83TXZLlXDKwlT+OccGQJ6fvTW0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785127460; c=relaxed/simple;
	bh=qX5Zi/EhpP2Cps1GhAw4uVKby5er/ymS4vpb1O7BJRo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pUsGauV2knXaUQ9IZlvkUbzIuEhWN9xH234mB2godx9mQaBx5yQivMlVtSXLH+jXGvbRpAiR7veC0jePMP/a/FOcpwWG6KSs7cwpV1ZiykgOZE8w+54o9iqqj6rYxwV6xNE639yszGXYHmt8v22WZ4Qv5XzCLHVgtCEdPHup9E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IR5j7LKF; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IR5j7LKF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785127458;
	bh=zRzHKsKiO1nbc6geaKuKv7s1LE1ddv7ElBD4E+tDMjE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IR5j7LKFfLhAypxhn6orEesRl7Z7tnVDpAr/T8L8z1fxFw5rjag71lsDEcsHAHYKW
	 rfO77UakU4Pnt/xiIgfGDzHh5fvSunbl7Nz9ZfqDD5FL6VDBdnm+0woQLZLqWWuGP5
	 OL42Qi79LL1Z1aJxaY9anOPlg4VnxMY+MmAGPIhM=
Received: from github.com (hubbernetes-node-1ded4fa.ash1-iad.github.net [10.56.171.28])
	by smtp.github.com (Postfix) with ESMTPA id 4AA34181046
	for <linux-bluetooth@vger.kernel.org>; Sun, 26 Jul 2026 21:44:18 -0700 (PDT)
Date: Sun, 26 Jul 2026 21:44:18 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1133845/31c0e0-000000@github.com>
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

  Branch: refs/heads/1133845
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
