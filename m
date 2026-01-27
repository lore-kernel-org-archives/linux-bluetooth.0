Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE26233149
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539255; cv=none; b=bl8eZ4lB3ESwYF9EbtB30Jvi60pdc5OROUR4U6uysdrmW5jejMBOBuxtY+C2lco1y2pVGSBp1E9ergbh5bIBoKLX4jrKWbqCNH4HhYbTL33p/WIYyuHOxuhHOrhQGtbcIiG8PCBC0EkswLzCZihnu7VKPfLDotBJplbUMInn7RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539255; c=relaxed/simple;
	bh=f5Hw5cMVRv7XwHu0UF6n8e+oMMvXj6kmRDxGXmrDa0s=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZvwE+DE/r1U5ASP/Vk5vGIV1IN38s1m1jOA3HKV31X+fRDwCAiD9aiBertkv3pwrnY8Ub+kihbjNb2JiI8w5y7dpTiCn43SfAfIacBBtO5CbNUG+sMHIJUhQ29gcOCAWiQsKGOB6nosvPgLf11Hsah1T5/OgVXF+W4AmW5YjraA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aY+i0UAD; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aY+i0UAD"
Received: from github.com (hubbernetes-node-da265f8.ash1-iad.github.net [10.56.148.25])
	by smtp.github.com (Postfix) with ESMTPA id 88D3A600598
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769539253;
	bh=MG4tv7m5vmbp4fNalUvxyMFRS8GSqAOqC+7z3f8nBiM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aY+i0UADLpJ9AgGiY1B52YQ30ykUkY0v0dLlENfl+s3mg6OJ0AuTu4NQkk2cTUSJh
	 kwi5rLO7JVd0wsQuBjmtw5pbLJ+ekAH7Y3QghTzXqY68x3eUc+inyyWlw8l+lwGMx7
	 J8HxXcl7JkeNoRw8Yk8jWe7ijO0t4sKCmdFKoNEk=
Date: Tue, 27 Jan 2026 10:40:53 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047711/9f3e9c-000000@github.com>
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

  Branch: refs/heads/1047711
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
