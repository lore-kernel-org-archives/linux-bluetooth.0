Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8CA27F744
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509523; cv=none; b=G7gjvycMZjnhUEq7tz1pNDfP8sA1b9GiZUqjcBzP5TKymetyLi8+TH2PMO97LlWfCgKgPQNm7eL+eXCMD0DKwBLOgljQSk4LBx8XqncbNBUlk8ZbSbLSlw7DP+B/mh+Qr0ul+mJdldJJKarD3kab7QKXK8aaciqYPrRs+EvQpWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509523; c=relaxed/simple;
	bh=5HfCS+4k0OMFQ2brGukEOOormWaaZsVv+2NMO5A5QW8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HNRtXxafc0EcOrUPsVODHv+Y60cD20SsneyAZOEGCsCwpZAgtSLRSFl2ya7wpkqioQDDSQ0lL1uqkORv10dSaYibqH+CNzR5CZenaYYL4f98WMYFW+rYB9MbsCTEJhL4FuEg3otKBwkhYJfnizW7nyIuPYOkJgGT//TFvqnBeWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VQ0Heopm; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VQ0Heopm"
Received: from github.com (hubbernetes-node-f819557.va3-iad.github.net [10.48.132.33])
	by smtp.github.com (Postfix) with ESMTPA id 38BBE4E026C
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 08:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745509519;
	bh=4XkVjV8S05oFCbESheAVcvMkBTl9OnX7B5XOFHJ/+4Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VQ0HeopmK7NVius9DPHJCpZghai/zBWBF+MxhfosaCC8omW0XvkTFf7TGMWrhsgBW
	 AZCYBATTfUlfYDenXV472PW1IzQcxYBq2/arGbgz4kkDSfY9bnAau79BlrrGtxhW/c
	 dP2Gl2AFEIq6+z0yavw2Wag7qXeRnEcTFMVFdli8=
Date: Thu, 24 Apr 2025 08:45:19 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/955281/000000-889087@github.com>
Subject: [bluez/bluez] 889087: obex: Send response to client for Abort request
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

  Branch: refs/heads/955281
  Home:   https://github.com/bluez/bluez
  Commit: 889087d13261d2f6fb7ee9cff1a56d46dd6b714b
      https://github.com/bluez/bluez/commit/889087d13261d2f6fb7ee9cff1a56d46dd6b714b
  Author: Amisha Jain <quic_amisjain@quicinc.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M obexd/src/obex.c

  Log Message:
  -----------
  obex: Send response to client for Abort request

Incase of ongoing transfer, If the client sends Abort request, Server is not
sending any response back.

Ideally it should send OK or Success reponse code for the abort command.

This is required in PTS testing for passing below testcases -
1) OPP/SR/OPH/BV-27-I
To verify that a server can respond to an ABORT from the client during an OBEX operation.
2)FTP/SR/OTR/BV-02-C
To verify that the pushed file is aborted normally.
3)PBAP/PSE/PDF/BV-06-I
Verify that the PCE can abort a Phone Book object download from the PSE.
4)PBAP/PSE/PBF/BV-03-I
Verify that the PCE can abort a vCard-listing object download from the PSE.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
