Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A39F3264E0
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789913131; cv=none; b=oINOtjNzTlHP6ZG06lybaXQt1fg3+gTsVRksOOKyK4ul0/IijizVAaHEbul+iRoevn7Yv6o4lPKWJnlLuP3jmXRzp0S5Vppoy4mTpfrV/JuQON0gqf5PkR6tgbaP8RjGh7XQFlU1KCj3XePLa7K805MlxFf5Coi4d2siZ00NnLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789913131; c=relaxed/simple;
	bh=zjg1hReu+trRiKvyNrfFZ2mcrrV/3TddkV0a04oxZtM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DZ7nM1GAWDeb1ZAliTUXwZ/ltdXXOsex1B2/vaQMJGbPenTU0n7CoQuM+SWdmmEaTnmnTi95hZalY08Woh2d/Wikw9A5I9effsTfuKw+Ua5l2M7/fBb0bF72fHOnlBNUil5YczVGPoc9ChVeUoYydhKHkFOwNTFHUwMsXW0XkLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gQ5bqRMr; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gQ5bqRMr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789913129;
	bh=XvRjnqxSYvd0EvlxGVA0qmaqiy8t4tMSv1oojSY01co=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gQ5bqRMr1pkTxZjXc0kISode0fhCbwmB179OOXuljk/7FST1Nyx1H4ATw/A1O6AVh
	 QFqiSwVT2r2wTjSE4cK1/KkTgZ4BPY+qHahBFHJMdEn51Vtp3bRnp+4zIEpbCXfI15
	 GAdpGbcyx+M9r95YBkVqgnb5MqJFckc8OHfBo5Vo=
Received: from github.com (hubbernetes-node-5a59d0f.ash1-iad.github.net [10.56.201.81])
	by smtp.github.com (Postfix) with ESMTPA id 1618960025C
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 07:05:29 -0700 (PDT)
Date: Sun, 20 Sep 2026 07:05:29 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1149710/e76177-000000@github.com>
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

  Branch: refs/heads/1149710
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
