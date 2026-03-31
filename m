Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAC4395240
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941318; cv=none; b=Jt07AdN09Y2cF3iX26mqiC57xzGOFQIC3YiggPn4auTXbMbSXf4X8MCXp3fj4THN9dWfAZtOw73EoRzQrmC0oeOEr07Ecwi9xa4faA9wGrtgz++umM/qSFTcl3pkV5aVhzch5OeI++SEg4QgRdbYGaIAMXDEckW3jFVlYGZV+ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941318; c=relaxed/simple;
	bh=niO5bU3qYoiU4TxLfWR/+zKyu2TmCGVpdhr3D5mLX+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSpS8xY7BK3WjT73t8nSHdvVdiukNpsRw0f8qCfAK/NUtShHIWD5KdxtY1VP9cfrZ2RejqRgVdXc/ZH9uQWOnMmx5fHdod8T2vEhGNS3IeKkVzzLtfgXdnjoN8pw1MJXknaGovkAqjTeGLPRNxZx5seVGLwhetooeM/Wa0TVIKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=YCAV+eVG; arc=none smtp.client-ip=188.68.63.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="YCAV+eVG"
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4flK2H24Wtz41kq;
	Tue, 31 Mar 2026 09:07:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1774940871;
	bh=niO5bU3qYoiU4TxLfWR/+zKyu2TmCGVpdhr3D5mLX+Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YCAV+eVGEW+JHRsMLPDqMqg9Qp+/As5V9oWdIlXBGNy/BeolkJpPBLjqmXpueR+al
	 Ev9b7K7uFV5tIXLTpdLsiHc2QFqgRIvVlJE51whhAYWZSZnwSVNkYW7rarR6etIVYo
	 dyHMsnL0g6ltcN+2VN9usORLSJsZCFl5MxX3p40+b+DKUUQcRrxHB8o4/hDqLwUHWI
	 Pb7E3eczRoR4OahMBTe1e0X6320h99wBUm3O0wOlr2fNhnqVmRm6vue3t2iJ7Ek3ck
	 I1PIalGY96ij9ued91/poYKNQdPVTTNKr9TKrLUzuHO3eexCKxyxMDPbHyq+R3F8OM
	 /x6L09T05h8ww==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4flK2H16DSz41kB;
	Tue, 31 Mar 2026 09:07:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4flK2F4y9Kz8tXL;
	Tue, 31 Mar 2026 09:07:49 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id E16FA635BA;
	Tue, 31 Mar 2026 09:07:48 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <b3a60d9e-b811-42d9-bf05-f400e1302a30@leemhuis.info>
Date: Tue, 31 Mar 2026 09:07:48 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Oops with 6.19.10: RIP: 0010:hci_sock_get_channel+0x5/0x20
To: Paul Menzel <pmenzel@molgen.mpg.de>, Gabor Gombas <gombasgg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev
References: <actZBr+wqcABY5mt@lan>
 <e96776d6-ce8c-4626-984e-474f3606445d@molgen.mpg.de>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <e96776d6-ce8c-4626-984e-474f3606445d@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <177494086919.1835925.14006630632952215677@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: E16FA635BA
X-NC-CID: A2rfKZRQg7n1SSr5ft6mbS/R7NJjfykfjUE+KXkwFdV9onilZ08=

On 3/31/26 08:24, Paul Menzel wrote:
> Am 31.03.26 um 07:17 schrieb Gabor Gombas:
>
> Can you reproduce the issue? If yes, it’d be a great help, if you could
> bisect the issue.

For instructions see:
https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html
or https://docs.kernel.org/admin-guide/bug-bisect.html

Checking if mainline is affected is also important (the first guide
handles that), as that determines how this needs to be handled.

Ciao, Thorsten
