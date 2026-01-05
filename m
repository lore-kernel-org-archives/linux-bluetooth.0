Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ED132E12D
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610753; cv=none; b=fgcxfRKMti8JJMczyjY9toCVE+3pupY3NkWpdLyiF/hl1HXMghRWBrayjsrPtxnFSDkip8atBrF4b88XZc4hTfRpNf3lJTyTdGrDkFZJU5yaZecwH0hQueEc3m+lAj4abHiYANXgxp8RdkAeYZY0a0XjsIXfcyWpY4OmR5nHSS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610753; c=relaxed/simple;
	bh=NWSDcZ7wnuENPKWwmkyCpZTqnhRmQQKakYmA37dTfUE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=u3HNLHFcn8bPQAVKj/NlVZ/a2Np49zLXgmtH3bakryzbDKVx1bYYX9iJVPnbB1JX/vvuzLjEXU5iZ11baYETKZZdHIn2E8tMN6o3tmUVjxZ0muntshXe4EQ+k3S/mRXfPd68KvSguh10BD7DaZQIeav1dN0pHOW+Vp7YNuwKg8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=E1KjqnEp; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="E1KjqnEp"
Received: from github.com (hubbernetes-node-fb0401b.ac4-iad.github.net [10.52.220.68])
	by smtp.github.com (Postfix) with ESMTPA id 05CA521266
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 02:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767610751;
	bh=d6neKjT9mgh3BZEBbixyN5Dk2xX6qkfVoSsCqbDxKOk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=E1KjqnEp+Fv4ioZF4GVG3tQb1759bWZzXgqWqVy05Q4rmZZhH4HZMheF+nXiZ+dhi
	 fUUaklFkKd6P/1GN5pIcQQbMyeesqNrakVB8L6HjZrOsOtaaVh/t4EtuMn99csPOC9
	 0wX+Q2H0sYnriqhm6Qg741EugZEOmNhO8ZxeFHQY=
Date: Mon, 05 Jan 2026 02:59:11 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1031333/c8dc51-000000@github.com>
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

  Branch: refs/heads/1031333
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
