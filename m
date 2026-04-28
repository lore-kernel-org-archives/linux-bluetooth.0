Received: from out-34.smtp.github.com (out-34.smtp.github.com [192.30.252.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912903B7B7B
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777390821; cv=none; b=D80Hs2WfbgdpPJEacoDaW8Ql+OeR+NemxmIPWMcFYVzp1WAhPZksfdGR7RQ78FhiVcnZ0RgBrVDpi98hj4lfsRRQdpHjVNS9UeIBEWg/Ymz5UoP353xVFukk7ORf0iGpz58wA6bbqXLyeqenjIyEEeYvkg26y6l4wXrHPjGGqb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777390821; c=relaxed/simple;
	bh=JwquXYTYIMAIG7ktL7D74h76wfO34dFanv2N8wR/sCg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VaDzcVWe3mSuGt1MOMjci9uViF6Eg0I2qf54IjGVg44RpUhLQKlHpbdWax0BsZ0ZsE2hQkPIBSZOxbSjJ8Ky/mztxQ7uDedX4pl8nxAQBLrstd+WpmX6MGBKSpfd0b20nqIN6zmCV+YPquFd6SuCqniQ+oKBBpXaTrXm5ftyrqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QzjozZhH; arc=none smtp.client-ip=192.30.252.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QzjozZhH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777390818;
	bh=TRIRWMKrYnvd7p1RBekpaYf5UeUFv5I1HNv8LC8xLRU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QzjozZhHJoAKM3As+g7V6N3FEivSRUNq+2CHeZbbx0YZzcZl8dkywRKx+fR6+xrbf
	 flXBjFokC+35iCLRuyontdiiOsW2F5o94qnDuEi5Jx5soTiAEQXIJY8Tk13mKY/NvS
	 nD36XouTIZ+wW8StWbZpFdydEMUTVw/Lpvz4yPSY=
Received: from github.com (hubbernetes-node-ba424ef.ac4-iad.github.net [10.52.133.33])
	by smtp.github.com (Postfix) with ESMTPA id B058974040E
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 08:40:18 -0700 (PDT)
Date: Tue, 28 Apr 2026 08:40:18 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1086916/000000-1b866e@github.com>
Subject: [bluez/bluez] 505db9: client: add public-broadcast advertising
 command
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

  Branch: refs/heads/1086916
  Home:   https://github.com/bluez/bluez
  Commit: 505db9ca976bd619e41a116129caeaf1ea35f4cd
      https://github.com/bluez/bluez/commit/505db9ca976bd619e41a116129caeaf1ea35f4cd
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-04-28 (Tue, 28 Apr 2026)

  Changed paths:
    M client/advertising.c
    M client/advertising.h
    M client/main.c

  Log Message:
  -----------
  client: add public-broadcast advertising command


  Commit: 1b866ee4f1ec0bd7dd0df2b4e39cca47bf1f80a5
      https://github.com/bluez/bluez/commit/1b866ee4f1ec0bd7dd0df2b4e39cca47bf1f80a5
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-04-28 (Tue, 28 Apr 2026)

  Changed paths:
    M client/advertising.c

  Log Message:
  -----------
  client: make advertise.name use public broadcast name


Compare: https://github.com/bluez/bluez/compare/505db9ca976b%5E...1b866ee4f1ec

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
