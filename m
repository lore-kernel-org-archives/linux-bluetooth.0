Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DEF286A4
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Nov 2025 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762687505; cv=none; b=ecs8d57CkOZm2HeEyBOxonY42gaAp6OF7uCK1S56LSzPLIdbMzwu1x4DlFO//RMJ4fHgfcJn6sWP44g7s6gXri4LaT5BVx73q0RORrgjkFMY2ucsW7YRtuNh30zR2lzCEcu+GZH6NeMplXGpMVQp1si/T2KbYyL5hDrVbKANxqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762687505; c=relaxed/simple;
	bh=NuzLyXg38l2vmlXodXa4kFbC290QgN9ADS0lUul+eL8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=C6vYhAW2DNhKPCFl7qERzatKgdKe/HcYKyPFHA7QlxyEXWCF7K/X5T4Y13GEcAJjMI6jzGYWKvfbySqGAEBbLOQz6QLTLnAM2hmioM8v0OBQuBfaM3OVcPn3GHBza3aixaq+xg2/FVhCV2sLObrk+jjag+EzDSIVIK6wSkmwy3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VL/vUe7f; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VL/vUe7f"
Received: from github.com (hubbernetes-node-fb6008d.ac4-iad.github.net [10.52.220.81])
	by smtp.github.com (Postfix) with ESMTPA id 447FC2085F
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Nov 2025 03:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762687503;
	bh=qYixbjtsJUp7xUWFMWfDPvJ7agH1drk0lFbAw/Ga3z8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VL/vUe7fZ7sNWkrFVm4eURp3y5EM1LGJPo9hMOu7PlziufbRhRFgZN8jQuj0+460b
	 tUVmbHLZw0EbOD09/3sL3vkrdTMaWtMopgg7uJxiMp99ZccqhSnPOY0jjWhOMV+OPD
	 Wmv57rN0UJ9yqTs5NXEc7I8bmbdofXXFrwimj3h4=
Date: Sun, 09 Nov 2025 03:25:03 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1021286/000000-68b16b@github.com>
Subject: [bluez/bluez] 68b16b: bap: make SetConfiguration() work similarly for
 uc...
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

  Branch: refs/heads/1021286
  Home:   https://github.com/bluez/bluez
  Commit: 68b16b7379a53700b063dd0db4d7abe8869bb8ed
      https://github.com/bluez/bluez/commit/68b16b7379a53700b063dd0db4d7abe8869bb8ed
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-09 (Sun, 09 Nov 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: make SetConfiguration() work similarly for ucast and bcast

Change ucast SetConfiguration() to always create a new stream.

Previously, it also removed all streams, but this is not useful now as
it prevents client from creating multiple streams, and since it can use
ClearConfiguration() to remove streams.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
