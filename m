Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C875225405
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 07:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748330382; cv=none; b=aJQ8Ujkm4VCDFWx0akMgG4e522inyI2oFZ53LwPNL2beJoVLJRx3xW/zEBVBN6Mzx/RhRZp4OrD7thXivTto6LA01/0OQ1F5hbGAEpZjHC8fJTqjHlEDLpzkDW5wj97YVFn+FyRQM1dW/M1NYTpk8psHzujvG5zFto2CbIDh4Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748330382; c=relaxed/simple;
	bh=8Uwmge49n0dQyY9bASo67jsIGV6TtiwQBvIoMDJQKWw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Jfj22xh5sajYhGeTt1j8mz92PB1cZnDRT44nCzG6bM/t8G5rLabNc94YRMsgkH/Ao5YvBinJI0umDTeV4YZBZlTQ0dhwkklYcPrpIsuosj3N/oB4miM928kRAl7nisihY2IZ3AKSTYUQn5tq0f91pR0LEvaWV16ASPPE/I8zPto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iMPH7GMf; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iMPH7GMf"
Received: from github.com (hubbernetes-node-f10d5fe.ash1-iad.github.net [10.56.152.31])
	by smtp.github.com (Postfix) with ESMTPA id 3F2089202A4
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 00:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748330380;
	bh=3lF/C9w6gnfqKl++vmWmeKSI9xdWzh75WMzR545BExk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iMPH7GMfgY1n4+klkBhzP/0EcleLZELHDLBgjNiKg8mWi7Us3o3JJOm5Psy+3Fco1
	 13MQ6I3SdEQX9OG3vCpLCv1m4djK74iesEl84wrgdNwm6o85wA3rNChk2sSJ0xairf
	 Vtc5Es6DU09kdtxWVxwEYX9aHm3T6ma2jSAP175I=
Date: Tue, 27 May 2025 00:19:40 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/966569/000000-946f22@github.com>
Subject: [bluez/bluez] 946f22: obexd/transfer: Send Transferred property on
 trans...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/966569
  Home:   https://github.com/bluez/bluez
  Commit: 946f227de985ec2ac83c10e2e94a46da244f09f0
      https://github.com/bluez/bluez/commit/946f227de985ec2ac83c10e2e94a4=
6da244f09f0
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-27 (Tue, 27 May 2025)

  Changed paths:
    M obexd/client/transfer.c

  Log Message:
  -----------
  obexd/transfer: Send Transferred property on transfer completion

Currently the Transferred property is sent each second and not on
transfer completion, this leads to get no transferred size info or
without the last packet size(s).



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
