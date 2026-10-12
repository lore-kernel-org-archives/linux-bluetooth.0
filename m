Received: from out-43.smtp.github.com (out-43.smtp.github.com [192.30.252.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3034D361DA7
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 23:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849117; cv=none; b=i/49JoAsnvYHNyZJ4J+fQjbNPD9Q4KtKlXzHH7tWCnGkovy6x0Z7I5VwsPCMRrttN7ecqNnRrHn2d28xWQeuHdA9wkyHr+C0/uPOA4LJwsVSg/bYROBC+UGC0AKSPWWCceTBs9XnQ86UM1On+nW1OPC9AzErNoK7RGWvXskdkbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849117; c=relaxed/simple;
	bh=PXZGWMfcNwo8kyaohuT1V1vmD7edIRGjhwGIa//CpSk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MtWhFz9jP9Kdkwcr4aIWDFw0HkvUe17wHPDnAB9hDGsvzOcpv78XOjvb1iyS6dXbRrouOpa4QakxhwAWEZtkQ8DXDDvt67UrkSeZa4H/IDAG05lDrmtxsYK490S1Jd6EiCM3zwShO99YBrsOXCZmXleONmoWrTwqziXaZUdut50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=FvaCV/nx; arc=none smtp.client-ip=192.30.252.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="FvaCV/nx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791849115;
	bh=C9F2jIuRM+a8qTjGiLOvEN050do+Ymzcw6chPE5KBdY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FvaCV/nxev4HtuWPoOptTy5jOAdX3zs5Lmkm+rm8cqTn2gPRAFJHFUHhJut40/zXb
	 cY1zwGYZZUmdsvyDAcdj5hNQkTgIH+tgiGHMNrH9VWPaIazi6ZUNoOFIdiXTraK/Of
	 DnErXmf5UDmsL/UgtJRazPRbUCVArDxg/+KHiCLPHGsMLTb6DqbMR0CnpEp1edq0tt
	 /f/HZoVEUOFrxsXyXX4yrm0uuRY7dWptSyQa3A7/xwkuPb2hJ13Aq71Wnx3cpN4kuw
	 0By/w8J3vFCnmjc92FjeyDjHskhpbgXHKxgP0GJEdMNGZ/8XECdo46FPqIp7SjAxUX
	 D08ETKk7KbhaA==
Received: from github.com (hubbernetes-node-2aa0f23.ash1-iad.github.net [10.56.85.27])
	by smtp.github.com (Postfix) with ESMTPA id 60CB1840986
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 16:51:55 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:51:55 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1182837/73dc1c-000000@github.com>
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

  Branch: refs/heads/1182837
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
