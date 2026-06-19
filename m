Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEE632AAA7
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2026 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781887560; cv=none; b=K76u4rrNvB3D6+eq1aZen83B46h1wA9LiBHU3/RutRqjM2Y1ninRyHvM6PtZGKtsREeWWqEdy3IU8Z4ZoJmDnu226PAg3h0L0FTbvT3qrXhS3ai95fiL8rsu+VYmPWp22OOdX8ep/+7YcXUFZE1EFCxQklpLpHuTDjKp+O37egQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781887560; c=relaxed/simple;
	bh=hia1ZP1ZmaSC8eUzBTmZ9XrnDRBIuJY/G2jY7tJ07Xg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WRjulHbTIsRkfuOdz+5BqiiQQI/HTyVo0f0uGVhLVM5vIUqGO2Pd1Bt+xL1J9r4zwJsG6vD+XMaHxOaUlGiGu3y/TM6q6fnrnRFzY0veXhM2Dm0lw7xL9o5U0Rv428gD7V0gneKMlGUSQhx7Rg36qN+ycnc6zdOZ+k2MxDQBTH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=R1KyqFqU; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="R1KyqFqU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781887558;
	bh=xaumJrBLaBgvNjCEIauklZ7HZ/IG3cfYxjgs9t9ZZpI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=R1KyqFqUqfHKVFdoQ0xyIeZIJTf7Fg4kmHGXv4pfTYw06tGGCJ+gK6K7tNrGAgzOG
	 u15UHomCC1vXSI2b9ijcI1MkolsfyEptkn6VZm9BJFdtlq6tb73cDaB7vceG7N4P92
	 hGVxAbNpIQZQIN/1xmdh0SqUF4G5YewmuIhdzeTA=
Received: from github.com (hubbernetes-node-eb39dbe.va3-iad.github.net [10.48.153.33])
	by smtp.github.com (Postfix) with ESMTPA id 799B8180FF5
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2026 09:45:58 -0700 (PDT)
Date: Fri, 19 Jun 2026 09:45:58 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1113283/14e39d-000000@github.com>
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

  Branch: refs/heads/1113283
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
