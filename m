Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F8A2DC790
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 21:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765573837; cv=none; b=CGMaweu7iAJjmUFVewZJMDnfnmwJK/kIJvKzLi7R5UiGLVQqzvast48nrmB3mjykjDLQySqXuE/tnSHOpsgKNCpa5rpQQEOvIYJpLqmeoakI4kRtsRIhyASkUKjec5Q2V+zMhX8YXXRK/7R+h/7dxXMOZXJyxvvB/k4jrHl/Pi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765573837; c=relaxed/simple;
	bh=5Ph+rbz+wsCdc5KDjI/2NlUNXXs27+tDDiPM9MM37G8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IdHEx6Lv0ER02NRD63GiLDlPsOReUxWIq9IuA06QJ1XGvKza+hAUsEltQLizGNFMKD9UNiKIfgb01p8AHkkpuNgZzhxlFN926M1k0JcpsdqnPv1LDfNzoVnLNN7fQA80X3Um+I45l5rdP2mBrrYg9LoFsz/IlLr5rHoD0pkRJBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=B14D4m91; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="B14D4m91"
Received: from github.com (hubbernetes-node-3fe1596.ash1-iad.github.net [10.56.128.33])
	by smtp.github.com (Postfix) with ESMTPA id A1A2A60091B
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 13:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765573835;
	bh=tq5gK11jNcHj/2P3rIshbDXDD6LETh0NHP+4DfnzDMY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=B14D4m91i6Fi7ctF/jQOHfNYD3ejRpq8+mE7frJN/vb6cKkKRgWYNPqgHhTGYtDhC
	 llMLEw7nEzq4NFjHkUOu3SWD4W8SxpaneEpfmCmNT9ZZb5i5Dz8k5+pJ0m0CMhqnDs
	 7W7fO4j4X/8wvR8h8OvQrfkf4MPfuevgsBMB6MSk=
Date: Fri, 12 Dec 2025 13:10:35 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032437/3ff490-000000@github.com>
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

  Branch: refs/heads/1032437
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
