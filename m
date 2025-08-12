Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E093C2E3B08
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 02:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754966505; cv=none; b=PSq9aJcX58Y9HwQ0pbcWH/H46u1WNiFZx4DS08UI3z5e1qjMQtnw18QdB34ZY0aVCpGXZeVAkD2/VClbd3WJy/guEDjf2b/Nms5ofRc331Ud+rFAYMA9s4w5cpSc8EvtVQaWkZt1Ifj9kswnIcKBp/j9EuoGVvl83QSlfU+5Q6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754966505; c=relaxed/simple;
	bh=veUtu5MjmNVrtaxFMkFSSqmXRgrnm/MyfcGmozfSAnU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=stCu03r9YxvdP050Zhy1q+q6b1LHv6FAK40hDnUUzcRbpGb9wxVqNRRwrRC+ztv6/GDqkFeSAUPGDhgjYkSbGIeoKOOj/Nlyo2ih+rnrtST9lDvSyRkU6FdpWQiMc9iiSVc5KR3PliEcCZ9e5k/Mdqr6fzPPD3kqCJMi5k1ozaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GeNL8/tG; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GeNL8/tG"
Received: from github.com (hubbernetes-node-6ff39f0.ac4-iad.github.net [10.52.14.19])
	by smtp.github.com (Postfix) with ESMTPA id E3D23700931
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 19:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754966502;
	bh=se9JJhhXdPVEVa2pDElwS+StbcXwdegigHC9jWB3DcI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GeNL8/tGLOfk+1ADKleoHje2I7Y6TqXFKJy06+ZcZ+ridTIGYjTXJAPjxkA2rk3Z0
	 CbJFA27vnaz4w1e+Nzffcyw+Wq4qElBVuPwzwd045q7E5lieW9h0+KBUm7T/OEKCqU
	 NeELJuhz4p66DcF2hbOC/YoP6oNYgQVe45rQq5sM=
Date: Mon, 11 Aug 2025 19:41:42 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/990189/020772-000000@github.com>
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

  Branch: refs/heads/990189
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
