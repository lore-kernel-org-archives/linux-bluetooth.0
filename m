Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E092D12F6
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 18:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752260272; cv=none; b=Am7/N1ELWViE7opIXzK7BmAj/6jfVxZXGsvZ0F6+KVHSiO2xKmanGz8kGq6pnBlmYjuF8oYYdL54rB71LEpcrY8SDuyyyIApGTPxbg2XIZyKIl+PKNOGoHg1OnHgK6ozMhWdP6giUeaRrAPRo1oU+8dJBOQYpVzrAj6P3W9YI0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752260272; c=relaxed/simple;
	bh=cd+isbJa0RZQa5NAEaogzxTe0xLrahF1Bu98GoXWR64=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oB0bfX2yld8wRezhLNmUB716pvKH0oQgU1MgsUJT2L5RFm8B92FSgcOKl+8Iahm8SxbBY3LFkn+sOfdRkRiUGCjDIRqYuLhfRa/OwRzZfpBa4+LjWER0AunwgkMYflfF08bg9J8bjw3K643rAQUMl+VAD8TgYqLl/SGZh829bnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BtYLRD8C; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BtYLRD8C"
Received: from github.com (hubbernetes-node-f9b6a34.ash1-iad.github.net [10.56.168.36])
	by smtp.github.com (Postfix) with ESMTPA id B03DC921212
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 11:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752260269;
	bh=Kk9BUYeLrvE7HZlxA3zk08t2bsGuNlGzMsYTO4jBJhY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BtYLRD8CltQ/RrTKIx93p5N6ADY/fGV8YJSbgFuApNW3E8zkWBgnOV8U1gYQ12sG0
	 SHWerm+nnjKbswq984PlpdWc16J8ax9YvtM+jflJEgfmBk2Hzf7fGa3/04NTtABAa4
	 TGq/L5m9U0jFG+gm1FlbS3ORswcZdh1l23eOGgrA=
Date: Fri, 11 Jul 2025 11:57:49 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/977765/189ecb-000000@github.com>
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

  Branch: refs/heads/977765
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
