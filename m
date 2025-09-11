Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A83631D722
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606442; cv=none; b=jfAft8AQnqbKmAo2m7mobVNKtPJawkQ3bluYpaS91Q0ZxfebQkavTle5ve6233zMeViUPaVBRWepdFGrDelFzsWwvJFVMyJNcazmZmqVn5l61J8Zv/nJ/5KPegITClYCyQI973VNDaFRM00kCnuFzsNN8WGo9Tust7Wl1PIXXDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606442; c=relaxed/simple;
	bh=Eu+zW0o1s/H7siz3H3e/SUWSs8vpqo1H/jZ56YcKLBI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=h9Qbz1m+ts8egBImOD23pQNQZLf2/PiWzT+hXvDHUrbegaiFIeJHvbDakSvsDDX8OKYdLdpr5fYkSECFoM0hCayfj5BjZP+IXN5cVQoJ7ARE6s09El4fe00I5h/7oyZW95Q5lFy8YAfDfzWsbIXxgubJP5Zl6Pd9chgp3ClG6Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ezo8OYu8; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ezo8OYu8"
Received: from github.com (hubbernetes-node-db85e9a.ash1-iad.github.net [10.56.144.42])
	by smtp.github.com (Postfix) with ESMTPA id 3B23E92138D
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757606440;
	bh=LtezYZbR1yVMdtyhWWS/HNR3/zDQs1SFQxT3dc3II7E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ezo8OYu8xRXQjq8IPhSsi/mD+AUNzcmjr/SOtyvrZ3i1BbtgQdvhM9lkRHKv43y1W
	 U/gsRtyEHMBy8h4NqUgAZaDbys/gcwsJUZBCthSQBkRXkLmonY4tqeojV7BitWZr5b
	 PeXJfhfrQbQkpK3w/EfgMmk6V+IRSQinmd/Co3+Q=
Date: Thu, 11 Sep 2025 09:00:40 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1001368/f426c8-000000@github.com>
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

  Branch: refs/heads/1001368
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
