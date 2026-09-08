Received: from out-43.smtp.github.com (out-43.smtp.github.com [192.30.252.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BE8559CAC
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788897401; cv=none; b=R+eBWko65Er3od5p30xro59XgDqCggSQwSB3YXK/uBM8EbYnCF4CaQJyZsAOTSZK8SyXn6RzNOaJmjZ4keGiBzLp4U/ZNMwHGvhJBEEdTT1trR0RbP0u1AvuUsLl1zDd58gM+koF9iT6S7BcbIa/A8U5qSz4MPXZ3N5ylBk4nGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788897401; c=relaxed/simple;
	bh=CZJOsuPJkqjot4MgW0X7Gb14pVUWsnzuV+KcHN8tqPE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=U69PScoXclxGIQS1pnpC/Trv9JJ54q5bBb6anj8uQRGWXHnaUyHkDWnIzvWvxo1fbtoBYB0EL2OJLJ4yGWchr7LDZHZbUGfKfUUKje9SdsXeNNh8R/U2W++8Q9KywUc4ROvMgePixEyrH1GzQEKY3JgsnrqeBzvgMQx7SPpH1Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EniOdw6y; arc=none smtp.client-ip=192.30.252.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EniOdw6y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788897399;
	bh=nmBjC5Dfxsg6KkGMLS4QUzZfUU+TwYJwdwnOlJh4GJk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EniOdw6ym6dv+6KP2eNZGKGumcRsGOgq/x017opC+oMZZC2urMkCa89tFqAvC4/LK
	 nkxbN34Qdh8kKkfY1g5BXU9CFNEF5OmEMcny/DOEyyDN2xBjo4JVC+5tgSxTsBE5If
	 NNkEcMWqb2lyjEYeWKJBt6S6bz0ehUiM1ZJRcbFI=
Received: from github.com (hubbernetes-node-dcfdca3.ash1-iad.github.net [10.56.207.103])
	by smtp.github.com (Postfix) with ESMTPA id 20EE7840FAA
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 12:56:39 -0700 (PDT)
Date: Tue, 08 Sep 2026 12:56:39 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1160130/394aa8-000000@github.com>
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

  Branch: refs/heads/1160130
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
