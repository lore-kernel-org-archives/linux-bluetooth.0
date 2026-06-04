Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DEC368D74
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601655; cv=none; b=RFY7ic5Pk0g96kBUnJBy/VNEGJ6bAt+snJ+5ag6zzsM7XOmXDOsnHCqGhDk8pWElw18U6Jd6Q5rOMNz83cKXoe9anZKM/whKUBBTkZkByeY0zEJjHymNv6wZwKSFQhLQJMQ1w6HU6ZjZJX5ymhKwMlSR2yjWGPgN/cDu9QrGTeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601655; c=relaxed/simple;
	bh=6i01xGe7BdIWBR+QvEBNj2MFL5GA0ZlqJdKWzpku2O4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=i6zKMNlvsJZaPV+27H3WI3e63Uo0FkXjUQjSKBMuimmYldsnw/txg7sOJhTsSW+80DHuz31O3lBqIP7JA9vhXSWZKBM4nFnfNXu6mTMdYBmHX6zsXxK9mcff9r0fIQaEhDOtKOlt7HTAcsw7uoveEjRs+8+tS8qWwlzVj/oXt9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Zv8KoiR1; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Zv8KoiR1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780601653;
	bh=1AMQZH7kr4dSWhltKLQuW6c0Smwhgqupp0Vdz0hvuWA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Zv8KoiR1jpNbb2ORNbb9bQ6fXprdVxuRcgfPUbNNAtonnIJQuo1mf492pl/qnSLvL
	 BNfOVmDIE5FokfjFLVH9Q2CQlYHKHhaCdsXqp7bQ5XauXX8pgDGk3r6bg/+cRYjSep
	 w8eCIZ/vPV4IyZ2Csx53C4vPCI64YrYuliE0Cd4g=
Received: from github.com (hubbernetes-node-e354f21.ash1-iad.github.net [10.56.182.40])
	by smtp.github.com (Postfix) with ESMTPA id 6A9A63667AE
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 12:34:13 -0700 (PDT)
Date: Thu, 04 Jun 2026 12:34:13 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1105837/f47761-000000@github.com>
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

  Branch: refs/heads/1105837
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
