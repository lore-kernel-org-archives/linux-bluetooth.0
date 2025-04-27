Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA4723AD
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745763438; cv=none; b=MlsMwc75O5wEGyV/ISZuSOHRIsi6mlUOrJ/m0HdpbLl60C9VWw9MBQq2wUyVb3HXfMGXFLdWRVMnUomNdFH7zyD36jWCe7S1MicojochGWhm70SFlJ1bTmtdp2dRWNJ2zY14pttkFYXUB6k1V0SpV7/OILWiwW/IaHx72gjf6xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745763438; c=relaxed/simple;
	bh=29dn+O10WbvaxWypS/7reYTUzQn7SArdrbyEdSaOf7Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GLMiAZZ4cgCUvksDmgKkyCXjKtDBw9jb3IDjQ/tAPKeoHLbSyeaucnrkx+oduWl6BYbCYjsqfuSlc/TsRrM+KvwDT14CSHKjVe0hf/SBqc5cMehRZy3rOtQlGmPlBrGFrz/Tky3jyjS1UP8BNaWPUKVLomjWYD+lpjwc9xCQY7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HT2k+Li2; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HT2k+Li2"
Received: from github.com (hubbernetes-node-e1d2a62.va3-iad.github.net [10.48.219.47])
	by smtp.github.com (Postfix) with ESMTPA id A284DE0605
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 07:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745763435;
	bh=NZbFV3/ZSTlDYrMWh97fcP+uDCZqTXyAYnkgKw7H8+s=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HT2k+Li2977p7qWubhcQch32CFCouNYBPswbwQ0JBNeg+t9s+ZN5XnVCscsM02sqJ
	 1cq+/LCLXwdFb0jkT/gsn02u9TIFOfnRPs7XEs330UMkxIjry8gEqyAlZnxemjED3H
	 /96mEbmhsAXZVqkrXDqcGgOPETRvvfYpobVuMQ8o=
Date: Sun, 27 Apr 2025 07:17:15 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957498/000000-e838d5@github.com>
Subject: [bluez/bluez] 9dbd64: org.bluez.Media: add SupportedFeatures
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

  Branch: refs/heads/957498
  Home:   https://github.com/bluez/bluez
  Commit: 9dbd64f1cd7f4b24e5323183916b4433d7c67979
      https://github.com/bluez/bluez/commit/9dbd64f1cd7f4b24e5323183916b4433d7c67979
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-27 (Sun, 27 Apr 2025)

  Changed paths:
    M doc/org.bluez.Media.rst

  Log Message:
  -----------
  org.bluez.Media: add SupportedFeatures

Add SupportedFeatures property for feature information that applications
cannot find otherwise.

Add feature tx-timestamping. Applications cannot enable it on old BlueZ
versions without that feature, as it requires special handling on BlueZ
side.


  Commit: e838d5e0620d6d9cd51cefeaf18d19d57c259956
      https://github.com/bluez/bluez/commit/e838d5e0620d6d9cd51cefeaf18d19d57c259956
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-27 (Sun, 27 Apr 2025)

  Changed paths:
    M profiles/audio/media.c
    M src/adapter.h

  Log Message:
  -----------
  media: implement SupportedFeatures property

Add org.bluez.Media.SupportedFeatures. Add feature tx-timestamping.


Compare: https://github.com/bluez/bluez/compare/9dbd64f1cd7f%5E...e838d5e0620d

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
