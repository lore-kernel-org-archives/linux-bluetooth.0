Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66EA2641E3
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765295418; cv=none; b=DSK6RH8TNRZbNHKqZDv5A4iR5E5RhFuymGh2noIk0bpMvWKMGrWJM6IVWTCzlgCfJouiabz+q/Rk8d7jeb3coxtuCDMGjMosWBsB67qG0g9JG7HV0J2Bdf5AdiZFhUMSrxodJ+pu9rhYELkFPAbWRaEXfI0a9aGxXqEiP9cqPkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765295418; c=relaxed/simple;
	bh=uP1A5xglp3RDUMNv5GCFBhJFqEzmQeb0sqU3xBvufA0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TpcndM4pHumhUd19794MRh0LLVLznKFMGIwETaJfO+XY71NpOBvCtu+l0c51lwhv9FM3RV7h+2l2zGxBFFU6yDEZRqZvlYNkuxpRItcZBGZZLa46uyCryyn0IGeC5mzkwO5B2mmQllnP/AANWtK/nLJ/HYnyxhkQaUM1QQfqmuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kgJD/Mav; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kgJD/Mav"
Received: from github.com (hubbernetes-node-6763abf.va3-iad.github.net [10.48.219.82])
	by smtp.github.com (Postfix) with ESMTPA id DE96A4E02A8
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 07:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765295415;
	bh=JM0UeZBl8DJBOTPIyfXk7Z9heLfkYOR6GH3oI/J2/4I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kgJD/MavcCpQ0EEYLHubod1fsuznw0aV277vZVk7k+BJlLBs4SEq2goHcUXd+J4XK
	 ltZ3Q7SkdV2druecRtdfHqST9yk5Hql8b/AEMs5Yo2Q/5ANmHaFYpEXTrCpf2Mmhqo
	 Bn6o7CzKmlaAHed+XuQcjmmzfrFcIzdf0HRRBufk=
Date: Tue, 09 Dec 2025 07:50:15 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1031084/d569e5-000000@github.com>
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

  Branch: refs/heads/1031084
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
