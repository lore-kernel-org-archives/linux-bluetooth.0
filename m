Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1746B391E7C
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Aug 2026 07:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786262387; cv=none; b=jC3+IFTjzjk3ADFCDtlqlpSI04wpP3KtzeRj28IyvX+UpSeouuReXgEolChWcObK8V+Yng8SoFYucHEkJf9jJxlmFT0wqiAbVWe83zUJiAcRZHkLSFHXQjkUFK5pRT1D4XSV3FDFjrS1B9doDqvKhlNQlHyV9nJt0eDvMTXz+sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786262387; c=relaxed/simple;
	bh=y3EaD3p5z3cPkouTiT3DcZryZbiqB7vr+Unazi3BiPw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ec3e2UFCnhAsJuOTyE3FSOkMxMmCNoW79hziajWTaUs1Gt5FRd9Ie9i23h0nNV6yjLmdwUS4DYoMX8x9M5zNqSRMldMolmkL59nqndlVOFDHsqboZfQHUKMGe+h4WzdDcnWsC3P8yQOqul0q2qWdAAbmn3ud9LL3GpySFmoq5iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=b5Gd3NXN; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="b5Gd3NXN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786262385;
	bh=hCYA8dSzAxnUfbfypAs17xd/HbgXP84dVV3zMFLm7FM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=b5Gd3NXNr1C9mVytVvj7kdFHlhxVi1li0vdgB0v/hU9USqC5KPQ0EoimvaTVcjWxg
	 ZDWffGUGkvyk2QUEjDaz0etcogQGAevO1EkakB9iBdeLhwyIF4mcHMM2kpl086U3BP
	 X4fdqDO8yQW0O67AqdOTDorkmyLVWQlJ/dupKSJg=
Received: from github.com (hubbernetes-node-7068fed.ash1-iad.github.net [10.56.196.54])
	by smtp.github.com (Postfix) with ESMTPA id 357DC3605A9
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Aug 2026 00:59:45 -0700 (PDT)
Date: Sun, 09 Aug 2026 00:59:45 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1125185/c90ff7-000000@github.com>
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

  Branch: refs/heads/1125185
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
