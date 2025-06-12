Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A63273D7B
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740542; cv=none; b=h9XhGbFVD4VZ7fwqOrR+ijYasGOkrvTzNOvhlLY2H+RGZCOG4xG38Lw95Pf3NTVpTdFWKhNgSkbRgLqqwdGufkWJLXWL6WO9JkZtIlfQo28qsukS55efFI3BQ8vqxpyiixGlcxgfw4cxenO9AbHjPYf1J6dcyCmjsMOYzWCNqUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740542; c=relaxed/simple;
	bh=oeMhbpjD/fRqqzRF1Ar4yHC8HWGrG4TFer2jbCBaHoE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ph7tjEao9mc+MYm0jFK31zk8iDia6NKxYiDPHXDqsPnPi/wv++1G+lWzNqNgEZDc2UBklpl9XEVjkPfpsR8/eweJz/b/Ie4YWemWuD0ARFcse/L9TiLPPPNu1aoIzAkcM3e8tQCbTBfmRDWJNEtdb7eXnCSJIopRsUlbKYeHcfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZSEA7NMa; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZSEA7NMa"
Received: from github.com (hubbernetes-node-0757ced.ac4-iad.github.net [10.52.164.24])
	by smtp.github.com (Postfix) with ESMTPA id 8A62D213EC
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 08:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749740537;
	bh=T28WtAQHSLgV3bAoRC7hnXuqfpSQp1VNY8I6ukDo8q4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZSEA7NMa8ovZjPbZC7VgybX9VAKyYd580PrWKiR63gmhdX9AGUonA9yagwnGTpZJu
	 SoSodXaEe+HLhHKkZn35c5DNtRLQlUEigpRTc5CQILywkq9YsYO4sDXzNyWr+8epAq
	 LFx+NgJC7YLLwlW0pC7tPadvdmd554SHsseSlz0s=
Date: Thu, 12 Jun 2025 08:02:17 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/971158/5d59e0-000000@github.com>
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

  Branch: refs/heads/971158
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
