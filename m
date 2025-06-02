Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F8B1991CB
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Jun 2025 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748850149; cv=none; b=KfTjuFh0ol9m8qInJyD9mtXNFw+15ATfaAi+rOYrCqT3P2IZzDl/VFGDl4CZ3arI8eXNCzjbNikGEx/8p7DZz+sKwTCz/ZD4RzTC1IFrZikQv7gj6v8nzFJhmV5r3/W9YDJPXu3zputRwa+Oyn/gT7IyG+i94X4JunbksgtiqdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748850149; c=relaxed/simple;
	bh=sldv668+K1kw51Vm5EunhY20RsHFzhxhO7e5VAKY/1A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Lnis5QDOoSpsNyz4dptoO2KZB3jpYWThDvIPizTtDezlrDIbB35IQgCCNAT0q/iEQp7E3/ECtr5lpj2IvRXJ71dCHU64h3Lp0O42xHeq0iGVnz60MUestt22D3BXu5qgqbCy9x6EemSBvRQOim9shQCfdkIob5lHG1Dt7IH2U8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mb7JfqHU; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mb7JfqHU"
Received: from github.com (hubbernetes-node-f28788c.ac4-iad.github.net [10.52.211.86])
	by smtp.github.com (Postfix) with ESMTPA id D16F764113D
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Jun 2025 00:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748850146;
	bh=CL2YPskl5udU4ldqTIsCD2KFmxs2pX5ibelG5A0z1gw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mb7JfqHUgBwX+RtJVgfdBdOMgXAb6G4SWewVQfeuxD8rnJEHnMmGnkrhRjQCJohEz
	 3KJz4MKhRL4j01o8+YlVkseepPNgJ/PVwvkfefenqsKULWC1S3aaFY5eR26BHcdHnT
	 /1ggiZ3JYdkJd+xQJMPScxfrV9CmepvgdP3LJUzI=
Date: Mon, 02 Jun 2025 00:42:26 -0700
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/aed494-d97d19@github.com>
Subject: [bluez/bluez] d97d19: Release 5.83
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: d97d1951b447f8575e972458d3007afcfed6cf28
      https://github.com/bluez/bluez/commit/d97d1951b447f8575e972458d3007afcfed6cf28
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2025-06-02 (Mon, 02 Jun 2025)

  Changed paths:
    M ChangeLog
    M configure.ac

  Log Message:
  -----------
  Release 5.83



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
