Received: from out-4.smtp.github.com (out-4.smtp.github.com [192.30.252.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9B354704E
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791318861; cv=none; b=gzbbqRoHTtUdBLTMrR9vnR8gR9b5aVbcVP1AuIwKV1ueiXVFbo5XqP2QoTw276rLVVvneh9BTK3idTvGgwiWx7TkY29dez0lF7xajM1f0HGUwuMJCfSl4UK8Kt45xaVYEH72lU7e53N18AVtjpTq5F0TMSqVmPJprWwJmmGigS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791318861; c=relaxed/simple;
	bh=9wpRoxMGoZbbrn0GmVQSneYBkcIGN+zxzarcgpL6+84=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nNKnXxtyOxeSuZnxRudyCmpSkUFOU74AmNsMAZpdzgbtN98syVkCwe0QaO5HVfTMdLEt06CmHnqcm7kq/CAFwvGaXl8cHQBuE9zHZOTVagSc9yQFGNj9K8H8N8M7PrvHcIg6r9RrJyUYc+t35Up7zjpDuRdrzciM9kIRGpVQYxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=CK+kD1aj; arc=none smtp.client-ip=192.30.252.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="CK+kD1aj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791318859;
	bh=+NcEXLT9BF2EibjCUNVSoRaq9KCaxEqtbF1sPpyueyE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CK+kD1ajHbsNKcSEzlxNvhgQDmnaaiHl2lDdcMHnV1ieu7AgkopzYWcal8PKeIf/9
	 dyEEgNxMzk2ezpLLTYtuc0zEdlD2VyRmUhb45CF2/MezOJxfm23vKdS6oWa4W7jMpl
	 DBnbmdfXk6J5bik6uzZyp96kPL6w+CpPaPJZZVSWQtjJHs9d5UHHEWVZEVhSJb3m6o
	 /FL8lPiWwSDqt7/a8z86IAwdkQQgVt1GFX6VrT/SmvbeAsJS7B9Pz+N6nb6cXCrYEi
	 oCBK7ThfGm2Btu0Ltl6xNltSFryHEmrEEYLWMf9g1WwZIH4UOSoOxRcoAnkbfNwr+F
	 uR7mKv58azZ1w==
Received: from github.com (hubbernetes-node-709e1fc.va3-iad.github.net [10.48.86.34])
	by smtp.github.com (Postfix) with ESMTPA id 286E7340A2C
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 13:34:19 -0700 (PDT)
Date: Tue, 06 Oct 2026 13:34:19 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1179727/9c0205-000000@github.com>
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

  Branch: refs/heads/1179727
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
