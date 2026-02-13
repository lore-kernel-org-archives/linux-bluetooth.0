Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFD4243956
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 20:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771016291; cv=none; b=d4LX5lRkm3/ENpHzFgDw/SJr6xITWbvPAOvgItoNUPTmbcbvhJrbGgYdnGGtZklB8iN0wkXzaiFNS2rekd4jUaT89bhvvr8FrTV/OtbEcd7EC5KeWeJelwI+W6bdrKb9V0YcCKqs+3xU6iQtN7pLNBfF6CvgivaNifFJrSV+cGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771016291; c=relaxed/simple;
	bh=cxaxo/WlpC7CO4//Qu1hnUaK3G0aoJNz93EtcFaKy2w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YE/WHOD30yYz4pelGuxcH1Bwbe/hNK66qDreiNry0wowEbqYr6NQe9tuDxSjuOWVLjqXjRIChm0L1hHbBINz9Joxvip6vvsIlK2+CpAmUmz8MjATb6lvvtT10uJXmvGySeXjS+Jk2WS1JMnVP5zNs1f9ETP11jnanjq8v8h0ycI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HIyx8I8L; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HIyx8I8L"
Received: from github.com (hubbernetes-node-d1b186d.ac4-iad.github.net [10.52.223.57])
	by smtp.github.com (Postfix) with ESMTPA id 92AEE64108F
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 12:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771016289;
	bh=cMIzN0g6IQzZZ12jfItSNXuQkHWOO6pJJGA/TcLUZdA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HIyx8I8LdH57lb6oSwFFSySJOAIIy5d5+ZTYYXUMhGT+43Tl+6chcT0prNa2TvmbI
	 Zl/Zoz5168I26mpd7yDhLqA6yTWBkRKe/cZNhtabZFkpA2ChL658bTQcyW/lcQuhjS
	 uS+dWbTllHrMXrepf1H81Zw9D7/U7kM7DXzq3V7U=
Date: Fri, 13 Feb 2026 12:58:09 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1053686/95e693-000000@github.com>
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

  Branch: refs/heads/1053686
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
