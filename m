Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE69425A323
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747068890; cv=none; b=QLs2IiIoZNaCFxbm8ETlPrw8WZNK5ghTcYOa399KU1cNHsiNH4JtzDWWdJ/iJUZTE8LNR/+VUkTJjgAHkuPRWxgyF1WdQe0Pz/Uzdo4vH07HM5C5lKj1pJLIsnDZA9ZCL7Agi3xgAySaRlZ1kTcVFFNE0jcEI5HC70Tv7AK5iJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747068890; c=relaxed/simple;
	bh=yiJXJqs+GvobiM5A1U/r9CLyNVeK0S6zCBVJDaNcW10=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OELclFzUs1uTvqO1jauyuAp8V+rZek5Hqp+sNw7wAptVlQmeFYAJEcJGsmzIIrOBaw6Xlzm9uYvEMdx+4CkJ4gUEWfwq2eKkJAQnXqlOapHlRH5+m1DoTUj3L28Nbd+/eOTmjqWjH1KniZMWrjjLLYuCRrPbm385X7Q3gVwaztk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=E5hPkoH6; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="E5hPkoH6"
Received: from github.com (hubbernetes-node-f60636d.va3-iad.github.net [10.48.173.24])
	by smtp.github.com (Postfix) with ESMTPA id EE55F4E03CF
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 09:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747068888;
	bh=2JIuFOJNavhecb340I5sTumVGJDLj7wbVkzcCY2DnD8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=E5hPkoH6ZSJWS63LbqqYTO/Q3DzaJ0clnVDY30y+INZsrqfz65IqTlhFHFGx0Gn3N
	 ZBT9r6aLF5+oq9D5JW+1zYRDF+1muF7fltTcCgbBRevGF+bv596j/QVzTyLHjJLyBC
	 TU+kRDMh+b0ixUuu9SLU2kEmkXx5ScVWVdyDnfYc=
Date: Mon, 12 May 2025 09:54:47 -0700
From: Arun Raghavan <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/5e248d-5a112d@github.com>
Subject: [bluez/bluez] 5a112d: shared/asha: Fix bad parens in a comparison
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 5a112d14e42369e97d3c415a3a08ee62727da8db
      https://github.com/bluez/bluez/commit/5a112d14e42369e97d3c415a3a08ee62727da8db
  Author: Arun Raghavan <arun@asymptotic.io>
  Date:   2025-05-12 (Mon, 12 May 2025)

  Changed paths:
    M src/shared/asha.c

  Log Message:
  -----------
  shared/asha: Fix bad parens in a comparison

The last parameter to the memcmp was incorrectly the result of the
comparison rather than the sizeof()'s value.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
