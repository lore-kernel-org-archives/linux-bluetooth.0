Received: from out-33.smtp.github.com (out-33.smtp.github.com [192.30.252.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560D447799F
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 20:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786481873; cv=none; b=VxmdutpdGNAivw0mq3jCpZWKZGlYblmOs79xmnAVyuefEv4qsfbRrJpPmKNdCtYnAWJclj7Lxbx2JVP+xpgxL+IqsW3sqXtYhK+ipoO37mPpnpytMaOQ5hrD/0DHI+kpGve291J9nlF1TD75YM+ciLx7udd8VmQPJt95vMDAJYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786481873; c=relaxed/simple;
	bh=6kM0QPodagxm6y+4fY08rC9Bct1Svn6iJ4u+SH0cTP4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=R/K5rOhTv6DCnJOyNxxeuoN+5Q6MbRcj7WRem+DaSmr5bGHlr+7KXuJIjRKXjdEo/m14uLA+mZ55eFHpBZPDH4Y95jI3YZMP1BLReiGEqt3TnHuWGHlmlLrMelN5Pn30XcLfEgZzA9q5tlU0p4rGwC8v9t864HZt+i60z+clzEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XO9QFhaP; arc=none smtp.client-ip=192.30.252.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XO9QFhaP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786481871;
	bh=RGcOQQKwwltdpkolvRK3SZFnXyzXCn7Fly7/fuY8iaY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XO9QFhaPgu+lfs+NLwI4kaJ2R9M/vTHqTOwhQjOKvC+mSBR4IGLRoV8LgyCZ8eQfE
	 tHF1hqWMPIxqpZIXc+cfFtRPjZwSk6PD8yuNdE6j6KgtOAhBlS9zQ+r3jhetwRkdVC
	 Wth79t7Db5zSmCAcTRKjhcrQqfH58/YoWqVNsPtM=
Received: from github.com (hubbernetes-node-11f14a3.ac4-iad.github.net [10.52.179.50])
	by smtp.github.com (Postfix) with ESMTPA id 4C4FA741341
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 13:57:51 -0700 (PDT)
Date: Tue, 11 Aug 2026 13:57:51 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1142579/beebaf-000000@github.com>
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

  Branch: refs/heads/1142579
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
