Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567083B636B
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570016; cv=none; b=RgoIukAQOO4V+/GbgvIICLh1PnE1HEgkNXNoHWYn70SlX2aIY8H7nYVIaVa50TgC8kdty55O59JHpvnEs8GpCnOHlUSI59FV34cKTw/VxXfR/G8nmMuXJ7VzUP++s1zzaYQjn0Kgy2Qno2H6nikUlorMDKRd6zFyB9vp0VmpuJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570016; c=relaxed/simple;
	bh=VzJIOI9jraKVhsByiHJZtL78JyPn9TXVGK6OHsR0fa8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=a2JsEQZjMvl/iuIP3zdH7gk+Zc1zxnz+ibGLgvk/xCmg86rGGW8VpNeXg8DvTQE+Ho3qpI6AjITSWm385By7M8m5tVbZPA3eBn7TTGxC9pRazGlcBCNhXACXq3R1mN7qCVDiVU/gkT4TEtPA0qY5IX/cMlwCmon6bELZ71jUEyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IrN3cq3u; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IrN3cq3u"
Received: from github.com (hubbernetes-node-6f0bdc0.va3-iad.github.net [10.48.221.54])
	by smtp.github.com (Postfix) with ESMTPA id 7D1FC92117C
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 06:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775570014;
	bh=T0Jl1EgjcGwwvimXB8zs0J9/dl084AUGG28oFR3Jl+E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IrN3cq3uv4PzVaZllH9Wlblj6NPTA4bWQAMruqNGS6WAUvGfReRiDdBM4bd/QOS5U
	 m3+wbic93xTJHZbY6Go7wIn/Ok372Drb3RQQlmAGU5bvPGlaYZ5vZmbrlC1HdQqiF0
	 bpkPTH9z/Zxsi5p9p/nyVDVTYR4AyIE55ISb2hWY=
Date: Tue, 07 Apr 2026 06:53:34 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/21db57-a73fcb@github.com>
Subject: [bluez/bluez] a73fcb: monitor: Fix not loading local GATT DB from
 cache
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
  Commit: a73fcbf207d34db68ef272f4b7d1762918dfb856
      https://github.com/bluez/bluez/commit/a73fcbf207d34db68ef272f4b7d1762918dfb856
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-06 (Mon, 06 Apr 2026)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor: Fix not loading local GATT DB from cache

The local GATT DB maybe discover in previous connection and therefore
should be cached as well to be able to decode follow-up connections
where the discovery may not be visible.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
