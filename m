Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C0B324712
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536941; cv=none; b=rv8dopcZV9nlC/Lxj4gN2KjNXbwdTEamyLkl3uX0nM2C3yr32NjzuShaDp3Ic0sfy24iNRiYqmGX9eIywD3pCtcCW8x9ijLtwif7aEe2nRDqBoZIgizu4T7o/tdGUH/82m0mY2qFpyL+CFrmznw2SdgvZUc8pAdQNR5q+mZlkYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536941; c=relaxed/simple;
	bh=z+CaVoqchGMmsobyS12PrsFNa6Ikfu9ilvDOvz075YM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TBq35DGKkcktNcVzy29GYdYrdWRaJEjz0n6xdhHaa28zDBl8HA0ZdDjLXXXZPhETHf46+A1KAvX0numLbJce1H1nReoz79s5OhSGvsy4yd629ch/Afge8K/MIlrs2UigrU1IkUXAktZX0174e+bNveqhzq0364IKS9SUER23eh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OXY5CGC3; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OXY5CGC3"
Received: from github.com (hubbernetes-node-ea278cf.ash1-iad.github.net [10.56.184.36])
	by smtp.github.com (Postfix) with ESMTPA id CE29D60122C
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769536939;
	bh=F8PekdTI7b3ojpt/5qFZMGlXr+Ts/t3wj6meZOa9jLQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OXY5CGC3KK1T06HHUQNK9Wrkihf3TINgsU2gXl0fF+y1kK5RX9vuDROfjJUr6guih
	 pE24rzgHyZRhaBPU348xfSiVg00gMEFJ4lt15iW7Lk+mvrTA3+znSNMH/XEHIVzGzO
	 ydjvsmzNfd27zzpwErYML79s+RLo1gVHR05vPJi4=
Date: Tue, 27 Jan 2026 10:02:19 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047655/7137d0-000000@github.com>
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

  Branch: refs/heads/1047655
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
