Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911DB2877FA
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 03:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004850; cv=none; b=JqdiXOEhZZZ5RqLhY6e4L30PnTIM8ZAQES6Cy1P1d6BSBbEFak4xp9GLVwFXHZ7EDmXwkydFs/9ATcDFQ5o2qSAXFG+w83GZqS67nU1oVtaCmg89n1GlGGQ/W2B5Aue6y3MfNHKEeQTjJY6BjsttospLFRkeAME/dfxXsOY/tqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004850; c=relaxed/simple;
	bh=qVYrbgq3DqzMfEQPPMj1LQCOK4agD1Y27NpTASeC2O4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cLlavIY9+lupOCZM+kkXPF1dYXSrCViDQBwB3yVnSAtK1/SPjw2TQyU2TlVPO8/m3lQvw9Sr711IU4NdiSWD1oJGD6WOw6OcrYjoRsULVqOm0nDAo5PAqieIhIVfHLj4Wur+6vDBzUiMCYSkK/A6j06gokYZsqN7p5MINHikze8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=P7ozIEyU; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="P7ozIEyU"
Received: from github.com (hubbernetes-node-3fe37c1.ash1-iad.github.net [10.56.209.89])
	by smtp.github.com (Postfix) with ESMTPA id 909A4141166
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 19:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763004848;
	bh=BxWvbYpSjrnLQ1/Fe8BCbgFF37eyGOA/o338vHx95Ao=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=P7ozIEyUeDrq9vhF5LhpAa57LGr3USBfcw7fFIZC1gl7fYKJWXWCEwyRth+djcUch
	 AWykZjAdbnIqAX48vFR9hxc+VO/uxfN4bTqaO5WX0oWOyN5ZhrQ3V7pcp0CbYi7sC5
	 bjHzHLZwfz2jpARwST5bMcFbYUraL2T7Cr8ORi2U=
Date: Wed, 12 Nov 2025 19:34:08 -0800
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1022762/000000-689cd4@github.com>
Subject: [bluez/bluez] 689cd4: bearer: Implement Connect/Disconnect methods
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

  Branch: refs/heads/1022762
  Home:   https://github.com/bluez/bluez
  Commit: 689cd4f6787b2f02c28dcc2da93d5f5dbf9383d1
      https://github.com/bluez/bluez/commit/689cd4f6787b2f02c28dcc2da93d5f5dbf9383d1
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-11-13 (Thu, 13 Nov 2025)

  Changed paths:
    M src/bearer.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  bearer: Implement Connect/Disconnect methods

This patch provides implementations for the Connect and Disconnect
methods of the org.bluez.Bearer.LE1 and org.bluez.Bearer.BREDR1
interfaces.

Signed-off-by: Ye He <ye.he@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
