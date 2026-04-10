Received: from out-43.smtp.github.com (out-43.smtp.github.com [192.30.252.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79DB3D9DD2
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775841255; cv=none; b=PE15iK5AdyJbB7OC/Q6ElEswy3m8n55dqw32QChdGpfekMLf65kuP/b0PfIZ/5EVRQ/oSX+i8u0Qvpx1igudAWkOSTZ2iIoJoqeUB2JRqkjj1dSMy2fnzZ/Yaawh88Smqbaf9qTXpqC13nAypwYq3YtZSLgv5klU5phQZBPLJVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775841255; c=relaxed/simple;
	bh=hDQpGvk2loYMogohOzakxLXzV8ZuG7VzXzmPY0NA52E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nAa9JOOQbXnTE+g7A/J+ElVt1ytw8RRkLH2oMLSrLmA5G0JS3CQKImTplMCUvkaEAbV5SPaPNx3Uwrc0O0XsF8WWBJnVm6N+tB/z+MPIjBrJz35Ll1djk5642WAeX02NWVY/+qHYsTQAqwFCmz0IJjZgAGopCL5ifUdZBs9vQ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Of9aZglH; arc=none smtp.client-ip=192.30.252.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Of9aZglH"
Received: from github.com (hubbernetes-node-d3e81ec.ash1-iad.github.net [10.59.98.27])
	by smtp.github.com (Postfix) with ESMTPA id E07D86C00D8
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 10:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775841253;
	bh=m8UgCXycspLDNlYaw5NRzVb8uE33g5/CtZWFS5vSDis=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Of9aZglHm/VvnE2tm0F1MMZqFhz+s0KtgpelSo/57umE62PufX0zobsTBQIpUNp9E
	 fkp1999mb86ZilS19nzQUG3p4/+aseGZV2HlLuvVA+l+w9nnlYuPxfhIiDcwfDB1TF
	 t/fTPdTX/CCaUAT9wFi3YDBuh4Y5ndNzp4OKIo+A=
Date: Fri, 10 Apr 2026 10:14:13 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1065141/6e61a1-000000@github.com>
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

  Branch: refs/heads/1065141
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
