Received: from out-29.smtp.github.com (out-29.smtp.github.com [192.30.252.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4876524AF8
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761477; cv=none; b=RT/m9PDp6dcDVedPZ2r34skNod8rL3g9ggF/0mTdLmuReKiqWEVzgVIsvHChgV0NRMNfK3zT4nUiEpSRvDCqD5yl5pOCTAKo/zwuXy49lv02G2ENYXeIU6zIGdSjhk/+NgJh0jPRPpOPt+8CMkyB4zHqkCD9Ptg/vBFOzdn+1bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761477; c=relaxed/simple;
	bh=Ly5xnYaql6C4bMtpkRu8ApuYl+ZWU8F6C9uE7SGefyQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UubGBKpDIeq7vNUo1AN8hVM51D4EUOHwr1pXl7eq16mLgLzAny9G+xuhd7+Gjgo+TX5Bwah8hz4jxzqniLgcn3jMU1BmQFPZcnp8E7PqRujfEQevNl/sb+7M7zZHhWu+Nduvkdl14Rby2iX0iBMeLz9N/52VdUWqPbdGcq2dmtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SNFZBoQI; arc=none smtp.client-ip=192.30.252.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SNFZBoQI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789761466;
	bh=t3aAGLj9mwsm5dG/ELMcWntOC4J3fcKAChnz/6/yP3U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SNFZBoQI2ZZn8oN4RA9wNRIzsy86kJLIGUDSPFbK+jUyKJ6IGBB76xI/KY9HLbcW+
	 GeY+uhtTbnRu27c+OpsLg1ZOkIRuXgiF2AAWJ0NA8R9pk2w99WrB0/ezSqMM0av3Tx
	 OxYmFhsD8OSHfEuOtv4hDlzltJvWeAPpE6nKrtK4=
Received: from github.com (hubbernetes-node-bdfe5d7.ac4-iad.github.net [10.52.172.39])
	by smtp.github.com (Postfix) with ESMTPA id AA54532107D
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 12:57:46 -0700 (PDT)
Date: Fri, 18 Sep 2026 12:57:46 -0700
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/084d21-ebbb4e@github.com>
Subject: [bluez/bluez] ebbb4e: monitor: Add constants for CTE related commands
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
  Commit: ebbb4ee31ad7011cead3d6394c68d10076ab55fc
      https://github.com/bluez/bluez/commit/ebbb4ee31ad7011cead3d6394c68d10076ab55fc
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add constants for CTE related commands



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
