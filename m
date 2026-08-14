Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342C4451992
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786702795; cv=none; b=UZvwflhT6pzVPCF+clI2ictaiQ4yXNNQ+a3tAq6k4IROUhy9gPxgow1+gDl4U8OBsBP2khL4xkDDnoFINJEopf0LixEIx/2OS0ttZ4bFyv4w0T/1OX8EN6SsAklLb8k6vQ9QWp8FlN4hP4q38Fxj5dCUIu3KdsM9PCKHp00JbxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786702795; c=relaxed/simple;
	bh=QXEr9PkdVHaw7hpm+p6qMHFfKmcrDVqfYUIlaGcS1SM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KVQvOpGo8hZnEVdA+9DX+EHhD8e8TASAw+/fkNRbEFDKVBXyKm6igwkk3feO00Lmb48Z++02ifsjSevSvZQ/08SajYjcVJfidvqleDyoMLVOmooeR47w2ZqdLkOkgWBhzdulSCrOBtzupb9zsqTMXGiOK+NmFkDvxxpW8M+up00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kIYgbtbe; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kIYgbtbe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786702780;
	bh=9F+3fvbYzklPDCpkzSqlF96TjLhkUMKoZ26Ildt670w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kIYgbtbexAPMHgv94HUYKTnTE35n4ENgBQgF7c5+Rtuu2ZQeuR26GKCf7AR7+UI7v
	 vHI0pMi5wlRv1V6chI/J+Bg5wzgYYPgT9u79WxhCg4JY1HdwaVk/CP/BdKAGlaxdLm
	 e+HhESqtjC/nBLQBNfVjirg9/DtmR8f76l85T29M=
Received: from github.com (hubbernetes-node-9ca5e60.ash1-iad.github.net [10.56.146.40])
	by smtp.github.com (Postfix) with ESMTPA id D60D3607C5F
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 03:19:40 -0700 (PDT)
Date: Fri, 14 Aug 2026 03:19:40 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1128023/22fc7f-000000@github.com>
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

  Branch: refs/heads/1128023
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
