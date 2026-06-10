Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13935477E
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110213; cv=none; b=ffLdXFautRGThm90Er3oWDAZden1117RI1myII68wDaNYYUlqWqYI+7kfOLNq7aLKUkmsymlJ6ep8nEQmtbip8GG1pHXTRxlDuqPkN69pd3ynCg2s8BIPE1ItMKBAWvw1m2m/9Dz/nGF563XTtIUaR5lIooqDrb8HtJEQSIcJ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110213; c=relaxed/simple;
	bh=72yqfHJS6KKtSuQbhj5QbhYzf0JBCGLAudA5qHiuypQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cAoRsimhq+wrorfoiKXSE+WsA6YftpMam9vmu5gRnnexsv+Fgf7+uSlcVgvv63qBVBYNuqCz4DG7il0FWi1p5aRIAdaXTf9dKZXlof1L4ayW+j9ExVJSVNz5MJbaKiHEjm94nj7ehMal/nzAt4OSnVbTuNjUAASu5mSg5SQcR8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=G1Tg48yX; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="G1Tg48yX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781110210;
	bh=bEPL2IE/vxmdJHzGC7LCJIoM3UR4HaKyLYSGZPGAyRE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=G1Tg48yXtciEUhTn04xGeoJ61Xj5fXVOaMm/gccsuqFEV5Nchjbe2WDzpK3uk6Hw2
	 WTdVvtnmPGDVQTr1zdh+LIMs3iVyuIZeQXOtniK8paMlitRzn5EjgbXbT2ETOk5gBi
	 DDpEwNP/rB8HQ6/7FICeN8egRkVCCcH521RYcYVA=
Received: from github.com (hubbernetes-node-a8826d9.ash1-iad.github.net [10.56.172.30])
	by smtp.github.com (Postfix) with ESMTPA id E28F4521236
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 09:50:10 -0700 (PDT)
Date: Wed, 10 Jun 2026 09:50:10 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1092801/af87aa-000000@github.com>
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

  Branch: refs/heads/1092801
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
