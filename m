Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0084C26AAAB
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771013931; cv=none; b=f5wWE9ilkCOC417C+PczUHHqdzY5VWi3JJCohedeNaAJcgEroZ20IVe9LkiGBa0OVNuNC+Ry3A8V/9P7frmUrwwNUHutq5F+orf8yvirgpBXh87PmNCWMskznnAu4zwNpsvpUtSwSjZaaoYcB4qDVYeFK5SCN8Lrw5eSQwmMH0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771013931; c=relaxed/simple;
	bh=125syyNpWr6OhKc1LRgyIjyd8VRmaLUQaHbQNAFOsqA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AQ2DWAvViFMIDf+2C6JWtdXBc3aWQWAYh1uOTqotZEiG0rsLTJl3oLbZu+jE8YwcP6IJ5TkDwOaI3TfowtgpR45XvpEgpZvXuAbMSV8/TquyhJRtN/m/sbCG4DUPgKp/BBeCe3DCOQ1L7FmuP/hmEfaJLFeSVggpC1EoxTuDYxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AtEwa1vS; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AtEwa1vS"
Received: from github.com (hubbernetes-node-6ab89cd.ac4-iad.github.net [10.52.159.16])
	by smtp.github.com (Postfix) with ESMTPA id 4208F640BF0
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 12:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771013929;
	bh=bSUNG7Yk6i3fYEZf6FpJJKptndo46kjXkQv/frdnd4E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AtEwa1vS3SkgDZsHyljuMWsky30TtwQsNMzDa1tKRJZB5R8sM7J7uSwyrq3CnGW9U
	 dbu/UNwAKgus7CCE5AZDkV4yqDwXI0w+WhtNWTBUPPAbdvu7U35Aw4iiFnTrRYO6DO
	 qNuwrx0JvPjKbzgS5oUHok4TtnmCnTHRUW+AI33E=
Date: Fri, 13 Feb 2026 12:18:49 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/30acac-eae363@github.com>
Subject: [bluez/bluez] fe0501: bass: Fix crash if setup is freed before
 bass_bcod...
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
  Commit: fe0501126ba5d1ad23e05773ce6b474b5b727c98
      https://github.com/bluez/bluez/commit/fe0501126ba5d1ad23e05773ce6b474b5b727c98
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-12 (Thu, 12 Feb 2026)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Fix crash if setup is freed before bass_bcode_req response

If a the stream is set to idle (e.g. because the endpoint is
unregistered) the bass_bcode_req would be left with a dangling
pointer possibly leading to a crash if the remote peer respond or
the request times out.


  Commit: eae36399e75807dcf3d88d9af18909288fa71ee4
      https://github.com/bluez/bluez/commit/eae36399e75807dcf3d88d9af18909288fa71ee4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-12 (Thu, 12 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add reading output section

This adds a section explaining how to read the output of btmon.


Compare: https://github.com/bluez/bluez/compare/30acac54935c...eae36399e758

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
