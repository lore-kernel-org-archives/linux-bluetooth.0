Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B37A2C08D7
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763407101; cv=none; b=Jyh8mzn/ZGrfY27XywIVwogbrenZh15dx3iQV2CDt6r7vNOTNLIQ7Hpz0iXgOi3/d5Pkf1okLqOQsrcA3smFGY/614CLsrU4nWfAOV+y8gFFEjp8L67rnsbMy5OPCCDQYmwI/itXnzhKuOpAFav4Fnvfaicohnzy1niUh5Cn0KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763407101; c=relaxed/simple;
	bh=m0Ye5/AV9y7HDI23nH+oxSMpiFerIYy+I8znNfS2B+E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=g68ePxQkra5jTW3TazmE2egHdrT/514dHXZYU+w0ZE5K15QFhJDgXEhoinWIWMd2+bBuil7q7JEQSi7NyaDv2HU1ImG+CU1evyiKjatdcLxNh5RA2cbfLo3ESf67/sWE/FfBz8nl1W3hZ9AtDJu8A1ZXnE6Vo6WfK2rdgTjA6/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BTmNUquX; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BTmNUquX"
Received: from github.com (hubbernetes-node-3a0e537.ash1-iad.github.net [10.56.212.106])
	by smtp.github.com (Postfix) with ESMTPA id 26859140B89
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 11:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763407099;
	bh=ydevimgv9sszjmmSj6AsWbcZAiatkeZoCVo8H+Dt45M=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BTmNUquX0LZmBET4DM8MOHkHje+++jPDeSkJ92jp80F4Ba0mNc6WaJrWD47XYNHjA
	 8rAwBEno8hCIWVc1hGm/ttwUKLkAQRSscjf9Gs2AGsn7TSxB+LoQqNAUe6mGIgsf0l
	 MGgV1IGUn4Gq1YSyaQLaPOJUwGphLq7mmpJJXE/c=
Date: Mon, 17 Nov 2025 11:18:19 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1023839/64a912-000000@github.com>
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

  Branch: refs/heads/1023839
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
