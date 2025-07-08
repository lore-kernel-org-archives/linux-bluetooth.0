Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C8338385
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961408; cv=none; b=Ig2BHrzFGdCSyh4hRkYtR1OkZj35/a8B/RWFo8gFymER4vLySX2Bn31P/T5+tzWuIMFTKZMI8BDvBkJT0GaOlxyA6DpMIXDl5F7DuuI+uu7Sp6ULdYZc09GwUoDo29UjmF6WWlXThTbVn1d4u1GXXNYpD0f31EfgKD0tMZVJJ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961408; c=relaxed/simple;
	bh=raTgdsuo+IzVIx4sbt+SzSRSJ+umlj0pBNSi/9+UBdo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fpP3ahRzAYDzFkNwXXvQO7I5mPe78hADIRYQ2iZg4uo6buzP51TkYrTKVHm0C8n/Ss+k+uo2tjshZFTal9C3jsQtKOH01OOMD9mBWA1PGiO3/2MteCyNWbVskisbRtxyMvHL2Yp8djQtMcvB67gkRyax8r8oooNpOr6pwkw1ILk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GywJvW8y; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GywJvW8y"
Received: from github.com (hubbernetes-node-8422489.ac4-iad.github.net [10.52.169.31])
	by smtp.github.com (Postfix) with ESMTPA id EFE6B7007F9
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 00:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751961406;
	bh=SRHmw8/8U3oDs2vBxFg1BDMy6MKZR1ZA/zDDro8ziY0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GywJvW8ytsbLdZSAaf5L16TTHsnwYDRCkh/RMD0Z1mNaY8ZgEKIXNmLs0uhhw7dA7
	 sQun20SN2QMxL/J+8VPDGSzNqBUePAkr9Yv2QFCCfpu5tFEMVrsBTQxKnlWjkiQx4t
	 6psbyQwtjYzDdKkCECC+zn607P2+/TM+2enIJQB8=
Date: Tue, 08 Jul 2025 00:56:45 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/979696/3e4758-000000@github.com>
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

  Branch: refs/heads/979696
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
