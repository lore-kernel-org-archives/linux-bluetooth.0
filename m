Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3105C343215
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716888; cv=none; b=Rk6UQDcU6momc7QdkwtZ79qhM10RKVdMVgNIB6Hkz+iEC9BoNs15bWuWX0Zaj0b7hzYgKidWEzdCLGy7HwNPP6Z+W/QCvdtso5fcI/IdHGosPumLaTbQI9zMWlaYLAeK9pyecTuRyGrAsdQXbPiHAB6S/PdlZhy1PCGsRmipYmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716888; c=relaxed/simple;
	bh=dlbWXRpVLXsAM8kuAZ9P7UbmFEZpy9ZRQU/nmeDYjs4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oMyNrTzdOzKm4X6IsezYGKF/jUINPfPi2YeRKZscuX6z+oRJLKQ+aT+E1k36DomoM8rnQthNYtd/fKa4VddpQQxG3l956uF/JJ4fv1dSUTrgwSMY1/NfnR8+ZzVweXPMnEUHIK3L9xJRiw9jN/fqKV9IOBHdIVitsycZYF23GFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FmC93B4e; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FmC93B4e"
Received: from github.com (unknown [10.55.98.27])
	by smtp.github.com (Postfix) with ESMTPA id 4F01264110C
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 01:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763716886;
	bh=BOO/uZNn4QzDmutNYSykcUVK008+CPohphfF9NTm0L8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FmC93B4eGwCb1UUvi2I/MCsqQqV31EIhcSOooEvHoOXI5FFoUKrDEaX0dA8oQOA+h
	 37EassWQOHkJkBAc6T1Qosqu9CRuAi/I54bkCACXZFy5IuAKHFcdL/vtUJgwsDPp2N
	 zWdY7twuNRdgAI0vP2HDxYPSLYQyo7dIHON+ygbE=
Date: Fri, 21 Nov 2025 01:21:26 -0800
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1026231/000000-9dc877@github.com>
Subject: [bluez/bluez] 9dc877: client: Fix issue of bearer info not printing
 corr...
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

  Branch: refs/heads/1026231
  Home:   https://github.com/bluez/bluez
  Commit: 9dc8772297ba47afa23adbfef0f380f1c28d6b71
      https://github.com/bluez/bluez/commit/9dc8772297ba47afa23adbfef0f380f1c28d6b71
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-11-21 (Fri, 21 Nov 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Fix issue of bearer info not printing correctly

The device proxy was incorrectly used when printing
bearer properties.

Signed-off-by: Ye He <ye.he@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
