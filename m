Received: from out-42.smtp.github.com (out-42.smtp.github.com [192.30.252.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF12238239D
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065855; cv=none; b=ep7BX2GELCJwS0WjTue8v3ks7/5zjcpDMxYzmnScoMV1hmvcB/ueStHv6M0RxsQPXkIFec2NndZGHkawjlR5ERcagIUnrEnSioMyrn89JSJPoC8zgsTJaS1MXV0kwXlfFObSO/ZXLUXFafwq7bEcPlOdOVoogtUXX//pkg+5gbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065855; c=relaxed/simple;
	bh=NsFDJhEiQztaQnSsvX2UeD4+B8iXTIk2sHj27R6V5ZU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IosTJ+Q6PWENBx5dWBii4XwdawuL/yjrfY/pNH/ML8qzXFeeXUsMeuVG9MSbntDB8AjMkt7+53GoQ2bq8/8wZEBRpwYBrGq5K2ck86R41Sqop8rv7XEzii3q2ysvlHP39GH6LhiFve6T7sGFnk+U0OUWgZBrF3auBCzoaAQKmbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MaadrXib; arc=none smtp.client-ip=192.30.252.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MaadrXib"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789065853;
	bh=UZhBFycPnte1brcUGXjYo3uSW9lCrS6cdRmerm2jaiU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MaadrXibgy16qVZx9pNJ6EMbKAkhEgxgZEGpbFF9Pvm7lIUOzlqCtQ2TTTTnqHUGq
	 IDsVoNQiFwtvxMBB4Ohh/f1CwfTQXPvzCTQuhodfqkSVOMj+88HQkbidhCVhD0VTZ0
	 I5wcii+YScZ3iRISOrgkpeqGV6n8/E8qh94Mve1I=
Received: from github.com (hubbernetes-node-2668a9d.ash1-iad.github.net [10.59.94.37])
	by smtp.github.com (Postfix) with ESMTPA id 5FEA984178C
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:44:13 -0700 (PDT)
Date: Thu, 10 Sep 2026 11:44:13 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1147292/03f0f6-000000@github.com>
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

  Branch: refs/heads/1147292
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
