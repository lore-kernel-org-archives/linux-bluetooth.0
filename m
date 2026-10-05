Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB76D41686D
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791237463; cv=none; b=kJamXUzbi6wl5HLs42RHcy648r6bx80v5b2UVbWuzxv6EP1DR9EQeE80OWrd0O49V+iC/EfKfW3eqWfdFkF2gWRgey3TeBXifAiVE/gxdfJ00hD2kYy+ibzTY2U7vJEX5B9nknQxHn3lsQlN5sao1Jeh90E+k1330r2Hyy1xSTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791237463; c=relaxed/simple;
	bh=JiFkARKpqL3CoySQ0Oi2nHhdba9gnTcTcOh6DBDPURA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nFAcJlZwjMVw5sV6KaMGz6w+ibcImU+9pLq9jeZ72WUzeupExOpxgsslh0V31NaIBzdIxeMzLQKAVsNpiJsOnFtfzqe6w2XgbnQ9cFePUQ1KhAZUhp3bns0cEAT/hoPYDM5kmyvve5+hoWaQ66SAY5TQztHi7owO+I9IG8HekS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=nKlNLNC8; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="nKlNLNC8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791237461;
	bh=79fVIsKieKuTtqYXYnIu8qujxyikIQ0eDrvqP00VbLU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=nKlNLNC8Gh+/DczaGhwuVq3RrIf3n8ii53XRCTPTqqtz5xomNN3nNtCq0fu8UuDNa
	 zhYuSyMG5dufLGGG6l4UeHR/MK2dInBJXd/MTtmQmJgYxVjMy4ZJwIu8rixe99Y+4H
	 VVO82dGT5zONy3UpY7IXrAueaf90L17VxeutW/1BGU81Nm91U2wboW15sz6X0O0DAY
	 xxRQaC+YUasDEe8m/T6CeiXgsn16rlSi21HrCSsnk4Xm5fwG996ffFIT6D1323xXFL
	 XnHn0tjiLPDvh92hzrc+zV4mIFSjOxUmSq4lXIRafir3WHFztkKZgElu5C7UXby1s+
	 pTeabtRIDSR4w==
Received: from github.com (hubbernetes-node-e3d7e3f.ac4-iad.github.net [10.52.134.22])
	by smtp.github.com (Postfix) with ESMTPA id ED45A7802BC
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 14:57:40 -0700 (PDT)
Date: Mon, 05 Oct 2026 14:57:40 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1177946/a70d67-000000@github.com>
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

  Branch: refs/heads/1177946
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
