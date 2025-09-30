Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF16E239E76
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Sep 2025 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251174; cv=none; b=CpIGS6WOAw49v/Rhed0v2VGmzStiwwt+NGlIYdmVm98845GenpX9FcqsVf4LnCmvHS5Uq6O6B7JG7xo6yLq0J0/6bwiBmhYhlPGMmwzkx4BQhHJECrk5bydcm6O8rnVbc7aLC9bm6Skx255s237YWI8aRZgtuxUzZANuw3Iqrts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251174; c=relaxed/simple;
	bh=omnNcUY1YBMLPOCfZVe396HKNRy7IjV7Axtb4plQ38E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XZFxKBtK+qjCTYr0BeQTKxeH3ypqBVcViPYvQwBrKLEsDfwGsBiAMSbFgD+5VdpCyoYg9HyIxDJIL8/wuZwoPddGqti/xupAxEmAZz6MXPLT1zaJt+GeJ4PdfD02JG2X9sLuDCi1E3OB/3xDrVyhQD2rpWHCdDcGXXmrNd8Vfe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=D5rebvNr; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="D5rebvNr"
Received: from github.com (hubbernetes-node-972ab6c.ac4-iad.github.net [10.52.223.71])
	by smtp.github.com (Postfix) with ESMTPA id EF2D6640164
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Sep 2025 09:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759251172;
	bh=1WhLR9JCuHAOGCaWSw/9mEhX0+BnxZKr1J1AJoJ7Z/M=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=D5rebvNrLYDh/zzUcOFocObfY2rEMUWK+qwhTr43bZgVyAIxc54zaJSDEuPm2IgS2
	 cC7Q93uEUAEVd2p1p77ceK8ozWb9Iyr+26zkEhgfjr96Hb5Lr4qzeAag0r4YKS6chp
	 IghItdJwnKYm1Hc5aJmwmo07bUDQry1Ts6cWReuk=
Date: Tue, 30 Sep 2025 09:52:51 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1004133/33e7ae-000000@github.com>
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

  Branch: refs/heads/1004133
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
