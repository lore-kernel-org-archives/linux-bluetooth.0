Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9BB64CD1
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713385929; cv=none; b=tTjn0V7p/fphv4+u+owccnxJn0CYy+WgOERTKumxfME9bHVQ9vX5KvmcbRzwD4d4uIRsdgiyg5OWI1wFbtbYArm8cFDXK9Pof31fiv7Q9IpT1CuDEiZH+GmN/aawD2i6w/Nfxyg0nC2UCJDsXvXXusDYNpg5CxixvrPBJ4XM02I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713385929; c=relaxed/simple;
	bh=F/nk7qm+UCHNOvVA2gpW+G404xcOpmOGwopYQrIFl9g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WKIhKAkPGEMW5FaUxy9RmBni0kOyIqpFIGEX9fPvIJ+9o9xiX2uBxfxgcvhND2gRumhlfEc746SBTwEckODA7btP8f6IaqtGaIosTHIS5tx4x6b6S1VK5NERV6kmXl5XU5prXL1gnh4dHAGBiq+N8/CV/tFV8vPbIxBvrbSif/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=l5JFFem+; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="l5JFFem+"
Received: from github.com (hubbernetes-node-f28a972.ac4-iad.github.net [10.52.125.45])
	by smtp.github.com (Postfix) with ESMTPA id C1CB45E08F0
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 13:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1713385926;
	bh=WtMbNcJU1ETy9LHDrL3W3f6gUrbyoirP0tKDIVpdVXk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=l5JFFem+IPGJ0vcaikCU1FZXvbyhUwfF6hWJkJDubKNgdGiCPlYCK+KAIUWgKqxs6
	 /gjTmL1jhTPCFqJYQOmoYPZVHc7OHCwn4Xv2TyFl+jMGyxBxb/k/8fvIl3rttCkkCZ
	 ObUBFM+6jMK6kzXWhZc0/E+2GgLb+H72+TeXc30c=
Date: Wed, 17 Apr 2024 13:32:06 -0700
From: Preston Hunt <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/b411b9-89cb88@github.com>
Subject: [bluez/bluez] 89cb88: monitor: fix spelling typo
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
  Commit: 89cb88b0f030cd1b4dc96cfd1760332122957ec3
      https://github.com/bluez/bluez/commit/89cb88b0f030cd1b4dc96cfd1760332122957ec3
  Author: Preston Hunt <me@prestonhunt.com>
  Date:   2024-04-17 (Wed, 17 Apr 2024)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: fix spelling typo



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
