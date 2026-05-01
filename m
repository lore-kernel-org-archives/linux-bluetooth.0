Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792AB275870
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2026 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777648003; cv=none; b=NAfvv7fWTf98AKWbqCxSKz3hxRXoX0IUt2UlBGmUvNd7eGI1glwDUuuL7aGxeRM+AEKrybOxMk0PksgI7IqcM5YQyvUMFqsJTTzTO79bzuj7GqkuWMDRqHAoHYADyYAQAT63yd3hfWkYrfLDICZsMw0XgcCHU3K80BgqVNQMt5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777648003; c=relaxed/simple;
	bh=hH5Y8txw9OjO7o8Ea5Tp777gQEFTZSRs1EfRDi0gVSY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XEO40MpvzaehY/fdJkKVbXL76ltJcvNgHadjz6+NAznFQllqga4PKZJaGx1GzX/2zw0HDhSO3QYD0ABCQRGea7UHIeG91GlP74Mg6nGJ11oGFp7dAOv3IlL7DdjyCrCAseIBN3ysd+WJ/48c8epxl/1rLegz2cjeUcjcuCytYWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TP0Fa+/C; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TP0Fa+/C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777648001;
	bh=f0bHC0FTXJFOVaXy2pfBdWs5sRhkyaCYd+UvcDbMyhQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TP0Fa+/CUIEwXvClfq4PDOCAcS/lk2qP3+xKluvAJHdgZInIU6a22nRUmy0+OCzY4
	 0m5qXrfWHZnmpqCMWO/9V4AFSBtI3WZ8n6xiek3Ap5u5yHU9bq44hAXYDjyotr5nNy
	 IYB56q76bgtvN9hVEYfs1aVO16+7sxoSAsQmHSjU=
Received: from github.com (hubbernetes-node-f7ded0b.ac4-iad.github.net [10.52.223.65])
	by smtp.github.com (Postfix) with ESMTPA id AAB3D21029
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2026 08:06:41 -0700 (PDT)
Date: Fri, 01 May 2026 08:06:41 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1088308/3bcc24-000000@github.com>
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

  Branch: refs/heads/1088308
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
