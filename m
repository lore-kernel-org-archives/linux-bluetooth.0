Received: from o5.sgmail.github.com (o5.sgmail.github.com [192.254.113.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112C83998A4
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.113.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246428; cv=none; b=lBfWwHpXkw+v+ZOS57x/GUmoNJHWxaZNlSkfiODgMWNFl5/q2069y6V8OzB9UOJF4KurRgTMRfkbAzd8hsMzSaJ9qB+ZkUJrtmZPIJMOFKr1LJWeoPddYgOd2oUWs5SCaCBpOwjCyUUaxkVObVo848EKZkOGqc7WTuOPMJGAyB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246428; c=relaxed/simple;
	bh=AwJnvbo2VC8xkXRVpQbOstTo+X9PQPzVCVCgJ35DCts=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=GYKKLNA/BWJp7OlzJlfQMimajQuPHaHRZVlUg45Le37zmzqQ/+mS6GMUm0JXjNMnAwsBvnAM3kBlTxPwuGrTtS27sLSX4l1GAF/9zUZCyGxZluDwoIlo6eZcWH570KR3DZifRGU66vmexYv7AwzqFrNvLq+0iHEe9wCyDBpIhF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LsitDzhv; arc=none smtp.client-ip=192.254.113.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LsitDzhv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; t=1782246425;
	bh=Axs3clzI+2RyvsmVHuNQ9xWWtlaVJH5nFXxT2Ww0AYU=;
	b=LsitDzhvnzrZS+AxkAUez4Mpcf5VLUvqP3HniLisr8M29CNBSXPcZ1/it/cto/Pcx7w/
	lvCibFq5U2CmzST8ej6zbIl2on0Pe/TDSwI5ZfFkHzuwZyk1QBgjRezr6q7QS/+GQhMF6v
	ch0vctwE/W/uJUOUrWDCvX9s0xF0J1cFQ=
Received: by recvd-55495ccb64-gfh9q with SMTP id recvd-55495ccb64-gfh9q-1-6A3AEC19-76
	2026-06-23 20:27:05.89750394 +0000 UTC m=+77470.732199449
Received: from out-18.smtp.github.com (unknown)
	by geopod-ismtpd-48 (SG)
	with ESMTP id WkgI5I6JQems4uYdvIIiPg
	for <linux-bluetooth@vger.kernel.org>;
	Tue, 23 Jun 2026 20:27:05.879 +0000 (UTC)
Received: from github.com (hubbernetes-node-c4406e6.va3-iad.github.net [10.51.95.37])
	by smtp.github.com (Postfix) with ESMTPA id 9130C181233
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 13:27:03 -0700 (PDT)
Date: Tue, 23 Jun 2026 20:27:05 +0000 (UTC)
From: BluezTestBot <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/1114843/4ec0b2-000000@github.com>
Subject: [bluez/bluez]
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: 
 =?us-ascii?Q?u001=2EyVDaIUJfOTIVaBYkJvNzXFDwUvSfXABmYIMG7o2yQ0XjHiQN8HeKlKfUQ?=
 =?us-ascii?Q?+TD5y9uUDiSc3WCQ=2FbFOxbFL1vD40BVhhuMf5U9?=
 =?us-ascii?Q?bfrrrzotXuMdXUincRroFCKB2PB0uZsRuGX8w0f?=
 =?us-ascii?Q?osm2mqQDCtL4t4boyy40Z4=2FTsTAZKczk=2FYuv7Mk?=
 =?us-ascii?Q?tW33uT5yoLOMoHIv7+2O6jXr2tJW7wpCfzTeh2B?=
 =?us-ascii?Q?3S4J7SL2zUVGDvP6L5pkDnNmZz3GheGB8DSDNoQ?= =?us-ascii?Q?dpEx?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/1114843
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
