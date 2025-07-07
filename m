Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4682E13EFE3
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751871368; cv=none; b=Q/y08QIiRX3hTNha+tDwrYhk7sBWctyHx8K8W/Qr25z86GJTG5Wzvd/5+QadgFV09bB/QAmG5yVPKKr1GsUFIMeA9H6+38kAhQ9crccC0B+NamUGA2sNfROUx0wRoo6OTiegaxDTPiYWo4IbGBLoNAqPGwrPXoGPN6JoTiHO3b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751871368; c=relaxed/simple;
	bh=4x3pkGu18rBAxdy1h+5fbO40k/ryO9Gy8wqtAqo0vaQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=C6Uj/ZBftGmT8fvr+zynysVIaaZRlbxnA+2cwALe4JzEyioMdnHJkhNMaEWPT7r/XPdw9TR5U6JFZUX9lm8kn1F6/inkWXcDAbQaYqMPl+E9y5J4VLJXGkfr2xxYlRl2bzsq/ki9CrMHwPkwQbaBWIhTF4vTMm7hX/wRVtSnKao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=k1bsNiTU; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="k1bsNiTU"
Received: from github.com (hubbernetes-node-a2a3ea9.va3-iad.github.net [10.48.158.16])
	by smtp.github.com (Postfix) with ESMTPA id 58DC98C02BE
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Jul 2025 23:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751871363;
	bh=gCqPlGlwfJxxR2NspDbQmJzYjCndEqXOEgWt20OBqCc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=k1bsNiTUtz2R2QAbyHPdk2EpzMn19fWg/5c7KtUPMQJ9ILslS+wpjFsqQWKX1kQ9q
	 SMnhXCZBVQ3mlmYlT6vwgzySlA6hnUib6Ldvy3JwIi4EMc+Crzp0sVNDXVwEHU+nns
	 11qn12U/fNo9j9LZjJeDixWRhqWoegfk1cmk2Nbc=
Date: Sun, 06 Jul 2025 23:56:03 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/977969/21cdde-000000@github.com>
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

  Branch: refs/heads/977969
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
