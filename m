Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC3178C91
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198731; cv=none; b=oqcV+veRJWfNeldsfFiuTRxVnW3WQq+P92ymKfj+2aVV1rziAJSI2cv5jBpJ8nLr8QTgbUP5xKg6Edw916jx4Zou9NLBOcCE70/O8MWLS23JxnPbYEd6KvSvjzb1cAX0A0baf85og6sNspZ0cLOBjFIDzmwTfQPUKv0jZF5uUvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198731; c=relaxed/simple;
	bh=DGxpXgQtjBFrGeR5qX1L6PTm4C2RN7LUDcUchE/cSj4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=i0GNHr+8SgsZtEjD1TKPXOPhCjxxURr0FU57DBmh2iwn+lE5vgNz1bnAx35rFVbn3Rv/GSBIDCZrsz5mQQqkSGZdm2fYGIKs9Xf6zmY7zL5kGWc2J2dRLJRZZMg2ytY1H4jnwC82FI6wO00wPb5Z2mQRVnfo12pU2Q/CMwLOynY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fMEo5vv5; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fMEo5vv5"
Received: from github.com (hubbernetes-node-cb5844f.ac4-iad.github.net [10.52.12.64])
	by smtp.github.com (Postfix) with ESMTPA id 9270F700CC6
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 09:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1713198728;
	bh=v+Wn/ZXHnOYQMcKF2JadfXpAqmUMgyDEzem9DDH5ftY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fMEo5vv5aAzBRUZS0ny23iAtJaJNNaoyt4CHyZJUS8H7X5FYc+pR7VxTXL22VtAOI
	 XUiHLZB/KqtQ5VnGUKEd4+c3v7/6Z+SVMilVDI/Q4wULvss4kmXQDMdF28BwfWc+Ds
	 lzM1mW70Wt0LGl5SVg+qSQI/PMJo1hrxxkYiZl5s=
Date: Mon, 15 Apr 2024 09:32:08 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/tags/5.75/000000-79c02c@github.com>
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

  Branch: refs/tags/5.75
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
