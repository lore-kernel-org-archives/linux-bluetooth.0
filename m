Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B00C2EAD1C
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 20:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806144; cv=none; b=o6bppHkTk+/SmaRPIPKunqxRrs1dDgLpbuuIexaOUuM2xPHzZUYUthMncbzD9movFBeFOnmLXFkfRAPJtHpbCq6sv6ZBU9Yd0riIKH+CvU+NVHVLGqU0IwRAo/0smSnlIqBSxIORp7cQurNaNwv5lTr7DtuYX2Zl+WrdVSKyp5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806144; c=relaxed/simple;
	bh=glrhp9xCgsVxMVwhrOD4/aajZhluPt15Ho/lR1JjbeU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dSOKyLrUgWKiO3HPj3APiP5UkbObOW1LkVqKn+bo3DRo9LasA8POf5tYDsv0uZQFRZL1kMNHb1aiTOYY50JSzm7W8kmmTXRynzNfDMYsI2WjL+dtacS9Gw2ih4FErontQSst3rDydw1mBQjMg54uvYBCuxfDpycKIA87X+1J2cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eeeq90C0; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eeeq90C0"
Received: from github.com (hubbernetes-node-215b32e.va3-iad.github.net [10.48.220.28])
	by smtp.github.com (Postfix) with ESMTPA id 0F2814E1146
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 12:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762806142;
	bh=Ya9xWUhlVDCQGDr54p0ON4PQh8y1t1evd+n/ho0LKUM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eeeq90C0V591mrW7ESU77n6wqos3DIobqtylo1bagL49MpFD47f37R/xTL2LIOrYP
	 75QmKxgPEE/jQ3wT5yMG0eKPPDYrTKdfay8XFQm4rwr5FDYfCmpKYEPtdyyuhKO5oc
	 F/nOZXRWyPOZbI30C3Asi8uBZAxqLMRSrCB8XFYQ=
Date: Mon, 10 Nov 2025 12:22:22 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1021420/930322-000000@github.com>
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

  Branch: refs/heads/1021420
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
