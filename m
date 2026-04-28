Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B693988F9
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777390823; cv=none; b=XL4hPirYRElaCYE/jYe1Sy8A6z721bcSHEY+Qo/3rCmDPDzOlMvw+sDkUyyEdA0xNfZ1PZMwudwcnksewN8yCQl0u4moJw84o52I4eMgwOJ9XvKTRcxiHDUYp7J0CeSr/Lr55B49J93JXuLs36usPSM4MpINaFX8keLLS1wJogs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777390823; c=relaxed/simple;
	bh=4oF5cpC1xXma+qpddAe/OwFeQ3DepxLGEqMGba5znNM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iHRT1oHRsUkmVG1VFRFyGrEGwZ693EndpUFMoyyBBfxzEMx+4yfetz8jA9sAvMMWqwb9x/ArK3knfegnd77F5pjqQGVKWxeAhK0TorPlTFMNtDUr22JKt9FPbxruOjbxCJCYENSPgWkfQ6AknwQKFQ99VzpibUL22t/eds7hauo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=m6uWHKRD; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="m6uWHKRD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777390821;
	bh=yHgqKY4OqfNNxAu0umIrrQVQ0QPQqgs3XoLV3xBd2OM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=m6uWHKRDcplt4AKuAdOUt3Asbp5plkgPkzgta6mySx/9uuDMK7tYZkfQ0iX+0Jnu8
	 9vZ5YRR4TxhjH3VKgG3WiCtDu6t+uOwb1u0bhM0GSUp+xNp/VNsqSsjhPmxEuScSqw
	 zJkLVyQ69gDRuxD1e8CrMT+oCi10AHEaSTQ/UY8M=
Received: from github.com (hubbernetes-node-e54d966.va3-iad.github.net [10.48.180.47])
	by smtp.github.com (Postfix) with ESMTPA id DB261181046
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 08:40:21 -0700 (PDT)
Date: Tue, 28 Apr 2026 08:40:21 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1085227/713b66-000000@github.com>
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

  Branch: refs/heads/1085227
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
