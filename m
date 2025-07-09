Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5D32EA169
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069643; cv=none; b=i2QjZo5rSriFxqHw2/2INUgmP48BhIph0vof4n+4+3v/TXbSb79OogbxpcvB2hotuK4o5pLuZq2VR8Cxr7SzN8iKVX5hsbrOXVrEXDpypr1N9Bg9OzvEfysXRZJx58oR/E5dL2iaLU3jcquweY1lUbH23CyjOso//jFv0mYBO2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069643; c=relaxed/simple;
	bh=j4qi7x/DscAy+DFdiUEobHEaAvkihqN49G639uBr/OQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=S6I+t6zgMcMaSfZ5NbuO0Z7G7O5lens0anccPxSd/CQ7peob1msB3QMeAZ5642EVpfba6mqjnlb+hJ2/eLO8y9W0AvnyrkJOiGAMyLBWUqJZbha8xxU8G4KNX3orQIG1LKHPmn4OZwibj8RJi4OYbx88l9sEmDoiIyB1evhubW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Zb+e1/g2; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Zb+e1/g2"
Received: from github.com (hubbernetes-node-d8f4ee0.ash1-iad.github.net [10.56.158.20])
	by smtp.github.com (Postfix) with ESMTPA id BD1B6921349
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 07:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752069641;
	bh=G5E8I6vQsYBMLPnWmINStQflGqa7A69NHB6jbAze3D4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Zb+e1/g2PE8Ys0yGQOUslE3JPlnF3HVGINYHGfaDCEfEZl7MbGkEv5ZbE2q6rX2ig
	 81fTiQF+QIymaW6+dAPjMNenX/xBNu3LXE2WHWX425hf8d8Vx7A61zWDIJOFuBDPJa
	 iwyviMmc+fez98JiGOOakktC+Fwfx+YmHl/XBbmA=
Date: Wed, 09 Jul 2025 07:00:41 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/980144/378b5a-000000@github.com>
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

  Branch: refs/heads/980144
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
