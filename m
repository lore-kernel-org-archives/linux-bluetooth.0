Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D2F2E3718
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797776; cv=none; b=ek0RaSJVhwnBRbrLvcLLwsxz2ITtR8v1ffR8yZ6XHX559IzIVHcZc2mxLLPjtsRkm0sOLhKgBT4oXtRiXoCHcCeEuQTr5c7dgH1+8eozG26Wok18yOwQplwDJZuygzCtC1HTkUk8sjTMt8nOKMjZjqalA/fX5ZsDVUKu9M0mBOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797776; c=relaxed/simple;
	bh=XUPyo33nkuAeSpz5OvCiKtA7n2LthbIEe4vbGrvdI0g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JUcwb27qc5YyiPnWL4RvMVRWsRT3mIunkjskFAcRpuO0syaJTA1IL7qVMA6Jl/fob39CIauwptY9dA3taEph5A6Xje3hF2ujm+PEd1HJXjwbeQH/0aX2lvHbHCgCaU0rsgYHZrOz8yzktzCf2MWPOxnGrUkUVtcH8yHyrmJtsYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=f81YsFrq; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="f81YsFrq"
Received: from github.com (hubbernetes-node-43b0c3d.ash1-iad.github.net [10.56.158.31])
	by smtp.github.com (Postfix) with ESMTPA id F32E2140924
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 10:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755797774;
	bh=SBJtisesy4d9MLFUbzcZSSOzgI33mQPZd+fitIjjX2w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=f81YsFrqxSoD1xx3TulPQdVIDxMncedlrXWCOcAzR5VbxXSqcgU14s5ZBIT95pc1c
	 U6Yik+urypzJWMQQU+J/IYBoyvTFoLgVa30Zgaa0nmahxm/6C9QxA/5wbahvNzNpZ1
	 LkWRiDpIF186M4aFTf3EusJ+f+7jaosf1L4FwPUQ=
Date: Thu, 21 Aug 2025 10:36:13 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/994059/d338b5-000000@github.com>
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

  Branch: refs/heads/994059
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
