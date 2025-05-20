Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA0021CFFA
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 21:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747776526; cv=none; b=gJdqz2MWKQykMS2W1B5p20NXYxePeEtquFl/Ngwf3Pz8VA1RDCxsZm2QrOr4qZzFwcmyYEGd+4XAvqp/fWKTKZ7npWnh9snmkUpJeRGGP1Wa/LlTrb9v4JlfBdxp/sk/SXDdr0PxXqXifQlJ9JKFcQSKgukfy9E1jorkL6QecfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747776526; c=relaxed/simple;
	bh=ivHid/e+pILPnfOXraP4zTFpTczek9s90op63rdZYy0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kdyESm/q1iwhM+mEtW7BQzSY5LuPcSD1bEc2xfHFs1vcFpDACfTpDgZqaXYxlY5oWRoys2CoOyE2LiaEgV8D4EoenBO6ACJnKBrBizsDe0DkxTNu6Cc2+JQFFKISXF66SYcwyK9VwJZg0xaRcathLYafg4ggNxeU9K/HkorN12s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DigwZoTs; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DigwZoTs"
Received: from github.com (hubbernetes-node-551cb05.va3-iad.github.net [10.48.220.22])
	by smtp.github.com (Postfix) with ESMTPA id 84F25E066D
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 14:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747776524;
	bh=mtV6DQVQZwhPWtpIX672fprTqENzT440rzReXQI51qo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DigwZoTsfJ6hWN9owiBNkAjpoa3M7TxktKn2I3oGSYxB5SYj66zM1MrrA7jhQM03A
	 xUzHKmC7WIuFSudLvbM9GaKXJEqGr53ij+T0RVpV2ONNu57B5OmopBh6XEvQ3Yc1RF
	 ZdOLhVxfZkJFHYAfNyzgCYik4tQMZvpp9OwdvxB8=
Date: Tue, 20 May 2025 14:28:44 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/964317/c3826f-000000@github.com>
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

  Branch: refs/heads/964317
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
