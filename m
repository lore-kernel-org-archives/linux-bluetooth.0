Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F58F22689C
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764686490; cv=none; b=WJ4FucREqrQkGrvR6dsXSkgHC+Gd1RlYRs2/SzXrK3Tx3XbqO/mfDsaS0uyDtkOAjNXcQ/cSEFyGtSsIJmGHsoL6sxiBEje4aR3H83nwEiLdf8piAGNfFuYODJQp4qsyhTbk/mx40JUEDjYcRSAPxnZeuFnunpqOiwfQzk/0WtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764686490; c=relaxed/simple;
	bh=NeC8nNvF7k/W54bNeXGLaOQPGp+Cjg5/lChcUKi63cI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TDRlVXCV7mA7d0zY8TYRMqJbISH6v/RVF4OAtJkQMETyJ4M+wUZviGOVd6ZE0PM4mj2iU3y+EwrPBTdnd7N7TVuXhq2j2hVTyzUO/CowdYSSbl+itOV8RG1MQsoW0HFRZNCJnlYUEmEVOBPIj2XXS8Uq7xkrvARPHiwRzbkh43w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=I80zq2oY; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="I80zq2oY"
Received: from github.com (hubbernetes-node-4cba83f.ash1-iad.github.net [10.56.166.37])
	by smtp.github.com (Postfix) with ESMTPA id 9AF4B92114A
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 06:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764686488;
	bh=kL+dNzbyxMJ3VKvMz5c326jIJ5LxOZFN0LDQL6HB20Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=I80zq2oYcE8mEzwrPGs9+1GSqVEzkV5LE/cl8XrB5NVhIEAzXsxrx9lbsR7zSuoIx
	 j0EGlNJ43ncf6+pkPSbPvfrx0HgF4lH47N4qYvuYBS8bfjZkkYIU7vf+Zi5AUSHgjC
	 mj6ugWSW2eGxxEYfLTbYnuqGwEbwYDTcqxwFW+hM=
Date: Tue, 02 Dec 2025 06:41:28 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1028487/9b4a1c-000000@github.com>
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

  Branch: refs/heads/1028487
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
