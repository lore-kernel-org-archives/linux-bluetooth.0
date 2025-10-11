Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1084E1A08BC
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Oct 2025 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760208889; cv=none; b=kyQtsNHTY/rXinPdSEux38EsRs7bkaarl3kPTIm3cV5zSkF98byYzxY1oTxUY9quT1JHDBaPpV6d4pmIRnUCwv7s5cf20Boj5KjxSW6W0zd4V+8/EGS94uCDto1SyyOT3LwtK1sAOI+QS+9JrbVJ9ju2BJRwv8JgqKWQp8Om800=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760208889; c=relaxed/simple;
	bh=mz0v2xYonxAaTnvZyjQf6ZXBKM/z+3EmVg0wpgI818Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MNfMSPqbG/AYbLpmX6faZP/Fb8WBEMaUCbwGU5wenH1B1qgIiXktlEhWYPfj0npR2Kaqpz8RKG8g1AXVNtVGW67YxM52cMeaXzQHhCHpan1/EGx4728rKA8fB/H7r0TCzeBYNQqL90OXSExzOIwqHiclANdFkCFTLtYas8dAa6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cEFy9IFY; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cEFy9IFY"
Received: from github.com (hubbernetes-node-8fedf30.va3-iad.github.net [10.48.220.50])
	by smtp.github.com (Postfix) with ESMTPA id 0BD988C0189
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Oct 2025 11:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760208887;
	bh=vlPnMTcKtct74AxpSH+2ubVhMBwvKhD4ChQiW3pcNtE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cEFy9IFY6Tac9813GGMZLTnC0aJDXxYh7sUvfosz8a7Xk/x4sS7n3yg15wRyxHjUC
	 MFKxtxNps9+SILBxawE7rGkCnaBlKVpnKCpkbwuvoHsim741aAA2iXJn+3NcLjlLm8
	 JTkPQJZn7xhf3xezKcBtF4lWv97Rs1c4rCVc2W0A=
Date: Sat, 11 Oct 2025 11:54:47 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1010380/000000-04d044@github.com>
Subject: [bluez/bluez] 04d044: shared/bap: check pac cc and metadata length
 befor...
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

  Branch: refs/heads/1010380
  Home:   https://github.com/bluez/bluez
  Commit: 04d044e80dc9872c1705703c73df71c79a8560c9
      https://github.com/bluez/bluez/commit/04d044e80dc9872c1705703c73df71c79a8560c9
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-10-11 (Sat, 11 Oct 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: check pac cc and metadata length before use

Don't read past buffer end if device provided bogus values for PAC
caps/metadata lengths.

Use iov pull properly, and also check metadata LTV validity.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
