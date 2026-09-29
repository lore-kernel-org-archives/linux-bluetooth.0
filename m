Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793C44E66AD
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689891; cv=none; b=V7wVtGg85+OFWGqPNF9lFkAiC+lhzFV1yW5pJzgu++53e4ufSLyHyu/4zrq4G02TdIi4Iv8iLDaAPYDUR7CCZKLlcFEi6bTPQ6WRlk3wancYSn8c4xqYY14y6Sn302b4FfFLhLCZNjacJX7b3I0qsexKEz1bKgrCGvOPuqFcRsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689891; c=relaxed/simple;
	bh=V1weiaAvAASo5o6vmT333FdpZv9ApmN83YyWEnnNrWE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=sUKrEoeHWfMXNG5qoMEcdpzrKH9TkPXGqw1W7jWCbCuDcs7QLEbyKFR1PCWSbTMeyWlsHR7Hf3ypp5f2NswnlACsi4DY0jgMSPFvZnk4jYoM6u8zyTr0sMn9xeMX0fWMckneEQGhex+7f6loaOSBjZHGI1FSuU4Kd9XwhZgukvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=X6fmCFH8; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="X6fmCFH8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790689889;
	bh=6sLMQJ9pjd/2jeUQJtSuUCaMzSEfZEsQ2hLpTc1hYGw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=X6fmCFH8OiqcJOKQx3xZBi1D3mhEZ4kweBRmj827R7JUaN0V0vhgZnb+HOUHcYsd5
	 FAVG3zLyqs6xqPAQniRp8YFjE+Cgvt+4FKJ5FJPf9D5hWNmcpjyMhZW306VeaCabGz
	 OvH4UxErkDvL+LMbG4x1Vs2jvkOHZNu3CMcTmgRG80X5n3LeFDOMUv8z/TtFmaqZrf
	 nWXR+wM/HvYsdZ+REtDW09oSR8QpMKBb71JccFYlX8ScaK6YWw42vhgYLUXVxQ0Ask
	 tvwuHHPD80dMqmKTrYoUbEsc+5zH/ADfpbndcLEgy0kXO93rRIvRyT+i1K+222TuEV
	 IXj+FOEV9RQMg==
Received: from github.com (hubbernetes-node-5cb4eb8.va3-iad.github.net [10.48.74.90])
	by smtp.github.com (Postfix) with ESMTPA id 8A564807614
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 06:51:29 -0700 (PDT)
Date: Tue, 29 Sep 2026 06:51:29 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1173703/8edb2c-000000@github.com>
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

  Branch: refs/heads/1173703
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
