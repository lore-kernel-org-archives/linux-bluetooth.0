Received: from out-30.smtp.github.com (out-30.smtp.github.com [192.30.252.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B68547F2E9
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709376; cv=none; b=PdvPuMBemcZVmzBsqNKL5va79rUMl6JV+KjyqJ1Aye0c5BiXIbcw6Gy6fnf/I7/Gjp1no19WIIsOfs+bODBqYCYM4akvK+GFkoC+CZBd9i9/a0o3FdvTGLHjbcGpOLN+P8aWq6sJKV/rsY8u5dZ5kpbfzGK5AKtLxTuVw6S/1o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709376; c=relaxed/simple;
	bh=pk/Jq1Tj/7qCOpz/nAxBBhYzfUMvws/ZCpbbPbpbH3g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=g6GqK/tLCKRtHPVz8OPVV7HblqCgDi17/xiysY+hSSxIeWKNxtXWnSGU5DtyShJ8wCM04xgqa8j0nMtGLXuiQeAYXV8diYsrR0P6iRHXEn5fNZjxKdvLOQF0r9qgUSqcC6Pr1ar2mo6sL+iwDI1WcAbD9z6MwiJZq/zrhkyhdCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WFAcunpN; arc=none smtp.client-ip=192.30.252.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WFAcunpN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781709373;
	bh=wty6EmOomSPWziMxLi3e1Oxqu+L7t5syemGJdlO82ug=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WFAcunpNyjT7Tz5x0zYCyZge7jxCaGxlbUpdJP57a42I0LGNC25BLl/svhx3tn5SY
	 JvqqqMJ0mpNiL0OgkwNqnVHygGbONWUjyVZNqa22CbP7WGnxRl1MAhKzeNowr6ur0+
	 S0ArP+Gu/eQsI8EfxknxMoZ7BcTGYJD/qNGJfmwI=
Received: from github.com (hubbernetes-node-bc18804.ac4-iad.github.net [10.55.89.13])
	by smtp.github.com (Postfix) with ESMTPA id 2B01D3232EA
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 08:16:13 -0700 (PDT)
Date: Wed, 17 Jun 2026 08:16:13 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1112111/d8e60b-000000@github.com>
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

  Branch: refs/heads/1112111
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
