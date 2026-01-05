Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C796331CA7B
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 03:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767582470; cv=none; b=bCqs4CXEpwVAnRDcGJ9bkI2L6BwsfYH85CexPUbIbuCtut6wWZLvUJVMtZ/ouPatAsLzoVRtY7w/CjeT2zgC8eafBgmbwJBME8vrPW3Nqw+ULc5y3m7+xNcFKMqzLkbqxmZCJEC8gviE7/r1di1q812IaTsb7sb4JIlODUEufqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767582470; c=relaxed/simple;
	bh=Fd+Qm0BGrljvy4I3hMy5aOAw13R+nNyDAcXUEL+w+f0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pZKOatU/7x+VJNPxZ2zpwP2PyFx4vXZKiDpp/62x1Oc3HAw0tBOsTgHRtprzB+anFnJmrtbCUJWOB8K50sP9bDG/LwuyGM3V2AwDISyjQnsj9fPxU+OOO8pGZY6DreQi91HuMJKGweF9IWnOnE5gqs4KPPwqtNYUpWtHn5KaX/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fpXc0jg+; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fpXc0jg+"
Received: from github.com (hubbernetes-node-b248d88.va3-iad.github.net [10.51.90.40])
	by smtp.github.com (Postfix) with ESMTPA id 014394E06C3
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Jan 2026 19:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767582468;
	bh=ORW58+p+bTV2L5Jmnhdli87F3uAAWflD0N/RNIJgf6Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fpXc0jg+nqLjLwB5bE0VlPOnzYoDyOIuBI4fTiaBQLx9ZGmv/E/4BWuMAc8LvHTsM
	 Ikt8X8Hf2l678rCNKClu/NAfnoktupa+NgFlVwvG2LgsM5WuDOPAiMwNWzoENAYV7/
	 OMP+zXnzG0oKvO7aczE9ohTNzl+GWwd2Et9pg4hc=
Date: Sun, 04 Jan 2026 19:07:47 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1031026/e2324f-000000@github.com>
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

  Branch: refs/heads/1031026
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
