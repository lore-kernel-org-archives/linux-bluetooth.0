Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191672EC0AE
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776202211; cv=none; b=DhDMgNYgWxApUorqwz5HzuDQcGIMoU4/c6sj0MImMIVp4zh2EWMo8PIkSg+8hAqp+8iB7klftKWn4R3pjO1QSLbQatxOOIXpOR3VDV2pXhLD2Z9M4b7Zss5I3bMGpk2Wjfjl6IseZKk0TYWgu8uzBGXW5e4P9yQqJeuaJjZsbmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776202211; c=relaxed/simple;
	bh=UzvCQ49vIeJbFvRD9TrHQTdCpLAQ00YX2E5FTVGD55M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=l1SUJQkyVZhQtfPvWunF27gJDKdQqsMMrD85GIJrzF/ZMFBb/HDnEoPk9PP7y8NOTChbTsxZn/J4y1A1MQGwwNCMUl9OHXQJevqpcdUzmQWLK/FUfCO0fEVPujdfZsfffdu/8QLfkAVKf+2mpO2DGd6m0jcAFjInfo9Jt5qGn3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PSuICIAu; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PSuICIAu"
Received: from github.com (hubbernetes-node-97b7a47.ac4-iad.github.net [10.52.202.74])
	by smtp.github.com (Postfix) with ESMTPA id 47D992105E
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 14:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776202208;
	bh=LZlbve1I9pA0EH9QGGko6HS60YJPfVyDCg9qj1tjE20=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PSuICIAuwsTMAsF2kV8YV684OKRN5sV7Nv0gGPAppn8fzhZcK+QM0NOKIF6ERFPql
	 JE96dtco2HGfoFoBvax/b8+Kdg+ACcYVB+NQ9Gylo8SCvGEyPJzop9MFhIIxRV55jJ
	 7vc9bJwTuarWq7lE6Xe0ijr33tsSkaqSRCJiHl5M=
Date: Tue, 14 Apr 2026 14:30:08 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1081093/1e4863-000000@github.com>
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

  Branch: refs/heads/1081093
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
