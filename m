Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C3328B64
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840144; cv=none; b=ViczERvhylI1fioR473CFuyIWUr0IS+peMR3yyAObMora3U6boR0EXyT6HJlZjfrrfBruh98SBqBPbA6/HD7aoqLadMXciQYYwWsHDs7vhUyQhbsHVqVox1CKcgy4tSg7c7IJLrbI7MDMBhPQq0vbcWuBEuLR8DVFhLE9b5cXtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840144; c=relaxed/simple;
	bh=oO+QbLqnUUi0cyU/VmbpaJZxTuZEqCWumhO4E5/mQmY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JDrOpKls4/BAl1ffT41jzgSkUHyQkU3FoshBD3Z9H+rylnqYUZ54rJDr12u6jC/FpESQLwYNctxgUAwC6IMNolVfZKKLrF20OBXMvJRRGiE3sWbAml776buXe4oJ2FdByxCk+jtlZvad5Vf502gYa4FjK/PpeL6fUa+5e6l3shU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=f8WOggTB; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="f8WOggTB"
Received: from github.com (hubbernetes-node-e660a62.ac4-iad.github.net [10.52.168.35])
	by smtp.github.com (Postfix) with ESMTPA id 6602F200CA
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 08:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768840142;
	bh=tXLD5cAGYoT5SKFo/I06L+kczaVf19YwI/+nDrGCXv4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=f8WOggTB+Hqs1LbYSKMoL0QQDAFRcsXo+CfOA43XWbTotQgJ7NqjewGPox/YTkEwj
	 ZAItGpm91zi61ao9sMULZKP/hWvuG21OoqQGL1HenB7sbAnlr3tECM/huzz8SJScBe
	 qwrrmhpPexChyUHa4nEJxsWiK/jim2hRBuX6EEuE=
Date: Mon, 19 Jan 2026 08:29:02 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1043515/5577b3-000000@github.com>
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

  Branch: refs/heads/1043515
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
