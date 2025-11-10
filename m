Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB482EBBA2
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806145; cv=none; b=duJuCCZHKZtW/Fzqe3+BfYQ2Wp0WeYW6eN/4wfu8SCWY67YH8vFjoBVcS25if8fU8b8fZND2Ig8B1yL+aVnZ4+wuKy/MB4Ty/Kg+kBpkkC/rxq7UNHftMtL9ztjdFlRs+2E7/szry8GyFfBuq1dF7dos0y4NP3oCBHcCPD1IrMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806145; c=relaxed/simple;
	bh=ZeOhu/3+q/mnQvKn5+d0Q9E/E+oGJsz1AuNspaD/vNc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iMd9y3REN+QUZ9TZQ2NfStMv+dovj8qPhkSLMSVtUsVDmOGapEJwWT22hCLwUxGoHBxaWy7ak91MzbENEPPc8pLKsyceJvIspFZqigzjruuNsEpxHXemxKCvCTOmiItDLQCpWHFqOZ90iLdnCjxAxKkQCQRDtkS4dXIPTnbWhf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iUeOPScG; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iUeOPScG"
Received: from github.com (hubbernetes-node-1cf423f.ash1-iad.github.net [10.56.169.38])
	by smtp.github.com (Postfix) with ESMTPA id 92506601240
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 12:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762806143;
	bh=NNvyupP08GUd3JdbuC4Z9PoOkkadbNHMsd/QwQOx/Ko=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iUeOPScGSa2aUCPXyTupopVqnsI6iMX9l1tBXU4dV3YF+T2eEBqLBM9ececTkrXiu
	 3SLpekIOSeePwU1xKMy1UX+EKkmGuAuDdgQ5Skrv8ddLFvAS2A8RLEIKXyiEEXAmAf
	 d8E/wWxgGn8wLg1kRFqWU4HQPhn19FrNzJAn/G8c=
Date: Mon, 10 Nov 2025 12:22:23 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1021286/68b16b-000000@github.com>
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

  Branch: refs/heads/1021286
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
