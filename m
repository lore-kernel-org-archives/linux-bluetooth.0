Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EC433D4E9
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065863; cv=none; b=ixahznTc9c6o5yWqkHGyr74VyDFZmcj5pTt/WwANRQ+heMVtLE0/gM17SOEtbrBvLnBuXnrikUZ4QV4/n9q1KSgX9hhYWcRpSfRPraFOvtApnBSSOHVP91SUF5qWTvStfmRED8Q1lfhUBRsekP4gpPF9cTtS6hXvQfnwd3bWkO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065863; c=relaxed/simple;
	bh=kG8eQjaDVeAcKi2MYGL0ngG1Jp0ss/aZFJdCJqYuNt4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aRa2zkQuggYC1ofXUiMGTOOp7Bqw+H2G5glXeM0bV5ACJzNVghKUAeaJFngZT0vm6K+uhga3nbypw9Bl5VxacF78L+G4xwq8JAPknUsL6KvVLRa606C6qCvoGG79ekKDsOD7aL+ZmVLBuPIEC2Cj74t/TMYH3sZa01JRaE8CyCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QJOaMcVC; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QJOaMcVC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789065861;
	bh=ad3KmU2IHYj2gSeDGyxmU1oE5fFn4lP70DPI1ulW4Ns=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QJOaMcVCmwRBPiKnzZ4J7B6AYo8i8ipd0Hc02TkC46ju2MlJCnrFr/sS7EUK+cd2L
	 OnNzBfpVEy3Cx6ydGhyJOxXUGGrRqtyjC8o7Ti3zPmqynlUmrIlnrVfmaHLZD7OUkK
	 RneeJOchtZ688tOBVItC3r5Qgcy8R+PuCO1/3GKk=
Received: from github.com (hubbernetes-node-08ee7cf.ash1-iad.github.net [10.56.209.53])
	by smtp.github.com (Postfix) with ESMTPA id 1C851520C49
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:44:21 -0700 (PDT)
Date: Thu, 10 Sep 2026 11:44:21 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1146334/b0c2f7-000000@github.com>
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

  Branch: refs/heads/1146334
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
