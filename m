Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647AB324B20
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472781; cv=none; b=eAbN9+p4rV1Z5oYVI2PtFYh1VZlrDoFaXWcw6qy0M4tGQZFBXi4j7WhrbRbeFihn819jsf+nkYHJnsigx2bf5JNBDLhI0WPsX/ICjJH7YWQIL5rDBm5MNX00dzgD+jhTabemTzJMWq5VLL8XXiWwJXapM9qe53DB0TaXq79nPas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472781; c=relaxed/simple;
	bh=T5W3yGkvTQQ+ccJLhsrlBg+XdRMwk6q0FDIjqvVwEDk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NHdVGP+9jBG8lSOF3aep569sHfh3h+A4MTinIQxv4svFvXUSTSKfSymzDmiQwIdFqNy1DYnRsdwp+dHRRLfMevOuFDclVOTgTHfe3cfOp3iDIbLIas/BUyYwYHjIRAIRb19qRbRF5YB7LfISvvrJNo4NRuId2oUhoabKs0OuAPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SeuSrFTq; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SeuSrFTq"
Received: from github.com (hubbernetes-node-0238e88.va3-iad.github.net [10.48.151.32])
	by smtp.github.com (Postfix) with ESMTPA id 936541C0256
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 14:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774472779;
	bh=V0OH1CieUu5Xv/PvpVMcrDKhqvGL+oSxlytT+/Y7uT8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SeuSrFTqjsRLYY7WTY7oUVYjMuDTQe87gV9dscmYBjK2ou3aDfi6RoskwtpvEFASZ
	 Z765qHbs64BjPh0rdTJ8C32ZkAualh1lLtlZcuOf3tIYNExe0QnjCzSSZSXl9AQH43
	 fxZoRBTW4dAuu2LfXKClBW2zPtLY12Fo+q80BKk4=
Date: Wed, 25 Mar 2026 14:06:19 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1056772/054e7e-000000@github.com>
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

  Branch: refs/heads/1056772
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
