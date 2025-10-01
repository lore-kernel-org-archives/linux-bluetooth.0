Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9730125C6FF
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330764; cv=none; b=ZehFrM2e+K5WSU/XhwMRGXIjQqnBcjlaAAld9e6E59Mj5eOxrjvkq13+e/xWux4Bp5vPJsVl6Xa865uyf+magJvZKBM5IQj7ComEWWU6FdcXcQZRv0vXPX4hhxCMf7LeUKM9onqVYMnNJnwZBHhgGnpNKAuyEvoFbfsUGckkNqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330764; c=relaxed/simple;
	bh=l45rDcqOcK8LZFP+HqW8LNrIXMv7XWBkZF437+hyz60=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BkjwYVfVFhOUJfD2DEQ2MU66JnCZOIs06a5y54kZI5hRLbPSYNKGQvCrd9ubFxt0YieY7tNnWtWctZTLRv5StXWSCAYO9H4RsQRg6btg6dQlkNRJn/+yoUIaNGoBGJaqrlsti74ySy1qcpXYMsFMBGPR0deAtpIruGVrprvRxjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AkPvKz1i; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AkPvKz1i"
Received: from github.com (hubbernetes-node-3d3a7bc.ac4-iad.github.net [10.52.153.33])
	by smtp.github.com (Postfix) with ESMTPA id A45724012DD
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 07:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759330761;
	bh=kcwY401oq4MMPVaPlELgPMp0WQkRkBv0NpwaK/irGvo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AkPvKz1iMuWf2DNFf7vXcg0OOAY4uD9F4Ohudmmu1Pv72QjnqWinvFp6smP2UV/xu
	 0huLPZbOe8nAHnoUglfJ2DgDTYMrdciH1uNy8p+VAWAf99J2LuqToYVOxxvhagDbCP
	 VCquD8FzMB+G4zwvxYoolgZ6iOBGo1wgQ/2UsJ5k=
Date: Wed, 01 Oct 2025 07:59:21 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1007463/1199c6-000000@github.com>
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

  Branch: refs/heads/1007463
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
