Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D661487F6
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Jul 2025 09:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753005428; cv=none; b=Bu+mDQ/0zabVa1EI+K22N62G1mtAE+h8cGkjRJMRhWYZpGs2mdOHtWbTP/maF7TeViBJWM79RzGKQm8eGumGGwFZJUQtEoiOWnAbfab2t8CACQ1ESYxpd/JKiXZOze6O2rmLuVIe2kTa13GWPlpbrNMEOidW35X3cLJOOwO+kT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753005428; c=relaxed/simple;
	bh=KxoieH27CI53VpN8r0Fv9pTmZZ6Aa9St7ZxV83ySlm8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=sTuto6lNmXBL5+u1V6IR6RXwvQC9hVRvUA+VZ5t10X7L8g6//BrD2w9poFwbJvA1WyiotfxD4IJAzQUkbEpAiQv0O7hvrYgG+whO7f3a3EeMiMCdrtkKPw3i03LKVzy8oVAysUbLyDaJUpAiJwCUmfitGLDre/fmPk42CZhPpTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gU+9ASRA; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gU+9ASRA"
Received: from github.com (hubbernetes-node-472d518.ash1-iad.github.net [10.56.190.29])
	by smtp.github.com (Postfix) with ESMTPA id 19BB16008F7
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Jul 2025 02:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753005426;
	bh=65IXKyAnWcgbe6n5iY4HZ3Bt9g0hiaLoPNaYEJquf/A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gU+9ASRAp1gxMuLTx9fa3em5CuVYP12mwp+sUC2TGjU0R9USIs8inF2bwGr80xdIT
	 YiRAwRRxZsZJg8V2LFFn2NWFmyRmyNsv5EdR/0Zpfd/g3Yo4YktwXclv5ARYXmroTk
	 ebGxAYIKSq1+i+XQU2jWxWRPGIEWCxwdGoTM12ys=
Date: Sun, 20 Jul 2025 02:57:06 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/974159/dcb59d-000000@github.com>
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

  Branch: refs/heads/974159
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
