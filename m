Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098341B21AD
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Jun 2025 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748850149; cv=none; b=BP+BUgJ2Uv7bxgGLBmkZvnTfCjr6ez2UplZJh1CdCyMV65aEHf0rYvmz6GXxHPiwH9y8ysyxUNRc2Ncmpn5fTDav2brkj2TsgW5RHnn0WVGkH3JWpp2nzztTaTkgFchDVrBB5ErOS6qCrWPb5nGUJ+JnoxxnNUkWF5Z8ZVEfKPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748850149; c=relaxed/simple;
	bh=vF9R3zXdiRaEBU5ZhqxzGv0fpenJ9286o15z3wLR0Oo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=K/iML+EYXKvxdp19kIenBP5DawgLoCfaKzTsJUanpOXriY5Rz67aXzCyrOHAtG1BtTbI9OUPi1rJEx9NFLvnnMNZ935keUyZlv1oakfM6MMoD2GbN/IigEfjvC7wVYxLWIJmteA55U4skzRsMrdmqBq5wF9IihU6Y5aMAu++r+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Jg41tBga; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Jg41tBga"
Received: from github.com (hubbernetes-node-769ff3e.va3-iad.github.net [10.48.158.14])
	by smtp.github.com (Postfix) with ESMTPA id 1A2838C11B3
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Jun 2025 00:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748850147;
	bh=bJGBi/ysUGQxAWh66yc1NYr0ISeGYeIgNmzd+n3r1v8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Jg41tBgaHi3xnkgoTrjGcTILGWcl0YudBHNsio4oWpJgsE72m5BUe8XZSWg5Ggf2F
	 9/AHpBhiBb4lOIVLISjZ8PKelnl2vgnysNpHkSis9+MVwJ7mygEc14qicsEWAOJP6d
	 OmLj2nV6BfLPhfyA4MSphIv+/ZzHLZI+GkOkcHsc=
Date: Mon, 02 Jun 2025 00:42:27 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/tags/5.83/000000-bd7045@github.com>
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

  Branch: refs/tags/5.83
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
