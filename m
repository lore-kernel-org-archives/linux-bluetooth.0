Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B701A3EBF34
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 19:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771011182; cv=none; b=pznJiAdSRAfS1eYh6wrhGdPFO+m5G5ypoFTIn9tNtxF3hagIj97c5MHExznNTaya1NNBs0TYZrX2jHRDRYL2gCcgRNt/TYFi2tPyVVB6g4fOa5JDsxiiZSe5fHxvshZkBOOScjdJ3utBj+E1GyxRo5syj9YkFsksr0frMNKPOKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771011182; c=relaxed/simple;
	bh=gXsNty2M7ycmjbhUH2W6ganzorB8I0Ia43vYPs+8ZpM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Ci/k3/ozpasEBl/RQnIzKQMNliRsDMmfON6CJrU3bfiIZHLKZiNjBxCT1hbeAX8rcTjqLGyYY89nyAozGFipy/XxXUh3G58hHOH+c2SZViOb9IA6/QDpYNQJ8QDEIINu8kt50evJX4jbqm3YBw4M/h1GHRG+sEWmoP/97leO9f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Rss48uSy; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Rss48uSy"
Received: from github.com (hubbernetes-node-e7df5c6.ac4-iad.github.net [10.52.211.99])
	by smtp.github.com (Postfix) with ESMTPA id F09F4640830
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 11:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771011180;
	bh=EmuLAAuG1rlFRNduPtP9HERcYmDGeRa6VJz+sUvf4Ls=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Rss48uSyoqtxMKl13MK1V8vykHdg2eQFAhg5LFLEmYli7mFoYsLKh9hU2qdRV9m2+
	 1N9GtIYsCUax9GMOG/hqgjJDicV+VNrrfH2sQ6XMtuUNWQra2QLNF9/IqiprZhrbMF
	 UsYpVSG5JE4icf3aHRMVZV4h8waMDxQFp+IxiQ8s=
Date: Fri, 13 Feb 2026 11:33:00 -0800
From: Copilot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/copilot/fix-dualshock4-random-inputs/902d82-dc0aee@github.com>
Subject: [bluez/bluez] dc0aee: input: Refine documentation and combine warning
 me...
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

  Branch: refs/heads/copilot/fix-dualshock4-random-inputs
  Home:   https://github.com/bluez/bluez
  Commit: dc0aee85bad150208dfeba967ff06834f575b26f
      https://github.com/bluez/bluez/commit/dc0aee85bad150208dfeba967ff06834f575b26f
  Author: copilot-swe-agent[bot] <198982749+Copilot@users.noreply.github.com>
  Date:   2026-02-13 (Fri, 13 Feb 2026)

  Changed paths:
    M profiles/input/device.c

  Log Message:
  -----------
  input: Refine documentation and combine warning messages

- Clarify that continuation frames are logged but not processed
- Combine two warn() calls into single message for cleaner logs
- Final code review feedback addressed

Co-authored-by: Vudentz <2156363+Vudentz@users.noreply.github.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
