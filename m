Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3172533E374
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601652; cv=none; b=aXRQNHOjzt45AESP6LML+Zf1sSwMSw28wSyGuVZikfpF/IcvqScDD0up5sWYsSrb7ClGT3ePlkmJaAzrgfW+i4l1jIa2dwzDHlKmOObwaCOIMSQ1aGvQg7or4s52Oy/iRD+8DVacgyAg9t74+OhelUUsR98EBxHPPdpJ0ngJXVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601652; c=relaxed/simple;
	bh=Xuok5fpvVh0me2HQHp7Bvbqn4REWuc/W7q4ecRrs+v4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WUFSJs6GJo9T6Hli5YHxJBWTlKAKO20SPPLx1ip9w3fq9pK8HW51UoOqUVG4S44tecr3YipEMqrfvhlrdpFELA16mXUtgFP5ydzefAjCQgjnsC/+hg0ardNpDqn39sMaBTlAbCT9IoCEtzIRFml0qOqqDmUk/pia6+EX1aLOEtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WXY7CHx1; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WXY7CHx1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780601650;
	bh=7jvkUr42WPNXEdJuOEmj5iwKCU8gVnScqTp+c57i1G8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WXY7CHx1jW44dKUSpv55LqxBIdMLEWMmqU5I4+fU1ch5/Rmyef6cRTnjMXLs7CLJs
	 M/pc9ZSDqFaPMZXJZPrnqTLJaDIhS3kxII2TWqXsRmPAnvryY83eo2G3CwixbVoAgN
	 Nc0ksfu3LGVRQqIMQCET7KzDKjNN8yPAuwqOFv70=
Received: from github.com (hubbernetes-node-d21d708.va3-iad.github.net [10.48.143.33])
	by smtp.github.com (Postfix) with ESMTPA id 5DE748010D9
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 12:34:10 -0700 (PDT)
Date: Thu, 04 Jun 2026 12:34:10 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1105842/d02777-000000@github.com>
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

  Branch: refs/heads/1105842
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
