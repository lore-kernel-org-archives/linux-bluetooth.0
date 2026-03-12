Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9510538D009
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773312993; cv=none; b=c/w34ZrETB58VRaXIvTmMydL0/OJtLkRAXasVXyqn44aH/lddWWPMqV5DvPCovWzM6NAwDB/lDMZlRyFy359Apg6WgYcZm6BiCmgrUsoAqMm5npW9M46fbd67ERF04U67EHuji3iF1pfKPmLO22hZwglvhG/Xv57OosjTgryAq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773312993; c=relaxed/simple;
	bh=xDKBMFrWVbb9mPBYIckSPzcErZ4DyRIVXzUo6yhaUx4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=J52K6hIDloqUVnjms7Poxfj/pZ6dcG/w/vsSQ3dW67jlaLt8BWyu+IAO77l6SSEOo1zpPHs7nvnPM7utT7zGBE4v3A0iKuLmRt/hO2qnxKiSv8GtZ07tP7NTg6txpIEpwNiHfnuIbHqfGH2TAGTQXL8OCp43lwRJ23zoiAtveE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UcFVuaNd; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UcFVuaNd"
Received: from github.com (hubbernetes-node-1cb2d6b.ash1-iad.github.net [10.56.170.26])
	by smtp.github.com (Postfix) with ESMTPA id E4F27140415
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 03:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773312991;
	bh=pDW7wb3xnve1+Mes8rfAK00cSxp/lZvof8AqMRUVn3A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UcFVuaNdj2OjXPvg3UJTqfKpALMtaIlBGNinWQG4sMpHWN0wC1gTUL3TGgdotZ1jb
	 Re31sYD5S6bxiIGUPjZoTjNA+xhjIyepivyOTVEJsp5p/dxbWf3BayZLhD1QD3VIiQ
	 uRR1v8HpPR6GbogU2M91O/nXIAFk6CkfNit1YqIc=
Date: Thu, 12 Mar 2026 03:56:31 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/826174/994184-000000@github.com>
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

  Branch: refs/heads/826174
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
