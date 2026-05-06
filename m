Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AE945348E
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075877; cv=none; b=pnbM35ox73k/znHXXZNgRfg84qFtNm3yEZV9IVEJyQilIyacDZ5Zh1wyie2Vk+EX/A6sCSzK7nLjEMSAcijxjJHutEleiqErLsnyfyKKdJerCgkD3fX4SqslbMpBy3LMs2ud3LPxqr0c9deSxNA78Mw3Nm4rGg/s3dNAav0Fpb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075877; c=relaxed/simple;
	bh=8oUd7qXmcTOant8pOrz/iHBdQkQ/XqLcaeemhbPwI8g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=QZ6OElBMvYzFzQrKg/wQ9k/RraPJ8MRo/4fNdRvvk/7/THcE0SXmaro8U1yPDDU2tweHNejDPDIGxe4PTnVAGtuIQRiyNGE55hGtb8xTsowkM9KZj27bAfufYJiPIf7jsgNLIwAqdY5tm5/W7xGQ/w/qgJTAPwjY1ql54VmFwV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jQyQuZvN; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jQyQuZvN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778075875;
	bh=wnT3OB1bTEkzJk7d625r1ya8H3Wkq0NJsIQPiiRtqD8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jQyQuZvNV9MlnJxj4Qydx1J0nSZg53Ow8yvANSCUmZqM6b5LJn6qzlJCfWgsqCF6E
	 ZnSnK2r3H+N7wlCFH1Kyqetluhw/7XebWeMDTjuRo2wYbr9NzMlB0mBCAdmLSFwRFp
	 vvtTugWYRRLRtSu4CItgy55yDwL4esJAjis/wA18=
Received: from github.com (hubbernetes-node-263282b.ac4-iad.github.net [10.52.167.39])
	by smtp.github.com (Postfix) with ESMTPA id B4CF7940E38
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 06:57:55 -0700 (PDT)
Date: Wed, 06 May 2026 06:57:55 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1088547/dfbc31-000000@github.com>
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

  Branch: refs/heads/1088547
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
